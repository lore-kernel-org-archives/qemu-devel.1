Received: from eggs.gnu.org ([2001:4830:134:3::10]:39865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvJ-0000C6-S9
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvI-0008MC-Fq
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:17 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Mar 2017 10:56:03 +0200
Message-Id: <1490691368-32099-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1490691368-32099-1-git-send-email-armbru@redhat.com>
References: <1490691368-32099-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 for-2.9 05/10] rbd: Don't accept -drive
 driver=rbd, keyvalue-pairs=...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

The way we communicate extra key-value pairs from
qemu_rbd_parse_filename() to qemu_rbd_open() exposes option parameter
"keyvalue-pairs" on the command line.  It's not wanted there.  Hack:
rename the parameter to "=keyvalue-pairs" to make it inaccessible.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 182a5a3..2632533 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -215,7 +215,7 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
     }
 
     if (keypairs[0]) {
-        qdict_put(options, "keyvalue-pairs", qstring_from_str(keypairs));
+        qdict_put(options, "=keyvalue-pairs", qstring_from_str(keypairs));
     }
 
 
@@ -330,7 +330,11 @@ static QemuOptsList runtime_opts = {
             .help = "Rados id name",
         },
         {
-            .name = "keyvalue-pairs",
+            /*
+             * HACK: name starts with '=' so that qemu_opts_parse()
+             * can't set it
+             */
+            .name = "=keyvalue-pairs",
             .type = QEMU_OPT_STRING,
             .help = "Legacy rados key/value option parameters",
         },
@@ -405,7 +409,7 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
     conf       = qemu_opt_get(rbd_opts, "conf");
     clientname = qemu_opt_get(rbd_opts, "user");
     name       = qemu_opt_get(rbd_opts, "image");
-    keypairs   = qemu_opt_get(rbd_opts, "keyvalue-pairs");
+    keypairs   = qemu_opt_get(rbd_opts, "=keyvalue-pairs");
 
     ret = rados_create(&cluster, clientname);
     if (ret < 0) {
@@ -638,7 +642,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     snap           = qemu_opt_get(opts, "snapshot");
     clientname     = qemu_opt_get(opts, "user");
     name           = qemu_opt_get(opts, "image");
-    keypairs       = qemu_opt_get(opts, "keyvalue-pairs");
+    keypairs       = qemu_opt_get(opts, "=keyvalue-pairs");
 
     if (!pool || !name) {
         error_setg(errp, "Parameters 'pool' and 'image' are required");
-- 
2.7.4
