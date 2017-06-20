Received: from eggs.gnu.org ([2001:4830:134:3::10]:41019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dNR0W-0005KB-C7
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dNR0S-0007DH-DS
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dNR0S-0007A7-3u
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 17:48:16 -0400
Date: Tue, 20 Jun 2017 14:48:07 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <59492D1C0200007800164AA3@prv-mh.provo.novell.com>
Message-ID: <alpine.DEB.2.10.1706201421210.12819@sstabellini-ThinkPad-X260>
References: <59492D1C0200007800164AA3@prv-mh.provo.novell.com>
	<59492D1C0200007800164AA3@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Jan Beulich <JBeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien.grall@arm.com>, xen-devel <xen-devel@lists.xenproject.org>, qemu-devel@nongnu.org

On Tue, 20 Jun 2017, Jan Beulich wrote:
> Rather than constructing a local structure instance on the stack, fill
> the fields directly on the shared ring, just like other (Linux)
> backends do. Build on the fact that all response structure flavors are
> actually identical (the old code did make this assumption too).
> 
> This is XSA-216.
> 
> Reported by: Anthony Perard <anthony.perard@citrix.com>
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
> v2: Add QEMU_PACKED to fix handling 32-bit guests by 64-bit qemu.
> 
> --- a/hw/block/xen_blkif.h
> +++ b/hw/block/xen_blkif.h
> @@ -14,9 +14,6 @@
>  struct blkif_common_request {
>      char dummy;
>  };
> -struct blkif_common_response {
> -    char dummy;
> -};
>  
>  /* i386 protocol version */
>  #pragma pack(push, 4)
> @@ -36,13 +33,7 @@ struct blkif_x86_32_request_discard {
>      blkif_sector_t sector_number;    /* start sector idx on disk (r/w only)  */
>      uint64_t       nr_sectors;       /* # of contiguous sectors to discard   */
>  };
> -struct blkif_x86_32_response {
> -    uint64_t        id;              /* copied from request */
> -    uint8_t         operation;       /* copied from request */
> -    int16_t         status;          /* BLKIF_RSP_???       */
> -};
>  typedef struct blkif_x86_32_request blkif_x86_32_request_t;
> -typedef struct blkif_x86_32_response blkif_x86_32_response_t;
>  #pragma pack(pop)
>  
>  /* x86_64 protocol version */
> @@ -62,20 +53,14 @@ struct blkif_x86_64_request_discard {
>      blkif_sector_t sector_number;    /* start sector idx on disk (r/w only)  */
>      uint64_t       nr_sectors;       /* # of contiguous sectors to discard   */
>  };
> -struct blkif_x86_64_response {
> -    uint64_t       __attribute__((__aligned__(8))) id;
> -    uint8_t         operation;       /* copied from request */
> -    int16_t         status;          /* BLKIF_RSP_???       */
> -};
>
>  typedef struct blkif_x86_64_request blkif_x86_64_request_t;
> -typedef struct blkif_x86_64_response blkif_x86_64_response_t;
>  
>  DEFINE_RING_TYPES(blkif_common, struct blkif_common_request,
> -                  struct blkif_common_response);
> +                  struct blkif_response);
>  DEFINE_RING_TYPES(blkif_x86_32, struct blkif_x86_32_request,
> -                  struct blkif_x86_32_response);
> +                  struct blkif_response QEMU_PACKED);

In my test, the previous sizes and alignments of the response structs
were (on both x86_32 and x86_64):

sizeof(blkif_x86_32_response)=12   sizeof(blkif_x86_64_response)=16
align(blkif_x86_32_response)=4     align(blkif_x86_64_response)=8

While with these changes are now, when compiled on x86_64:
sizeof(blkif_x86_32_response)=11   sizeof(blkif_x86_64_response)=16
align(blkif_x86_32_response)=1     align(blkif_x86_64_response)=8

when compiled on x86_32:
sizeof(blkif_x86_32_response)=11   sizeof(blkif_x86_64_response)=12
align(blkif_x86_32_response)=1     align(blkif_x86_64_response)=4

Did I do my tests wrong?

QEMU_PACKED is not the same as #pragma pack(push, 4). In fact, it is the
same as #pragma pack(push, 1), causing the struct to be densely packed,
leaving no padding whatsever.

In addition, without __attribute__((__aligned__(8))),
blkif_x86_64_response won't be 8 bytes aligned when built on x86_32.

Am I missing something?


>  DEFINE_RING_TYPES(blkif_x86_64, struct blkif_x86_64_request,
> -                  struct blkif_x86_64_response);
> +                  struct blkif_response);
>  
>  union blkif_back_rings {
>      blkif_back_ring_t        native;
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -769,31 +769,30 @@ static int blk_send_response_one(struct
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
> +        resp = RING_GET_RESPONSE(&blkdev->rings.native,
> +                                 blkdev->rings.native.rsp_prod_pvt);
>          break;
>      case BLKIF_PROTOCOL_X86_32:
> -        dst = RING_GET_RESPONSE(&blkdev->rings.x86_32_part,
> -                                blkdev->rings.x86_32_part.rsp_prod_pvt);
> +        resp = RING_GET_RESPONSE(&blkdev->rings.x86_32_part,
> +                                 blkdev->rings.x86_32_part.rsp_prod_pvt);
>          break;
>      case BLKIF_PROTOCOL_X86_64:
> -        dst = RING_GET_RESPONSE(&blkdev->rings.x86_64_part,
> -                                blkdev->rings.x86_64_part.rsp_prod_pvt);
> +        resp = RING_GET_RESPONSE(&blkdev->rings.x86_64_part,
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
> 
> 
> 
