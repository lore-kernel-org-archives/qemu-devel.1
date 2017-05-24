Received: from eggs.gnu.org ([2001:4830:134:3::10]:52213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafY-0003vI-JR
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafU-0001Lz-Jv
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dDafU-0001Lb-2w
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1FE6180F93
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 18:05:55 +0000 (UTC)
From: Vladislav Yasevich <vyasevic@redhat.com>
Date: Wed, 24 May 2017 14:05:23 -0400
Message-Id: <1495649128-10529-8-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
Subject: [Qemu-devel] [PATCH 07/12] migration: Allow for a limited number of
 announce timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com, Vladislav Yasevich <vyasevic@redhat.com>

We currently create a new announcement timer every time
qemu_announce_self() is called.  Since this is now a qmp
command, this can lead to abuse.   Limit the number of
timers that are created.  Give QMP interface and migration
process 1 timer each.  This way, QMP can't abuse the
announce_self mechanism.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 include/migration/vmstate.h |  1 +
 include/sysemu/sysemu.h     |  9 ++++++++-
 migration/migration.c       |  2 +-
 migration/savevm.c          | 24 +++++++++++++++++++-----
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f8aed9b..689b685 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1057,6 +1057,7 @@ void vmstate_register_ram_global(struct MemoryRegion *memory);
 
 typedef struct AnnounceTimer {
     QEMUTimer *tm;
+    struct AnnounceTimer **entry;
     AnnounceParameters params;
     QEMUClockType type;
     int round;
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 2ef1687..85a2af1 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -78,14 +78,21 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify);
 int save_vmstate(const char *name, Error **errp);
 int load_vmstate(const char *name, Error **errp);
 
+typedef enum AnnounceType {
+    QEMU_ANNOUNCE_MIGRATION,
+    QEMU_ANNOUNCE_USER,
+    QEMU_ANNOUNCE__MAX,
+} AnnounceType;
+
 AnnounceParameters *qemu_get_announce_params(void);
 void qemu_fill_announce_parameters(AnnounceParameters **to,
                                    AnnounceParameters *from);
+
 bool qemu_validate_announce_parameters(AnnounceParameters *params,
                                        Error **errp);
 void qemu_set_announce_parameters(AnnounceParameters *announce_params,
                                   AnnounceParameters *params);
-void qemu_announce_self(AnnounceParameters *params);
+void qemu_announce_self(AnnounceParameters *params, AnnounceType type);
 
 /* Subcommands for QEMU_VM_COMMAND */
 enum qemu_vm_cmd {
diff --git a/migration/migration.c b/migration/migration.c
index 987c1cf..724fc40 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -345,7 +345,7 @@ static void process_incoming_migration_bh(void *opaque)
      * This must happen after all error conditions are dealt with and
      * we're sure the VM is going to be running on this host.
      */
-    qemu_announce_self(qemu_get_announce_params());
+    qemu_announce_self(qemu_get_announce_params(), QEMU_ANNOUNCE_MIGRATION);
 
     /* If global state section was not received or we are in running
        state, we need to obey autostart. Any other state is set with
diff --git a/migration/savevm.c b/migration/savevm.c
index b55ce6a..dcba8bd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -218,6 +218,8 @@ static void qemu_announce_self_iter(NICState *nic, void *opaque)
     }
 }
 
+AnnounceTimer *announce_timers[QEMU_ANNOUNCE__MAX];
+
 static void qemu_announce_self_once(void *opaque)
 {
     AnnounceTimer *timer = (AnnounceTimer *)opaque;
@@ -228,6 +230,7 @@ static void qemu_announce_self_once(void *opaque)
         timer_mod(timer->tm, qemu_clock_get_ms(timer->type) +
                   self_announce_delay(timer));
     } else {
+            *(timer->entry) = NULL;
             timer_del(timer->tm);
             timer_free(timer->tm);
             g_free(timer);
@@ -256,12 +259,23 @@ AnnounceTimer *qemu_announce_timer_create(AnnounceParameters *params,
     return timer;
 }
 
-void qemu_announce_self(AnnounceParameters *params)
+void qemu_announce_self(AnnounceParameters *params, AnnounceType type)
 {
     AnnounceTimer *timer;
 
-    timer = qemu_announce_timer_create(params, QEMU_CLOCK_REALTIME,
-                                       qemu_announce_self_once);
+    timer = announce_timers[type];
+    if (!timer) {
+        timer = qemu_announce_timer_create(params, QEMU_CLOCK_REALTIME,
+                                            qemu_announce_self_once);
+        announce_timers[type] = timer;
+        timer->entry = &announce_timers[type];
+    } else {
+        /* For now, don't do anything.  If we want to reset the timer,
+         * we'll need to add locking to each announce timer to prevent
+         * races between timeout handling and a reset.
+         */
+        return;
+    }
     qemu_announce_self_once(timer);
 }
 
@@ -276,7 +290,7 @@ void qmp_announce_self(bool has_params, AnnounceParameters *params,
     if (has_params)
         qemu_set_announce_parameters(&announce_params, params);
 
-    qemu_announce_self(&announce_params);
+    qemu_announce_self(&announce_params, QEMU_ANNOUNCE_USER);
 }
 
 /***********************************************************/
@@ -1750,7 +1764,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
      */
     cpu_synchronize_all_post_init();
 
-    qemu_announce_self(qemu_get_announce_params());
+    qemu_announce_self(qemu_get_announce_params(), QEMU_ANNOUNCE_MIGRATION);
 
     /* Make sure all file formats flush their mutable metadata.
      * If we get an error here, just don't restart the VM yet. */
-- 
2.7.4
