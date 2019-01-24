Received: from eggs.gnu.org ([209.51.188.92]:42512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmcT3-0003aK-VN
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmcT3-0001ZY-1V
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:42:41 -0500
Date: Thu, 24 Jan 2019 11:42:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190124104217.GD4601@localhost.localdomain>
References: <20190111164506.15971-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111164506.15971-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: avoid possible out-of-bounds
 access to r->buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 11.01.2019 um 17:45 hat Paolo Bonzini geschrieben:
> Whenever the allocation length of a SCSI request is shorter than the size of the
> VPD page list, page_idx is used blindly to index into r->buf.  Even though
> the stores in the insertion sort are protected against overflows, the same is not
> true of the reads and the final store of 0xb0.
> 
> This basically does the same thing as commit 57dbb58d80 ("scsi-generic: avoid
> out-of-bounds access to VPD page list", 2018-11-06), except that here the
> allocation length can be chosen by the guest.  Note that according to the SCSI
> standard, the contents of the PAGE LENGTH field are not altered based
> on the allocation length.
> 
> The code was introduced by commit 6c219fc8a1 ("scsi-generic: keep VPD
> page list sorted", 2018-11-06) but the overflow was already possible before.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Fixes: a71c775b24ebc664129eb1d9b4c360590353efd5
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-generic.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index 7237b4162e..42700e8897 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -182,7 +182,7 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
>              /* Also take care of the opt xfer len. */
>              stl_be_p(&r->buf[12],
>                      MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
> -        } else if (s->needs_vpd_bl_emulation && page == 0x00) {
> +        } else if (s->needs_vpd_bl_emulation && page == 0x00 && r->buflen >= 4) {

If you make it page == 0, it would even fit in 80 characters. :-)

>              /*
>               * Now we're capable of supplying the VPD Block Limits
>               * response if the hardware can't. Add it in the INQUIRY
> @@ -193,18 +193,20 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
>               * and will use it to proper setup the SCSI device.
>               *
>               * VPD page numbers must be sorted, so insert 0xb0 at the
> -             * right place with an in-place insert.  After the initialization
> -             * part of the for loop is executed, the device response is
> -             * at r[0] to r[page_idx - 1].
> +             * right place with an in-place insert.  When the while loop
> +             * begins the device response is at r[0] to r[page_idx - 1].
>               */
> -            for (page_idx = lduw_be_p(r->buf + 2) + 4;
> -                 page_idx > 4 && r->buf[page_idx - 1] >= 0xb0;
> -                 page_idx--) {
> +            page_idx = lduw_be_p(r->buf + 2) + 4;
> +            page_idx = MIN(page_idx, r->buflen);
> +            while (page_idx > 4 && r->buf[page_idx - 1] >= 0xb0) {
>                  if (page_idx < r->buflen) {
>                      r->buf[page_idx] = r->buf[page_idx - 1];
>                  }
> +                page_idx--;
> +            }
> +            if (page_idx < r->buflen) {
> +                r->buf[page_idx] = 0xb0;
>              }
> -            r->buf[page_idx] = 0xb0;
>              stw_be_p(r->buf + 2, lduw_be_p(r->buf + 2) + 1);
>          }
>      }

Looks good to me.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
