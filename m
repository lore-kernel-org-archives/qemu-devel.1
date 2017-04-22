Received: from eggs.gnu.org ([2001:4830:134:3::10]:34183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXF-00013h-Oa
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXC-0003tM-Is
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3511
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXB-0003ri-Vx
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:50 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:35:21 +0800
Message-ID: <1492850128-17472-12-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND v2 11/18] savevm: split save/find
 loadvm_handlers entry into two helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: quintela@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

COLO's checkpoint process is based on migration process,
everytime we do checkpoint we will repeat the process of savevm and loadvm.

So we will call qemu_loadvm_section_start_full() repeatedly, It will
add all migration sections information into loadvm_handlers list everytime,
which will lead to memory leak.

To fix it, we split the process of saving and finding section entry into two
helper functions, we will check if section info was exist in loadvm_handlers
list before save it.

This modifications have no side effect for normal migration.

Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 55 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 03ae1bd..f87cd8d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1836,6 +1836,37 @@ void loadvm_free_handlers(MigrationIncomingState *mis)
     }
 }
 
+static LoadStateEntry *loadvm_add_section_entry(MigrationIncomingState *mis,
+                                                 SaveStateEntry *se,
+                                                 uint32_t section_id,
+                                                 uint32_t version_id)
+{
+    LoadStateEntry *le;
+
+    /* Add entry */
+    le = g_malloc0(sizeof(*le));
+
+    le->se = se;
+    le->section_id = section_id;
+    le->version_id = version_id;
+    QLIST_INSERT_HEAD(&mis->loadvm_handlers, le, entry);
+    return le;
+}
+
+static LoadStateEntry *loadvm_find_section_entry(MigrationIncomingState *mis,
+                                                 uint32_t section_id)
+{
+    LoadStateEntry *le;
+
+    QLIST_FOREACH(le, &mis->loadvm_handlers, entry) {
+        if (le->section_id == section_id) {
+            break;
+        }
+    }
+
+    return le;
+}
+
 static int
 qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
 {
@@ -1878,15 +1909,12 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
         return -EINVAL;
     }
 
-    /* Add entry */
-    le = g_malloc0(sizeof(*le));
-
-    le->se = se;
-    le->section_id = section_id;
-    le->version_id = version_id;
-    QLIST_INSERT_HEAD(&mis->loadvm_handlers, le, entry);
-
-    ret = vmstate_load(f, le->se, le->version_id);
+     /* Check if we have saved this section info before, if not, save it */
+    le = loadvm_find_section_entry(mis, section_id);
+    if (!le) {
+        le = loadvm_add_section_entry(mis, se, section_id, version_id);
+    }
+    ret = vmstate_load(f, se, version_id);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%x of"
                      " device '%s'", instance_id, idstr);
@@ -1909,12 +1937,9 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
     section_id = qemu_get_be32(f);
 
     trace_qemu_loadvm_state_section_partend(section_id);
-    QLIST_FOREACH(le, &mis->loadvm_handlers, entry) {
-        if (le->section_id == section_id) {
-            break;
-        }
-    }
-    if (le == NULL) {
+
+    le = loadvm_find_section_entry(mis, section_id);
+    if (!le) {
         error_report("Unknown savevm section %d", section_id);
         return -EINVAL;
     }
-- 
1.8.3.1
