Received: from eggs.gnu.org ([2001:4830:134:3::10]:43526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAs9Y-0000P3-7K
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAs9S-0001GJ-0A
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:46:31 -0400
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-4-david@gibson.dropbear.id.au>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ecd2b2b6-38ea-8c0c-02b0-c35e9b72f4ae@redhat.com>
Date: Fri, 12 Oct 2018 09:46:16 +0200
MIME-Version: 1.0
In-Reply-To: <20181012032431.32693-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/5] virtio-balloon: Rework ballon_page()
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 12/10/2018 05:24, David Gibson wrote:
> This replaces the balloon_page() internal interface with
> ballon_inflate_page(), with a slightly different interface.  The new
> interface will make future alterations simpler.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/virtio/virtio-balloon.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index e8611aab0e..7229afad6e 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -33,11 +33,11 @@
>  
>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
>  
> -static void balloon_page(void *addr, int deflate)
> +static void balloon_inflate_page(VirtIOBalloon *balloon,
> +                                 MemoryRegion *mr, hwaddr offset)
>  {
> -    if (!qemu_balloon_is_inhibited() && !deflate) {
> -        qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
> -    }
> +    void *addr = memory_region_get_ram_ptr(mr) + offset;

I prefer an empty line here

> +    qemu_madvise(addr, BALLOON_PAGE_SIZE, QEMU_MADV_DONTNEED);
>  }
>  
>  static const char *balloon_stat_names[] = {
> @@ -222,7 +222,6 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  
>          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
>              hwaddr pa;
> -            hwaddr addr;
>              int p = virtio_ldl_p(vdev, &pfn);
>  
>              pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
> @@ -244,11 +243,9 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  
>              trace_virtio_balloon_handle_output(memory_region_name(section.mr),
>                                                 pa);
> -            /* Using memory_region_get_ram_ptr is bending the rules a bit, but
> -               should be OK because we only want a single page.  */
> -            addr = section.offset_within_region;
> -            balloon_page(memory_region_get_ram_ptr(section.mr) + addr,
> -                         !!(vq == s->dvq));
> +            if (!qemu_balloon_is_inhibited() && vq != s->dvq) {
> +                balloon_inflate_page(s, section.mr, section.offset_within_region);
> +            }
>              memory_region_unref(section.mr);
>          }
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
