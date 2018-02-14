Received: from eggs.gnu.org ([2001:4830:134:3::10]:37485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1em3zj-0002IO-Mw
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1em3zi-0001uI-SK
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:49:35 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 14 Feb 2018 21:49:15 +0100
Message-Id: <20180214204915.7980-4-mreitz@redhat.com>
In-Reply-To: <20180214204915.7980-1-mreitz@redhat.com>
References: <20180214204915.7980-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] block/ssh: Add basic .bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Jeff Cody <jcody@redhat.com>

libssh2 does not seem to offer real truncation support, so we can only
grow files -- but that is better than nothing.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/block/ssh.c b/block/ssh.c
index ff8576f21e..c235eec255 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1219,6 +1219,29 @@ static int64_t ssh_getlength(BlockDriverState *bs)
     return length;
 }
 
+static int ssh_truncate(BlockDriverState *bs, int64_t offset,
+                        PreallocMode prealloc, Error **errp)
+{
+    BDRVSSHState *s = bs->opaque;
+
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Unsupported preallocation mode '%s'",
+                   PreallocMode_str(prealloc));
+        return -ENOTSUP;
+    }
+
+    if (offset < s->attrs.filesize) {
+        error_setg(errp, "ssh driver does not support shrinking files");
+        return -ENOTSUP;
+    }
+
+    if (offset == s->attrs.filesize) {
+        return 0;
+    }
+
+    return ssh_grow_file(s, offset, errp);
+}
+
 static BlockDriver bdrv_ssh = {
     .format_name                  = "ssh",
     .protocol_name                = "ssh",
@@ -1231,6 +1254,7 @@ static BlockDriver bdrv_ssh = {
     .bdrv_co_readv                = ssh_co_readv,
     .bdrv_co_writev               = ssh_co_writev,
     .bdrv_getlength               = ssh_getlength,
+    .bdrv_truncate                = ssh_truncate,
     .bdrv_co_flush_to_disk        = ssh_co_flush,
     .create_opts                  = &ssh_create_opts,
 };
-- 
2.14.3
