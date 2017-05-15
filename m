Received: from eggs.gnu.org ([2001:4830:134:3::10]:50447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAM54-0007bp-6a
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAM53-0002FN-9n
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:54:58 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 15 May 2017 14:54:39 -0500
Message-Id: <20170515195439.17677-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Use QDict helpers for --force-share
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, armbru@redhat.com, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Fam's addition of --force-share in commits 459571f7 and 335e9937
were developed prior to the addition of QDict scalar insertion
macros, but merged after the general cleanup in commit 46f5ac20.
Patch created mechanically by rerunning:

 spatch --sp-file scripts/coccinelle/qobject.cocci \
        --macro-file scripts/cocci-macro-file.h --dir . --in-place

Signed-off-by: Eric Blake <eblake@redhat.com>
---

This could go in through Markus' qapi tree (since he took the
original cleanup), a block maintainer (since it only touches block
files), or even the trivial patch queue (since it's so small and
mechanical) - I don't care which, as long as we don't drop it!

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
2.9.4
