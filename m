Received: from eggs.gnu.org ([2001:4830:134:3::10]:55768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38b6-0007mO-RO
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38b6-0006Ds-01
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38b5-0006Cx-QU
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEF7223E6D0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:06:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:47 +0200
Message-Id: <20170425220451.6028-38-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 37/41] migration: Move last funtions to misc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

After this, nothing outside of migration uses migration.h

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h | 7 -------
 include/migration/misc.h      | 8 +++++++-
 ui/spice-core.c               | 2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 1e18b24..735f565 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -133,17 +133,10 @@ void migrate_fd_error(MigrationState *s, const Error *error);
 
 void migrate_fd_connect(MigrationState *s);
 
-void add_migration_state_change_notifier(Notifier *notify);
-void remove_migration_state_change_notifier(Notifier *notify);
 MigrationState *migrate_init(void);
 bool migration_is_blocked(Error **errp);
-bool migration_in_setup(MigrationState *);
-bool migration_has_finished(MigrationState *);
-bool migration_has_failed(MigrationState *);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
-/* ...and after the device transmission */
-bool migration_in_postcopy_after_devices(MigrationState *);
 MigrationState *migrate_get_current(void);
 
 bool migrate_release_ram(void);
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 6709b15..28f69be 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -41,5 +41,11 @@ void savevm_skip_configuration(void);
 /* migration/migration.c */
 void qemu_start_incoming_migration(const char *uri, Error **errp);
 bool migration_is_idle(void);
-
+void add_migration_state_change_notifier(Notifier *notify);
+void remove_migration_state_change_notifier(Notifier *notify);
+bool migration_in_setup(MigrationState *);
+bool migration_has_finished(MigrationState *);
+bool migration_has_failed(MigrationState *);
+/* ...and after the device transmission */
+bool migration_in_postcopy_after_devices(MigrationState *);
 #endif
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 804abc5..a087ad5 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -35,7 +35,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu/notify.h"
-#include "migration/migration.h"
+#include "migration/misc.h"
 #include "hw/hw.h"
 #include "ui/spice-display.h"
 #include "qapi-event.h"
-- 
2.9.3
