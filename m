Received: from eggs.gnu.org ([209.51.188.92]:45976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwBYO-0007cR-CD
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwBYM-0000TM-I7
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:59:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gwBYL-0000R0-QL
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:59:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46F753DFCD
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 19:59:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 19 Feb 2019 19:59:28 +0000
Message-Id: <20190219195928.12289-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration: Fix cancel state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

During a cancelled migration there's a race where the fd can
go into an error state before we get back around the migration loop
and migration_detect_error transitions from cancelling->failed.

Check for cancelled/cancelling and don't change the state.

Red Hat bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D1608649

Fixes: b23c2ade250
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c39d3054ec..e44f77af02 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2911,6 +2911,13 @@ static MigThrError postcopy_pause(MigrationState *=
s)
 static MigThrError migration_detect_error(MigrationState *s)
 {
     int ret;
+    int state =3D s->state;
+
+    if (state =3D=3D MIGRATION_STATUS_CANCELLING ||
+        state =3D=3D MIGRATION_STATUS_CANCELLED) {
+        /* End the migration, but don't set the state to failed */
+        return MIG_THR_ERR_FATAL;
+    }
=20
     /* Try to detect any file errors */
     ret =3D qemu_file_get_error(s->to_dst_file);
@@ -2920,7 +2927,7 @@ static MigThrError migration_detect_error(Migration=
State *s)
         return MIG_THR_ERR_NONE;
     }
=20
-    if (s->state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE && ret =3D=3D -=
EIO) {
+    if (state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE && ret =3D=3D -EIO=
) {
         /*
          * For postcopy, we allow the network to be down for a
          * while. After that, it can be continued by a
@@ -2932,7 +2939,7 @@ static MigThrError migration_detect_error(Migration=
State *s)
          * For precopy (or postcopy with error outside IO), we fail
          * with no time.
          */
-        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
         trace_migration_thread_file_err();
=20
         /* Time to stop the migration, now. */
--=20
2.20.1
