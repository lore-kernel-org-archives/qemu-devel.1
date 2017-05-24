Received: from eggs.gnu.org ([2001:4830:134:3::10]:44560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDS4p-0007aX-Sd
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDS4m-00070S-0v
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:55:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dDS4l-000702-Nf
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:55:27 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 24 May 2017 10:55:17 +0200
Message-Id: <20170524085519.22856-2-quintela@redhat.com>
In-Reply-To: <20170524085519.22856-1-quintela@redhat.com>
References: <20170524085519.22856-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] migration: Use savevm_handlers instead of
 loadvm copy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Juan Quintela <quintela@trasno.org>

From: Juan Quintela <quintela@trasno.org>

There is no reason for having the loadvm_handlers at all.  There is
only one use, and we can use the savevm handlers.

We will remove the loadvm handlers on a following patch.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d971e5e..55ac8c1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1792,7 +1792,7 @@ struct LoadStateEntry {
  * Returns: true if the footer was good
  *          false if there is a problem (and calls error_report to say why)
  */
-static bool check_section_footer(QEMUFile *f, LoadStateEntry *le)
+static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 {
     uint8_t read_mark;
     uint32_t read_section_id;
@@ -1805,15 +1805,15 @@ static bool check_section_footer(QEMUFile *f, LoadStateEntry *le)
     read_mark = qemu_get_byte(f);
 
     if (read_mark != QEMU_VM_SECTION_FOOTER) {
-        error_report("Missing section footer for %s", le->se->idstr);
+        error_report("Missing section footer for %s", se->idstr);
         return false;
     }
 
     read_section_id = qemu_get_be32(f);
-    if (read_section_id != le->section_id) {
+    if (read_section_id != se->section_id) {
         error_report("Mismatched section id in footer for %s -"
                      " read 0x%x expected 0x%x",
-                     le->se->idstr, read_section_id, le->section_id);
+                     se->idstr, read_section_id, se->section_id);
         return false;
     }
 
@@ -1887,7 +1887,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
                      " device '%s'", instance_id, idstr);
         return ret;
     }
-    if (!check_section_footer(f, le)) {
+    if (!check_section_footer(f, se)) {
         return -EINVAL;
     }
 
@@ -1898,29 +1898,29 @@ static int
 qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
 {
     uint32_t section_id;
-    LoadStateEntry *le;
+    SaveStateEntry *se;
     int ret;
 
     section_id = qemu_get_be32(f);
 
     trace_qemu_loadvm_state_section_partend(section_id);
-    QLIST_FOREACH(le, &mis->loadvm_handlers, entry) {
-        if (le->section_id == section_id) {
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (se->section_id == section_id) {
             break;
         }
     }
-    if (le == NULL) {
+    if (se == NULL) {
         error_report("Unknown savevm section %d", section_id);
         return -EINVAL;
     }
 
-    ret = vmstate_load(f, le->se, le->version_id);
+    ret = vmstate_load(f, se, se->version_id);
     if (ret < 0) {
         error_report("error while loading state section id %d(%s)",
-                     section_id, le->se->idstr);
+                     section_id, se->idstr);
         return ret;
     }
-    if (!check_section_footer(f, le)) {
+    if (!check_section_footer(f, se)) {
         return -EINVAL;
     }
 
-- 
2.9.3
