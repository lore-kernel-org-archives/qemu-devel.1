Received: from eggs.gnu.org ([209.51.188.92]:51322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyzUv-0005cE-WE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gyzHM-00037V-1X
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:29:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gyzHL-00036y-Nt
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:29:43 -0500
Date: Wed, 27 Feb 2019 12:10:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190227121052.GD2602@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] possible ahci/migrate fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com

Hi Alex,
  Can you see if the attached patch fixes the ahci/migrate failure you
see;  it won't fail for me however mean I am to it.


=46rom f4c327d14d656d1c0f0e694d0efc6165493416f0 Mon Sep 17 00:00:00 2001
=46rom: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Wed, 27 Feb 2019 12:04:37 +0000
Subject: [PATCH] migration: Cleanup during exit

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
---
 migration/migration.c | 8 ++++++++
 vl.c                  | 7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index e44f77af02..f612313d09 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -126,6 +126,7 @@ static bool migration_object_check(MigrationState *ms, =
Error **errp);
 static int migration_maybe_pause(MigrationState *s,
                                  int *current_active_state,
                                  int new_state);
+static void migrate_fd_cancel(MigrationState *s);
=20
 void migration_object_init(void)
 {
@@ -169,6 +170,11 @@ void migration_object_init(void)
=20
 void migration_object_finalize(void)
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
index 2f340686a7..c1920165f3 100644
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
+    migration_object_finalize();
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

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
