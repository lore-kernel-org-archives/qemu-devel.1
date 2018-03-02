Received: from eggs.gnu.org ([2001:4830:134:3::10]:53309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqx-00027U-Ji
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqw-0003Wu-QE
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:47 +0100
Message-Id: <20180302185448.6314-37-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 36/37] block/ssh: Add basic .bdrv_truncate()
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

From: Max Reitz <mreitz@redhat.com>

libssh2 does not seem to offer real truncation support, so we can only
grow files -- but that is better than nothing.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180214204915.7980-4-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/block/ssh.c b/block/ssh.c
index 4bcf10334f..80a8b40dfa 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1220,6 +1220,29 @@ static int64_t ssh_getlength(BlockDriverState *bs)
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
@@ -1232,6 +1255,7 @@ static BlockDriver bdrv_ssh = {
     .bdrv_co_readv                = ssh_co_readv,
     .bdrv_co_writev               = ssh_co_writev,
     .bdrv_getlength               = ssh_getlength,
+    .bdrv_truncate                = ssh_truncate,
     .bdrv_co_flush_to_disk        = ssh_co_flush,
     .create_opts                  = &ssh_create_opts,
 };
-- 
2.13.6
