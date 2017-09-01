Received: from eggs.gnu.org ([2001:4830:134:3::10]:54021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUn-0000Ju-Rt
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUj-0007NW-Uk
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUj-0007Lp-IX
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CD937EA8A
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 139B57820F
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:57 +0200
Message-Id: <20170901125611.29295-34-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/47] qapi: Drop superfluous qapi_enum_parse()
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

The lookup tables have a sentinel, no need to make callers pass their
size.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503564371-26090-3-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[Commit message corrected]
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
index 3308814bba..af48b0d26b 100644
--- a/block.c
+++ b/block.c
@@ -1335,7 +1335,6 @@ static int bdrv_open_common(BlockDriverState *bs, B=
lockBackend *file,
         BlockdevDetectZeroesOptions value =3D
             qapi_enum_parse(BlockdevDetectZeroesOptions_lookup,
                             detect_zeroes,
-                            BLOCKDEV_DETECT_ZEROES_OPTIONS__MAX,
                             BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                             &local_err);
         if (local_err) {
diff --git a/block/file-posix.c b/block/file-posix.c
index cb3bfce147..97e8a92e23 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -439,7 +439,7 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
                   ? BLOCKDEV_AIO_OPTIONS_NATIVE
                   : BLOCKDEV_AIO_OPTIONS_THREADS;
     aio =3D qapi_enum_parse(BlockdevAioOptions_lookup, qemu_opt_get(opts=
, "aio"),
-                          BLOCKDEV_AIO_OPTIONS__MAX, aio_default, &local=
_err);
+                          aio_default, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret =3D -EINVAL;
@@ -448,7 +448,7 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
     s->use_linux_aio =3D (aio =3D=3D BLOCKDEV_AIO_OPTIONS_NATIVE);
=20
     locking =3D qapi_enum_parse(OnOffAuto_lookup, qemu_opt_get(opts, "lo=
cking"),
-                              ON_OFF_AUTO__MAX, ON_OFF_AUTO_AUTO, &local=
_err);
+                              ON_OFF_AUTO_AUTO, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret =3D -EINVAL;
@@ -1975,8 +1975,7 @@ static int raw_create(const char *filename, QemuOpt=
s *opts, Error **errp)
     nocow =3D qemu_opt_get_bool(opts, BLOCK_OPT_NOCOW, false);
     buf =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
     prealloc =3D qapi_enum_parse(PreallocMode_lookup, buf,
-                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
-                               &local_err);
+                               PREALLOC_MODE_OFF, &local_err);
     g_free(buf);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/block/file-win32.c b/block/file-win32.c
index 4706335cff..978d8058fe 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -304,7 +304,7 @@ static bool get_aio_option(QemuOpts *opts, int flags,=
 Error **errp)
     aio_default =3D (flags & BDRV_O_NATIVE_AIO) ? BLOCKDEV_AIO_OPTIONS_N=
ATIVE
                                               : BLOCKDEV_AIO_OPTIONS_THR=
EADS;
     aio =3D qapi_enum_parse(BlockdevAioOptions_lookup, qemu_opt_get(opts=
, "aio"),
-                          BLOCKDEV_AIO_OPTIONS__MAX, aio_default, errp);
+                          aio_default, errp);
=20
     switch (aio) {
     case BLOCKDEV_AIO_OPTIONS_NATIVE:
diff --git a/block/gluster.c b/block/gluster.c
index 3064a45047..8367e806d0 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -544,8 +544,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGlu=
ster *gconf,
         if (!strcmp(ptr, "tcp")) {
             ptr =3D "inet";       /* accept legacy "tcp" */
         }
-        type =3D qapi_enum_parse(SocketAddressType_lookup, ptr,
-                               SOCKET_ADDRESS_TYPE__MAX, -1, NULL);
+        type =3D qapi_enum_parse(SocketAddressType_lookup, ptr, -1, NULL=
);
         if (type !=3D SOCKET_ADDRESS_TYPE_INET
             && type !=3D SOCKET_ADDRESS_TYPE_UNIX) {
             error_setg(&local_err,
@@ -1002,8 +1001,7 @@ static int qemu_gluster_create(const char *filename=
,
                           BDRV_SECTOR_SIZE);
=20
     tmp =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc =3D qapi_enum_parse(PreallocMode_lookup, tmp,
-                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
+    prealloc =3D qapi_enum_parse(PreallocMode_lookup, tmp, PREALLOC_MODE=
_OFF,
                                &local_err);
     g_free(tmp);
     if (local_err) {
diff --git a/block/parallels.c b/block/parallels.c
index e1e06d23cc..eb92366e51 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -697,7 +697,8 @@ static int parallels_open(BlockDriverState *bs, QDict=
 *options, int flags,
     s->prealloc_size =3D MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_=
BITS);
     buf =3D qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
     s->prealloc_mode =3D qapi_enum_parse(prealloc_mode_lookup, buf,
-            PRL_PREALLOC_MODE__MAX, PRL_PREALLOC_MODE_FALLOCATE, &local_=
err);
+                                       PRL_PREALLOC_MODE_FALLOCATE,
+                                       &local_err);
     g_free(buf);
     if (local_err !=3D NULL) {
         goto fail_options;
diff --git a/block/qcow2.c b/block/qcow2.c
index a3679c69e8..470a0dedaa 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2917,8 +2917,7 @@ static int qcow2_create(const char *filename, QemuO=
pts *opts, Error **errp)
     }
     buf =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
     prealloc =3D qapi_enum_parse(PreallocMode_lookup, buf,
-                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
-                               &local_err);
+                               PREALLOC_MODE_OFF, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret =3D -EINVAL;
@@ -3608,8 +3607,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *op=
ts, BlockDriverState *in_bs,
=20
     optstr =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
     prealloc =3D qapi_enum_parse(PreallocMode_lookup, optstr,
-                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
-                               &local_err);
+                               PREALLOC_MODE_OFF, &local_err);
     g_free(optstr);
     if (local_err) {
         goto err;
diff --git a/blockdev.c b/blockdev.c
index 02cd69bc21..722a61e3fb 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -440,7 +440,6 @@ static void extract_common_blockdev_options(QemuOpts =
*opts, int *bdrv_flags,
         *detect_zeroes =3D
             qapi_enum_parse(BlockdevDetectZeroesOptions_lookup,
                             qemu_opt_get(opts, "detect-zeroes"),
-                            BLOCKDEV_DETECT_ZEROES_OPTIONS__MAX,
                             BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                             &local_error);
         if (local_error) {
diff --git a/hmp.c b/hmp.c
index fd80dce758..03c1a783b6 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1742,7 +1742,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
         if (read_only) {
             read_only_mode =3D
                 qapi_enum_parse(BlockdevChangeReadOnlyMode_lookup,
-                                read_only, BLOCKDEV_CHANGE_READ_ONLY_MOD=
E__MAX,
+                                read_only,
                                 BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN, &=
err);
             if (err) {
                 hmp_handle_error(mon, &err);
diff --git a/include/qapi/util.h b/include/qapi/util.h
index 7436ed815c..4eb8a3fe2f 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -12,7 +12,7 @@
 #define QAPI_UTIL_H
=20
 int qapi_enum_parse(const char * const lookup[], const char *buf,
-                    int max, int def, Error **errp);
+                    int def, Error **errp);
=20
 int parse_qapi_name(const char *name, bool complete);
=20
diff --git a/migration/global_state.c b/migration/global_state.c
index dcbbcb28be..88c55f8cdb 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -89,8 +89,7 @@ static int global_state_post_load(void *opaque, int ver=
sion_id)
     s->received =3D true;
     trace_migrate_global_state_post_load(runstate);
=20
-    r =3D qapi_enum_parse(RunState_lookup, runstate, RUN_STATE__MAX,
-                                -1, &local_err);
+    r =3D qapi_enum_parse(RunState_lookup, runstate, -1, &local_err);
=20
     if (r =3D=3D -1) {
         if (local_err) {
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 46eda7d196..ee7594ff19 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -16,7 +16,7 @@
 #include "qapi/util.h"
=20
 int qapi_enum_parse(const char * const lookup[], const char *buf,
-                    int max, int def, Error **errp)
+                    int def, Error **errp)
 {
     int i;
=20
@@ -24,7 +24,7 @@ int qapi_enum_parse(const char * const lookup[], const =
char *buf,
         return def;
     }
=20
-    for (i =3D 0; i < max; i++) {
+    for (i =3D 0; lookup[i]; i++) {
         if (!strcmp(buf, lookup[i])) {
             return i;
         }
diff --git a/qemu-img.c b/qemu-img.c
index 56ef49e214..611ab7ddf3 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3491,8 +3491,7 @@ static int img_resize(int argc, char **argv)
             break;
         case OPTION_PREALLOCATION:
             prealloc =3D qapi_enum_parse(PreallocMode_lookup, optarg,
-                                       PREALLOC_MODE__MAX, PREALLOC_MODE=
__MAX,
-                                       NULL);
+                                       PREALLOC_MODE__MAX, NULL);
             if (prealloc =3D=3D PREALLOC_MODE__MAX) {
                 error_report("Invalid preallocation mode '%s'", optarg);
                 return 1;
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 27164b8205..96e10d62dc 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -641,7 +641,6 @@ int main(int argc, char **argv)
             detect_zeroes =3D
                 qapi_enum_parse(BlockdevDetectZeroesOptions_lookup,
                                 optarg,
-                                BLOCKDEV_DETECT_ZEROES_OPTIONS__MAX,
                                 BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                                 &local_err);
             if (local_err) {
diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index e8697577a5..d72ee8c4e7 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -20,25 +20,20 @@ static void test_qapi_enum_parse(void)
     Error *err =3D NULL;
     int ret;
=20
-    ret =3D qapi_enum_parse(QType_lookup, NULL, QTYPE__MAX, QTYPE_NONE,
-                          &error_abort);
+    ret =3D qapi_enum_parse(QType_lookup, NULL, QTYPE_NONE, &error_abort=
);
     g_assert_cmpint(ret, =3D=3D, QTYPE_NONE);
=20
-    ret =3D qapi_enum_parse(QType_lookup, "junk", QTYPE__MAX, -1,
-                          NULL);
+    ret =3D qapi_enum_parse(QType_lookup, "junk", -1, NULL);
     g_assert_cmpint(ret, =3D=3D, -1);
=20
-    ret =3D qapi_enum_parse(QType_lookup, "junk", QTYPE__MAX, -1,
-                          &err);
+    ret =3D qapi_enum_parse(QType_lookup, "junk", -1, &err);
     error_free_or_abort(&err);
=20
-    ret =3D qapi_enum_parse(QType_lookup, "none", QTYPE__MAX, -1,
-                          &error_abort);
+    ret =3D qapi_enum_parse(QType_lookup, "none", -1, &error_abort);
     g_assert_cmpint(ret, =3D=3D, QTYPE_NONE);
=20
     ret =3D qapi_enum_parse(QType_lookup, QType_lookup[QTYPE__MAX - 1],
-                          QTYPE__MAX, QTYPE__MAX - 1,
-                          &error_abort);
+                          QTYPE__MAX - 1, &error_abort);
     g_assert_cmpint(ret, =3D=3D, QTYPE__MAX - 1);
 }
=20
--=20
2.13.5
