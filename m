Received: from eggs.gnu.org ([2001:4830:134:3::10]:60305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csUfW-00026t-8y
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csUfQ-0006Ou-6K
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csUfP-0006O1-VC
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0218D6561
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 13:26:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Mar 2017 15:26:29 +0200
Message-Id: <1490621195-2228-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-1-git-send-email-armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 for-2.9 05/11] rbd: Don't accept -drive
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
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

The way we communicate extra key-value pairs from
qemu_rbd_parse_filename() to qemu_rbd_open() exposes option parameter
"keyvalue-pairs" on the command line.  It's not wanted there.  Hack:
rename the parameter to "=keyvalue-pairs" to make it inaccessible.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
