Received: from eggs.gnu.org ([2001:4830:134:3::10]:39711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxCqg-00016x-MW
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxCqb-0002b4-2D
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:58:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7107)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dxCqa-0002ZG-Pj
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:56 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 27 Sep 2017 14:57:40 +0100
Message-Id: <20170927135742.19724-6-dgilbert@redhat.com>
In-Reply-To: <20170927135742.19724-1-dgilbert@redhat.com>
References: <20170927135742.19724-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] migration: wire vmstate_save_state errors
 up to vmstate_subsection_save
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

Route the errors from vmstate_save_state up through
vmstate_subsection_save (and back down, all rather recursive).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170925112917.21340-5-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Commit message fixed up as per Peter's review
---
 migration/vmstate.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 848e8448c6..0b3282c9df 100644
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
 
@@ -395,9 +395,7 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
         json_end_array(vmdesc);
     }
 
-    vmstate_subsection_save(f, vmsd, opaque, vmdesc);
-
-    return 0;
+    return vmstate_subsection_save(f, vmsd, opaque, vmdesc);
 }
 
 static const VMStateDescription *
@@ -463,11 +461,12 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -491,7 +490,10 @@ static void vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -503,4 +505,6 @@ static void vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
     if (vmdesc && subsection_found) {
         json_end_array(vmdesc);
     }
+
+    return ret;
 }
-- 
2.13.5
