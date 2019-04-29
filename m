Received: from eggs.gnu.org ([209.51.188.92]:51341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLG3V-0001rg-8a
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 19:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1hLG3T-00019R-8x
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 19:51:29 -0400
Received: from inet-orm.provo.novell.com ([137.65.248.124]:50118
	helo=mail.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1hLG3T-00018N-2m
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 19:51:27 -0400
From: Bruce Rogers <brogers@suse.com>
Date: Mon, 29 Apr 2019 17:51:09 -0600
Message-Id: <20190429235109.20307-1-brogers@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] scsi-disk: handle invalid cdb length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, Bruce Rogers <brogers@suse.com>

While investigating link-time-optimization, the compiler flagged this
case of not handling the error return from scsi_cdb_length(). Handle
this error case with a trace report.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 hw/scsi/scsi-disk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e7e865ab3b..dc13c892ef 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2520,6 +2520,10 @@ static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, uint8_t *buf)
     int len = scsi_cdb_length(buf);
     char *line_buffer, *p;
 
+    if (len < 0) {
+        trace_scsi_disk_new_request(lun, tag, "bad cdb length!");
+        return;
+    }
     line_buffer = g_malloc(len * 5 + 1);
 
     for (i = 0, p = line_buffer; i < len; i++) {
-- 
2.21.0
