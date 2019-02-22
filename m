Received: from eggs.gnu.org ([209.51.188.92]:53419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gx74g-0003gb-6t
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gx6oy-0007I7-GR
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:08:42 -0500
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:43543)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gx6oy-00077Y-2M
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:08:40 -0500
Received: from player697.ha.ovh.net (unknown [10.109.146.32])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id DF40D17B1D3
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 10:08:28 +0100 (CET)
Date: Fri, 22 Feb 2019 10:08:22 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190222100822.73515a4d@bahia.lan>
In-Reply-To: <20190214043916.22128-3-david@gibson.dropbear.id.au>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190214043916.22128-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/5] virtio-balloon: Corrections
 to address verification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mst@redhat.com, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org

On Thu, 14 Feb 2019 15:39:13 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

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
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/virtio-balloon.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 43af521884..eb357824d8 100644
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
> -            section = memory_region_find(get_system_memory(), pa, 1);
> -            if (!int128_nz(section.size) ||
> -                !memory_region_is_ram(section.mr) ||
> +            section = memory_region_find(get_system_memory(), pa,
> +                                         BALLOON_PAGE_SIZE);
> +            if (!section.mr) {
> +                trace_virtio_balloon_bad_addr(pa);
> +                continue;
> +            }

memory_region_unref(section.mr) with section.mr == NULL is safe and
resolves to a nop. Not sure you need a separate if to handle this
case.

Apart from that,

Reviewed-by: Greg Kurz <groug@kaod.org>

> +            if (!memory_region_is_ram(section.mr) ||
>                  memory_region_is_rom(section.mr) ||
>                  memory_region_is_romd(section.mr)) {
>                  trace_virtio_balloon_bad_addr(pa);
