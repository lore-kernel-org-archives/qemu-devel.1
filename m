Received: from eggs.gnu.org ([2001:4830:134:3::10]:52329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPL-0005I8-6o
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPH-0006YC-3m
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:38 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 15:57:17 +0300
Message-Id: <5b203ceb35b456503115cb2a4ab2941b2fdc2a6a.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 01/14] block: Don't call
 update_flags_from_options() if the options are wrong
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

If qemu_opts_absorb_qdict() fails and we carry on and call
update_flags_from_options() then that can result on a failed
assertion:

   $ qemu-io -c 'reopen -o read-only=foo' hd.qcow2
   block.c:1101: update_flags_from_options: Assertion `qemu_opt_find(opts, BDRV_OPT_CACHE_DIRECT)' failed.
   Aborted

This only happens in bdrv_reopen_queue_child(). Although this function
doesn't return errors, we can simply keep the wrong options in the
reopen queue and later bdrv_reopen_prepare() will fail.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c                    | 11 +++++++++--
 tests/qemu-iotests/133     |  6 ++++++
 tests/qemu-iotests/133.out |  4 ++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 7710b399a3..47d5fe2f91 100644
--- a/block.c
+++ b/block.c
@@ -2942,12 +2942,19 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
     if (parent_options) {
         QemuOpts *opts;
         QDict *options_copy;
+        Error *local_err = NULL;
         assert(!flags);
         role->inherit_options(&flags, options, parent_flags, parent_options);
         options_copy = qdict_clone_shallow(options);
         opts = qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort);
-        qemu_opts_absorb_qdict(opts, options_copy, NULL);
-        update_flags_from_options(&flags, opts);
+        qemu_opts_absorb_qdict(opts, options_copy, &local_err);
+        /* Don't call update_flags_from_options() if the options are wrong.
+         * bdrv_reopen_prepare() will later return an error. */
+        if (!local_err) {
+            update_flags_from_options(&flags, opts);
+        } else {
+            error_free(local_err);
+        }
         qemu_opts_del(opts);
         qobject_unref(options_copy);
     }
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index af6b3e1dd4..b9f17c996f 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -92,6 +92,12 @@ echo
 IMGOPTSSYNTAX=false $QEMU_IO -f null-co -c 'reopen' -c 'info' \
     "json:{'driver': 'null-co', 'size': 65536}"
 
+echo
+echo "=== Check that invalid options are handled correctly ==="
+echo
+
+$QEMU_IO -c 'reopen -o read-only=foo' $TEST_IMG
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
index f4a85aeb63..570f623b6b 100644
--- a/tests/qemu-iotests/133.out
+++ b/tests/qemu-iotests/133.out
@@ -24,4 +24,8 @@ Cannot change the option 'driver'
 
 format name: null-co
 format name: null-co
+
+=== Check that invalid options are handled correctly ===
+
+Parameter 'read-only' expects 'on' or 'off'
 *** done
-- 
2.11.0
