Received: from eggs.gnu.org ([2001:4830:134:3::10]:59837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwRZu-0007xa-Sh
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwRZt-000231-TD
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:29:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dwRZt-00022X-L7
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 07:29:33 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 25 Sep 2017 12:29:15 +0100
Message-Id: <20170925112917.21340-5-dgilbert@redhat.com>
In-Reply-To: <20170925112917.21340-1-dgilbert@redhat.com>
References: <20170925112917.21340-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] migration: wire vmstate_save_state
 errors up to vmstate_subsection_save
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, famz@redhat.com
Cc: peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Route the errors from vmstate_subsection_save up through
vmstate_subsection_save (and back down, all rather recursive).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
