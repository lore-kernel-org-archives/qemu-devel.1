Received: from eggs.gnu.org ([209.51.188.92]:40773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAsvi-0005Lv-Lw
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAsvh-0004EU-NM
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hAsvh-0004Dx-GL
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:33 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  1 Apr 2019 11:08:25 +0200
Message-Id: <20190401090827.20793-4-armbru@redhat.com>
In-Reply-To: <20190401090827.20793-1-armbru@redhat.com>
References: <20190401090827.20793-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/5] migration: Support adding migration
 blockers earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com, kwolf@redhat.com, imammedo@redhat.com

migrate_add_blocker() asserts we have a current_migration object, in
migrate_get_current().  We do only after migration_object_init().

This contributes to the following dependency cycle:

* configure_blockdev() must run before machine_set_property()
  so machine properties can refer to block backends

* machine_set_property() before configure_accelerator()
  so machine properties like kvm-irqchip get applied

* configure_accelerator() before migration_object_init()
  so that Xen's accelerator compat properties get applied.

* migration_object_init() before configure_blockdev()
  so configure_blockdev() can add migration blockers

The cycle was closed when recent commit cda4aa9a5a0 "Create block
backends before setting machine properties" added the first
dependency, and satisfied it by violating the last one.  Broke block
backends that add migration blockers, as demonstrated by qemu-iotests
055.

To fix it, break the last dependency: make migrate_add_blocker()
usable before migration_object_init().

The previous commit already removed the use of migrate_get_current()
from migrate_add_blocker() itself.  Didn't quite do the trick, as
there's another one hiding in migration_is_idle().

The use there isn't actually necessary: when no migration object has
been created yet, migration is surely idle.  Make migration_is_idle()
return true then.

Fixes: cda4aa9a5a08777cf13e164c0543bd4888b8adce
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index f6076e5295..609e0df5d0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1646,7 +1646,11 @@ bool migration_in_postcopy_after_devices(MigrationState *s)
 
 bool migration_is_idle(void)
 {
-    MigrationState *s = migrate_get_current();
+    MigrationState *s = current_migration;
+
+    if (!s) {
+        return true;
+    }
 
     switch (s->state) {
     case MIGRATION_STATUS_NONE:
-- 
2.17.2
