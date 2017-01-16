Received: from eggs.gnu.org ([2001:4830:134:3::10]:37138)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cT92I-0003T6-Sy
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cT92G-0007m3-CA
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:17:30 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:49908 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cT92G-0007kt-30
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:17:28 -0500
From: Peter Lieven <pl@kamp.de>
Date: Mon, 16 Jan 2017 16:17:12 +0100
Message-Id: <1484579832-18589-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH] block/iscsi: avoid data corruption with
 cache=writeback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

nb_cls_shrunk in iscsi_allocmap_update can become -1 if the
request starts and ends within the same cluster. This results
in passing -1 to bitmap_set and bitmap_clear and they don't
handle negative values properly. In the end this leads to data
corruption.

Fixes: e1123a3b40a1a9a625a29c8ed4debb7e206ea690
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/iscsi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 6aeeb9e..1860f1b 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -499,14 +499,18 @@ iscsi_allocmap_update(IscsiLun *iscsilun, int64_t sector_num,
     if (allocated) {
         bitmap_set(iscsilun->allocmap, cl_num_expanded, nb_cls_expanded);
     } else {
-        bitmap_clear(iscsilun->allocmap, cl_num_shrunk, nb_cls_shrunk);
+        if (nb_cls_shrunk > 0) {
+            bitmap_clear(iscsilun->allocmap, cl_num_shrunk, nb_cls_shrunk);
+        }
     }
 
     if (iscsilun->allocmap_valid == NULL) {
         return;
     }
     if (valid) {
-        bitmap_set(iscsilun->allocmap_valid, cl_num_shrunk, nb_cls_shrunk);
+        if (nb_cls_shrunk > 0) {
+            bitmap_set(iscsilun->allocmap_valid, cl_num_shrunk, nb_cls_shrunk);
+        }
     } else {
         bitmap_clear(iscsilun->allocmap_valid, cl_num_expanded,
                      nb_cls_expanded);
-- 
1.9.1
