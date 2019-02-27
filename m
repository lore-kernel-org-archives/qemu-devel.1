Received: from eggs.gnu.org ([209.51.188.92]:43521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gz2OL-00059k-FE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gz2OJ-0002cO-Ts
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:49:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gz2OJ-0002bO-IQ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:49:07 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 27 Feb 2019 16:49:00 +0000
Message-Id: <20190227164900.16378-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration: Cleanup during exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, alex.bennee@linaro.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Currently we cleanup the migration object as we exit main after the
main_loop finishes; however if there's a migration running things
get messy and we can end up with the migration thread still trying
to access freed structures.

We now take a ref to the object around the migration thread itself,
so the act of dropping the ref during exit doesn't cause us to lose
the state until the thread quits.

Cancelling the migration during migration also tries to get the thread
to quit.

We do this a bit earlier; so hopefully migration gets out of the way
before all the devices etc are freed.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 include/migration/misc.h |  2 +-
 migration/migration.c    | 10 +++++++++-
 vl.c                     |  7 ++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 0471e04d1f..6f9df74436 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -36,7 +36,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);
=20
 /* migration/migration.c */
 void migration_object_init(void);
-void migration_object_finalize(void);
+void migration_shutdown(void);
 void qemu_start_incoming_migration(const char *uri, Error **errp);
 bool migration_is_idle(void);
 void add_migration_state_change_notifier(Notifier *notify);
diff --git a/migration/migration.c b/migration/migration.c
index e44f77af02..d45561f9b8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -126,6 +126,7 @@ static bool migration_object_check(MigrationState *ms=
, Error **errp);
 static int migration_maybe_pause(MigrationState *s,
                                  int *current_active_state,
                                  int new_state);
+static void migrate_fd_cancel(MigrationState *s);
=20
 void migration_object_init(void)
 {
@@ -167,8 +168,13 @@ void migration_object_init(void)
     }
 }
=20
-void migration_object_finalize(void)
+void migration_shutdown(void)
 {
+    /*
+     * Cancel the current migration - that will (eventually)
+     * stop the migration using this structure
+     */
+    migrate_fd_cancel(current_migration);
     object_unref(OBJECT(current_migration));
 }
=20
@@ -3134,6 +3140,7 @@ static void *migration_thread(void *opaque)
=20
     rcu_register_thread();
=20
+    object_ref(OBJECT(s));
     s->iteration_start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
=20
     qemu_savevm_state_header(s->to_dst_file);
@@ -3230,6 +3237,7 @@ static void *migration_thread(void *opaque)
=20
     trace_migration_thread_after_loop();
     migration_iteration_finish(s);
+    object_unref(OBJECT(s));
     rcu_unregister_thread();
     return NULL;
 }
diff --git a/vl.c b/vl.c
index 2f340686a7..e7f460a114 100644
--- a/vl.c
+++ b/vl.c
@@ -4579,6 +4579,12 @@ int main(int argc, char **argv, char **envp)
=20
     gdbserver_cleanup();
=20
+    /*
+     * cleaning up the migration object cancels any existing migration
+     * try to do this early so that it also stops using devices.
+     */
+    migration_shutdown();
+
     /* No more vcpu or device emulation activity beyond this point */
     vm_shutdown();
=20
@@ -4594,7 +4600,6 @@ int main(int argc, char **argv, char **envp)
     monitor_cleanup();
     qemu_chr_cleanup();
     user_creatable_cleanup();
-    migration_object_finalize();
     /* TODO: unref root container, check all devices are ok */
=20
     return 0;
--=20
2.20.1
