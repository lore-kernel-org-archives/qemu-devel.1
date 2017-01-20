Received: from eggs.gnu.org ([2001:4830:134:3::10]:43595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUTYs-0006qK-5J
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUTYr-0000WK-8Z
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:24:38 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 20 Jan 2017 15:23:09 +0800
Message-Id: <20170120072310.8009-16-famz@redhat.com>
In-Reply-To: <20170120072310.8009-1-famz@redhat.com>
References: <20170120072310.8009-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 15/16] qcow2: Force "no other writer" lock
 on bs->file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, eblake@redhat.com

Writing to the same qcow2 file from two QEMU processes at the same time
will never work correctly, so disable it even when the caller specifies
BDRV_O_RDWR.

Other formats are less vulnerable because they don't have internal
snapshots thus qemu-img is less often misused to create live snapshot.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/qcow2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 96fb8a8..879361a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1177,6 +1177,17 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
+    if ((flags & BDRV_O_SHARE_RW) && (flags & BDRV_O_RDWR)) {
+        /* Shared write is never a good idea for qcow2, override it.
+         * XXX: Use permission propagation and masking mechanism in op blockers
+         * API once it's there. */
+        ret = bdrv_reopen(bs->file->bs, flags & ~BDRV_O_SHARE_RW, &local_err);
+        if (ret) {
+            error_propagate(errp, local_err);
+            goto fail;
+        }
+    }
+
 #ifdef DEBUG_ALLOC
     {
         BdrvCheckResult result = {0};
-- 
2.9.3
