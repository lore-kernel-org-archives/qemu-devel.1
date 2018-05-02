Received: from eggs.gnu.org ([2001:4830:134:3::10]:34831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpJ5-0006V0-PX
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpJ2-0002r7-ME
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49680 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDpJ2-0002qq-FV
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:16 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:47:23 +0800
Message-Id: <20180502104740.12123-8-peterx@redhat.com>
In-Reply-To: <20180502104740.12123-1-peterx@redhat.com>
References: <20180502104740.12123-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 07/24] qmp: hmp: add migrate "resume" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

It will be used when we want to resume one paused migration.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json   | 5 ++++-
 hmp.c                 | 4 +++-
 migration/migration.c | 2 +-
 hmp-commands.hx       | 7 ++++---
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 97891aec89..17b78c9938 100644
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
index 9d184b3f36..9faf22d3ae 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1408,7 +1408,7 @@ bool migration_is_blocked(Error **errp)
 
 void qmp_migrate(const char *uri, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
-                 Error **errp)
+                 bool has_resume, bool resume, Error **errp)
 {
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
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
 
-- 
2.14.3
