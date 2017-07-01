Received: from eggs.gnu.org ([2001:4830:134:3::10]:55861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dR5vo-0005q0-Qd
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 20:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dR5vj-0006Ib-RW
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 20:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dR5vj-0006II-Is
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 20:06:31 -0400
Date: Fri, 30 Jun 2017 17:06:30 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1498838825-23701-3-git-send-email-igor.druzhinin@citrix.com>
Message-ID: <alpine.DEB.2.10.1706301631020.2919@sstabellini-ThinkPad-X260>
References: <1498838825-23701-1-git-send-email-igor.druzhinin@citrix.com>
	<1498838825-23701-3-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 2/4] xen/mapcache: add an ability to create
 dummy mappings
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
> Dummys are simple anonymous mappings that are placed instead
> of regular foreign mappings in certain situations when we need
> to postpone the actual mapping but still have to give a
> memory region to QEMU to play with.
> 
> This is planned to be used for restore on Xen.
> 
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
>
> ---
>  hw/i386/xen/xen-mapcache.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
> index e60156c..05050de 100644
> --- a/hw/i386/xen/xen-mapcache.c
> +++ b/hw/i386/xen/xen-mapcache.c
> @@ -150,7 +150,8 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>  
>  static void xen_remap_bucket(MapCacheEntry *entry,
>                               hwaddr size,
> -                             hwaddr address_index)
> +                             hwaddr address_index,
> +                             bool dummy)
>  {
>      uint8_t *vaddr_base;
>      xen_pfn_t *pfns;
> @@ -177,11 +178,25 @@ static void xen_remap_bucket(MapCacheEntry *entry,
>          pfns[i] = (address_index << (MCACHE_BUCKET_SHIFT-XC_PAGE_SHIFT)) + i;
>      }
>  
> -    vaddr_base = xenforeignmemory_map(xen_fmem, xen_domid, PROT_READ|PROT_WRITE,
> -                                      nb_pfn, pfns, err);
> -    if (vaddr_base == NULL) {
> -        perror("xenforeignmemory_map");
> -        exit(-1);
> +    if (!dummy) {
> +        vaddr_base = xenforeignmemory_map(xen_fmem, xen_domid,
> +                                           PROT_READ|PROT_WRITE,
> +                                           nb_pfn, pfns, err);
> +        if (vaddr_base == NULL) {
> +            perror("xenforeignmemory_map");
> +            exit(-1);
> +        }
> +    } else {
> +        /*
> +         * We create dummy mappings where we are unable to create a foreign
> +         * mapping immediately due to certain circumstances (i.e. on resume now)
> +         */
> +        vaddr_base = mmap(NULL, size, PROT_READ|PROT_WRITE,
> +                          MAP_ANON|MAP_SHARED, -1, 0);
> +        if (vaddr_base == NULL) {
> +            perror("mmap");
> +            exit(-1);
> +        }

For our sanity in debugging this in the future, I think it's best if we
mark this mapcache entry as "dummy". Since we are at it, we could turn
the lock field of MapCacheEntry into a flag field and #define LOCK as
(1<<0) and DUMMY as (1<<1). Please do that as a separate patch.


>      }
>  
>      entry->vaddr_base = vaddr_base;
> @@ -211,6 +226,7 @@ static uint8_t *xen_map_cache_unlocked(hwaddr phys_addr, hwaddr size,
>      hwaddr cache_size = size;
>      hwaddr test_bit_size;
>      bool translated = false;
> +    bool dummy = false;
>  
>  tryagain:
>      address_index  = phys_addr >> MCACHE_BUCKET_SHIFT;
> @@ -262,14 +278,14 @@ tryagain:
>      if (!entry) {
>          entry = g_malloc0(sizeof (MapCacheEntry));
>          pentry->next = entry;
> -        xen_remap_bucket(entry, cache_size, address_index);
> +        xen_remap_bucket(entry, cache_size, address_index, dummy);
>      } else if (!entry->lock) {
>          if (!entry->vaddr_base || entry->paddr_index != address_index ||
>                  entry->size != cache_size ||
>                  !test_bits(address_offset >> XC_PAGE_SHIFT,
>                      test_bit_size >> XC_PAGE_SHIFT,
>                      entry->valid_mapping)) {
> -            xen_remap_bucket(entry, cache_size, address_index);
> +            xen_remap_bucket(entry, cache_size, address_index, dummy);
>          }
>      }
>  
> @@ -282,6 +298,10 @@ tryagain:
>              translated = true;
>              goto tryagain;
>          }
> +        if (!dummy && runstate_check(RUN_STATE_INMIGRATE)) {
> +            dummy = true;
> +            goto tryagain;
> +        }
>          trace_xen_map_cache_return(NULL);
>          return NULL;
>      }
> -- 
> 2.7.4
> 
