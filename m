Received: from eggs.gnu.org ([2001:4830:134:3::10]:39165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euMEQ-00086f-Oj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:55:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euMEQ-0003NI-3c
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:55:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45602 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1euMEP-0003N4-Vd
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:55:02 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  9 Mar 2018 17:54:52 +0000
Message-Id: <20180309175453.41548-6-dgilbert@redhat.com>
In-Reply-To: <20180309175453.41548-1-dgilbert@redhat.com>
References: <20180309175453.41548-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] migration: fix applying wrong capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pl@kamp.de, peterx@redhat.com, quintela@redhat.com

From: Peter Xu <peterx@redhat.com>

When setting migration capabilities via QMP/HMP, we'll apply them even
if the capability check failed.  Fix it.

Fixes: 4a84214ebe ("migration: provide migrate_caps_check()", 2017-07-18)
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180305094938.31374-1-peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 62c243d2d4..6a4780ef6f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -747,13 +747,15 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
 {
     MigrationState *s = migrate_get_current();
     MigrationCapabilityStatusList *cap;
+    bool cap_list[MIGRATION_CAPABILITY__MAX];
 
     if (migration_is_setup_or_active(s->state)) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
         return;
     }
 
-    if (!migrate_caps_check(s->enabled_capabilities, params, errp)) {
+    memcpy(cap_list, s->enabled_capabilities, sizeof(cap_list));
+    if (!migrate_caps_check(cap_list, params, errp)) {
         return;
     }
 
-- 
2.14.3
