Received: from eggs.gnu.org ([2001:4830:134:3::10]:55953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHpSo-0005IU-HN
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHpSl-0002mG-Br
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:10:06 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:33117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cHpSl-0002m2-5O
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:10:03 -0500
Received: by mail-wj0-x243.google.com with SMTP id kp2so13713439wjc.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 02:10:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161216075527.5421-1-zhongjun@sangfor.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <698b3cd4-0eeb-7739-e692-58615fc40956@redhat.com>
Date: Fri, 16 Dec 2016 11:10:00 +0100
MIME-Version: 1.0
In-Reply-To: <20161216075527.5421-1-zhongjun@sangfor.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] scsi-disk: passthrough VERIFY command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Junlian Bell <zhongjun@sangfor.com.cn>
Cc: qemu-devel@nongnu.org



On 16/12/2016 08:55, Junlian Bell wrote:
> When a scsi-disk object receives VERIFY command with BYTCHK bit being zero,
> scsi_block_is_passthrough returns false and finally makes req being proceeded
> by scsi_block_dma_command. Because scsi_block_dma_command has removed process
> of VERIFY, QEMU will abort in this function.
> 
> This patch makes all VERIFY passthrough to solve this problom.
> 
> Signed-off-by: Junlian Bell <zhongjun@sangfor.com.cn>
> ---
>  hw/scsi/scsi-disk.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index a96319138a..f30f97f976 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2690,13 +2690,6 @@ static bool scsi_block_is_passthrough(SCSIDiskState *s, uint8_t *buf)
>      case VERIFY_10:
>      case VERIFY_12:
>      case VERIFY_16:
> -        /* Check if BYTCHK == 0x01 (data-out buffer contains data
> -         * for the number of logical blocks specified in the length
> -         * field).  For other modes, do not use scatter/gather operation.
> -         */
> -        if ((buf[1] & 6) != 2) {
> -            return false;
> -        }
>          break;
>  
>      case READ_6:
> 

Does this work too?

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a963191..676164d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2157,6 +2157,13 @@ static int32_t scsi_disk_dma_command(SCSIRequest
*req, uint8_t *buf)
         DPRINTF("Write %s(sector %" PRId64 ", count %u)\n",
                 (command & 0xe) == 0xe ? "And Verify " : "",
                 r->req.cmd.lba, len);
+    case VERIFY_10:
+    case VERIFY_12:
+    case VERIFY_16:
+        /* We get here only for BYTCHK=00 and only for scsi-block.  As
+         * far as DMA is concerned, we can treat it as a write, and
+         * scsi_block_do_sgio will send VERIFY commands.
+         */
         if (r->req.cmd.buf[1] & 0xe0) {
             goto illegal_request;
         }

Thanks,

Paolo
