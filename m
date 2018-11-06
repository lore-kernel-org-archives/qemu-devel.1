Received: from eggs.gnu.org ([2001:4830:134:3::10]:43476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gK3SJ-0004gQ-SS
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gK3SI-0001SM-1Y
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:39:51 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:45261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gK3SG-00016z-0E
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:39:49 -0500
Received: by mail-qt1-x844.google.com with SMTP id l9-v6so3061415qtj.12
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 07:39:28 -0800 (PST)
References: <20181029173437.32559-1-pbonzini@redhat.com>
	<20181029173437.32559-2-pbonzini@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <288c938a-af29-8820-3606-cc2667a51f3f@gmail.com>
Date: Tue, 6 Nov 2018 13:39:24 -0200
MIME-Version: 1.0
In-Reply-To: <20181029173437.32559-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/4] scsi-generic: keep VPD page list sorted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mreitz@redhat.com



On 10/29/18 2:34 PM, Paolo Bonzini wrote:
> Block limits emulation is just placing 0xb0 as the final byte of the
> VPD pages list.  However, VPD page numbers must be sorted, so change
> that to an in-place insert.  Since I couldn't find any disk that triggered
> the loop more than once, this was tested by adding manually 0xb1
> at the end of the list and checking that 0xb0 was added before.
>
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>


Out of curiosity: how did you hit an issue with the ordering?

>   hw/scsi/scsi-generic.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index d60c4d0fcf..aebb7cdd82 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -144,7 +144,7 @@ static int execute_command(BlockBackend *blk,
>   
>   static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
>   {
> -    uint8_t page, page_len;
> +    uint8_t page, page_idx;
>   
>       /*
>        *  EVPD set to zero returns the standard INQUIRY data.
> @@ -190,10 +190,21 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
>                *
>                * This way, the guest kernel will be aware of the support
>                * and will use it to proper setup the SCSI device.
> +             *
> +             * VPD page numbers must be sorted, so insert 0xb0 at the
> +             * right place with an in-place insert.  After the initialization
> +             * part of the for loop is executed, the device response is
> +             * at r[0] to r[page_idx - 1].
>                */
> -            page_len = r->buf[3];
> -            r->buf[page_len + 4] = 0xb0;
> -            r->buf[3] = ++page_len;
> +            for (page_idx = lduw_be_p(r->buf + 2) + 4;
> +                 page_idx > 4 && r->buf[page_idx - 1] >= 0xb0;
> +                 page_idx--) {
> +                if (page_idx < r->buflen) {
> +                    r->buf[page_idx] = r->buf[page_idx - 1];
> +                }
> +            }
> +            r->buf[page_idx] = 0xb0;
> +            stw_be_p(r->buf + 2, lduw_be_p(r->buf + 2) + 1);
>           }
>       }
>   }
