Received: from eggs.gnu.org ([2001:4830:134:3::10]:57874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejSbG-0006J7-Dm
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejSbF-0000aR-OK
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:29:34 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  7 Feb 2018 17:29:20 +0100
Message-Id: <20180207162920.28386-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] block: early check for blockers on drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com

Even if an op blocker is present for BLOCK_OP_TYPE_MIRROR_SOURCE,
it is checked a bit late and the result is that the target is
created even if drive-mirror subsequently fails.  Add an early
check to avoid this.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 8e977eef11..c7e2e0a00e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3565,6 +3565,11 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
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
2.14.3
