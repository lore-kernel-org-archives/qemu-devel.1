Received: from eggs.gnu.org ([2001:4830:134:3::10]:60102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl9-00082j-FA
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl6-0006zJ-Ef
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:19 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Sun, 26 Aug 2018 17:09:32 +0300
Message-Id: <c96c83fefeaf6d586f0c521ddd36b076cd60eaed.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/9] qemu-io: Fix writethrough check in reopen
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

"qemu-io reopen" doesn't allow changing the writethrough setting of
the cache, but the check is wrong, causing an error even on a simple
reopen with the default parameters:

   $ qemu-img create -f qcow2 hd.qcow2 1M
   $ qemu-system-x86_64 -monitor stdio -drive if=virtio,file=hd.qcow2
   (qemu) qemu-io virtio0 reopen
   Cannot change cache.writeback: Device attached

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 qemu-io-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 5bf5f28178..db0b3ee5ef 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2025,7 +2025,7 @@ static int reopen_f(BlockBackend *blk, int argc, char **argv)
         return -EINVAL;
     }
 
-    if (writethrough != blk_enable_write_cache(blk) &&
+    if (!writethrough != blk_enable_write_cache(blk) &&
         blk_get_attached_dev(blk))
     {
         error_report("Cannot change cache.writeback: Device attached");
-- 
2.11.0
