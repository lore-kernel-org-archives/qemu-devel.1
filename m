Received: from eggs.gnu.org ([2001:4830:134:3::10]:36130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dvNVA-0003MF-8n
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dvNV9-0003LM-Aa
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:56:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Sep 2017 14:55:59 +0200
Message-Id: <20170922125559.11768-1-kwolf@redhat.com>
In-Reply-To: <20170915101008.16646-2-kwolf@redhat.com>
References: <20170915101008.16646-2-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/6] qemu-io: Drop write permissions before
 read-only reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

qemu-io provides a 'reopen' command that allows switching from writable
to read-only access. We need to make sure that we don't try to keep
write permissions to a BlockBackend that becomes read-only, otherwise
things are going to fail.

This requires a bdrv_drain() call because otherwise in-flight AIO
write requests could issue new internal requests while the permission
has already gone away, which would cause assertion failures. Draining
the queue doesn't break AIO requests in any new way, bdrv_reopen() would
drain it anyway only a few lines later.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-io-cmds.c             | 12 ++++++++++++
 tests/qemu-iotests/187.out |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 2811a89099..3727fb43f3 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2010,6 +2010,18 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
         return 0;
     }
 
+    if (!(flags & BDRV_O_RDWR)) {
+        uint64_t orig_perm, orig_shared_perm;
+
+        bdrv_drain(bs);
+
+        blk_get_perm(blk, &orig_perm, &orig_shared_perm);
+        blk_set_perm(blk,
+                     orig_perm & ~(BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED),
+                     orig_shared_perm,
+                     &error_abort);
+    }
+
     qopts = qemu_opts_find(&reopen_opts, NULL);
     opts = qopts ? qemu_opts_to_qdict(qopts, NULL) : NULL;
     qemu_opts_reset(&reopen_opts);
diff --git a/tests/qemu-iotests/187.out b/tests/qemu-iotests/187.out
index 68fb944cd5..30b987f71f 100644
--- a/tests/qemu-iotests/187.out
+++ b/tests/qemu-iotests/187.out
@@ -12,7 +12,7 @@ Start from read-write
 
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-write failed: Operation not permitted
+Block node is read-only
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.13.5
