Received: from eggs.gnu.org ([2001:4830:134:3::10]:57786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHtoM-0000el-2O
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHtoI-0002oI-AH
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gHtoI-0002dn-0H
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5669F81DEC
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 16:57:31 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 31 Oct 2018 16:57:25 +0000
Message-Id: <20181031165725.61938-4-dgilbert@redhat.com>
In-Reply-To: <20181031165725.61938-1-dgilbert@redhat.com>
References: <20181031165725.61938-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] migration: avoid segmentfault when take a
 snapshot of a VM which being migrated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com

From: Jia Lina <jialina01@baidu.com>

During an active background migration, snapshot will trigger a
segmentfault. As snapshot clears the "current_migration" struct
and updates "to_dst_file" before it finds out that there is a
migration task, Migration accesses the null pointer in
"current_migration" struct and qemu crashes eventually.

Signed-off-by: Jia Lina <jialina01@baidu.com>
Signed-off-by: Chai Wen <chaiwen@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Message-Id: <20181026083620.10172-1-jialina01@baidu.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c |  2 +-
 migration/migration.h |  2 ++
 migration/savevm.c    | 19 +++++++++++--------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8b36e7f184..b261c1e4ce 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -742,7 +742,7 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
  * Return true if we're already in the middle of a migration
  * (i.e. any of the active or setup states)
  */
-static bool migration_is_setup_or_active(int state)
+bool migration_is_setup_or_active(int state)
 {
     switch (state) {
     case MIGRATION_STATUS_ACTIVE:
diff --git a/migration/migration.h b/migration/migration.h
index f7813f8261..e413d4d8b6 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -241,6 +241,8 @@ void migrate_fd_error(MigrationState *s, const Error =
*error);
=20
 void migrate_fd_connect(MigrationState *s, Error *error_in);
=20
+bool migration_is_setup_or_active(int state);
+
 void migrate_init(MigrationState *s);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
diff --git a/migration/savevm.c b/migration/savevm.c
index 9992af4db4..ef707b8c43 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1327,21 +1327,25 @@ static int qemu_savevm_state(QEMUFile *f, Error *=
*errp)
     MigrationState *ms =3D migrate_get_current();
     MigrationStatus status;
=20
-    migrate_init(ms);
-
-    ms->to_dst_file =3D f;
+    if (migration_is_setup_or_active(ms->state) ||
+        ms->state =3D=3D MIGRATION_STATUS_CANCELLING ||
+        ms->state =3D=3D MIGRATION_STATUS_COLO) {
+        error_setg(errp, QERR_MIGRATION_ACTIVE);
+        return -EINVAL;
+    }
=20
     if (migration_is_blocked(errp)) {
-        ret =3D -EINVAL;
-        goto done;
+        return -EINVAL;
     }
=20
     if (migrate_use_block()) {
         error_setg(errp, "Block migration and snapshots are incompatible=
");
-        ret =3D -EINVAL;
-        goto done;
+        return -EINVAL;
     }
=20
+    migrate_init(ms);
+    ms->to_dst_file =3D f;
+
     qemu_mutex_unlock_iothread();
     qemu_savevm_state_header(f);
     qemu_savevm_state_setup(f);
@@ -1363,7 +1367,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **e=
rrp)
         error_setg_errno(errp, -ret, "Error while writing VM state");
     }
=20
-done:
     if (ret !=3D 0) {
         status =3D MIGRATION_STATUS_FAILED;
     } else {
--=20
2.19.1
