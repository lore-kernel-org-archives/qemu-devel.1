Received: from eggs.gnu.org ([2001:4830:134:3::10]:38738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD8xZ-0005ku-52
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD8xX-00014a-EM
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dD8xX-00013g-5n
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33FA080C0F
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 12:30:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 23 May 2017 14:30:37 +0200
Message-Id: <1495542638-12335-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1495542638-12335-1-git-send-email-armbru@redhat.com>
References: <1495542638-12335-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] block: Use QDict helpers for --force-share
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Fam's addition of --force-share in commits 459571f7 and 335e9937
were developed prior to the addition of QDict scalar insertion
macros, but merged after the general cleanup in commit 46f5ac20.
Patch created mechanically by rerunning:

 spatch --sp-file scripts/coccinelle/qobject.cocci \
        --macro-file scripts/cocci-macro-file.h --dir . --in-place

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170515195439.17677-1-eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-img.c | 7 +++----
 qemu-io.c  | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b506839..60f1784 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -296,7 +296,7 @@ static BlockBackend *img_open_opts(const char *optstr,
             error_report("--force-share/-U conflicts with image options");
             return NULL;
         }
-        qdict_put(options, BDRV_OPT_FORCE_SHARE, qbool_from_bool(true));
+        qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
     }
     blk = blk_new_open(NULL, NULL, options, flags, &local_err);
     if (!blk) {
@@ -326,7 +326,7 @@ static BlockBackend *img_open_file(const char *filename,
     }
 
     if (force_share) {
-        qdict_put(options, BDRV_OPT_FORCE_SHARE, qbool_from_bool(true));
+        qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
     }
     blk = blk_new_open(filename, NULL, options, flags, &local_err);
     if (!blk) {
@@ -3156,8 +3156,7 @@ static int img_rebase(int argc, char **argv)
             if (!options) {
                 options = qdict_new();
             }
-            qdict_put(options, BDRV_OPT_FORCE_SHARE,
-                      qbool_from_bool(true));
+            qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
         }
         bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name));
         blk_old_backing = blk_new_open(backing_name, NULL,
diff --git a/qemu-io.c b/qemu-io.c
index 34fa8a1..8e38b28 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -76,7 +76,7 @@ static int openfile(char *name, int flags, bool writethrough, bool force_share,
             QDECREF(opts);
             return 1;
         }
-        qdict_put(opts, BDRV_OPT_FORCE_SHARE, qbool_from_bool(true));
+        qdict_put_bool(opts, BDRV_OPT_FORCE_SHARE, true);
     }
     qemuio_blk = blk_new_open(name, NULL, opts, flags, &local_err);
     if (!qemuio_blk) {
-- 
2.7.4
