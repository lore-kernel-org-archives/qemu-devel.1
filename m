Received: from eggs.gnu.org ([209.51.188.92]:57337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ6Ab-0003Py-24
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ64Z-00007J-Cj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:13721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJ64Z-00005J-54
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:47:39 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Wed, 24 Apr 2019 08:47:00 +0800
Message-Id: <20190424004700.12766-5-richardw.yang@linux.intel.com>
In-Reply-To: <20190424004700.12766-1-richardw.yang@linux.intel.com>
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/4] migration/savevm: wrap into
 qemu_loadvm_state_header()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

On source side, we have qemu_savevm_state_header() to send related data,
while on the receiving side those steps are scattered in
qemu_loadvm_state().

This patch wrap those related steps into qemu_loadvm_state_header() to
make it friendly to read.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/savevm.c | 69 +++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index a80ae83663..64d23682c6 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2256,6 +2256,43 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
     return 0;
 }
 
+static int qemu_loadvm_state_header(QEMUFile *f)
+{
+    unsigned int v;
+    int ret;
+
+    v = qemu_get_be32(f);
+    if (v != QEMU_VM_FILE_MAGIC) {
+        error_report("Not a migration stream");
+        return -EINVAL;
+    }
+
+    v = qemu_get_be32(f);
+    if (v == QEMU_VM_FILE_VERSION_COMPAT) {
+        error_report("SaveVM v2 format is obsolete and don't work anymore");
+        return -ENOTSUP;
+    }
+    if (v != QEMU_VM_FILE_VERSION) {
+        error_report("Unsupported migration stream version");
+        return -ENOTSUP;
+    }
+
+    if (migrate_get_current()->send_configuration) {
+        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
+            error_report("Configuration section missing");
+            qemu_loadvm_state_cleanup();
+            return -EINVAL;
+        }
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
+
+        if (ret) {
+            qemu_loadvm_state_cleanup();
+            return ret;
+        }
+    }
+    return 0;
+}
+
 static int qemu_loadvm_state_setup(QEMUFile *f)
 {
     SaveStateEntry *se;
@@ -2403,7 +2440,6 @@ int qemu_loadvm_state(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     Error *local_err = NULL;
-    unsigned int v;
     int ret;
 
     if (migration_is_blocked(&local_err)) {
@@ -2411,34 +2447,9 @@ int qemu_loadvm_state(QEMUFile *f)
         return -EINVAL;
     }
 
-    v = qemu_get_be32(f);
-    if (v != QEMU_VM_FILE_MAGIC) {
-        error_report("Not a migration stream");
-        return -EINVAL;
-    }
-
-    v = qemu_get_be32(f);
-    if (v == QEMU_VM_FILE_VERSION_COMPAT) {
-        error_report("SaveVM v2 format is obsolete and don't work anymore");
-        return -ENOTSUP;
-    }
-    if (v != QEMU_VM_FILE_VERSION) {
-        error_report("Unsupported migration stream version");
-        return -ENOTSUP;
-    }
-
-    if (migrate_get_current()->send_configuration) {
-        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
-            error_report("Configuration section missing");
-            qemu_loadvm_state_cleanup();
-            return -EINVAL;
-        }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
-
-        if (ret) {
-            qemu_loadvm_state_cleanup();
-            return ret;
-        }
+    ret = qemu_loadvm_state_header(f);
+    if (ret) {
+        return ret;
     }
 
     if (qemu_loadvm_state_setup(f) != 0) {
-- 
2.19.1
