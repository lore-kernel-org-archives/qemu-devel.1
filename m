Received: from eggs.gnu.org ([2001:4830:134:3::10]:42821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAs7f-0007y0-Pb
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gAs7c-0000QD-IV
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:44:35 -0400
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-3-david@gibson.dropbear.id.au>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0ea22284-a019-4d6b-9951-976174248d5a@redhat.com>
Date: Fri, 12 Oct 2018 09:44:25 +0200
MIME-Version: 1.0
In-Reply-To: <20181012032431.32693-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 2/5] virtio-balloon: Corrections to address
 verification
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
> The virtio-balloon device's verification of the address given to it by the
> guest has a number of faults:
>     * The addresses here are guest physical addresses, which should be
>       'hwaddr' rather than 'ram_addr_t' (the distinction is admittedly
>       pretty subtle and confusing)
>     * We don't check for section.mr being NULL, which is the main way that
>       memory_region_find() reports basic failures.  We really need to check
>       that before looking at any other section fields, because
>       memory_region_find() doesn't initialize them on the failure path
>     * We're passing a length of '1' to memory_region_find(), but really the
>       guest is requesting that we put the entire page into the balloon,
>       so it makes more sense to call it with BALLOON_PAGE_SIZE
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/virtio/virtio-balloon.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 6ec4bcf4e1..e8611aab0e 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -221,17 +221,20 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>          }
>  
>          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
> -            ram_addr_t pa;
> -            ram_addr_t addr;
> +            hwaddr pa;
> +            hwaddr addr;
>              int p = virtio_ldl_p(vdev, &pfn);
>  
> -            pa = (ram_addr_t) p << VIRTIO_BALLOON_PFN_SHIFT;
> +            pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
>              offset += 4;
>  
> -            /* FIXME: remove get_system_memory(), but how? */

Should we leave that fixme? (on the other hand, virtio-balloon operates
on all system mamory, so I also don't really see a way around this ...)

> -            section = memory_region_find(get_system_memory(), pa, 1);
> -            if (!int128_nz(section.size) ||
> -                !memory_region_is_ram(section.mr) ||
> +            section = memory_region_find(get_system_memory(), pa,
> +                                         BALLOON_PAGE_SIZE);
> +            if (!section.mr) {
> +                trace_virtio_balloon_bad_addr(pa);
> +                continue;
> +            }
> +            if (!memory_region_is_ram(section.mr) ||
>                  memory_region_is_rom(section.mr) ||
>                  memory_region_is_romd(section.mr)) {
>                  trace_virtio_balloon_bad_addr(pa);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
