Received: from eggs.gnu.org ([2001:4830:134:3::10]:46903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZN-0003cS-32
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZL-0001tA-W1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:57 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:33 +0100
Message-Id: <20181212132735.16080-40-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 39/41] block: Remove assertions from
 update_flags_from_options()
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

This function takes four options (cache.direct, cache.no-flush,
read-only and auto-read-only) from a QemuOpts object and updates the
flags accordingly.

If any of those options is not set (because it was missing from the
original QDict or because it had an invalid value) then the function
aborts with a failed assertion:

   $ qemu-io -c 'reopen -o read-only=3Dfoo' hd.qcow2
   block.c:1126: update_flags_from_options: Assertion `qemu_opt_find(opts=
, BDRV_OPT_CACHE_DIRECT)' failed.
   Aborted

This assertion is unnecessary, and it forces any caller of
bdrv_reopen() to pass all the aforementioned four options. This may
have made sense in order to remove ambiguity when bdrv_reopen() was
taking both flags and options, but that's not the case anymore.

It's also unnecessary if we want to validate the option values,
because bdrv_reopen_prepare() already takes care of that, as we can
see if we remove the assertions:

   $ qemu-io -c 'reopen -o read-only=3Dfoo' hd.qcow2
   Parameter 'read-only' expects 'on' or 'off'

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                    | 4 ----
 tests/qemu-iotests/133     | 9 +++++++++
 tests/qemu-iotests/133.out | 7 +++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index cb354438be..c6d4564bcf 100644
--- a/block.c
+++ b/block.c
@@ -1139,22 +1139,18 @@ static void update_flags_from_options(int *flags,=
 QemuOpts *opts)
 {
     *flags &=3D ~(BDRV_O_CACHE_MASK | BDRV_O_RDWR | BDRV_O_AUTO_RDONLY);
=20
-    assert(qemu_opt_find(opts, BDRV_OPT_CACHE_NO_FLUSH));
     if (qemu_opt_get_bool_del(opts, BDRV_OPT_CACHE_NO_FLUSH, false)) {
         *flags |=3D BDRV_O_NO_FLUSH;
     }
=20
-    assert(qemu_opt_find(opts, BDRV_OPT_CACHE_DIRECT));
     if (qemu_opt_get_bool_del(opts, BDRV_OPT_CACHE_DIRECT, false)) {
         *flags |=3D BDRV_O_NOCACHE;
     }
=20
-    assert(qemu_opt_find(opts, BDRV_OPT_READ_ONLY));
     if (!qemu_opt_get_bool_del(opts, BDRV_OPT_READ_ONLY, false)) {
         *flags |=3D BDRV_O_RDWR;
     }
=20
-    assert(qemu_opt_find(opts, BDRV_OPT_AUTO_READ_ONLY));
     if (qemu_opt_get_bool_del(opts, BDRV_OPT_AUTO_READ_ONLY, false)) {
         *flags |=3D BDRV_O_AUTO_RDONLY;
     }
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 63b25f394b..565e0b1b6e 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -100,6 +100,15 @@ $QEMU_IO -c 'reopen -w -o read-only=3Don' $TEST_IMG
 $QEMU_IO -c 'reopen -c none -o cache.direct=3Don' $TEST_IMG
 $QEMU_IO -c 'reopen -c writeback -o cache.direct=3Don' $TEST_IMG
 $QEMU_IO -c 'reopen -c directsync -o cache.no-flush=3Don' $TEST_IMG
+
+echo
+echo "=3D=3D=3D Check that invalid options are handled correctly =3D=3D=3D=
"
+echo
+
+$QEMU_IO -c 'reopen -o read-only=3Dfoo' $TEST_IMG
+$QEMU_IO -c 'reopen -o cache.no-flush=3Dbar' $TEST_IMG
+$QEMU_IO -c 'reopen -o cache.direct=3Dbaz' $TEST_IMG
+$QEMU_IO -c 'reopen -o auto-read-only=3Dqux' $TEST_IMG
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
index 48a9d087f0..414c7fa27f 100644
--- a/tests/qemu-iotests/133.out
+++ b/tests/qemu-iotests/133.out
@@ -32,4 +32,11 @@ Cannot set both -r/-w and 'read-only'
 Cannot set both -c and the cache options
 Cannot set both -c and the cache options
 Cannot set both -c and the cache options
+
+=3D=3D=3D Check that invalid options are handled correctly =3D=3D=3D
+
+Parameter 'read-only' expects 'on' or 'off'
+Parameter 'cache.no-flush' expects 'on' or 'off'
+Parameter 'cache.direct' expects 'on' or 'off'
+Parameter 'auto-read-only' expects 'on' or 'off'
 *** done
--=20
2.19.2
