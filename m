Received: from eggs.gnu.org ([2001:4830:134:3::10]:55165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdcyU-0000sO-QU
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdcyP-0004tc-Tm
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:53:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdcyP-0004rQ-MU
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:53:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so6319802wmb.4
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:53:37 -0700 (PDT)
References: <20180711205813.22346-1-danielhb413@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4353326-28db-0094-e998-f92026d8e7a9@redhat.com>
Date: Thu, 12 Jul 2018 16:53:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180711205813.22346-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] scsi-disk: Block Device
 Characteristics emulation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>

On 11/07/2018 22:58, Daniel Henrique Barboza wrote:
> The current BDC VPD page (page 0xb1) is too short. This can be
> seen running sg_utils:
> 
> $ sg_vpd --page=bdc /dev/sda
> Block device characteristics VPD page (SBC):
> Block device characteristics VPD page length too short=8
> 
> By the SCSI spec, the expected size of the SBC page is 0x40.
> There is no telling how the guest will behave with a shorter
> message - it can ignore it, or worse, make (wrong)
> assumptions.
> 
> This patch fixes the emulation by setting the size to 0x40.
> This is the output of the previous sg_vpd command after
> applying it:
> 
> $ sg_vpd --page=bdc /dev/sda -v
>     inquiry cdb: 12 01 b1 00 fc 00
> Block device characteristics VPD page (SBC):
>    [PQual=0  Peripheral device type: disk]
>   Medium rotation rate is not reported
>   Product type: Not specified
>   WABEREQ=0
>   WACEREQ=0
>   Nominal form factor not reported
>   FUAB=0
>   VBULS=0
> 
> To improve readability, this patch also adds the VBULS value
> explictly and add comments on the existing fields we're
> setting.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Kevin kindly agreed to take this through the block tree, so

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

> ---
>  hw/scsi/scsi-disk.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 32f3f96ff8..5ae7baa082 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -775,11 +775,12 @@ int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
>      }
>      case 0xb1: /* block device characteristics */
>      {
> -        buflen = 8;
> +        buflen = 0x40;
>          outbuf[4] = (s->rotation_rate >> 8) & 0xff;
>          outbuf[5] = s->rotation_rate & 0xff;
> -        outbuf[6] = 0;
> -        outbuf[7] = 0;
> +        outbuf[6] = 0; /* PRODUCT TYPE */
> +        outbuf[7] = 0; /* WABEREQ | WACEREQ | NOMINAL FORM FACTOR */
> +        outbuf[8] = 0; /* VBULS */
>          break;
>      }
>      case 0xb2: /* thin provisioning */
> 
