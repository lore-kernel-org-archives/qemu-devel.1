Received: from eggs.gnu.org ([2001:4830:134:3::10]:33437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQfqN-0004Gg-4J
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQfqJ-0008T7-Eg
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:42:59 -0500
Received: from mail-vk0-x229.google.com ([2607:f8b0:400c:c05::229]:32884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQfqJ-0008Sx-1F
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:42:55 -0500
Received: by mail-vk0-x229.google.com with SMTP id 137so347296019vkl.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 11:42:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161222152300.32395-22-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
	<20161222152300.32395-22-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 19:42:33 +0000
Message-ID: <CAFEAcA_G4Cgwimce6kMzWkB2zHLbTMwWH8ZcEP2kRu8853Lu_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 21/25] scsi-disk: fix VERIFY for scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 December 2016 at 15:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
> When a scsi-disk object receives VERIFY command with BYTCHK bit being zero,
> scsi_block_is_passthrough returns false and finally makes req being proceeded
> by scsi_block_dma_command. Because scsi_block_dma_command has removed process
> of VERIFY, QEMU will abort in this function.
>
> Reported-by: Junlian Bell <zhongjun@sangfor.com.cn>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index a963191..bdd1e5f 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2157,6 +2157,13 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
>          DPRINTF("Write %s(sector %" PRId64 ", count %u)\n",
>                  (command & 0xe) == 0xe ? "And Verify " : "",
>                  r->req.cmd.lba, len);
> +    case VERIFY_10:
> +    case VERIFY_12:
> +    case VERIFY_16:
> +        /* We get here only for BYTCHK == 0x01 and only for scsi-block.
> +         * As far as DMA is concerned, we can treat it the same as a write;
> +         * scsi_block_do_sgio will send VERIFY commands.
> +         */
>          if (r->req.cmd.buf[1] & 0xe0) {
>              goto illegal_request;
>          }

Coverity now complains about the fallthrough into the case statements
added here. I assume from the patch that the fallthrough is deliberate,
in which case a /* fall through */ comment would assist future
readers...

thanks
-- PMM
