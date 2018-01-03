Received: from eggs.gnu.org ([2001:4830:134:3::10]:34794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVx-0007RJ-Nk
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVw-0007MP-Ik
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:39:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWfVw-0007Le-Bp
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:39:12 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Jan 2018 10:38:34 +0100
Message-Id: <20180103093834.20879-15-quintela@redhat.com>
In-Reply-To: <20180103093834.20879-1-quintela@redhat.com>
References: <20180103093834.20879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 14/14] migration: finalize current_migration
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

current_migration has .instance_finalize callback, but it is not
called, because nobody unrefs current_migration. Fix that.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/misc.h | 1 +
 migration/migration.c    | 5 +++++
 vl.c                     | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index c079b7771b..77fd4f587c 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -44,6 +44,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);
 
 /* migration/migration.c */
 void migration_object_init(void);
+void migration_object_finalize(void);
 void qemu_start_incoming_migration(const char *uri, Error **errp);
 bool migration_is_idle(void);
 void add_migration_state_change_notifier(Notifier *notify);
diff --git a/migration/migration.c b/migration/migration.c
index 17cc219da2..7a77b193c1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -132,6 +132,11 @@ void migration_object_init(void)
     }
 }
 
+void migration_object_finalize(void)
+{
+    object_unref(OBJECT(current_migration));
+}
+
 /* For outgoing */
 MigrationState *migrate_get_current(void)
 {
diff --git a/vl.c b/vl.c
index d3a5c5d021..073aef4b84 100644
--- a/vl.c
+++ b/vl.c
@@ -4874,6 +4874,7 @@ int main(int argc, char **argv, char **envp)
     monitor_cleanup();
     qemu_chr_cleanup();
     user_creatable_cleanup();
+    migration_object_finalize();
     /* TODO: unref root container, check all devices are ok */
 
     return 0;
-- 
2.14.3
