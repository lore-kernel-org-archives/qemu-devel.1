Received: from eggs.gnu.org ([2001:4830:134:3::10]:56559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dR5zU-0007yW-IB
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 20:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dR5zP-0000Rz-Iv
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 20:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dR5zP-0000RY-9q
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 20:10:19 -0400
Date: Fri, 30 Jun 2017 17:10:17 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1498838825-23701-5-git-send-email-igor.druzhinin@citrix.com>
Message-ID: <alpine.DEB.2.10.1706301543130.2919@sstabellini-ThinkPad-X260>
References: <1498838825-23701-1-git-send-email-igor.druzhinin@citrix.com>
	<1498838825-23701-5-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 4/4] xen: don't use xenstore to
 save/restore physmap anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, sstabellini@kernel.org, anthony.perard@citrix.com, paul.durrant@citrix.com, pbonzini@redhat.com

On Fri, 30 Jun 2017, Igor Druzhinin wrote:
> If we have a system with xenforeignmemory_map2() implemented
> we don't need to save/restore physmap on suspend/restore
> anymore. In case we resume a VM without physmap - try to
> recreate the physmap during memory region restore phase and
> remap map cache entries accordingly. The old code is left
> for compatibility reasons.
> 
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
> ---
>  hw/i386/xen/xen-hvm.c       | 45 ++++++++++++++++++++++++++++++++++-----------
>  include/hw/xen/xen_common.h |  1 +
>  2 files changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index d259cf7..1b6a5ce 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -305,6 +305,7 @@ static hwaddr xen_phys_offset_to_gaddr(hwaddr start_addr,
>      return start_addr;
>  }
>  
> +#ifdef XEN_COMPAT_PHYSMAP
>  static int xen_save_physmap(XenIOState *state, XenPhysmap *physmap)
>  {
>      char path[80], value[17];
> @@ -334,6 +335,12 @@ static int xen_save_physmap(XenIOState *state, XenPhysmap *physmap)
>      }
>      return 0;
>  }
> +#else
> +static int xen_save_physmap(XenIOState *state, XenPhysmap *physmap)
> +{
> +    return 0;
> +}
> +#endif
>  
>  static int xen_add_to_physmap(XenIOState *state,
>                                hwaddr start_addr,
> @@ -368,6 +375,26 @@ go_physmap:
>      DPRINTF("mapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx"\n",
>              start_addr, start_addr + size);
>  
> +    mr_name = memory_region_name(mr);
> +
> +    physmap = g_malloc(sizeof (XenPhysmap));
> +
> +    physmap->start_addr = start_addr;
> +    physmap->size = size;
> +    physmap->name = mr_name;
> +    physmap->phys_offset = phys_offset;
> +
> +    QLIST_INSERT_HEAD(&state->physmap, physmap, list);
> +
> +    if (runstate_check(RUN_STATE_INMIGRATE)) {
> +        /* Now when we have a physmap entry we can remap a dummy mapping and change
> +         * it to a real one of guest foreign memory. */
> +        uint8_t *p = xen_remap_cache_entry(phys_offset, size);
> +        assert(p && p == memory_region_get_ram_ptr(mr));

I would just pass start_addr to xen_remap_cache_entry as argument. It
would make things easier. With that, I think we should also be able to
#ifdef xen_phys_offset_to_gaddr and the call to phys_offset_to_gaddr in
xen_map_cache_unlocked, right?  It would make things simpler.


> +        return 0;
> +    }
>      pfn = phys_offset >> TARGET_PAGE_BITS;
>      start_gpfn = start_addr >> TARGET_PAGE_BITS;
>      for (i = 0; i < size >> TARGET_PAGE_BITS; i++) {
> @@ -382,21 +409,11 @@ go_physmap:
>          }
>      }
>  
> -    mr_name = memory_region_name(mr);
> -
> -    physmap = g_malloc(sizeof (XenPhysmap));
> -
> -    physmap->start_addr = start_addr;
> -    physmap->size = size;
> -    physmap->name = mr_name;
> -    physmap->phys_offset = phys_offset;
> -
> -    QLIST_INSERT_HEAD(&state->physmap, physmap, list);
> -
>      xc_domain_pin_memory_cacheattr(xen_xc, xen_domid,
>                                     start_addr >> TARGET_PAGE_BITS,
>                                     (start_addr + size - 1) >> TARGET_PAGE_BITS,
>                                     XEN_DOMCTL_MEM_CACHEATTR_WB);
> +

Spurious change


>      return xen_save_physmap(state, physmap);
>  }
>  
> @@ -1158,6 +1175,7 @@ static void xen_exit_notifier(Notifier *n, void *data)
>      xs_daemon_close(state->xenstore);
>  }
>  
> +#ifdef XEN_COMPAT_PHYSMAP
>  static void xen_read_physmap(XenIOState *state)
>  {
>      XenPhysmap *physmap = NULL;
> @@ -1205,6 +1223,11 @@ static void xen_read_physmap(XenIOState *state)
>      }
>      free(entries);
>  }
> +#else
> +static void xen_read_physmap(XenIOState *state)
> +{
> +}
> +#endif
>  
>  static void xen_wakeup_notifier(Notifier *notifier, void *data)
>  {
> diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
> index 70a5cad..c04c5c9 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -80,6 +80,7 @@ extern xenforeignmemory_handle *xen_fmem;
>  
>  #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
>  
> +#define XEN_COMPAT_PHYSMAP
>  #define xenforeignmemory_map2(h, d, a, p, f, ps, ar, e) \
>      xenforeignmemory_map(h, d, p, ps, ar, e)
>  
> -- 
> 2.7.4
> 
