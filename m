Received: from eggs.gnu.org ([2001:4830:134:3::10]:36981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duMpQ-0005tn-Pp
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duMpP-00006i-Vl
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:01:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1duMpP-0008WK-QX
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:00:59 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 19 Sep 2017 19:00:37 +0100
Message-Id: <20170919180038.26056-5-dgilbert@redhat.com>
In-Reply-To: <20170919180038.26056-1-dgilbert@redhat.com>
References: <20170919180038.26056-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] migration: Route errors up through
 vmstate_save
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

Route the errors from vsmtate_save_state back up through
vmstate_save and out to the normal device state path.
That's the normal error path done.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 8d18a57ca0..c22a2fd758 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -751,14 +751,14 @@ static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se, QJSON *vmdes
     }
 }
 
-static void vmstate_save(QEMUFile *f, SaveStateEntry *se, QJSON *vmdesc)
+static int vmstate_save(QEMUFile *f, SaveStateEntry *se, QJSON *vmdesc)
 {
     trace_vmstate_save(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
     if (!se->vmsd) {
         vmstate_save_old_style(f, se, vmdesc);
-        return;
+        return 0;
     }
-    vmstate_save_state(f, se->vmsd, se->opaque, vmdesc);
+    return vmstate_save_state(f, se->vmsd, se->opaque, vmdesc);
 }
 
 /*
@@ -1147,7 +1147,11 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
         json_prop_int(vmdesc, "instance_id", se->instance_id);
 
         save_section_header(f, se, QEMU_VM_SECTION_FULL);
-        vmstate_save(f, se, vmdesc);
+        ret = vmstate_save(f, se, vmdesc);
+        if (ret) {
+            qemu_file_set_error(f, ret);
+            return ret;
+        }
         trace_savevm_section_end(se->idstr, se->section_id, 0);
         save_section_footer(f, se);
 
@@ -1289,6 +1293,8 @@ static int qemu_save_device_state(QEMUFile *f)
     cpu_synchronize_all_states();
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        int ret;
+
         if (se->is_ram) {
             continue;
         }
@@ -1301,7 +1307,10 @@ static int qemu_save_device_state(QEMUFile *f)
 
         save_section_header(f, se, QEMU_VM_SECTION_FULL);
 
-        vmstate_save(f, se, NULL);
+        ret = vmstate_save(f, se, NULL);
+        if (ret) {
+            return ret;
+        }
 
         save_section_footer(f, se);
     }
-- 
2.13.5
