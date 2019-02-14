Received: from eggs.gnu.org ([209.51.188.92]:46372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1guGL6-0007Mg-1U
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1guG82-0001MN-Ts
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:28:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2176 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
	id 1guG81-0001H2-52
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:28:34 -0500
From: Xiang Zheng <zhengxiang9@huawei.com>
Date: Thu, 14 Feb 2019 20:27:00 +0800
Message-ID: <20190214122700.18572-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] scsi-cd: Fix crash after remote cdrom detached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, wanghaibin.wang@huawei.com, lizhengui@huawei.com, Xiang Zheng <zhengxiang9@huawei.com>

There is a small window between the twice blk_is_available in
scsi_disk_emulate_command which would cause crash due to the later
assertion if the remote cdrom is detached in this window.

So this patch replaces assertions with return to avoid qemu crash.

Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
The qemu error log shows:

qemu-system-aarch64: /home/qemu/hw/scsi/scsi-disk.c:1896: scsi_disk_emulate_command: Assertion `blk_is_available(s->qdev.conf.blk)' failed.
2019-02-15 04:35:18.592: shutting down, reason=crashed

---
 hw/scsi/scsi-disk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index d4e83ae..6bcafe2 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1890,7 +1890,10 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
     memset(outbuf, 0, r->buflen);
     switch (req->cmd.buf[0]) {
     case TEST_UNIT_READY:
-        assert(blk_is_available(s->qdev.conf.blk));
+        if (!blk_is_available(s->qdev.conf.blk)) {
+            scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
+            return 0;
+        }
         break;
     case INQUIRY:
         buflen = scsi_disk_emulate_inquiry(req, outbuf);
-- 
1.8.3.1
