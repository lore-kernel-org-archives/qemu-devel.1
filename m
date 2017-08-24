Received: from eggs.gnu.org ([2001:4830:134:3::10]:37146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmO-0003PL-Ii
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmK-0000Me-Js
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dknmK-0000Lx-BQ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:16 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 10:45:57 +0200
Message-Id: <1503564371-26090-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1503564371-26090-1-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 02/16] qapi: Drop superfluous qapi_enum_parse()
 parameter max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

The lookup tables have a sentinel, no need to make callers pass their
size.

Fun: the header has it in the wrong position.  Good riddance.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c                  |  1 -
 block/file-posix.c       |  7 +++----
 block/file-win32.c       |  2 +-
 block/gluster.c          |  6 ++----
 block/parallels.c        |  3 ++-
 block/qcow2.c            |  6 ++----
 blockdev.c               |  1 -
 hmp.c                    |  2 +-
 include/qapi/util.h      |  2 +-
 migration/global_state.c |  3 +--
 qapi/qapi-util.c         |  4 ++--
 qemu-img.c               |  3 +--
 qemu-nbd.c               |  1 -
 tests/test-qapi-util.c   | 15 +++++----------
 14 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/block.c b/block.c
index 3615a68..dd0efa2 100644
--- a/block.c
+++ b/block.c
@@ -1335,7 +1335,6 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
         BlockdevDetectZeroesOptions value =
             qapi_enum_parse(BlockdevDetectZeroesOptions_lookup,
                             detect_zeroes,
-                            BLOCKDEV_DETECT_ZEROES_OPTIONS__MAX,
                             BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                             &local_err);
         if (local_err) {
diff --git a/block/file-posix.c b/block/file-posix.c
index cb3bfce..97e8a92 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -439,7 +439,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
                   ? BLOCKDEV_AIO_OPTIONS_NATIVE
                   : BLOCKDEV_AIO_OPTIONS_THREADS;
     aio = qapi_enum_parse(BlockdevAioOptions_lookup, qemu_opt_get(opts, "aio"),
-                          BLOCKDEV_AIO_OPTIONS__MAX, aio_default, &local_err);
+                          aio_default, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -448,7 +448,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     s->use_linux_aio = (aio == BLOCKDEV_AIO_OPTIONS_NATIVE);
 
     locking = qapi_enum_parse(OnOffAuto_lookup, qemu_opt_get(opts, "locking"),
-                              ON_OFF_AUTO__MAX, ON_OFF_AUTO_AUTO, &local_err);
+                              ON_OFF_AUTO_AUTO, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -1975,8 +1975,7 @@ static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
     nocow = qemu_opt_get_bool(opts, BLOCK_OPT_NOCOW, false);
     buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
     prealloc = qapi_enum_parse(PreallocMode_lookup, buf,
-                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
-                               &local_err);
+                               PREALLOC_MODE_OFF, &local_err);
     g_free(buf);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/block/file-win32.c b/block/file-win32.c
index 4706335..978d805 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -304,7 +304,7 @@ static bool get_aio_option(QemuOpts *opts, int flags, Error **errp)
     aio_default = (flags & BDRV_O_NATIVE_AIO) ? BLOCKDEV_AIO_OPTIONS_NATIVE
                                               : BLOCKDEV_AIO_OPTIONS_THREADS;
     aio = qapi_enum_parse(BlockdevAioOptions_lookup, qemu_opt_get(opts, "aio"),
-                          BLOCKDEV_AIO_OPTIONS__MAX, aio_default, errp);
+                          aio_default, errp);
 
     switch (aio) {
     case BLOCKDEV_AIO_OPTIONS_NATIVE:
diff --git a/block/gluster.c b/block/gluster.c
index 3064a45..8367e80 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -544,8 +544,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
         if (!strcmp(ptr, "tcp")) {
             ptr = "inet";       /* accept legacy "tcp" */
         }
-        type = qapi_enum_parse(SocketAddressType_lookup, ptr,
-                               SOCKET_ADDRESS_TYPE__MAX, -1, NULL);
+        type = qapi_enum_parse(SocketAddressType_lookup, ptr, -1, NULL);
         if (type != SOCKET_ADDRESS_TYPE_INET
             && type != SOCKET_ADDRESS_TYPE_UNIX) {
             error_setg(&local_err,
@@ -1002,8 +1001,7 @@ static int qemu_gluster_create(const char *filename,
                           BDRV_SECTOR_SIZE);
 
     tmp = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc = qapi_enum_parse(PreallocMode_lookup, tmp,
-                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
+    prealloc = qapi_enum_parse(PreallocMode_lookup, tmp, PREALLOC_MODE_OFF,
                                &local_err);
     g_free(tmp);
     if (local_err) {
diff --git a/block/parallels.c b/block/parallels.c
index e1e06d2..eb92366 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -697,7 +697,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     s->prealloc_size = MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_BITS);
     buf = qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
     s->prealloc_mode = qapi_enum_parse(prealloc_mode_lookup, buf,
-            PRL_PREALLOC_MODE__MAX, PRL_PREALLOC_MODE_FALLOCATE, &local_err);
+                                       PRL_PREALLOC_MODE_FALLOCATE,
+                                       &local_err);
     g_free(buf);
     if (local_err != NULL) {
         goto fail_options;
diff --git a/block/qcow2.c b/block/qcow2.c
index 40ba26c..7aaf248 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2933,8 +2933,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     }
     buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
     prealloc = qapi_enum_parse(PreallocMode_lookup, buf,
-                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
-                               &local_err);
+                               PREALLOC_MODE_OFF, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -3624,8 +3623,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
 
     optstr = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
     prealloc = qapi_enum_parse(PreallocMode_lookup, optstr,
-                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
-                               &local_err);
+                               PREALLOC_MODE_OFF, &local_err);
     g_free(optstr);
     if (local_err) {
         goto err;
diff --git a/blockdev.c b/blockdev.c
index 02cd69b..722a61e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -440,7 +440,6 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
         *detect_zeroes =
             qapi_enum_parse(BlockdevDetectZeroesOptions_lookup,
                             qemu_opt_get(opts, "detect-zeroes"),
-                            BLOCKDEV_DETECT_ZEROES_OPTIONS__MAX,
                             BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                             &local_error);
         if (local_error) {
diff --git a/hmp.c b/hmp.c
index fd80dce..03c1a78 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1742,7 +1742,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
         if (read_only) {
             read_only_mode =
                 qapi_enum_parse(BlockdevChangeReadOnlyMode_lookup,
-                                read_only, BLOCKDEV_CHANGE_READ_ONLY_MODE__MAX,
+                                read_only,
                                 BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN, &err);
             if (err) {
                 hmp_handle_error(mon, &err);
diff --git a/include/qapi/util.h b/include/qapi/util.h
index 7436ed8..4eb8a3f 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -12,7 +12,7 @@
 #define QAPI_UTIL_H
 
 int qapi_enum_parse(const char * const lookup[], const char *buf,
-                    int max, int def, Error **errp);
+                    int def, Error **errp);
 
 int parse_qapi_name(const char *name, bool complete);
 
diff --git a/migration/global_state.c b/migration/global_state.c
index dcbbcb2..88c55f8 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -89,8 +89,7 @@ static int global_state_post_load(void *opaque, int version_id)
     s->received = true;
     trace_migrate_global_state_post_load(runstate);
 
-    r = qapi_enum_parse(RunState_lookup, runstate, RUN_STATE__MAX,
-                                -1, &local_err);
+    r = qapi_enum_parse(RunState_lookup, runstate, -1, &local_err);
 
     if (r == -1) {
         if (local_err) {
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 46eda7d..ee7594f 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -16,7 +16,7 @@
 #include "qapi/util.h"
 
 int qapi_enum_parse(const char * const lookup[], const char *buf,
-                    int max, int def, Error **errp)
+                    int def, Error **errp)
 {
     int i;
 
@@ -24,7 +24,7 @@ int qapi_enum_parse(const char * const lookup[], const char *buf,
         return def;
     }
 
-    for (i = 0; i < max; i++) {
+    for (i = 0; lookup[i]; i++) {
         if (!strcmp(buf, lookup[i])) {
             return i;
         }
diff --git a/qemu-img.c b/qemu-img.c
index 56ef49e..611ab7d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3491,8 +3491,7 @@ static int img_resize(int argc, char **argv)
             break;
         case OPTION_PREALLOCATION:
             prealloc = qapi_enum_parse(PreallocMode_lookup, optarg,
-                                       PREALLOC_MODE__MAX, PREALLOC_MODE__MAX,
-                                       NULL);
+                                       PREALLOC_MODE__MAX, NULL);
             if (prealloc == PREALLOC_MODE__MAX) {
                 error_report("Invalid preallocation mode '%s'", optarg);
                 return 1;
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 27164b8..96e10d6 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -641,7 +641,6 @@ int main(int argc, char **argv)
             detect_zeroes =
                 qapi_enum_parse(BlockdevDetectZeroesOptions_lookup,
                                 optarg,
-                                BLOCKDEV_DETECT_ZEROES_OPTIONS__MAX,
                                 BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                                 &local_err);
             if (local_err) {
diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index e869757..d72ee8c 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -20,25 +20,20 @@ static void test_qapi_enum_parse(void)
     Error *err = NULL;
     int ret;
 
-    ret = qapi_enum_parse(QType_lookup, NULL, QTYPE__MAX, QTYPE_NONE,
-                          &error_abort);
+    ret = qapi_enum_parse(QType_lookup, NULL, QTYPE_NONE, &error_abort);
     g_assert_cmpint(ret, ==, QTYPE_NONE);
 
-    ret = qapi_enum_parse(QType_lookup, "junk", QTYPE__MAX, -1,
-                          NULL);
+    ret = qapi_enum_parse(QType_lookup, "junk", -1, NULL);
     g_assert_cmpint(ret, ==, -1);
 
-    ret = qapi_enum_parse(QType_lookup, "junk", QTYPE__MAX, -1,
-                          &err);
+    ret = qapi_enum_parse(QType_lookup, "junk", -1, &err);
     error_free_or_abort(&err);
 
-    ret = qapi_enum_parse(QType_lookup, "none", QTYPE__MAX, -1,
-                          &error_abort);
+    ret = qapi_enum_parse(QType_lookup, "none", -1, &error_abort);
     g_assert_cmpint(ret, ==, QTYPE_NONE);
 
     ret = qapi_enum_parse(QType_lookup, QType_lookup[QTYPE__MAX - 1],
-                          QTYPE__MAX, QTYPE__MAX - 1,
-                          &error_abort);
+                          QTYPE__MAX - 1, &error_abort);
     g_assert_cmpint(ret, ==, QTYPE__MAX - 1);
 }
 
-- 
2.7.5
