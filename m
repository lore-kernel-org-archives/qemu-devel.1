Received: from eggs.gnu.org ([2001:4830:134:3::10]:59765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3441c70c0=anthony.perard@citrix.com>)
	id 1dPtxh-000447-T5
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3441c70c0=anthony.perard@citrix.com>)
	id 1dPtxd-0006na-LQ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:07:37 -0400
Received: from smtp.citrix.com ([66.165.176.89]:57773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3441c70c0=anthony.perard@citrix.com>)
	id 1dPtxd-0006nL-Bg
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:07:33 -0400
Date: Tue, 27 Jun 2017 17:07:59 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170627160759.GA1598@perard.uk.xensource.com>
References: <59492D1C0200007800164AA3@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706201421210.12819@sstabellini-ThinkPad-X260>
	<594A2A1C0200007800164F2A@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706211108530.12819@sstabellini-ThinkPad-X260>
	<594B8493020000780016595C@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706221146320.12819@sstabellini-ThinkPad-X260>
	<594CEBEF0200007800166189@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706231131570.12819@sstabellini-ThinkPad-X260>
	<5950A8D802000078001012A1@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1706261206370.12819@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1706261206370.12819@sstabellini-ThinkPad-X260>
Subject: Re: [Qemu-devel] [PATCH] xen/disk: don't leak stack data via
 response ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Jan Beulich <jbeulich@suse.com>, julien.grall@arm.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

On Mon, Jun 26, 2017 at 12:12:18PM -0700, Stefano Stabellini wrote:
> On Mon, 26 Jun 2017, Jan Beulich wrote:
> > >>> Stefano Stabellini <sstabellini@kernel.org> 06/23/17 8:43 PM >>>
> > >On Fri, 23 Jun 2017, Jan Beulich wrote:
> > >> >>> On 22.06.17 at 20:52, <sstabellini@kernel.org> wrote:
> > >> > I am happy to write the code and/or the commit message. Would a simple
> > >> > cast like below work to fix the security issue?
> > >> 
> > >> I suppose so, but you do realize that this is _exactly_ what
> > >> my patch does, except you use dangerous casts while I play
> > >> type-safe?
> > >
> > >Why is the cast dangerous?
> > 
> > Casts, and especially pointer ones) are always dangerous, as they have
> > the potential of type changes elsewhere going unnoticed. You may have
> > noticed that in reviews I'm often picking at casts, because in a majority
> > of cases people use them they're not needed and hence their use is a
> > (latent) risk.
> > 
> > > Both your patch and my version of it rely on
> > >inner knowledge of the way the rings are laid out in memory, but at
> > >least my patch doesn't introduce the risk of instantiating broken
> > >structs. Besides, type safety checks don't add much value, given that we
> > >rely on the way the ring.h macros have been written, which weren't even
> > >imported in the QEMU project until March this year.
> > 
> > That's said, as it seems to imply backporting of the change to older
> > qemu may then be problematic. Otoh I don't recall having had problems
> > with using the patch with only minor adjustments on older trees of ours.
> > 
> > >These are the reasons why I prefer my version, but I would consider your
> > >version with clear in-code comments that warn users to avoid
> > >instantiating the structs because they are not ABI compliant.
> > >
> > >How do you want to proceed?
> > 
> > I can provide a version with comments added, but only next week. If you
> > feel like you want to go with your variant, I won't stand in the way, but I
> > also wouldn't give it my ack or alike (which you don't depend on anyway).
> 
> After careful consideration, I think I'll submit my version of the
> patch, assuming that Anthony is OK with it. (FYI I had to keep your
> signed-off-by line for copyright reasons: you own the copyright on some
> of the changes.)
> 
> Anthony, what do you think of the following:

I do prefare the version without cast, but this is fine too. It is much
easier to understand that nothing changes beside the fact that field are
filled directly on the shared ring rather than from the stack. So I'm
fine with it.

You can add my
Acked-by: Anthony PERARD <anthony.perard@citrix.com>

> ---
> 
> xen/disk: don't leak stack data via response ring
> 
> Rather than constructing a local structure instance on the stack, fill
> the fields directly on the shared ring, just like other (Linux)
> backends do. Build on the fact that all response structure flavors are
> actually identical (aside from alignment and padding at the end).
> 
> This is XSA-216.
> 
> Reported by: Anthony Perard <anthony.perard@citrix.com>
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> 
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index 3a22805..9200511 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -769,31 +769,30 @@ static int blk_send_response_one(struct ioreq *ioreq)
>      struct XenBlkDev  *blkdev = ioreq->blkdev;
>      int               send_notify   = 0;
>      int               have_requests = 0;
> -    blkif_response_t  resp;
> -    void              *dst;
> -
> -    resp.id        = ioreq->req.id;
> -    resp.operation = ioreq->req.operation;
> -    resp.status    = ioreq->status;
> +    blkif_response_t  *resp;
>  
>      /* Place on the response ring for the relevant domain. */
>      switch (blkdev->protocol) {
>      case BLKIF_PROTOCOL_NATIVE:
> -        dst = RING_GET_RESPONSE(&blkdev->rings.native, blkdev->rings.native.rsp_prod_pvt);
> +        resp = (blkif_response_t *) RING_GET_RESPONSE(&blkdev->rings.native,
> +                                 blkdev->rings.native.rsp_prod_pvt);
>          break;
>      case BLKIF_PROTOCOL_X86_32:
> -        dst = RING_GET_RESPONSE(&blkdev->rings.x86_32_part,
> -                                blkdev->rings.x86_32_part.rsp_prod_pvt);
> +        resp = (blkif_response_t *) RING_GET_RESPONSE(&blkdev->rings.x86_32_part,
> +                                 blkdev->rings.x86_32_part.rsp_prod_pvt);
>          break;
>      case BLKIF_PROTOCOL_X86_64:
> -        dst = RING_GET_RESPONSE(&blkdev->rings.x86_64_part,
> -                                blkdev->rings.x86_64_part.rsp_prod_pvt);
> +        resp = (blkif_response_t *) RING_GET_RESPONSE(&blkdev->rings.x86_64_part,
> +                                 blkdev->rings.x86_64_part.rsp_prod_pvt);
>          break;
>      default:
> -        dst = NULL;
>          return 0;
>      }
> -    memcpy(dst, &resp, sizeof(resp));
> +
> +    resp->id        = ioreq->req.id;
> +    resp->operation = ioreq->req.operation;
> +    resp->status    = ioreq->status;
> +
>      blkdev->rings.common.rsp_prod_pvt++;
>  
>      RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(&blkdev->rings.common, send_notify);

-- 
Anthony PERARD
