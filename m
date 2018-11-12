Received: from eggs.gnu.org ([2001:4830:134:3::10]:57658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMCmX-0000bU-SA
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMCmF-0001HV-8V
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:01:27 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 12 Nov 2018 16:00:48 +0200
Message-Id: <f5838d48e26e6a0c22e00b4c2e0fbb089709be20.1542031058.git.berto@igalia.com>
In-Reply-To: <cover.1542031058.git.berto@igalia.com>
References: <cover.1542031058.git.berto@igalia.com>
In-Reply-To: <cover.1542031058.git.berto@igalia.com>
References: <cover.1542031058.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v5 16/16] block: Fix update of
 BDRV_O_AUTO_RDONLY in update_flags_from_options()
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

Commit e35bdc123a4ace9f4d3fcca added the auto-read-only option and the
code to update its corresponding flag in update_flags_from_options(),
but forgot to clear the flag if auto-read-only is false.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reported-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 03277b3d19..e1a969e331 100644
--- a/block.c
+++ b/block.c
@@ -1137,7 +1137,7 @@ static int bdrv_open_flags(BlockDriverState *bs, int flags)
 
 static void update_flags_from_options(int *flags, QemuOpts *opts)
 {
-    *flags &= ~BDRV_O_CACHE_MASK;
+    *flags &= ~(BDRV_O_CACHE_MASK | BDRV_O_RDWR | BDRV_O_AUTO_RDONLY);
 
     if (qemu_opt_get_bool_del(opts, BDRV_OPT_CACHE_NO_FLUSH, false)) {
         *flags |= BDRV_O_NO_FLUSH;
@@ -1147,8 +1147,6 @@ static void update_flags_from_options(int *flags, QemuOpts *opts)
         *flags |= BDRV_O_NOCACHE;
     }
 
-    *flags &= ~BDRV_O_RDWR;
-
     if (!qemu_opt_get_bool_del(opts, BDRV_OPT_READ_ONLY, false)) {
         *flags |= BDRV_O_RDWR;
     }
-- 
2.11.0
