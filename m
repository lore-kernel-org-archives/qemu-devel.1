Received: from eggs.gnu.org ([2001:4830:134:3::10]:50181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eS9Zc-0005DQ-Uy
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eS9Zb-0004kb-VZ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:44:21 -0500
From: John Snow <jsnow@redhat.com>
Date: Thu, 21 Dec 2017 17:44:11 -0500
Message-Id: <20171221224411.8901-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] file-posix: refuse to open directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

I don't think there's a legitimate reason to open directories as if
they were files. This prevents QEMU from opening and attempting to probe
a directory inode, which can break in exciting ways. One of those ways
is lseek on ext4/xfs, which will return 0x7fffffffffffffff as the file
size instead of EISDIR. This can coax QEMU into responding with a
confusing "file too big" instead of "Hey, that's not a file".

See: https://bugs.launchpad.net/qemu/+bug/1739304/
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/file-posix.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 36ee89e940..bd29bdada6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -589,6 +589,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         s->needs_alignment = true;
     }
 #endif
+    if (S_ISDIR(st.st_mode)) {
+        ret = -EISDIR;
+        error_setg_errno(errp, errno, "Cannot open directory as file");
+        goto fail;
+    }
 
 #ifdef CONFIG_XFS
     if (platform_test_xfs_fd(s->fd)) {
-- 
2.14.3
