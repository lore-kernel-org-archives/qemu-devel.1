Received: from eggs.gnu.org ([2001:4830:134:3::10]:51977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1a-0002lB-41
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1Z-0005Bv-30
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:40 +0100
Message-Id: <20180213170529.10858-7-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/55] block: early check for blockers on
 drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Even if an op blocker is present for BLOCK_OP_TYPE_MIRROR_SOURCE,
it is checked a bit late and the result is that the target is
created even if drive-mirror subsequently fails.  Add an early
check to avoid this.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index bdbdeae7e4..7423c5317b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3569,6 +3569,11 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         return;
     }
 
+    /* Early check to avoid creating target */
+    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_MIRROR_SOURCE, errp)) {
+        return;
+    }
+
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
-- 
2.13.6
