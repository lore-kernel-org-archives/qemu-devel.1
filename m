Received: from eggs.gnu.org ([2001:4830:134:3::10]:60312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1euD5q-0001i6-PR
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1euD5p-0008OR-Ls
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:09:34 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  9 Mar 2018 16:09:08 +0800
Message-Id: <20180309080910.7274-3-famz@redhat.com>
In-Reply-To: <20180309080910.7274-1-famz@redhat.com>
References: <20180309080910.7274-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] block: Fix write flags in
 bdrv_backing_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

When the child in question already has write access, we shouldn't change
that just because the parent being open/reopen doesn't need it. But if
we are inherenting the flags from a writable parent, we shouldn't copy
the BDRV_O_RDWR flag, which is consistent with the BDRV_OPT_READ_ONLY
option we set.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index bedbe208e6..937f9fe159 100644
--- a/block.c
+++ b/block.c
@@ -997,7 +997,10 @@ static void bdrv_backing_options(int *child_flags, QDict *child_options,
                                  int parent_flags, QDict *parent_options,
                                  int current_flags)
 {
-    int flags = parent_flags;
+    /* write flag should be preserved if the backing file already has it. This
+     * is important during reopen, to keep "parallel block jobs" work. */
+    int write_flag = current_flags & BDRV_O_RDWR;
+    int flags = parent_flags | write_flag;
 
     /* The cache mode is inherited unmodified for backing files; except WCE,
      * which is only applied on the top level (BlockBackend) */
@@ -1005,9 +1008,13 @@ static void bdrv_backing_options(int *child_flags, QDict *child_options,
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FLUSH);
     qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE);
 
-    /* backing files always opened read-only */
-    qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
-    flags &= ~BDRV_O_COPY_ON_READ;
+
+    if (!write_flag) {
+        flags &= ~BDRV_O_COPY_ON_READ;
+        /* backing files always opened read-only */
+        qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
+        flags &= ~BDRV_O_RDWR;
+    }
 
     /* snapshot=on is handled on the top layer */
     flags &= ~(BDRV_O_SNAPSHOT | BDRV_O_TEMPORARY);
-- 
2.14.3
