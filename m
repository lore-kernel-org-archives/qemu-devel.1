Received: from eggs.gnu.org ([2001:4830:134:3::10]:52735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eUUIb-0000RC-CT
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 04:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eUUIY-0003W7-67
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 04:16:25 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:33714 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eUUIX-0003U5-Qa
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 04:16:22 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 28 Dec 2017 12:16:16 +0300
Message-Id: <20171228091616.7999-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] migration: finalize current_migration object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, dgilbert@redhat.com, quintela@redhat.com, peterx@redhat.com

current_migration has .instance_finalize callback, but it is not
called, because nobody unrefs current_migration. Fix that.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Note: migration_object_init() is called from main() too.
      _finalize looks a bit weird after all _cleanp's, but
      it finally calls migration_instance_finalize, so it
      should be more correct.

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
index 4de3b551fe..090678f6a8 100644
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
2.11.1
