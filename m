Received: from eggs.gnu.org ([2001:4830:134:3::10]:38266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGVh2-0004NO-60
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGVh0-0004qR-JH
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGVh0-0004px-9z
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:23:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56393BB9C1
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 19:23:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  1 Jun 2017 21:23:13 +0200
Message-Id: <20170601192327.29712-2-quintela@redhat.com>
In-Reply-To: <20170601192327.29712-1-quintela@redhat.com>
References: <20170601192327.29712-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 01/15] migration: Use savevm_handlers instead of
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

There is no reason for having the loadvm_handlers at all.  There is
only one use, and we can use the savevm handlers.

We will remove the loadvm handlers on a following patch.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

- Added load_version_id: version_id read from the stream (laurent)
- Added load_section_id: section_id read from the stream (dave)
---
 migration/savevm.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index a2d4f9c..07646f4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -272,7 +272,11 @@ typedef struct SaveStateEntry {
     int instance_id;
     int alias_id;
     int version_id;
+    /* version id read from the stream */
+    int load_version_id;
     int section_id;
+    /* section id read from the stream */
+    int load_section_id;
     SaveVMHandlers *ops;
     const VMStateDescription *vmsd;
     void *opaque;
@@ -1813,7 +1817,7 @@ struct LoadStateEntry {
  * Returns: true if the footer was good
  *          false if there is a problem (and calls error_report to say why)
  */
-static bool check_section_footer(QEMUFile *f, LoadStateEntry *le)
+static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 {
     uint8_t read_mark;
     uint32_t read_section_id;
@@ -1826,15 +1830,15 @@ static bool check_section_footer(QEMUFile *f, LoadStateEntry *le)
     read_mark = qemu_get_byte(f);
 
     if (read_mark != QEMU_VM_SECTION_FOOTER) {
-        error_report("Missing section footer for %s", le->se->idstr);
+        error_report("Missing section footer for %s", se->idstr);
         return false;
     }
 
     read_section_id = qemu_get_be32(f);
-    if (read_section_id != le->section_id) {
+    if (read_section_id != se->load_section_id) {
         error_report("Mismatched section id in footer for %s -"
                      " read 0x%x expected 0x%x",
-                     le->se->idstr, read_section_id, le->section_id);
+                     se->idstr, read_section_id, se->load_section_id);
         return false;
     }
 
@@ -1887,6 +1891,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
                      version_id, idstr, se->version_id);
         return -EINVAL;
     }
+    se->load_version_id = version_id;
+    se->load_section_id = section_id;
 
     /* Validate if it is a device's state */
     if (xen_enabled() && se->is_ram) {
@@ -1902,13 +1908,13 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
     le->version_id = version_id;
     QLIST_INSERT_HEAD(&mis->loadvm_handlers, le, entry);
 
-    ret = vmstate_load(f, le->se, le->version_id);
+    ret = vmstate_load(f, se, se->load_version_id);
     if (ret < 0) {
         error_report("error while loading state for instance 0x%x of"
                      " device '%s'", instance_id, idstr);
         return ret;
     }
-    if (!check_section_footer(f, le)) {
+    if (!check_section_footer(f, se)) {
         return -EINVAL;
     }
 
@@ -1919,29 +1925,29 @@ static int
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
+        if (se->load_section_id == section_id) {
             break;
         }
     }
-    if (le == NULL) {
+    if (se == NULL) {
         error_report("Unknown savevm section %d", section_id);
         return -EINVAL;
     }
 
-    ret = vmstate_load(f, le->se, le->version_id);
+    ret = vmstate_load(f, se, se->load_version_id);
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
2.9.4
