Received: from eggs.gnu.org ([2001:4830:134:3::10]:55647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNckF-0002LA-El
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dNckE-0004xF-CZ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dNckE-0004w5-4P
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3AEA380F9D
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 10:20:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 21 Jun 2017 12:20:02 +0200
Message-Id: <20170621102005.18701-3-quintela@redhat.com>
In-Reply-To: <20170621102005.18701-1-quintela@redhat.com>
References: <20170621102005.18701-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/5] migration: Rename cleanup() to
 save_cleanup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, kwolf@redhat.com, stefanha@redhat.com

We need a cleanup for loads, so we rename here to be consistent.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

Rename htab_cleanup to htap_save_cleanup as dave suggestion
---
 hw/ppc/spapr.c               | 4 ++--
 include/migration/register.h | 2 +-
 migration/block.c            | 2 +-
 migration/ram.c              | 2 +-
 migration/savevm.c           | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 422109f..5e28719 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1861,7 +1861,7 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
     return 0;
 }
 
-static void htab_cleanup(void *opaque)
+static void htab_save_cleanup(void *opaque)
 {
     sPAPRMachineState *spapr = opaque;
 
@@ -1872,7 +1872,7 @@ static SaveVMHandlers savevm_htab_handlers = {
     .save_setup = htab_save_setup,
     .save_live_iterate = htab_save_iterate,
     .save_live_complete_precopy = htab_save_complete,
-    .cleanup = htab_cleanup,
+    .save_cleanup = htab_save_cleanup,
     .load_state = htab_load,
 };
 
diff --git a/include/migration/register.h b/include/migration/register.h
index f607769..938ea2b 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -18,7 +18,7 @@ typedef struct SaveVMHandlers {
     /* This runs inside the iothread lock.  */
     SaveStateHandler *save_state;
 
-    void (*cleanup)(void *opaque);
+    void (*save_cleanup)(void *opaque);
     int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
     int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
 
diff --git a/migration/block.c b/migration/block.c
index 7cb77e5..0c24a7f 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -1009,7 +1009,7 @@ static SaveVMHandlers savevm_block_handlers = {
     .save_live_complete_precopy = block_save_complete,
     .save_live_pending = block_save_pending,
     .load_state = block_load,
-    .cleanup = block_migration_cleanup,
+    .save_cleanup = block_migration_cleanup,
     .is_active = block_is_active,
 };
 
diff --git a/migration/ram.c b/migration/ram.c
index 480248a..649f76c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2629,7 +2629,7 @@ static SaveVMHandlers savevm_ram_handlers = {
     .save_live_complete_precopy = ram_save_complete,
     .save_live_pending = ram_save_pending,
     .load_state = ram_load,
-    .cleanup = ram_migration_cleanup,
+    .save_cleanup = ram_migration_cleanup,
 };
 
 void ram_mig_init(void)
diff --git a/migration/savevm.c b/migration/savevm.c
index c699dc9..7d273f9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1237,8 +1237,8 @@ void qemu_savevm_state_cleanup(void)
 
     trace_savevm_state_cleanup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (se->ops && se->ops->cleanup) {
-            se->ops->cleanup(se->opaque);
+        if (se->ops && se->ops->save_cleanup) {
+            se->ops->save_cleanup(se->opaque);
         }
     }
 }
-- 
2.9.4
