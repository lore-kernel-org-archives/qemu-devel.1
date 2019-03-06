Received: from eggs.gnu.org ([209.51.188.92]:36708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1Rh3-0005v1-H2
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1Rh2-0007ki-Iy
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:14:25 -0500
References: <20190306030601.21986-1-david@gibson.dropbear.id.au>
	<20190306030601.21986-3-david@gibson.dropbear.id.au>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7ca90c23-9bac-0841-7ebc-364f25ab44af@redhat.com>
Date: Wed, 6 Mar 2019 09:14:17 +0100
MIME-Version: 1.0
In-Reply-To: <20190306030601.21986-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] virtio-balloon: Fix possible guest
 memory corruption with inflates & deflates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Michael Tsirkin <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06.03.19 04:06, David Gibson wrote:
> This fixes a balloon bug with a nasty consequence - potentially
> corrupting guest memory - but which is extremely unlikely to be
> triggered in practice.
> 
> The balloon always works in 4kiB units, but the host could have a
> larger page size on certain platforms.  Since ed48c59 "virtio-balloon:
> Safely handle BALLOON_PAGE_SIZE < host page size" we've handled this
> by accumulating requests to balloon 4kiB subpages until they formed a
> full host page.  Since f6deb6d "virtio-balloon: Remove unnecessary
> MADV_WILLNEED on deflate" we essentially ignore deflate requests.
> 
> Suppose we have a host with 8kiB pages, and one host page has subpages
> A & B.  If we get this sequence of events -
> 	inflate A
> 	deflate A
> 	inflate B
> - the current logic will discard the whole host page.  That's
> incorrect because the guest has deflated subpage A, and could have
> written important data to it.
> 
> This patch fixes the problem by adjusting our state information about
> partially ballooned host pages when deflate requests are received.
> 
> Fixes: ed48c59 "virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size"
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/virtio/virtio-balloon.c | 48 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 127289ae0e..7412bf8c85 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -111,6 +111,43 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
>      }
>  }
>  
> +static void balloon_deflate_page(VirtIOBalloon *balloon,
> +                                 MemoryRegion *mr, hwaddr offset)
> +{
> +    void *addr = memory_region_get_ram_ptr(mr) + offset;
> +    RAMBlock *rb;
> +    size_t rb_page_size;
> +    ram_addr_t ram_offset, host_page_base;
> +
> +    /* XXX is there a better way to get to the RAMBlock than via a
> +     * host address? */
> +    rb = qemu_ram_block_from_host(addr, false, &ram_offset);
> +    rb_page_size = qemu_ram_pagesize(rb);
> +    host_page_base = ram_offset & ~(rb_page_size - 1);
> +
> +    if (balloon->pbp
> +        && rb == balloon->pbp->rb
> +        && host_page_base == balloon->pbp->base) {
> +        int subpages = rb_page_size / BALLOON_PAGE_SIZE;
> +
> +        /*
> +         * This means the guest has asked to discard some of the 4kiB
> +         * subpages of a host page, but then changed its mind and
> +         * asked to keep them after all.  It's exceedingly unlikely
> +         * for a guest to do this in practice, but handle it anyway,
> +         * since getting it wrong could mean discarding memory the
> +         * guest is still using. */
> +        bitmap_clear(balloon->pbp->bitmap,
> +                     (ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
> +                     subpages);
> +
> +        if (bitmap_empty(balloon->pbp->bitmap, subpages)) {
> +            g_free(balloon->pbp);
> +            balloon->pbp = NULL;
> +        }
> +    }
> +}
> +
>  static const char *balloon_stat_names[] = {
>     [VIRTIO_BALLOON_S_SWAP_IN] = "stat-swap-in",
>     [VIRTIO_BALLOON_S_SWAP_OUT] = "stat-swap-out",
> @@ -314,8 +351,15 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  
>              trace_virtio_balloon_handle_output(memory_region_name(section.mr),
>                                                 pa);
> -            if (!qemu_balloon_is_inhibited() && vq != s->dvq) {
> -                balloon_inflate_page(s, section.mr, section.offset_within_region);
> +            if (!qemu_balloon_is_inhibited()) {
> +                if (vq == s->ivq) {
> +                    balloon_inflate_page(s, section.mr,
> +                                         section.offset_within_region);
> +                } else if (vq == s->dvq) {
> +                    balloon_deflate_page(s, section.mr, section.offset_within_region);
> +                } else {
> +                    g_assert_not_reached();
> +                }
>              }
>              memory_region_unref(section.mr);
>          }
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
