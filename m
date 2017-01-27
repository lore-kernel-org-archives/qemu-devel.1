Received: from eggs.gnu.org ([2001:4830:134:3::10]:33436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qt-0004zF-PC
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qs-0003xF-Oc
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:07 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:21 +0100
Message-Id: <1485524749-118532-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/41] block/iscsi: avoid data corruption with
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
Cc: Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

From: Peter Lieven <pl@kamp.de>

nb_cls_shrunk in iscsi_allocmap_update can become -1 if the
request starts and ends within the same cluster. This results
in passing -1 to bitmap_set and bitmap_clear and they don't
handle negative values properly. In the end this leads to data
corruption.

Fixes: e1123a3b40a1a9a625a29c8ed4debb7e206ea690
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <1484579832-18589-1-git-send-email-pl@kamp.de>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
