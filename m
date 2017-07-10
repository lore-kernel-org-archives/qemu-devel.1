Received: from eggs.gnu.org ([2001:4830:134:3::10]:35644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUcD0-0004rb-8s
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUcCy-0008Le-U6
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dUcCy-0008L5-K9
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE53C8A003
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 17:10:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 10 Jul 2017 18:10:36 +0100
Message-Id: <20170710171040.21021-6-dgilbert@redhat.com>
In-Reply-To: <20170710171040.21021-1-dgilbert@redhat.com>
References: <20170710171040.21021-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] migration: Rename save_live_setup() to
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
Cc: quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Juan Quintela <quintela@redhat.com>

We are going to use it now for more than save live regions.
Once there rename qemu_savevm_state_begin() to qemu_savevm_state_setup().

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170628095228.4661-2-quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/ppc/spapr.c               |  2 +-
 include/migration/register.h |  2 +-
 migration/block.c            |  2 +-
 migration/colo.c             |  2 +-
 migration/migration.c        |  2 +-
 migration/ram.c              |  2 +-
 migration/savevm.c           | 12 ++++++------
 migration/savevm.h           |  2 +-
 migration/trace-events       |  2 +-
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0ee9fac50b..ba87be5d48 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1953,7 +1953,7 @@ static void htab_cleanup(void *opaque)
 }
 
 static SaveVMHandlers savevm_htab_handlers = {
-    .save_live_setup = htab_save_setup,
+    .save_setup = htab_save_setup,
     .save_live_iterate = htab_save_iterate,
     .save_live_complete_precopy = htab_save_complete,
     .cleanup = htab_cleanup,
diff --git a/include/migration/register.h b/include/migration/register.h
index d9498d95eb..f607769e83 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -33,7 +33,7 @@ typedef struct SaveVMHandlers {
     int (*save_live_iterate)(QEMUFile *f, void *opaque);
 
     /* This runs outside the iothread lock!  */
-    int (*save_live_setup)(QEMUFile *f, void *opaque);
+    int (*save_setup)(QEMUFile *f, void *opaque);
     void (*save_live_pending)(QEMUFile *f, void *opaque,
                               uint64_t threshold_size,
                               uint64_t *non_postcopiable_pending,
diff --git a/migration/block.c b/migration/block.c
index 86c0b96cd1..7a7e83a268 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -1008,7 +1008,7 @@ static bool block_is_active(void *opaque)
 }
 
 static SaveVMHandlers savevm_block_handlers = {
-    .save_live_setup = block_save_setup,
+    .save_setup = block_save_setup,
     .save_live_iterate = block_save_iterate,
     .save_live_complete_precopy = block_save_complete,
     .save_live_pending = block_save_pending,
diff --git a/migration/colo.c b/migration/colo.c
index c4ba4c328b..ef35f00c9a 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -350,7 +350,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     /* Disable block migration */
     migrate_set_block_enabled(false, &local_err);
     qemu_savevm_state_header(fb);
-    qemu_savevm_state_begin(fb);
+    qemu_savevm_state_setup(fb);
     qemu_mutex_lock_iothread();
     qemu_savevm_state_complete_precopy(fb, false, false);
     qemu_mutex_unlock_iothread();
diff --git a/migration/migration.c b/migration/migration.c
index 31d46d1343..beea01ce63 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1835,7 +1835,7 @@ static void *migration_thread(void *opaque)
         qemu_savevm_send_postcopy_advise(s->to_dst_file);
     }
 
-    qemu_savevm_state_begin(s->to_dst_file);
+    qemu_savevm_state_setup(s->to_dst_file);
 
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
diff --git a/migration/ram.c b/migration/ram.c
index 0baa1e0d56..480248a00f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2623,7 +2623,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
 }
 
 static SaveVMHandlers savevm_ram_handlers = {
-    .save_live_setup = ram_save_setup,
+    .save_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
     .save_live_complete_postcopy = ram_save_complete,
     .save_live_complete_precopy = ram_save_complete,
diff --git a/migration/savevm.c b/migration/savevm.c
index be3f885119..66f816040e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -596,7 +596,7 @@ int register_savevm_live(DeviceState *dev,
     se->opaque = opaque;
     se->vmsd = NULL;
     /* if this is a live_savem then set is_ram */
-    if (ops->save_live_setup != NULL) {
+    if (ops->save_setup != NULL) {
         se->is_ram = 1;
     }
 
@@ -955,14 +955,14 @@ void qemu_savevm_state_header(QEMUFile *f)
     }
 }
 
-void qemu_savevm_state_begin(QEMUFile *f)
+void qemu_savevm_state_setup(QEMUFile *f)
 {
     SaveStateEntry *se;
     int ret;
 
-    trace_savevm_state_begin();
+    trace_savevm_state_setup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops || !se->ops->save_live_setup) {
+        if (!se->ops || !se->ops->save_setup) {
             continue;
         }
         if (se->ops && se->ops->is_active) {
@@ -972,7 +972,7 @@ void qemu_savevm_state_begin(QEMUFile *f)
         }
         save_section_header(f, se, QEMU_VM_SECTION_START);
 
-        ret = se->ops->save_live_setup(f, se->opaque);
+        ret = se->ops->save_setup(f, se->opaque);
         save_section_footer(f, se);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
@@ -1241,7 +1241,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 
     qemu_mutex_unlock_iothread();
     qemu_savevm_state_header(f);
-    qemu_savevm_state_begin(f);
+    qemu_savevm_state_setup(f);
     qemu_mutex_lock_iothread();
 
     while (qemu_file_get_error(f) == 0) {
diff --git a/migration/savevm.h b/migration/savevm.h
index 5a2ed1161d..6babc6221a 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -30,7 +30,7 @@
 #define QEMU_VM_SECTION_FOOTER       0x7e
 
 bool qemu_savevm_state_blocked(Error **errp);
-void qemu_savevm_state_begin(QEMUFile *f);
+void qemu_savevm_state_setup(QEMUFile *f);
 void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
diff --git a/migration/trace-events b/migration/trace-events
index 38345be9c3..9669e94ddc 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -32,7 +32,7 @@ savevm_send_open_return_path(void) ""
 savevm_send_ping(uint32_t val) "%x"
 savevm_send_postcopy_listen(void) ""
 savevm_send_postcopy_run(void) ""
-savevm_state_begin(void) ""
+savevm_state_setup(void) ""
 savevm_state_header(void) ""
 savevm_state_iterate(void) ""
 savevm_state_cleanup(void) ""
-- 
2.13.0
