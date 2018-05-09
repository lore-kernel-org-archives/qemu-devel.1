Received: from eggs.gnu.org ([2001:4830:134:3::10]:58647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDH-0004hJ-0H
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDD-0001Jl-Q8
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNDD-0001J4-LX
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5060E8E7B4
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:24:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:45 +0200
Message-Id: <20180509112406.6183-21-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 20/41] qmp: hmp: add migrate "resume" option
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

From: Peter Xu <peterx@redhat.com>

It will be used when we want to resume one paused migration.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-8-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp-commands.hx       | 7 ++++---
 hmp.c                 | 4 +++-
 migration/migration.c | 2 +-
 qapi/migration.json   | 5 ++++-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 35d862a5d2..078ded20cd 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -897,13 +897,14 @@ ETEXI
 
     {
         .name       = "migrate",
-        .args_type  = "detach:-d,blk:-b,inc:-i,uri:s",
-        .params     = "[-d] [-b] [-i] uri",
+        .args_type  = "detach:-d,blk:-b,inc:-i,resume:-r,uri:s",
+        .params     = "[-d] [-b] [-i] [-r] uri",
         .help       = "migrate to URI (using -d to not wait for completion)"
 		      "\n\t\t\t -b for migration without shared storage with"
 		      " full copy of disk\n\t\t\t -i for migration without "
 		      "shared storage with incremental copy of disk "
-		      "(base image shared between src and destination)",
+		      "(base image shared between src and destination)"
+                      "\n\t\t\t -r to resume a paused migration",
         .cmd        = hmp_migrate,
     },
 
diff --git a/hmp.c b/hmp.c
index 898e25f3e1..59d5341590 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1919,10 +1919,12 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool detach = qdict_get_try_bool(qdict, "detach", false);
     bool blk = qdict_get_try_bool(qdict, "blk", false);
     bool inc = qdict_get_try_bool(qdict, "inc", false);
+    bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
 
-    qmp_migrate(uri, !!blk, blk, !!inc, inc, false, false, &err);
+    qmp_migrate(uri, !!blk, blk, !!inc, inc,
+                false, false, true, resume, &err);
     if (err) {
         hmp_handle_error(mon, &err);
         return;
diff --git a/migration/migration.c b/migration/migration.c
index 3d3b0a5b4a..19f07fb64f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1413,7 +1413,7 @@ bool migration_is_blocked(Error **errp)
 
 void qmp_migrate(const char *uri, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
-                 Error **errp)
+                 bool has_resume, bool resume, Error **errp)
 {
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
diff --git a/qapi/migration.json b/qapi/migration.json
index 244334e9f4..84ae4b90d5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1031,6 +1031,8 @@
 # @detach: this argument exists only for compatibility reasons and
 #          is ignored by QEMU
 #
+# @resume: resume one paused migration, default "off". (since 2.12)
+#
 # Returns: nothing on success
 #
 # Since: 0.14.0
@@ -1052,7 +1054,8 @@
 #
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool', '*detach': 'bool' } }
+  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
+           '*detach': 'bool', '*resume': 'bool' } }
 
 ##
 # @migrate-incoming:
-- 
2.17.0
