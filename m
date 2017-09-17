Received: from eggs.gnu.org ([2001:4830:134:3::10]:58451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@gmail.com>) id 1dtNZ4-0002v1-8w
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 20:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@gmail.com>) id 1dtNZ1-0006vK-6W
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 20:36:02 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.dakinevich@gmail.com>)
	id 1dtNZ0-0006u7-UL
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 20:35:59 -0400
Received: by mail-lf0-x241.google.com with SMTP id y15so2883432lfd.0
	for <qemu-devel@nongnu.org>; Sat, 16 Sep 2017 17:35:58 -0700 (PDT)
From: Jan Dakinevich <jan.dakinevich@gmail.com>
Date: Sun, 17 Sep 2017 03:38:11 +0300
Message-Id: <1505608691-11975-1-git-send-email-jan.dakinevich@gmail.com>
Subject: [Qemu-devel] [PATCH v2] 9pfs: check the size of transport buffer
 before marshaling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Jan Dakinevich <jan.dakinevich@gmail.com>

v9fs_do_readdir_with_stat() should check for a maximum buffer size
before an attempt to marshal gathered data. Otherwise, buffers assumed
as misconfigured and the transport would be broken.

The patch brings v9fs_do_readdir_with_stat() in conformity with
v9fs_do_readdir() behavior.

Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
---
 hw/9pfs/9p.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 144c330..4d4ed85 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1754,17 +1754,26 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         if (err < 0) {
             break;
         }
+        if ((count + v9stat.size + 2) > max_count) {
+            v9fs_readdir_unlock(&fidp->fs.dir);
+
+            /* Ran out of buffer. Set dir back to old position and return */
+            v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
+            v9fs_stat_free(&v9stat);
+            v9fs_path_free(&path);
+            return count;
+        }
+
         /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
         len = pdu_marshal(pdu, 11 + count, "S", &v9stat);
 
         v9fs_readdir_unlock(&fidp->fs.dir);
 
-        if ((len != (v9stat.size + 2)) || ((count + len) > max_count)) {
-            /* Ran out of buffer. Set dir back to old position and return */
+        if (len < 0) {
             v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
             v9fs_stat_free(&v9stat);
             v9fs_path_free(&path);
-            return count;
+            return len;
         }
         count += len;
         v9fs_stat_free(&v9stat);
-- 
2.1.4
