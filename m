Received: from eggs.gnu.org ([2001:4830:134:3::10]:47095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gKNSl-0004Cz-Ss
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gKNSk-0002mS-IO
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:01:39 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  7 Nov 2018 14:59:49 +0200
Message-Id: <d213fb4eb326353eccde0ea1c5a05bba2da706e0.1541595424.git.berto@igalia.com>
In-Reply-To: <cover.1541595424.git.berto@igalia.com>
References: <cover.1541595424.git.berto@igalia.com>
In-Reply-To: <cover.1541595424.git.berto@igalia.com>
References: <cover.1541595424.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 14/15] block: Remove assertions from
 update_flags_from_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This function takes three options (cache.direct, cache.no-flush and
read-only) from a QemuOpts object and updates the flags accordingly.

If any of those options is not set (because it was missing from the
original QDict or because it had an invalid value) then the function
aborts with a failed assertion:

   $ qemu-io -c 'reopen -o read-only=foo' hd.qcow2
   block.c:1126: update_flags_from_options: Assertion `qemu_opt_find(opts, BDRV_OPT_CACHE_DIRECT)' failed.
   Aborted

This assertion is unnecessary, and it forces any caller of
bdrv_reopen() to pass all the aforementioned three options. This may
have made sense in order to remove ambiguity when bdrv_reopen() was
taking both flags and options, but that's not the case anymore.

It's also unnecessary if we want to validate the option values,
because bdrv_reopen_prepare() already takes care of that, as we can
see if we remove the assertions:

   $ qemu-io -c 'reopen -o read-only=foo' hd.qcow2
   Parameter 'read-only' expects 'on' or 'off'

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c                    | 4 ----
 tests/qemu-iotests/133     | 8 ++++++++
 tests/qemu-iotests/133.out | 6 ++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 8bc808d6f3..68f1e3b45e 100644
--- a/block.c
+++ b/block.c
@@ -1139,24 +1139,20 @@ static void update_flags_from_options(int *flags, QemuOpts *opts)
 {
     *flags &= ~BDRV_O_CACHE_MASK;
 
-    assert(qemu_opt_find(opts, BDRV_OPT_CACHE_NO_FLUSH));
     if (qemu_opt_get_bool_del(opts, BDRV_OPT_CACHE_NO_FLUSH, false)) {
         *flags |= BDRV_O_NO_FLUSH;
     }
 
-    assert(qemu_opt_find(opts, BDRV_OPT_CACHE_DIRECT));
     if (qemu_opt_get_bool_del(opts, BDRV_OPT_CACHE_DIRECT, false)) {
         *flags |= BDRV_O_NOCACHE;
     }
 
     *flags &= ~BDRV_O_RDWR;
 
-    assert(qemu_opt_find(opts, BDRV_OPT_READ_ONLY));
     if (!qemu_opt_get_bool_del(opts, BDRV_OPT_READ_ONLY, false)) {
         *flags |= BDRV_O_RDWR;
     }
 
-    assert(qemu_opt_find(opts, BDRV_OPT_AUTO_READ_ONLY));
     if (qemu_opt_get_bool_del(opts, BDRV_OPT_AUTO_READ_ONLY, false)) {
         *flags |= BDRV_O_AUTO_RDONLY;
     }
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 14e6b3b972..59d5e2ea25 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -101,6 +101,14 @@ $QEMU_IO -c 'reopen -w -o read-only=on' $TEST_IMG
 $QEMU_IO -c 'reopen -c none -o cache.direct=on' $TEST_IMG
 $QEMU_IO -c 'reopen -c writeback -o cache.direct=on' $TEST_IMG
 $QEMU_IO -c 'reopen -c directsync -o cache.no-flush=on' $TEST_IMG
+
+echo
+echo "=== Check that invalid options are handled correctly ==="
+echo
+
+$QEMU_IO -c 'reopen -o read-only=foo' $TEST_IMG
+$QEMU_IO -c 'reopen -o cache.no-flush=bar' $TEST_IMG
+$QEMU_IO -c 'reopen -o cache.direct=baz' $TEST_IMG
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
index 48a9d087f0..551096a9c4 100644
--- a/tests/qemu-iotests/133.out
+++ b/tests/qemu-iotests/133.out
@@ -32,4 +32,10 @@ Cannot set both -r/-w and 'read-only'
 Cannot set both -c and the cache options
 Cannot set both -c and the cache options
 Cannot set both -c and the cache options
+
+=== Check that invalid options are handled correctly ===
+
+Parameter 'read-only' expects 'on' or 'off'
+Parameter 'cache.no-flush' expects 'on' or 'off'
+Parameter 'cache.direct' expects 'on' or 'off'
 *** done
-- 
2.11.0
