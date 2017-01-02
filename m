Received: from eggs.gnu.org ([2001:4830:134:3::10]:40220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cNz0N-00013g-Q3
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 04:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cNz0F-0004IU-6X
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 04:34:11 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cNz0F-0004I7-0W
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 04:34:03 -0500
Received: by mail-wm0-x241.google.com with SMTP id u144so81216374wmu.0
	for <qemu-devel@nongnu.org>; Mon, 02 Jan 2017 01:34:02 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <ABkAAQD4AB3QlUFH9YYGDar2.1.1483013998163.Hmail.zhangqian@sangfor.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78c57713-dbdb-3680-a35c-cc888e22e6ca@redhat.com>
Date: Mon, 2 Jan 2017 10:34:00 +0100
MIME-Version: 1.0
In-Reply-To: <ABkAAQD4AB3QlUFH9YYGDar2.1.1483013998163.Hmail.zhangqian@sangfor.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: fix crash on VERIFY command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Qian <zhangqian@sangfor.com.cn>
Cc: qemu-devel@nongnu.org



On 29/12/2016 13:19, Zhang Qian wrote:
> From c2f1631132821d61e1942a8723ba596f91d3e672 Mon Sep 17 00:00:00 2001
> From: Zhang Qian <zhangqian@sangfor.com.cn>
> Date: Thu, 29 Dec 2016 20:00:01 +0800
> Subject: [PATCH] scsi-disk: fix crash on VERIFY command Commit 166dbda
>  "scsi-disk: fix VERIFY for scsi-block" add a process of VERIFY in
>  scsi_block_dma_command. But, the cmd.mode of req is SCSI_XFER_NONE, the req
>  is handled as a read operation. A verify command is not an actual read (we do
>  not implement compare mode) and thus does not have an AIOCB attached. so, it
>  will be crash in scsi_dma_complete. Commit ef8489d "scsi: avoid assertion
>  failure on VERIFY command" is added to process verify command, so we treat
>  verify command as a write operation.
> Signed-off-by: Zhang Qian <zhangqian@sangfor.com.cn>

I am not sure what the issue is, and your commit message doesn't explain
it.  There are a few unclear aspects:

1) the mode is set in scsi_cmd_xfer_mode.  For VERIFY, it is only
SCSI_XFER_NONE if the transferred data is empty, otherwise it is
SCSI_XFER_TO_DEV.  For BYTCHK=0x01, scsi_req_xfer sets cmd->xfer
correctly to number-of-blocks * block-size.

2) Your message does not say if you're using scsi-block or
scsi-disk/scsi-hd. Only scsi-block uses scsi_disk_dma_command for
VERIFY, and it does have an AIOCB (created by scsi_block_dma_writev).
If you were using virtio-scsi, then a wrong request from the guest might
have BYTCHK=0x01 and SCSI_XFER_NONE (see virtio_scsi_parse_cdb).
However, this does not affect whether the request has an AIOCB attached.


Please explain the issue better and, if it is for scsi-disk or scsi-hd,
please provide a testcase in tests/virtio-scsi-tests.c.

Thanks,

Paolo

> ---
>  hw/scsi/scsi-disk.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index bdd1e5f..ab05bf9 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2170,6 +2170,10 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
>          if (!check_lba_range(s, r->req.cmd.lba, len)) {
>              goto illegal_lba;
>          }
> + if (command == VERIFY_10 || command == VERIFY_12 ||
> +            command == VERIFY_16) {
> +            r->req.cmd.mode = SCSI_XFER_TO_DEV;
> +        }
>          r->sector = r->req.cmd.lba * (s->qdev.blocksize / 512);
>          r->sector_count = len * (s->qdev.blocksize / 512);
>          break;
> 
