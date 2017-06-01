Received: from eggs.gnu.org ([2001:4830:134:3::10]:51215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGYNz-0003mH-SI
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGYNy-0005uf-TA
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:16:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGYNy-0005uB-E7
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:16:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71327232050
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 22:16:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  2 Jun 2017 00:15:50 +0200
Message-Id: <20170601221552.30628-4-quintela@redhat.com>
In-Reply-To: <20170601221552.30628-1-quintela@redhat.com>
References: <20170601221552.30628-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] migration: Create load_setup()/cleanup()
 methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

We need to do things at load time.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/register.h |  2 ++
 migration/savevm.c           | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index 8e37185..0862bb8 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -42,6 +42,8 @@ typedef struct SaveVMHandlers {
                               uint64_t *non_postcopiable_pending,
                               uint64_t *postcopiable_pending);
     LoadStateHandler *load_state;
+    int (*load_setup)(QEMUFile *f, void *opaque);
+    int (*load_cleanup)(void *opaque);
 } SaveVMHandlers;
 
 int register_savevm(DeviceState *dev,
diff --git a/migration/savevm.c b/migration/savevm.c
index 0ec2cb0..1e5dfad 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1928,6 +1928,31 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
     return 0;
 }
 
+static int qemu_savevm_load_state_begin(QEMUFile *f)
+{
+    SaveStateEntry *se;
+    int ret;
+
+    trace_savevm_state_begin();
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
+            return ret;
+        }
+    }
+    return 0;
+}
+
 static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
 {
     uint8_t section_type;
@@ -2000,6 +2025,12 @@ int qemu_loadvm_state(QEMUFile *f)
         return -ENOTSUP;
     }
 
+
+    if (qemu_savevm_load_state_begin(f) != 0) {
+        error_report("Load state of one device failed");
+        return -EINVAL;
+    }
+
     if (!savevm_state.skip_configuration || enforce_config_section()) {
         if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
             error_report("Configuration section missing");
-- 
2.9.4
