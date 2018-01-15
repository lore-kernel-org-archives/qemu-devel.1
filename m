Received: from eggs.gnu.org ([2001:4830:134:3::10]:39275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eawDD-0008EW-1x
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 23:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eawD9-0006Ag-Qd
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 23:17:31 -0500
Received: from [45.249.212.32] (port=58044 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1eawD8-00064g-KC
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 23:17:27 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Mon, 15 Jan 2018 12:16:48 +0800
Message-ID: <20180115041648.33740-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] scsi: handle the special parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, wangxinxin.wang@huawei.com, linzhecheng <linzhecheng@huawei.com>

scsi_disk_emulate_command calls
scsi_build_sense(NULL, 0, outbuf, r->buflen,
                                  (req->cmd.buf[1] & 1) == 0);
But scsi_convert_sense doesn't handle the case when in_buf is NULL
or in_len is 0, which will lead to segfault.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>
---
 scsi/utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scsi/utils.c b/scsi/utils.c
index ddae650a99..b769e80c12 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -322,6 +322,10 @@ int scsi_convert_sense(uint8_t *in_buf, int in_len,
     SCSISense sense;
     bool fixed_in;
 
+    if (!in_buf || !in_len) {
+        return 0;
+    }
+
     fixed_in = (in_buf[0] & 2) == 0;
     if (in_len && fixed == fixed_in) {
         memcpy(buf, in_buf, MIN(len, in_len));
-- 
2.12.2.windows.2
