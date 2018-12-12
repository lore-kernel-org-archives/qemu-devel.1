Received: from eggs.gnu.org ([2001:4830:134:3::10]:46834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZK-0003ZI-E6
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZJ-0001qD-1N
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:29 +0100
Message-Id: <20181212132735.16080-36-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/41] qemu-io: Put flag changes in the options
 QDict in reopen_f()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

When reopen_f() puts a block device in the reopen queue, some of the
new options are passed using a QDict, but others ("read-only" and the
cache options) are passed as flags.

This patch puts those flags in the QDict. This way the flags parameter
becomes redundant and we'll be able to get rid of it in a subsequent
patch.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-io-cmds.c             | 27 ++++++++++++++++++++++++++-
 tests/qemu-iotests/133     |  9 +++++++++
 tests/qemu-iotests/133.out |  8 ++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 5363482213..c9ae09d574 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu-io.h"
 #include "sysemu/block-backend.h"
 #include "block/block.h"
@@ -1978,6 +1979,7 @@ static int reopen_f(BlockBackend *blk, int argc, ch=
ar **argv)
     int flags =3D bs->open_flags;
     bool writethrough =3D !blk_enable_write_cache(blk);
     bool has_rw_option =3D false;
+    bool has_cache_option =3D false;
=20
     BlockReopenQueue *brq;
     Error *local_err =3D NULL;
@@ -1989,6 +1991,7 @@ static int reopen_f(BlockBackend *blk, int argc, ch=
ar **argv)
                 error_report("Invalid cache option: %s", optarg);
                 return -EINVAL;
             }
+            has_cache_option =3D true;
             break;
         case 'o':
             if (!qemu_opts_parse_noisily(&reopen_opts, optarg, 0)) {
@@ -2046,9 +2049,31 @@ static int reopen_f(BlockBackend *blk, int argc, c=
har **argv)
     }
=20
     qopts =3D qemu_opts_find(&reopen_opts, NULL);
-    opts =3D qopts ? qemu_opts_to_qdict(qopts, NULL) : NULL;
+    opts =3D qopts ? qemu_opts_to_qdict(qopts, NULL) : qdict_new();
     qemu_opts_reset(&reopen_opts);
=20
+    if (qdict_haskey(opts, BDRV_OPT_READ_ONLY)) {
+        if (has_rw_option) {
+            error_report("Cannot set both -r/-w and '" BDRV_OPT_READ_ONL=
Y "'");
+            qobject_unref(opts);
+            return -EINVAL;
+        }
+    } else {
+        qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !(flags & BDRV_O_RDWR))=
;
+    }
+
+    if (qdict_haskey(opts, BDRV_OPT_CACHE_DIRECT) ||
+        qdict_haskey(opts, BDRV_OPT_CACHE_NO_FLUSH)) {
+        if (has_cache_option) {
+            error_report("Cannot set both -c and the cache options");
+            qobject_unref(opts);
+            return -EINVAL;
+        }
+    } else {
+        qdict_put_bool(opts, BDRV_OPT_CACHE_DIRECT, flags & BDRV_O_NOCAC=
HE);
+        qdict_put_bool(opts, BDRV_OPT_CACHE_NO_FLUSH, flags & BDRV_O_NO_=
FLUSH);
+    }
+
     bdrv_subtree_drained_begin(bs);
     brq =3D bdrv_reopen_queue(NULL, bs, opts, flags);
     bdrv_reopen_multiple(bdrv_get_aio_context(bs), brq, &local_err);
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index a9a47a3c36..63b25f394b 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -91,6 +91,15 @@ echo
 IMGOPTSSYNTAX=3Dfalse $QEMU_IO -f null-co -c 'reopen' -c 'info' \
     "json:{'driver': 'null-co', 'size': 65536}"
=20
+echo
+echo "=3D=3D=3D Check that mixing -c/-r/-w and their corresponding optio=
ns is forbidden =3D=3D=3D"
+echo
+
+$QEMU_IO -c 'reopen -r -o read-only=3Don' $TEST_IMG
+$QEMU_IO -c 'reopen -w -o read-only=3Don' $TEST_IMG
+$QEMU_IO -c 'reopen -c none -o cache.direct=3Don' $TEST_IMG
+$QEMU_IO -c 'reopen -c writeback -o cache.direct=3Don' $TEST_IMG
+$QEMU_IO -c 'reopen -c directsync -o cache.no-flush=3Don' $TEST_IMG
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
index f4a85aeb63..48a9d087f0 100644
--- a/tests/qemu-iotests/133.out
+++ b/tests/qemu-iotests/133.out
@@ -24,4 +24,12 @@ Cannot change the option 'driver'
=20
 format name: null-co
 format name: null-co
+
+=3D=3D=3D Check that mixing -c/-r/-w and their corresponding options is =
forbidden =3D=3D=3D
+
+Cannot set both -r/-w and 'read-only'
+Cannot set both -r/-w and 'read-only'
+Cannot set both -c and the cache options
+Cannot set both -c and the cache options
+Cannot set both -c and the cache options
 *** done
--=20
2.19.2
