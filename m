Received: from eggs.gnu.org ([2001:4830:134:3::10]:36925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duMpN-0005qo-52
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duMpK-0008Jq-Te
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:00:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1duMpK-0008HR-MD
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:00:54 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 19 Sep 2017 19:00:35 +0100
Message-Id: <20170919180038.26056-3-dgilbert@redhat.com>
In-Reply-To: <20170919180038.26056-1-dgilbert@redhat.com>
References: <20170919180038.26056-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] migration: check pre_save return in
 vmstate_save_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com
Cc: peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Check the return value of pre_save state and fail vmstate_save_state
if the pre_save failed.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/vmstate.h |  4 ++--
 migration/trace-events      |  1 +
 migration/vmstate.c         | 18 +++++++++++++++---
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index da46b1a36d..88b55df5ae 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -994,8 +994,8 @@ extern const VMStateInfo vmstate_info_qtailq;
 
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id);
-void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                        void *opaque, QJSON *vmdesc);
+int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
+                       void *opaque, QJSON *vmdesc);
 
 bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
 
diff --git a/migration/trace-events b/migration/trace-events
index d2910a6e7b..6f29fcc686 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -40,6 +40,7 @@ savevm_state_iterate(void) ""
 savevm_state_cleanup(void) ""
 savevm_state_complete_precopy(void) ""
 vmstate_save(const char *idstr, const char *vmsd_name) "%s, %s"
+vmstate_save_state_pre_save_res(const char *name, int res) "%s/%d"
 vmstate_save_state_loop(const char *name, const char *field, int n_elems) "%s/%s[%d]"
 vmstate_save_state_top(const char *idstr) "%s"
 vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 3226e8eb45..abff9466b7 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -308,15 +308,21 @@ bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)
 }
 
 
-void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
+int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                         void *opaque, QJSON *vmdesc)
 {
+    int ret = 0;
     VMStateField *field = vmsd->fields;
 
     trace_vmstate_save_state_top(vmsd->name);
 
     if (vmsd->pre_save) {
-        vmsd->pre_save(opaque);
+        ret = vmsd->pre_save(opaque);
+        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
+        if (ret) {
+            error_report("pre-save failed: %s", vmsd->name);
+            return ret;
+        }
     }
 
     if (vmdesc) {
@@ -353,7 +359,11 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                     assert(field->flags & VMS_ARRAY_OF_POINTER);
                     vmstate_info_nullptr.put(f, curr_elem, size, NULL, NULL);
                 } else if (field->flags & VMS_STRUCT) {
-                    vmstate_save_state(f, field->vmsd, curr_elem, vmdesc_loop);
+                    int ret = vmstate_save_state(f, field->vmsd, curr_elem,
+                                                 vmdesc_loop);
+                    if (ret) {
+                        return ret;
+                    }
                 } else {
                     field->info->put(f, curr_elem, size, field, vmdesc_loop);
                 }
@@ -381,6 +391,8 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
     }
 
     vmstate_subsection_save(f, vmsd, opaque, vmdesc);
+
+    return 0;
 }
 
 static const VMStateDescription *
-- 
2.13.5
