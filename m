Received: from eggs.gnu.org ([2001:4830:134:3::10]:37068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ejjUy-0006bC-NQ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ejjUu-0005Yz-Ip
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:32:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ejjUu-0005Xr-Dn
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:32:08 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu,  8 Feb 2018 18:31:14 +0800
Message-Id: <20180208103132.28452-11-peterx@redhat.com>
In-Reply-To: <20180208103132.28452-1-peterx@redhat.com>
References: <20180208103132.28452-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 10/28] qmp: hmp: add migrate "resume" option
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
 hmp-commands.hx       | 7 ++++---
 hmp.c                 | 4 +++-
 migration/migration.c | 2 +-
 qapi/migration.json   | 5 ++++-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 15620c94d3..28ed5a7a13 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -895,13 +895,14 @@ ETEXI
 
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
index b3de32d219..6f8eec8365 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1921,10 +1921,12 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
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
index 4a8c873b52..dbcc3f6296 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1362,7 +1362,7 @@ bool migration_is_blocked(Error **errp)
 
 void qmp_migrate(const char *uri, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
-                 Error **errp)
+                 bool has_resume, bool resume, Error **errp)
 {
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
diff --git a/qapi/migration.json b/qapi/migration.json
index 49d27f3b29..9d6ccfec6b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1012,6 +1012,8 @@
 # @detach: this argument exists only for compatibility reasons and
 #          is ignored by QEMU
 #
+# @resume: resume one paused migration, default "off". (since 2.12)
+#
 # Returns: nothing on success
 #
 # Since: 0.14.0
@@ -1033,7 +1035,8 @@
 #
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool', '*detach': 'bool' } }
+  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
+           '*detach': 'bool', '*resume': 'bool' } }
 
 ##
 # @migrate-incoming:
-- 
2.14.3
