Received: from eggs.gnu.org ([2001:4830:134:3::10]:56893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dSswU-0002jy-FD
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 18:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dSswP-0003nw-K0
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 18:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dSswP-0003nb-B6
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 18:38:37 -0400
Date: Wed, 5 Jul 2017 15:38:33 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1499183267-28623-3-git-send-email-igor.druzhinin@citrix.com>
Message-ID: <alpine.DEB.2.10.1707051522320.2919@sstabellini-ThinkPad-X260>
References: <1499183267-28623-1-git-send-email-igor.druzhinin@citrix.com>
	<1499183267-28623-3-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 2/4] xen/mapcache: add an ability to
 create dummy mappings
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

On Tue, 4 Jul 2017, Igor Druzhinin wrote:
> Dummys are simple anonymous mappings that are placed instead
> of regular foreign mappings in certain situations when we need
> to postpone the actual mapping but still have to give a
> memory region to QEMU to play with.
> 
> This is planned to be used for restore on Xen.
> 
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/i386/xen/xen-mapcache.c | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
> index e60156c..cd4e746 100644
> --- a/hw/i386/xen/xen-mapcache.c
> +++ b/hw/i386/xen/xen-mapcache.c
> @@ -53,6 +53,8 @@ typedef struct MapCacheEntry {
>      uint8_t *vaddr_base;
>      unsigned long *valid_mapping;
>      uint8_t lock;
> +#define XEN_MAPCACHE_ENTRY_DUMMY (1 << 0)
> +    uint8_t flags;
>      hwaddr size;
>      struct MapCacheEntry *next;
>  } MapCacheEntry;
> @@ -150,7 +152,8 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>  
>  static void xen_remap_bucket(MapCacheEntry *entry,
>                               hwaddr size,
> -                             hwaddr address_index)
> +                             hwaddr address_index,
> +                             bool dummy)
>  {
>      uint8_t *vaddr_base;
>      xen_pfn_t *pfns;
> @@ -177,11 +180,27 @@ static void xen_remap_bucket(MapCacheEntry *entry,
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
> +        entry->flags &= ~(XEN_MAPCACHE_ENTRY_DUMMY);
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
> +        entry->flags |= XEN_MAPCACHE_ENTRY_DUMMY;
>      }
>  
>      entry->vaddr_base = vaddr_base;
> @@ -211,6 +230,7 @@ static uint8_t *xen_map_cache_unlocked(hwaddr phys_addr, hwaddr size,
>      hwaddr cache_size = size;
>      hwaddr test_bit_size;
>      bool translated = false;
> +    bool dummy = false;
>  
>  tryagain:
>      address_index  = phys_addr >> MCACHE_BUCKET_SHIFT;
> @@ -262,14 +282,14 @@ tryagain:
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
> @@ -282,6 +302,10 @@ tryagain:
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
