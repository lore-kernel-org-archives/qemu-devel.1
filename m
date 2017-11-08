Received: from eggs.gnu.org ([2001:4830:134:3::10]:35686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJQp-0007s5-HX
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJQk-0006O7-Lq
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:01:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJQk-0006Nr-DC
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:01:42 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:00:59 +0800
Message-Id: <20171108060130.3772-2-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 01/32] migration: better error handling with
 QEMUFile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

If the postcopy down due to some reason, we can always see this on dst:

  qemu-system-x86_64: RP: Received invalid message 0x0000 length 0x0000

However in most cases that's not the real issue. The problem is that
qemu_get_be16() has no way to show whether the returned data is valid or
not, and we are _always_ assuming it is valid. That's possibly not wise.

The best approach to solve this would be: refactoring QEMUFile interface
to allow the APIs to return error if there is. However it needs quite a
bit of work and testing. For now, let's explicitly check the validity
first before using the data in all places for qemu_get_*().

This patch tries to fix most of the cases I can see. Only if we are with
this, can we make sure we are processing the valid data, and also can we
make sure we can capture the channel down events correctly.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c |  5 +++++
 migration/ram.c       | 26 ++++++++++++++++++++++----
 migration/savevm.c    | 40 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c0206023d7..eae34d0524 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1708,6 +1708,11 @@ static void *source_return_path_thread(void *opaque)
         header_type = qemu_get_be16(rp);
         header_len = qemu_get_be16(rp);
 
+        if (qemu_file_get_error(rp)) {
+            mark_source_rp_bad(ms);
+            goto out;
+        }
+
         if (header_type >= MIG_RP_MSG_MAX ||
             header_type == MIG_RP_MSG_INVALID) {
             error_report("RP: Received invalid message 0x%04x length 0x%04x",
diff --git a/migration/ram.c b/migration/ram.c
index 8620aa400a..960c726ff2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2687,7 +2687,7 @@ static int ram_load_postcopy(QEMUFile *f)
     void *last_host = NULL;
     bool all_zero = false;
 
-    while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
+    while (!(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr;
         void *host = NULL;
         void *page_buffer = NULL;
@@ -2696,6 +2696,16 @@ static int ram_load_postcopy(QEMUFile *f)
         uint8_t ch;
 
         addr = qemu_get_be64(f);
+
+        /*
+         * If qemu file error, we should stop here, and then "addr"
+         * may be invalid
+         */
+        ret = qemu_file_get_error(f);
+        if (ret) {
+            break;
+        }
+
         flags = addr & ~TARGET_PAGE_MASK;
         addr &= TARGET_PAGE_MASK;
 
@@ -2776,6 +2786,13 @@ static int ram_load_postcopy(QEMUFile *f)
             error_report("Unknown combination of migration flags: %#x"
                          " (postcopy mode)", flags);
             ret = -EINVAL;
+            break;
+        }
+
+        /* Detect for any possible file errors */
+        if (qemu_file_get_error(f)) {
+            ret = qemu_file_get_error(f);
+            break;
         }
 
         if (place_needed) {
@@ -2789,9 +2806,10 @@ static int ram_load_postcopy(QEMUFile *f)
                 ret = postcopy_place_page(mis, place_dest,
                                           place_source, block);
             }
-        }
-        if (!ret) {
-            ret = qemu_file_get_error(f);
+
+            if (ret) {
+                break;
+            }
         }
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 4a88228614..1da0255cd7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1765,6 +1765,11 @@ static int loadvm_process_command(QEMUFile *f)
     cmd = qemu_get_be16(f);
     len = qemu_get_be16(f);
 
+    /* Check validity before continue processing of cmds */
+    if (qemu_file_get_error(f)) {
+        return qemu_file_get_error(f);
+    }
+
     trace_loadvm_process_command(cmd, len);
     if (cmd >= MIG_CMD_MAX || cmd == MIG_CMD_INVALID) {
         error_report("MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
@@ -1830,6 +1835,7 @@ static int loadvm_process_command(QEMUFile *f)
  */
 static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 {
+    int ret;
     uint8_t read_mark;
     uint32_t read_section_id;
 
@@ -1840,6 +1846,13 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 
     read_mark = qemu_get_byte(f);
 
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        error_report("%s: Read section footer failed: %d",
+                     __func__, ret);
+        return false;
+    }
+
     if (read_mark != QEMU_VM_SECTION_FOOTER) {
         error_report("Missing section footer for %s", se->idstr);
         return false;
@@ -1875,6 +1888,13 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
     instance_id = qemu_get_be32(f);
     version_id = qemu_get_be32(f);
 
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        error_report("%s: Failed to read instance/version ID: %d",
+                     __func__, ret);
+        return ret;
+    }
+
     trace_qemu_loadvm_state_section_startfull(section_id, idstr,
             instance_id, version_id);
     /* Find savevm section */
@@ -1922,6 +1942,13 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
 
     section_id = qemu_get_be32(f);
 
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        error_report("%s: Failed to read section ID: %d",
+                     __func__, ret);
+        return ret;
+    }
+
     trace_qemu_loadvm_state_section_partend(section_id);
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->load_section_id == section_id) {
@@ -1989,8 +2016,14 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
     uint8_t section_type;
     int ret = 0;
 
-    while ((section_type = qemu_get_byte(f)) != QEMU_VM_EOF) {
-        ret = 0;
+    while (true) {
+        section_type = qemu_get_byte(f);
+
+        if (qemu_file_get_error(f)) {
+            ret = qemu_file_get_error(f);
+            break;
+        }
+
         trace_qemu_loadvm_state_section(section_type);
         switch (section_type) {
         case QEMU_VM_SECTION_START:
@@ -2014,6 +2047,9 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
                 goto out;
             }
             break;
+        case QEMU_VM_EOF:
+            /* This is the end of migration */
+            goto out;
         default:
             error_report("Unknown savevm section type %d", section_type);
             ret = -EINVAL;
-- 
2.13.6
