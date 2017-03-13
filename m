Received: from eggs.gnu.org ([2001:4830:134:3::10]:34342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=238b93894=Paul.Durrant@citrix.com>)
	id 1cnM6Q-0007WR-2R
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=238b93894=Paul.Durrant@citrix.com>)
	id 1cnM6L-0004oH-VO
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:17:18 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:3364
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=238b93894=Paul.Durrant@citrix.com>)
	id 1cnM6L-0004l1-J2
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 05:17:13 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 13 Mar 2017 09:17:08 +0000
Message-ID: <28eabb0e517e46b6b644f11d32d70e3d@AMSPEX02CL03.citrite.net>
References: <1489176412-30529-1-git-send-email-igor.druzhinin@citrix.com>
In-Reply-To: <1489176412-30529-1-git-send-email-igor.druzhinin@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] xen: don't save/restore the physmap on
 VM save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Igor Druzhinin
> Sent: 10 March 2017 20:07
> To: sstabellini@kernel.org; Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Igor Druzhinin <igor.druzhinin@citrix.com>
> Subject: [PATCH v2] xen: don't save/restore the physmap on VM
> save/restore
>=20
> Saving/restoring the physmap to/from xenstore was introduced to
> QEMU majorly in order to cover up the VRAM region restore issue.
> The sequence of restore operations implies that we should know
> the effective guest VRAM address *before* we have the VRAM region
> restored (which happens later). Unfortunately, in Xen environment
> VRAM memory does actually belong to a guest - not QEMU itself -
> which means the position of this region is unknown beforehand and
> can't be mapped into QEMU address space immediately.
>=20
> Previously, recreating xenstore keys, holding the physmap, by the
> toolstack helped to get this information in place at the right
> moment ready to be consumed by QEMU to map the region properly.
>=20
> The extraneous complexity of having those keys transferred by the
> toolstack and unnecessary redundancy prompted us to propose a
> solution which doesn't require any extra data in xenstore. The idea
> is to defer the VRAM region mapping till the point we actually know
> the effective address and able to map it. To that end, we initially
> only register the pointer to the framebuffer without actual mapping.
> Then, during the memory region restore phase, we perform the mapping
> of the known address and update the VRAM region metadata (including
> previously registered pointer) accordingly.
>=20
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
> ---
> v2:
> * Fix some building and coding style issues
> ---
>  exec.c               |   3 ++
>  hw/display/vga.c     |   2 +-
>  include/hw/xen/xen.h |   2 +-
>  xen-hvm-stub.c       |   2 +-
>  xen-hvm.c            | 114 ++++++++++++---------------------------------=
------
>  5 files changed, 33 insertions(+), 90 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index aabb035..5f2809e 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2008,6 +2008,9 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block,
> ram_addr_t addr)
>          }
>=20
>          block->host =3D xen_map_cache(block->offset, block->max_length, =
1);
> +        if (block->host =3D=3D NULL) {
> +            return NULL;
> +        }

I don't think this is right. Callers of this function do not seem to ever e=
xpect it to fail. Specifically the call to memory_region_get_ram_ptr() made=
 by vga_common_init() just stashes the pointer as the VRAM base and never c=
hecks its validity.

Anyway, if you modify do this code, you should cc the appropriate maintaine=
rs (Guest CPU cores) and justify why you need to.

>      }
>      return ramblock_ptr(block, addr);
>  }
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 69c3e1d..be554c2 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -2163,7 +2163,7 @@ void vga_common_init(VGACommonState *s,
> Object *obj, bool global_vmstate)
>      memory_region_init_ram(&s->vram, obj, "vga.vram", s->vram_size,
>                             &error_fatal);
>      vmstate_register_ram(&s->vram, global_vmstate ? NULL : DEVICE(obj));
> -    xen_register_framebuffer(&s->vram);
> +    xen_register_framebuffer(&s->vram, &s->vram_ptr);
>      s->vram_ptr =3D memory_region_get_ram_ptr(&s->vram);
>      s->get_bpp =3D vga_get_bpp;
>      s->get_offsets =3D vga_get_offsets;
> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> index 09c2ce5..3831843 100644
> --- a/include/hw/xen/xen.h
> +++ b/include/hw/xen/xen.h
> @@ -45,6 +45,6 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t
> size,
>                     struct MemoryRegion *mr, Error **errp);
>  void xen_modified_memory(ram_addr_t start, ram_addr_t length);
>=20
> -void xen_register_framebuffer(struct MemoryRegion *mr);
> +void xen_register_framebuffer(struct MemoryRegion *mr, uint8_t **ptr);
>=20
>  #endif /* QEMU_HW_XEN_H */
> diff --git a/xen-hvm-stub.c b/xen-hvm-stub.c
> index c500325..c89065e 100644
> --- a/xen-hvm-stub.c
> +++ b/xen-hvm-stub.c
> @@ -46,7 +46,7 @@ qemu_irq *xen_interrupt_controller_init(void)
>      return NULL;
>  }
>=20
> -void xen_register_framebuffer(MemoryRegion *mr)
> +void xen_register_framebuffer(MemoryRegion *mr, uint8_t **ptr)
>  {
>  }
>=20
> diff --git a/xen-hvm.c b/xen-hvm.c
> index 5043beb..270cd99 100644
> --- a/xen-hvm.c
> +++ b/xen-hvm.c
> @@ -41,6 +41,7 @@
>=20
>  static MemoryRegion ram_memory, ram_640k, ram_lo, ram_hi;
>  static MemoryRegion *framebuffer;
> +static uint8_t **framebuffer_ptr;
>  static bool xen_in_migration;
>=20
>  /* Compatibility with older version */
> @@ -302,7 +303,6 @@ static hwaddr xen_phys_offset_to_gaddr(hwaddr
> start_addr,
>              return physmap->start_addr;
>          }
>      }
> -

Pure whitespace fix. Needs to either be called out in the commit comment or=
 separated.
The rest of the patch looks good to me.

  Paul

>      return start_addr;
>  }
>=20
> @@ -317,7 +317,6 @@ static int xen_add_to_physmap(XenIOState *state,
>      XenPhysmap *physmap =3D NULL;
>      hwaddr pfn, start_gpfn;
>      hwaddr phys_offset =3D memory_region_get_ram_addr(mr);
> -    char path[80], value[17];
>      const char *mr_name;
>=20
>      if (get_physmapping(state, start_addr, size)) {
> @@ -340,6 +339,27 @@ go_physmap:
>      DPRINTF("mapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx"\n",
>              start_addr, start_addr + size);
>=20
> +    mr_name =3D memory_region_name(mr);
> +
> +    physmap =3D g_malloc(sizeof(XenPhysmap));
> +
> +    physmap->start_addr =3D start_addr;
> +    physmap->size =3D size;
> +    physmap->name =3D mr_name;
> +    physmap->phys_offset =3D phys_offset;
> +
> +    QLIST_INSERT_HEAD(&state->physmap, physmap, list);
> +
> +    if (runstate_check(RUN_STATE_INMIGRATE)) {
> +        /* At this point we have a physmap entry for the framebuffer reg=
ion
> +         * established during the restore phase so we can safely update =
the
> +         * registered framebuffer address here. */

The jump to go_physmap is predicated on (mr =3D=3D framebuffer && start_add=
r > 0xbffff) so the following 'if' is unnecessary.

> +        if (mr =3D=3D framebuffer) {
> +            *framebuffer_ptr =3D memory_region_get_ram_ptr(framebuffer);
> +        }
> +        return 0;
> +    }
> +
>      pfn =3D phys_offset >> TARGET_PAGE_BITS;
>      start_gpfn =3D start_addr >> TARGET_PAGE_BITS;
>      for (i =3D 0; i < size >> TARGET_PAGE_BITS; i++) {
> @@ -350,49 +370,17 @@ go_physmap:
>          if (rc) {
>              DPRINTF("add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
>                      PRI_xen_pfn" failed: %d (errno: %d)\n", idx, gpfn, r=
c, errno);
> +
> +            QLIST_REMOVE(physmap, list);
> +            g_free(physmap);
>              return -rc;
>          }
>      }
>=20
> -    mr_name =3D memory_region_name(mr);
> -
> -    physmap =3D g_malloc(sizeof (XenPhysmap));
> -
> -    physmap->start_addr =3D start_addr;
> -    physmap->size =3D size;
> -    physmap->name =3D mr_name;
> -    physmap->phys_offset =3D phys_offset;
> -
> -    QLIST_INSERT_HEAD(&state->physmap, physmap, list);
> -
>      xc_domain_pin_memory_cacheattr(xen_xc, xen_domid,
>                                     start_addr >> TARGET_PAGE_BITS,
>                                     (start_addr + size - 1) >> TARGET_PAG=
E_BITS,
>                                     XEN_DOMCTL_MEM_CACHEATTR_WB);
> -
> -    snprintf(path, sizeof(path),
> -            "/local/domain/0/device-
> model/%d/physmap/%"PRIx64"/start_addr",
> -            xen_domid, (uint64_t)phys_offset);
> -    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)start_addr);
> -    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
> -        return -1;
> -    }
> -    snprintf(path, sizeof(path),
> -            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/size",
> -            xen_domid, (uint64_t)phys_offset);
> -    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)size);
> -    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
> -        return -1;
> -    }
> -    if (mr_name) {
> -        snprintf(path, sizeof(path),
> -                "/local/domain/0/device-model/%d/physmap/%"PRIx64"/name"=
,
> -                xen_domid, (uint64_t)phys_offset);
> -        if (!xs_write(state->xenstore, 0, path, mr_name, strlen(mr_name)=
)) {
> -            return -1;
> -        }
> -    }
> -
>      return 0;
>  }
>=20
> @@ -1152,54 +1140,6 @@ static void xen_exit_notifier(Notifier *n, void
> *data)
>      xs_daemon_close(state->xenstore);
>  }
>=20
> -static void xen_read_physmap(XenIOState *state)
> -{
> -    XenPhysmap *physmap =3D NULL;
> -    unsigned int len, num, i;
> -    char path[80], *value =3D NULL;
> -    char **entries =3D NULL;
> -
> -    snprintf(path, sizeof(path),
> -            "/local/domain/0/device-model/%d/physmap", xen_domid);
> -    entries =3D xs_directory(state->xenstore, 0, path, &num);
> -    if (entries =3D=3D NULL)
> -        return;
> -
> -    for (i =3D 0; i < num; i++) {
> -        physmap =3D g_malloc(sizeof (XenPhysmap));
> -        physmap->phys_offset =3D strtoull(entries[i], NULL, 16);
> -        snprintf(path, sizeof(path),
> -                "/local/domain/0/device-model/%d/physmap/%s/start_addr",
> -                xen_domid, entries[i]);
> -        value =3D xs_read(state->xenstore, 0, path, &len);
> -        if (value =3D=3D NULL) {
> -            g_free(physmap);
> -            continue;
> -        }
> -        physmap->start_addr =3D strtoull(value, NULL, 16);
> -        free(value);
> -
> -        snprintf(path, sizeof(path),
> -                "/local/domain/0/device-model/%d/physmap/%s/size",
> -                xen_domid, entries[i]);
> -        value =3D xs_read(state->xenstore, 0, path, &len);
> -        if (value =3D=3D NULL) {
> -            g_free(physmap);
> -            continue;
> -        }
> -        physmap->size =3D strtoull(value, NULL, 16);
> -        free(value);
> -
> -        snprintf(path, sizeof(path),
> -                "/local/domain/0/device-model/%d/physmap/%s/name",
> -                xen_domid, entries[i]);
> -        physmap->name =3D xs_read(state->xenstore, 0, path, &len);
> -
> -        QLIST_INSERT_HEAD(&state->physmap, physmap, list);
> -    }
> -    free(entries);
> -}
> -
>  static void xen_wakeup_notifier(Notifier *notifier, void *data)
>  {
>      xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE,
> 0);
> @@ -1339,7 +1279,6 @@ void xen_hvm_init(PCMachineState *pcms,
> MemoryRegion **ram_memory)
>          goto err;
>      }
>      xen_be_register_common();
> -    xen_read_physmap(state);
>=20
>      /* Disable ACPI build because Xen handles it */
>      pcms->acpi_build_enabled =3D false;
> @@ -1374,9 +1313,10 @@ void destroy_hvm_domain(bool reboot)
>      }
>  }
>=20
> -void xen_register_framebuffer(MemoryRegion *mr)
> +void xen_register_framebuffer(MemoryRegion *mr, uint8_t **ptr)
>  {
>      framebuffer =3D mr;
> +    framebuffer_ptr =3D ptr;
>  }
>=20
>  void xen_shutdown_fatal_error(const char *fmt, ...)
> --
> 2.7.4
