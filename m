Received: from eggs.gnu.org ([2001:4830:134:3::10]:52916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e988L-0005WF-IC
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e988J-0007ps-1x
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e988I-0007p9-Ol
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:21:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2CA97EA92
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 11:21:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 30 Oct 2017 12:21:12 +0100
Message-Id: <20171030112112.6952-7-quintela@redhat.com>
In-Reply-To: <20171030112112.6952-1-quintela@redhat.com>
References: <20171030112112.6952-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] migration: make migrate uri parameter
 optional
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

Now that we have set an uri migration parameter, we can make it
optional in the command line.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp-commands.hx       |  4 ++--
 hmp.c                 |  5 +++--
 migration/migration.c | 12 +++++++++---
 qapi/migration.json   |  2 +-
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 4afd57cf5f..5be4e3934d 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -928,8 +928,8 @@ ETEXI
 
     {
         .name       = "migrate",
-        .args_type  = "detach:-d,blk:-b,inc:-i,uri:s",
-        .params     = "[-d] [-b] [-i] uri",
+        .args_type  = "detach:-d,blk:-b,inc:-i,uri:-s",
+        .params     = "[-d] [-b] [-i] [uri]",
         .help       = "migrate to URI (using -d to not wait for completion)"
 		      "\n\t\t\t -b for migration without shared storage with"
 		      " full copy of disk\n\t\t\t -i for migration without "
diff --git a/hmp.c b/hmp.c
index 9c544560bb..f8fae740e8 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1938,10 +1938,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool detach = qdict_get_try_bool(qdict, "detach", false);
     bool blk = qdict_get_try_bool(qdict, "blk", false);
     bool inc = qdict_get_try_bool(qdict, "inc", false);
-    const char *uri = qdict_get_str(qdict, "uri");
+    bool has_uri = qdict_get_try_bool(qdict, "uri", false);
+    const char *uri = qdict_get_try_str(qdict, "uri");
     Error *err = NULL;
 
-    qmp_migrate(uri, !!blk, blk, !!inc, inc, false, false, &err);
+    qmp_migrate(!!has_uri, uri, !!blk, blk, !!inc, inc, false, false, &err);
     if (err) {
         error_report_err(err);
         return;
diff --git a/migration/migration.c b/migration/migration.c
index 507226907b..3818a83489 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1356,7 +1356,7 @@ bool migration_is_blocked(Error **errp)
     return false;
 }
 
-void qmp_migrate(const char *uri, bool has_blk, bool blk,
+void qmp_migrate(bool has_uri, const char *uri, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
                  Error **errp)
 {
@@ -1374,7 +1374,13 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         error_setg(errp, "Guest is waiting for an incoming migration");
         return;
     }
-    migrate_set_uri(uri, errp);
+    if (has_uri && uri) {
+        migrate_set_uri(uri, errp);
+    }
+    if (!s->parameters.uri) {
+        error_setg(errp, "Migration uri needs to be set");
+        return;
+    }
     if (migration_is_blocked(errp)) {
         return;
     }
@@ -1412,7 +1418,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (strstart(s->parameters.uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "s->parameters.uri",
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "migration uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
diff --git a/qapi/migration.json b/qapi/migration.json
index ebde890604..6b9758ab99 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1042,7 +1042,7 @@
 #
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool', '*detach': 'bool' } }
+  'data': {'*uri': 'str', '*blk': 'bool', '*inc': 'bool', '*detach': 'bool' } }
 
 ##
 # @migrate-incoming:
-- 
2.13.6
