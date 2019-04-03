Received: from eggs.gnu.org ([209.51.188.92]:53182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hBUQc-00011q-QZ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 21:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hBUQa-0001MB-Mx
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 21:10:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:6234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hBUQY-0001Hr-U9
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 21:10:55 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Wed,  3 Apr 2019 09:10:16 +0800
Message-Id: <20190403011016.12549-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] vmstate: check subsection_found is enough
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

subsection_found is true implies vmdesc is not NULL.

This patch remove the additional check on vmdesc and rename
subsection_found to vmdesc_has_subsections to make it more self-explain.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
v2:
  * rename it to vmdesc_has_subsections
---
 migration/vmstate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index e2bbb7b5f7..1305d1a528 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -496,7 +496,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, QJSON *vmdesc)
 {
     const VMStateDescription **sub = vmsd->subsections;
-    bool subsection_found = false;
+    bool vmdesc_has_subsections = false;
     int ret = 0;
 
     trace_vmstate_subsection_save_top(vmsd->name);
@@ -508,9 +508,9 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             trace_vmstate_subsection_save_loop(vmsd->name, vmsdsub->name);
             if (vmdesc) {
                 /* Only create subsection array when we have any */
-                if (!subsection_found) {
+                if (!vmdesc_has_subsections) {
                     json_start_array(vmdesc, "subsections");
-                    subsection_found = true;
+                    vmdesc_has_subsections = true;
                 }
 
                 json_start_object(vmdesc, NULL);
@@ -533,7 +533,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
         sub++;
     }
 
-    if (vmdesc && subsection_found) {
+    if (vmdesc_has_subsections) {
         json_end_array(vmdesc);
     }
 
-- 
2.19.1
