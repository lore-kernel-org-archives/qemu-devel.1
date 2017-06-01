Received: from eggs.gnu.org ([2001:4830:134:3::10]:51165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGYNu-0003jB-Fh
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGYNt-0005qo-5Q
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:16:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGYNs-0005qZ-Ri
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:16:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5DD0804F2
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 22:15:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  2 Jun 2017 00:15:48 +0200
Message-Id: <20170601221552.30628-2-quintela@redhat.com>
In-Reply-To: <20170601221552.30628-1-quintela@redhat.com>
References: <20170601221552.30628-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] migration: Rename save_live_setup() to
 save_setup()
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

We are going to use it now for more than save live regions.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/ppc/spapr.c               | 2 +-
 include/migration/register.h | 2 +-
 migration/block.c            | 2 +-
 migration/ram.c              | 2 +-
 migration/savevm.c           | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0aadde6..d51a361 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1873,7 +1873,7 @@ static void htab_cleanup(void *opaque)
 }
 
 static SaveVMHandlers savevm_htab_handlers = {
-    .save_live_setup = htab_save_setup,
+    .save_setup = htab_save_setup,
     .save_live_iterate = htab_save_iterate,
     .save_live_complete_precopy = htab_save_complete,
     .cleanup = htab_cleanup,
diff --git a/include/migration/register.h b/include/migration/register.h
index 844afaf..6cb27f4 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -36,7 +36,7 @@ typedef struct SaveVMHandlers {
     int (*save_live_iterate)(QEMUFile *f, void *opaque);
 
     /* This runs outside the iothread lock!  */
-    int (*save_live_setup)(QEMUFile *f, void *opaque);
+    int (*save_setup)(QEMUFile *f, void *opaque);
     void (*save_live_pending)(QEMUFile *f, void *opaque,
                               uint64_t threshold_size,
                               uint64_t *non_postcopiable_pending,
diff --git a/migration/block.c b/migration/block.c
index 14a8a84..976c42e 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -995,7 +995,7 @@ static bool block_is_active(void *opaque)
 }
 
 static SaveVMHandlers savevm_block_handlers = {
-    .save_live_setup = block_save_setup,
+    .save_setup = block_save_setup,
     .save_live_iterate = block_save_iterate,
     .save_live_complete_precopy = block_save_complete,
     .save_live_pending = block_save_pending,
diff --git a/migration/ram.c b/migration/ram.c
index 1164f14..f2c13e2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2597,7 +2597,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 }
 
 static SaveVMHandlers savevm_ram_handlers = {
-    .save_live_setup = ram_save_setup,
+    .save_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
     .save_live_complete_postcopy = ram_save_complete,
     .save_live_complete_precopy = ram_save_complete,
diff --git a/migration/savevm.c b/migration/savevm.c
index 8489abf..67c9c39 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -606,7 +606,7 @@ int register_savevm_live(DeviceState *dev,
     se->opaque = opaque;
     se->vmsd = NULL;
     /* if this is a live_savem then set is_ram */
-    if (ops->save_live_setup != NULL) {
+    if (ops->save_setup != NULL) {
         se->is_ram = 1;
     }
 
@@ -1000,7 +1000,7 @@ void qemu_savevm_state_begin(QEMUFile *f)
 
     trace_savevm_state_begin();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops || !se->ops->save_live_setup) {
+        if (!se->ops || !se->ops->save_setup) {
             continue;
         }
         if (se->ops && se->ops->is_active) {
@@ -1010,7 +1010,7 @@ void qemu_savevm_state_begin(QEMUFile *f)
         }
         save_section_header(f, se, QEMU_VM_SECTION_START);
 
-        ret = se->ops->save_live_setup(f, se->opaque);
+        ret = se->ops->save_setup(f, se->opaque);
         save_section_footer(f, se);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
-- 
2.9.4
