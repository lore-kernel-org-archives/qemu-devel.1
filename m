Received: from eggs.gnu.org ([209.51.188.92]:34583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJ2a-0005be-2m
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJ2Y-0001Rk-3f
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBJ2X-0001Ow-G9
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 802B670D71
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 13:01:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EDDB84909
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 13:01:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  2 Apr 2019 15:01:10 +0200
Message-Id: <20190402130112.15142-7-armbru@redhat.com>
In-Reply-To: <20190402130112.15142-1-armbru@redhat.com>
References: <20190402130112.15142-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] migration: Support adding migration
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
Message-Id: <20190401090827.20793-4-armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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
