Received: from eggs.gnu.org ([2001:4830:134:3::10]:50282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWvUR-0002I8-Dm
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 21:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWvUQ-0000sq-LZ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 21:42:43 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu,  4 Jan 2018 10:42:28 +0800
Message-Id: <20180104024228.11780-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi: Don't deference in_buf if NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org

scsi_disk_emulate_command passes in_buf=NULL and in_len=0 in the
REQUEST_SENSE branch. Inline the fixed_in evaluation and put it after
the in_len test.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 scsi/utils.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scsi/utils.c b/scsi/utils.c
index ddae650a99..9a0a925ef9 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -320,10 +320,8 @@ int scsi_convert_sense(uint8_t *in_buf, int in_len,
                        uint8_t *buf, int len, bool fixed)
 {
     SCSISense sense;
-    bool fixed_in;
 
-    fixed_in = (in_buf[0] & 2) == 0;
-    if (in_len && fixed == fixed_in) {
+    if (in_len && !!fixed == ((in_buf[0] & 2) == 0)) {
         memcpy(buf, in_buf, MIN(len, in_len));
         return MIN(len, in_len);
     }
-- 
2.14.3
