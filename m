Received: from eggs.gnu.org ([2001:4830:134:3::10]:55670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNckH-0002N1-KS
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNckG-0004ym-Fo
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dNckG-0004yJ-86
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C8D58E773
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 10:20:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 21 Jun 2017 12:20:03 +0200
Message-Id: <20170621102005.18701-4-quintela@redhat.com>
In-Reply-To: <20170621102005.18701-1-quintela@redhat.com>
References: <20170621102005.18701-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/5] migration: Create
 load_setup()/cleanup() methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, kwolf@redhat.com, stefanha@redhat.com

We need to do things at load time and at cleanup time.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Move the printing of the error message so we can print the device
giving the error.
---
 include/migration/register.h |  2 ++
 migration/savevm.c           | 44 ++++++++++++++++++++++++++++++++++++++++++++
 migration/trace-events       |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index 938ea2b..a0f1edd 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -39,6 +39,8 @@ typedef struct SaveVMHandlers {
                               uint64_t *non_postcopiable_pending,
                               uint64_t *postcopiable_pending);
     LoadStateHandler *load_state;
+    int (*load_setup)(QEMUFile *f, void *opaque);
+    int (*load_cleanup)(void *opaque);
 } SaveVMHandlers;
 
 int register_savevm_live(DeviceState *dev,
diff --git a/migration/savevm.c b/migration/savevm.c
index 7d273f9..a0733f9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1923,6 +1923,44 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
     return 0;
 }
 
+static int qemu_loadvm_state_setup(QEMUFile *f)
+{
+    SaveStateEntry *se;
+    int ret;
+
+    trace_loadvm_state_setup();
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->load_setup) {
+            continue;
+        }
+        if (se->ops && se->ops->is_active) {
+            if (!se->ops->is_active(se->opaque)) {
+                continue;
+            }
+        }
+
+        ret = se->ops->load_setup(f, se->opaque);
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+            error_report("Load state of device %s failed", se->idstr);
+            return ret;
+        }
+    }
+    return 0;
+}
+
+static void qemu_loadvm_state_cleanup(void)
+{
+    SaveStateEntry *se;
+
+    trace_loadvm_state_cleanup();
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (se->ops && se->ops->load_cleanup) {
+            se->ops->load_cleanup(se->opaque);
+        }
+    }
+}
+
 static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
 {
     uint8_t section_type;
@@ -1995,6 +2033,11 @@ int qemu_loadvm_state(QEMUFile *f)
         return -ENOTSUP;
     }
 
+
+    if (qemu_loadvm_state_setup(f) != 0) {
+        return -EINVAL;
+    }
+
     if (!savevm_state.skip_configuration || enforce_config_section()) {
         if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
             error_report("Configuration section missing");
@@ -2058,6 +2101,7 @@ int qemu_loadvm_state(QEMUFile *f)
         }
     }
 
+    qemu_loadvm_state_cleanup();
     cpu_synchronize_all_post_init();
 
     return ret;
diff --git a/migration/trace-events b/migration/trace-events
index 9669e94..cb2c4b5 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,6 +7,8 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
+loadvm_state_setup(void) ""
+loadvm_state_cleanup(void) ""
 loadvm_handle_cmd_packaged(unsigned int length) "%u"
 loadvm_handle_cmd_packaged_main(int ret) "%d"
 loadvm_handle_cmd_packaged_received(int ret) "%d"
-- 
2.9.4
