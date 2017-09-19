Received: from eggs.gnu.org ([2001:4830:134:3::10]:36949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duMpP-0005sR-A9
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1duMpO-0008Tx-Cl
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:00:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1duMpO-0008Rw-2a
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:00:58 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 19 Sep 2017 19:00:36 +0100
Message-Id: <20170919180038.26056-4-dgilbert@redhat.com>
In-Reply-To: <20170919180038.26056-1-dgilbert@redhat.com>
References: <20170919180038.26056-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] migration: wire vmstate_save_state errors
 up to vmstate_subsection_save
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

Route the errors from vmstate_subsection_save up through
vmstate_subsection_save (and back down, all rather recursive).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/vmstate.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index abff9466b7..4146992373 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -21,8 +21,8 @@
 #include "trace.h"
 #include "qjson.h"
 
-static void vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
-                                    void *opaque, QJSON *vmdesc);
+static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
+                                   void *opaque, QJSON *vmdesc);
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque);
 
@@ -390,9 +390,7 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
         json_end_array(vmdesc);
     }
 
-    vmstate_subsection_save(f, vmsd, opaque, vmdesc);
-
-    return 0;
+    return vmstate_subsection_save(f, vmsd, opaque, vmdesc);
 }
 
 static const VMStateDescription *
@@ -458,11 +456,12 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
     return 0;
 }
 
-static void vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
-                                    void *opaque, QJSON *vmdesc)
+static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
+                                   void *opaque, QJSON *vmdesc)
 {
     const VMStateDescription **sub = vmsd->subsections;
     bool subsection_found = false;
+    int ret = 0;
 
     trace_vmstate_subsection_save_top(vmsd->name);
     while (sub && *sub && (*sub)->needed) {
@@ -486,7 +485,10 @@ static void vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             qemu_put_byte(f, len);
             qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
             qemu_put_be32(f, vmsdsub->version_id);
-            vmstate_save_state(f, vmsdsub, opaque, vmdesc);
+            ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc);
+            if (ret) {
+                return ret;
+            }
 
             if (vmdesc) {
                 json_end_object(vmdesc);
@@ -498,4 +500,6 @@ static void vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
     if (vmdesc && subsection_found) {
         json_end_array(vmdesc);
     }
+
+    return ret;
 }
-- 
2.13.5
