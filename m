Received: from eggs.gnu.org ([2001:4830:134:3::10]:47522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMg-0007bx-RN
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMf-0000Pg-Ja
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:42 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  2 May 2018 23:32:18 +0200
Message-Id: <20180502213219.7842-7-mreitz@redhat.com>
In-Reply-To: <20180502213219.7842-1-mreitz@redhat.com>
References: <20180502213219.7842-1-mreitz@redhat.com>
Subject: [Qemu-devel] [RFC 6/7] block: Use {blk_new, bdrv}_open_string_opts()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This patch makes every caller of blk_new_open() and bdrv_open() instead
call blk_new_open_string_opts() or bdrv_open_string_opts(),
respectively, when needed.  That is the case when the blockdev options
QDict may contain incorrectly typed string values.

In fact, all callers converted in this patch pass dicts that contain
string values only; and after this patch, all remaining callers of
blk_new_open() and bdrv_open() indeed guarantee that the dicts contain
only values that are correctly typed.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
Assuming that bdrv_open_inherit() always receives correctly typed
options and that parse_json_filename() always returns a correctly typed
dict, bs->options will always be correctly typed after this patch (as
far as I can see, that is).  All other callers of bdrv_open_inherit()
besides bdrv_open() and bdrv_open_string_opts() will inductively fulfill
these conditions, if they are met before them.

Now, of course both assumptions are wrong in the general case.
parse_json_filename() will only return a correctly typed dict if the
user used the correct types, or if all values were strings (which can be
converted with bdrv_type_blockdev_opts()).  Forbidding all other cases
could be seen as a bug fix, though.

But even more importantly, bdrv_open_string_opts() may receive a dict
that does not match the schema because there are string values that do
not match it.
---
 blockdev.c               | 8 ++++++--
 qemu-img.c               | 3 ++-
 qemu-io.c                | 2 +-
 qemu-nbd.c               | 2 +-
 tests/test-replication.c | 6 +++---
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 9d4955f23e..3e1125cbfa 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -595,7 +595,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
             bdrv_flags |= BDRV_O_INACTIVE;
         }
 
-        blk = blk_new_open(file, NULL, bs_opts, bdrv_flags, errp);
+        blk = blk_new_open_string_opts(file, bs_opts, bdrv_flags, errp);
         if (!blk) {
             goto err_no_bs_opts;
         }
@@ -670,7 +670,11 @@ static BlockDriverState *bds_tree_init(QDict *bs_opts, bool string_opts,
         bdrv_flags |= BDRV_O_INACTIVE;
     }
 
-    return bdrv_open(NULL, NULL, bs_opts, bdrv_flags, errp);
+    if (string_opts) {
+        return bdrv_open_string_opts(NULL, bs_opts, bdrv_flags, errp);
+    } else {
+        return bdrv_open(NULL, NULL, bs_opts, bdrv_flags, errp);
+    }
 }
 
 void blockdev_close_all_bdrv_states(void)
diff --git a/qemu-img.c b/qemu-img.c
index 42b60917b0..a29d76797f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -284,7 +284,7 @@ static BlockBackend *img_open_opts(const char *optstr,
         }
         qdict_put_str(options, BDRV_OPT_FORCE_SHARE, "on");
     }
-    blk = blk_new_open(NULL, NULL, options, flags, &local_err);
+    blk = blk_new_open_string_opts(NULL, options, flags, &local_err);
     if (!blk) {
         error_reportf_err(local_err, "Could not open '%s': ", optstr);
         return NULL;
@@ -294,6 +294,7 @@ static BlockBackend *img_open_opts(const char *optstr,
     return blk;
 }
 
+/* @options must be correctly typed */
 static BlockBackend *img_open_file(const char *filename,
                                    QDict *options,
                                    const char *fmt, int flags,
diff --git a/qemu-io.c b/qemu-io.c
index 0755a30447..544e47b7fc 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -102,7 +102,7 @@ static int openfile(char *name, int flags, bool writethrough, bool force_share,
         }
         qdict_put_str(opts, BDRV_OPT_FORCE_SHARE, "on");
     }
-    qemuio_blk = blk_new_open(name, NULL, opts, flags, &local_err);
+    qemuio_blk = blk_new_open_string_opts(name, opts, flags, &local_err);
     if (!qemuio_blk) {
         error_reportf_err(local_err, "can't open%s%s: ",
                           name ? " device " : "", name ?: "");
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 0af0560ad1..e5e1877106 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -944,7 +944,7 @@ int main(int argc, char **argv)
         }
         options = qemu_opts_to_qdict(opts, NULL);
         qemu_opts_reset(&file_opts);
-        blk = blk_new_open(NULL, NULL, options, flags, &local_err);
+        blk = blk_new_open_string_opts(NULL, options, flags, &local_err);
     } else {
         if (fmt) {
             options = qdict_new();
diff --git a/tests/test-replication.c b/tests/test-replication.c
index 68c0d04f2a..5a2bae66fd 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -191,7 +191,7 @@ static BlockBackend *start_primary(void)
     qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
     qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
 
-    blk = blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &local_err);
+    blk = blk_new_open_string_opts(NULL, qdict, BDRV_O_RDWR, &local_err);
     g_assert(blk);
     g_assert(!local_err);
 
@@ -323,7 +323,7 @@ static BlockBackend *start_secondary(void)
     qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
     qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
 
-    blk = blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &local_err);
+    blk = blk_new_open_string_opts(NULL, qdict, BDRV_O_RDWR, &local_err);
     assert(blk);
     monitor_add_blk(blk, S_LOCAL_DISK_ID, &local_err);
     g_assert(!local_err);
@@ -350,7 +350,7 @@ static BlockBackend *start_secondary(void)
     qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
     qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
 
-    blk = blk_new_open(NULL, NULL, qdict, BDRV_O_RDWR, &local_err);
+    blk = blk_new_open_string_opts(NULL, qdict, BDRV_O_RDWR, &local_err);
     assert(blk);
     monitor_add_blk(blk, S_ID, &local_err);
     g_assert(!local_err);
-- 
2.14.3
