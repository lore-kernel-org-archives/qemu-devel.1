Received: from eggs.gnu.org ([209.51.188.92]:50072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1EcN-0001JM-7W
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1EcM-00024F-1x
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1EcL-00023Y-Nb
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:41 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Mar 2019 18:15:57 +0000
Message-Id: <20190305181602.9051-17-dgilbert@redhat.com>
In-Reply-To: <20190305181602.9051-1-dgilbert@redhat.com>
References: <20190305181602.9051-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/21] migration/ram.c: add a notifier chain for
 precopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

From: Wei Wang <wei.w.wang@intel.com>

This patch adds a notifier chain for the memory precopy. This enables var=
ious
precopy optimizations to be invoked at specific places.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <1544516693-5395-6-git-send-email-wei.w.wang@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/misc.h | 19 +++++++++++++++
 migration/ram.c          | 51 +++++++++++++++++++++++++++++++++++++---
 migration/savevm.c       | 15 ++++++++++++
 vl.c                     |  1 +
 4 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index a3809fc67e..54871b67b1 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -20,6 +20,25 @@
=20
 /* migration/ram.c */
=20
+typedef enum PrecopyNotifyReason {
+    PRECOPY_NOTIFY_SETUP =3D 0,
+    PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC =3D 1,
+    PRECOPY_NOTIFY_AFTER_BITMAP_SYNC =3D 2,
+    PRECOPY_NOTIFY_COMPLETE =3D 3,
+    PRECOPY_NOTIFY_CLEANUP =3D 4,
+    PRECOPY_NOTIFY_MAX =3D 5,
+} PrecopyNotifyReason;
+
+typedef struct PrecopyNotifyData {
+    enum PrecopyNotifyReason reason;
+    Error **errp;
+} PrecopyNotifyData;
+
+void precopy_infrastructure_init(void);
+void precopy_add_notifier(NotifierWithReturn *n);
+void precopy_remove_notifier(NotifierWithReturn *n);
+int precopy_notify(PrecopyNotifyReason reason, Error **errp);
+
 void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
=20
diff --git a/migration/ram.c b/migration/ram.c
index 32c0dbb98a..bee4fb3fd4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -354,6 +354,32 @@ typedef struct RAMState RAMState;
=20
 static RAMState *ram_state;
=20
+static NotifierWithReturnList precopy_notifier_list;
+
+void precopy_infrastructure_init(void)
+{
+    notifier_with_return_list_init(&precopy_notifier_list);
+}
+
+void precopy_add_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_list_add(&precopy_notifier_list, n);
+}
+
+void precopy_remove_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_remove(n);
+}
+
+int precopy_notify(PrecopyNotifyReason reason, Error **errp)
+{
+    PrecopyNotifyData pnd;
+    pnd.reason =3D reason;
+    pnd.errp =3D errp;
+
+    return notifier_with_return_list_notify(&precopy_notifier_list, &pnd=
);
+}
+
 uint64_t ram_bytes_remaining(void)
 {
     return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_S=
IZE) :
@@ -1741,6 +1767,25 @@ static void migration_bitmap_sync(RAMState *rs)
     }
 }
=20
+static void migration_bitmap_sync_precopy(RAMState *rs)
+{
+    Error *local_err =3D NULL;
+
+    /*
+     * The current notifier usage is just an optimization to migration, =
so we
+     * don't stop the normal migration process in the error case.
+     */
+    if (precopy_notify(PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC, &local_err)) {
+        error_report_err(local_err);
+    }
+
+    migration_bitmap_sync(rs);
+
+    if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC, &local_err)) {
+        error_report_err(local_err);
+    }
+}
+
 /**
  * save_zero_page_to_file: send the zero page to the file
  *
@@ -3123,7 +3168,7 @@ static void ram_init_bitmaps(RAMState *rs)
=20
     ram_list_init_bitmaps();
     memory_global_dirty_log_start();
-    migration_bitmap_sync(rs);
+    migration_bitmap_sync_precopy(rs);
=20
     rcu_read_unlock();
     qemu_mutex_unlock_ramlist();
@@ -3403,7 +3448,7 @@ static int ram_save_complete(QEMUFile *f, void *opa=
que)
     rcu_read_lock();
=20
     if (!migration_in_postcopy()) {
-        migration_bitmap_sync(rs);
+        migration_bitmap_sync_precopy(rs);
     }
=20
     ram_control_before_iterate(f, RAM_CONTROL_FINISH);
@@ -3452,7 +3497,7 @@ static void ram_save_pending(QEMUFile *f, void *opa=
que, uint64_t max_size,
         remaining_size < max_size) {
         qemu_mutex_lock_iothread();
         rcu_read_lock();
-        migration_bitmap_sync(rs);
+        migration_bitmap_sync_precopy(rs);
         rcu_read_unlock();
         qemu_mutex_unlock_iothread();
         remaining_size =3D rs->migration_dirty_pages * TARGET_PAGE_SIZE;
diff --git a/migration/savevm.c b/migration/savevm.c
index 013098581f..1415001d1c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1088,6 +1088,7 @@ void qemu_savevm_state_header(QEMUFile *f)
 void qemu_savevm_state_setup(QEMUFile *f)
 {
     SaveStateEntry *se;
+    Error *local_err =3D NULL;
     int ret;
=20
     trace_savevm_state_setup();
@@ -1109,6 +1110,10 @@ void qemu_savevm_state_setup(QEMUFile *f)
             break;
         }
     }
+
+    if (precopy_notify(PRECOPY_NOTIFY_SETUP, &local_err)) {
+        error_report_err(local_err);
+    }
 }
=20
 int qemu_savevm_state_resume_prepare(MigrationState *s)
@@ -1251,6 +1256,11 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f=
, bool iterable_only,
     SaveStateEntry *se;
     int ret;
     bool in_postcopy =3D migration_in_postcopy();
+    Error *local_err =3D NULL;
+
+    if (precopy_notify(PRECOPY_NOTIFY_COMPLETE, &local_err)) {
+        error_report_err(local_err);
+    }
=20
     trace_savevm_state_complete_precopy();
=20
@@ -1383,6 +1393,11 @@ void qemu_savevm_state_pending(QEMUFile *f, uint64=
_t threshold_size,
 void qemu_savevm_state_cleanup(void)
 {
     SaveStateEntry *se;
+    Error *local_err =3D NULL;
+
+    if (precopy_notify(PRECOPY_NOTIFY_CLEANUP, &local_err)) {
+        error_report_err(local_err);
+    }
=20
     trace_savevm_state_cleanup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
diff --git a/vl.c b/vl.c
index 502857a176..c02a900649 100644
--- a/vl.c
+++ b/vl.c
@@ -3039,6 +3039,7 @@ int main(int argc, char **argv, char **envp)
     module_call_init(MODULE_INIT_OPTS);
=20
     runstate_init();
+    precopy_infrastructure_init();
     postcopy_infrastructure_init();
     monitor_init_globals();
=20
--=20
2.20.1
