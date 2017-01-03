Received: from eggs.gnu.org ([2001:4830:134:3::10]:48838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOLYW-0006IT-6v
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOLYT-0000qP-5D
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:38:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cOLYS-0000qI-Vz
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:38:53 -0500
References: <ANQAnwAIAL-QXsc3JFgQSapS.3.1483431170238.Hmail.zhangqian@sangfor.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <601a7b61-d7b8-57b2-af41-c7c6d89bcef1@redhat.com>
Date: Tue, 3 Jan 2017 10:38:49 +0100
MIME-Version: 1.0
In-Reply-To: <ANQAnwAIAL-QXsc3JFgQSapS.3.1483431170238.Hmail.zhangqian@sangfor.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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



On 03/01/2017 09:12, Zhang Qian wrote:
> yes, you are right.
> The scenarios of problem is
> a scsi-disk object receives VERIFY command with BYTCHK bit being zero,
> scsi_block_is_passthrough returns false and finally scsi-block uses
> scsi_disk_dma_command for
> VERIFY. So the mode is set to SCSI_XFER_NONE.
> In scsi_req_continue, scsi_read_data function is called.

Uhm, is the fix simply

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index bdd1e5f..c080888 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2701,7 +2701,7 @@ static bool scsi_block_is_passthrough(SCSIDiskState *s, uint8_t *buf)
          * for the number of logical blocks specified in the length
          * field).  For other modes, do not use scatter/gather operation.
          */
-        if ((buf[1] & 6) != 2) {
+        if ((buf[1] & 6) == 2) {
             return false;
         }
         break;

then?

Thanks,

Paolo
