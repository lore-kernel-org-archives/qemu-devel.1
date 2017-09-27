Received: from eggs.gnu.org ([2001:4830:134:3::10]:39624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxCqX-0000zc-TG
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxCqW-0002RH-So
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dxCqW-0002Pl-Js
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:52 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 27 Sep 2017 14:57:38 +0100
Message-Id: <20170927135742.19724-4-dgilbert@redhat.com>
In-Reply-To: <20170927135742.19724-1-dgilbert@redhat.com>
References: <20170927135742.19724-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] migration: check pre_save return in
 vmstate_save_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pl@kamp.de, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Check the return value of pre_save state and fail vmstate_save_state
if the pre_save failed.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170925112917.21340-3-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/vmstate.h |  4 ++--
 migration/trace-events      |  1 +
 migration/vmstate.c         | 12 ++++++++++--
 3 files changed, 13 insertions(+), 4 deletions(-)

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
index 3226e8eb45..ae8abd3c32 100644
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
@@ -381,6 +387,8 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
     }
 
     vmstate_subsection_save(f, vmsd, opaque, vmdesc);
+
+    return 0;
 }
 
 static const VMStateDescription *
-- 
2.13.5
