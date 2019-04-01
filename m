Received: from eggs.gnu.org ([209.51.188.92]:36471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hAqE7-0003EH-Bn
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hAqE6-00070z-Cj
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:15:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:53896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hAqE4-0006vB-Ps
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 02:15:22 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Mon,  1 Apr 2019 14:14:57 +0800
Message-Id: <20190401061457.9393-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] migration: cleanup check on ops in
 savevm.handlers iteration
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

During migration, there are several places to iterate on
savevm.handlers. And on each iteration, we need to check its ops and
related callbacks before invoke it.

Generally, ops is the first element to check, and it is only necessary
to check it once.

This patch clean all the related part in savevm.c to check ops only once
in those iterations.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/savevm.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 5f0ca7fac2..92af2471cd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1096,10 +1096,9 @@ void qemu_savevm_state_setup(QEMUFile *f)
         if (!se->ops || !se->ops->save_setup) {
             continue;
         }
-        if (se->ops && se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
+        if (se->ops->is_active &&
+            !se->ops->is_active(se->opaque)) {
                 continue;
-            }
         }
         save_section_header(f, se, QEMU_VM_SECTION_START);
 
@@ -1127,10 +1126,9 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
         if (!se->ops || !se->ops->resume_prepare) {
             continue;
         }
-        if (se->ops && se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
+        if (se->ops->is_active &&
+            !se->ops->is_active(se->opaque)) {
                 continue;
-            }
         }
         ret = se->ops->resume_prepare(s, se->opaque);
         if (ret < 0) {
@@ -1223,10 +1221,9 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
         if (!se->ops || !se->ops->save_live_complete_postcopy) {
             continue;
         }
-        if (se->ops && se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
+        if (se->ops->is_active &&
+            !se->ops->is_active(se->opaque)) {
                 continue;
-            }
         }
         trace_savevm_section_start(se->idstr, se->section_id);
         /* Section type */
@@ -1265,18 +1262,16 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
     cpu_synchronize_all_states();
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops ||
+        if (!se->ops || !se->ops->save_live_complete_precopy ||
             (in_postcopy && se->ops->has_postcopy &&
              se->ops->has_postcopy(se->opaque)) ||
-            (in_postcopy && !iterable_only) ||
-            !se->ops->save_live_complete_precopy) {
+            (in_postcopy && !iterable_only)) {
             continue;
         }
 
-        if (se->ops && se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
+        if (se->ops->is_active &&
+            !se->ops->is_active(se->opaque)) {
                 continue;
-            }
         }
         trace_savevm_section_start(se->idstr, se->section_id);
 
@@ -1377,10 +1372,9 @@ void qemu_savevm_state_pending(QEMUFile *f, uint64_t threshold_size,
         if (!se->ops || !se->ops->save_live_pending) {
             continue;
         }
-        if (se->ops && se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
+        if (se->ops->is_active &&
+            !se->ops->is_active(se->opaque)) {
                 continue;
-            }
         }
         se->ops->save_live_pending(f, se->opaque, threshold_size,
                                    res_precopy_only, res_compatible,
@@ -2276,10 +2270,9 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
         if (!se->ops || !se->ops->load_setup) {
             continue;
         }
-        if (se->ops && se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
+        if (se->ops->is_active &&
+            !se->ops->is_active(se->opaque)) {
                 continue;
-            }
         }
 
         ret = se->ops->load_setup(f, se->opaque);
-- 
2.19.1
