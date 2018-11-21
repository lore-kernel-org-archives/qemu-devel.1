Received: from eggs.gnu.org ([2001:4830:134:3::10]:55261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPSBv-0008Nq-K5
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPSBn-0006Pt-Ba
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:05:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gPSBl-0006Km-8C
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:05:05 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 21 Nov 2018 13:04:55 +0000
Message-Id: <20181121130456.35661-2-dgilbert@redhat.com>
In-Reply-To: <20181121130456.35661-1-dgilbert@redhat.com>
References: <20181121130456.35661-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] migration/colo.c: Fix compilation issue
 when disable replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, chen.zhang@intel.com, zhangckid@gmail.com, quintela@redhat.com
Cc: peterx@redhat.com

From: Zhang Chen <zhangckid@gmail.com>

This compilation issue will occur when user use --disable-replication
to config Qemu.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Message-Id: <20181101021226.6353-1-zhangckid@gmail.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/migration/colo.c b/migration/colo.c
index 956ac236b7..fcff04c78c 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -59,6 +59,8 @@ static bool colo_runstate_is_stopped(void)
=20
 static void secondary_vm_do_failover(void)
 {
+/* COLO needs enable block-replication */
+#ifdef CONFIG_REPLICATION
     int old_state;
     MigrationIncomingState *mis =3D migration_incoming_get_current();
     Error *local_err =3D NULL;
@@ -121,10 +123,14 @@ static void secondary_vm_do_failover(void)
     if (mis->migration_incoming_co) {
         qemu_coroutine_enter(mis->migration_incoming_co);
     }
+#else
+    abort();
+#endif
 }
=20
 static void primary_vm_do_failover(void)
 {
+#ifdef CONFIG_REPLICATION
     MigrationState *s =3D migrate_get_current();
     int old_state;
     Error *local_err =3D NULL;
@@ -165,6 +171,9 @@ static void primary_vm_do_failover(void)
=20
     /* Notify COLO thread that failover work is finished */
     qemu_sem_post(&s->colo_exit_sem);
+#else
+    abort();
+#endif
 }
=20
 COLOMode get_colo_mode(void)
@@ -415,11 +424,16 @@ static int colo_do_checkpoint_transaction(Migration=
State *s,
     /* Disable block migration */
     migrate_set_block_enabled(false, &local_err);
     qemu_mutex_lock_iothread();
+
+#ifdef CONFIG_REPLICATION
     replication_do_checkpoint_all(&local_err);
     if (local_err) {
         qemu_mutex_unlock_iothread();
         goto out;
     }
+#else
+        abort();
+#endif
=20
     colo_send_message(s->to_dst_file, COLO_MESSAGE_VMSTATE_SEND, &local_=
err);
     if (local_err) {
@@ -523,11 +537,15 @@ static void colo_process_checkpoint(MigrationState =
*s)
     object_unref(OBJECT(bioc));
=20
     qemu_mutex_lock_iothread();
+#ifdef CONFIG_REPLICATION
     replication_start_all(REPLICATION_MODE_PRIMARY, &local_err);
     if (local_err) {
         qemu_mutex_unlock_iothread();
         goto out;
     }
+#else
+        abort();
+#endif
=20
     vm_start();
     qemu_mutex_unlock_iothread();
@@ -690,11 +708,15 @@ void *colo_process_incoming_thread(void *opaque)
     object_unref(OBJECT(bioc));
=20
     qemu_mutex_lock_iothread();
+#ifdef CONFIG_REPLICATION
     replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
     if (local_err) {
         qemu_mutex_unlock_iothread();
         goto out;
     }
+#else
+        abort();
+#endif
     vm_start();
     trace_colo_vm_state_change("stop", "run");
     qemu_mutex_unlock_iothread();
@@ -785,18 +807,22 @@ void *colo_process_incoming_thread(void *opaque)
             goto out;
         }
=20
+#ifdef CONFIG_REPLICATION
         replication_get_error_all(&local_err);
         if (local_err) {
             qemu_mutex_unlock_iothread();
             goto out;
         }
+
         /* discard colo disk buffer */
         replication_do_checkpoint_all(&local_err);
         if (local_err) {
             qemu_mutex_unlock_iothread();
             goto out;
         }
-
+#else
+        abort();
+#endif
         /* Notify all filters of all NIC to do checkpoint */
         colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
=20
--=20
2.19.1
