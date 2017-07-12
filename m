Received: from eggs.gnu.org ([2001:4830:134:3::10]:60472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVBXG-000486-7Y
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVBXB-0005So-Cn
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:54:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVBXB-0005S7-5k
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:54:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12F6AC0587C1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 06:54:04 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 12 Jul 2017 14:53:43 +0800
Message-Id: <1499842423-21101-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1499842423-21101-1-git-send-email-peterx@redhat.com>
References: <1499842423-21101-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] migration: export capabilities to props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Do the same thing to migration capabilities, just like what we did in
previous patch for migration parameters.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index fd00670..7e6f353 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2001,6 +2001,9 @@ void migration_global_dump(Monitor *mon)
                    ms->send_configuration, ms->send_section_footer);
 }
 
+#define DEFINE_PROP_MIG_CAP(name, x)             \
+    DEFINE_PROP_BOOL(name, MigrationState, enabled_capabilities[x], false)
+
 static Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
@@ -2034,6 +2037,20 @@ static Property migration_properties[] = {
     DEFINE_PROP_INT64("x-checkpoint-delay", MigrationState,
                       parameters.x_checkpoint_delay,
                       DEFAULT_MIGRATE_X_CHECKPOINT_DELAY),
+
+    /* Migration capabilities */
+    DEFINE_PROP_MIG_CAP("xbzrle", MIGRATION_CAPABILITY_XBZRLE),
+    DEFINE_PROP_MIG_CAP("rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
+    DEFINE_PROP_MIG_CAP("auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
+    DEFINE_PROP_MIG_CAP("zero-blocks", MIGRATION_CAPABILITY_ZERO_BLOCKS),
+    DEFINE_PROP_MIG_CAP("compress", MIGRATION_CAPABILITY_COMPRESS),
+    DEFINE_PROP_MIG_CAP("events", MIGRATION_CAPABILITY_EVENTS),
+    DEFINE_PROP_MIG_CAP("postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
+    DEFINE_PROP_MIG_CAP("x-colo", MIGRATION_CAPABILITY_X_COLO),
+    DEFINE_PROP_MIG_CAP("release-ram", MIGRATION_CAPABILITY_RELEASE_RAM),
+    DEFINE_PROP_MIG_CAP("block", MIGRATION_CAPABILITY_BLOCK),
+    DEFINE_PROP_MIG_CAP("return-path", MIGRATION_CAPABILITY_RETURN_PATH),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.7.4
