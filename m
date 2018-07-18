Received: from eggs.gnu.org ([2001:4830:134:3::10]:52996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoam-0003Hw-1d
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoag-0000Ig-Re
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:16 -0400
Received: from relay.sw.ru ([185.231.240.75]:36418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ffoag-0000GK-HT
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:10 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 18 Jul 2018 18:41:59 +0300
Message-Id: <20180718154200.26777-17-dplotnikov@virtuozzo.com>
In-Reply-To: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v1 16/17] migration: move the device state
 saving logic to a separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

The logic being split will be reused by the background snapshot.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 migration/savevm.c | 91 +++++++++++++++++++++++++---------------------
 migration/savevm.h |  2 +
 2 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index f202c3de3a..36074ec9de 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1107,51 +1107,15 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     qemu_fflush(f);
 }
 
-int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
-                                       bool inactivate_disks)
+int qemu_savevm_state_save(QEMUFile *f, bool inactivate_disks,
+                           bool send_eof)
 {
-    QJSON *vmdesc;
     int vmdesc_len;
     SaveStateEntry *se;
     int ret;
-    bool in_postcopy = migration_in_postcopy();
-
-    trace_savevm_state_complete_precopy();
+    QJSON *vmdesc = qjson_new();
 
     cpu_synchronize_all_states();
-
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops ||
-            (in_postcopy && se->ops->has_postcopy &&
-             se->ops->has_postcopy(se->opaque)) ||
-            (in_postcopy && !iterable_only) ||
-            !se->ops->save_live_complete_precopy) {
-            continue;
-        }
-
-        if (se->ops && se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
-        }
-        trace_savevm_section_start(se->idstr, se->section_id);
-
-        save_section_header(f, se, QEMU_VM_SECTION_END);
-
-        ret = se->ops->save_live_complete_precopy(f, se->opaque);
-        trace_savevm_section_end(se->idstr, se->section_id, ret);
-        save_section_footer(f, se);
-        if (ret < 0) {
-            qemu_file_set_error(f, ret);
-            return -1;
-        }
-    }
-
-    if (iterable_only) {
-        return 0;
-    }
-
-    vmdesc = qjson_new();
     json_prop_int(vmdesc, "page_size", qemu_target_page_size());
     json_start_array(vmdesc, "devices");
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -1193,8 +1157,8 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
             return ret;
         }
     }
-    if (!in_postcopy) {
-        /* Postcopy stream will still be going */
+
+    if (send_eof) {
         qemu_put_byte(f, QEMU_VM_EOF);
     }
 
@@ -1213,6 +1177,51 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
     return 0;
 }
 
+int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
+                                       bool inactivate_disks)
+{
+    SaveStateEntry *se;
+    int ret;
+    bool in_postcopy = migration_in_postcopy();
+
+    trace_savevm_state_complete_precopy();
+
+    cpu_synchronize_all_states();
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops ||
+            (in_postcopy && se->ops->has_postcopy &&
+             se->ops->has_postcopy(se->opaque)) ||
+            (in_postcopy && !iterable_only) ||
+            !se->ops->save_live_complete_precopy) {
+            continue;
+        }
+
+        if (se->ops && se->ops->is_active) {
+            if (!se->ops->is_active(se->opaque)) {
+                continue;
+            }
+        }
+        trace_savevm_section_start(se->idstr, se->section_id);
+
+        save_section_header(f, se, QEMU_VM_SECTION_END);
+
+        ret = se->ops->save_live_complete_precopy(f, se->opaque);
+        trace_savevm_section_end(se->idstr, se->section_id, ret);
+        save_section_footer(f, se);
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+            return -1;
+        }
+    }
+
+    if (iterable_only) {
+        return 0;
+    }
+
+    return qemu_savevm_state_save(f, inactivate_disks, !in_postcopy);
+}
+
 /* Give an estimate of the amount left to be transferred,
  * the result is split into the amount for units that can and
  * for units that can't do postcopy.
diff --git a/migration/savevm.h b/migration/savevm.h
index 295c4a1f2c..0e8d7aecf8 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -40,6 +40,8 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
 void qemu_savevm_state_pending(QEMUFile *f, uint64_t max_size,
                                uint64_t *res_non_postcopiable,
                                uint64_t *res_postcopiable);
+int qemu_savevm_state_save(QEMUFile *f, bool inactivate_disks,
+                           bool send_eof);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
 void qemu_savevm_send_open_return_path(QEMUFile *f);
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
-- 
2.17.0
