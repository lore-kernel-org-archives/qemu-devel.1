Received: from eggs.gnu.org ([2001:4830:134:3::10]:37487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1em3zj-0002IP-P0
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1em3zi-0001uf-VR
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:49:35 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 14 Feb 2018 21:49:14 +0100
Message-Id: <20180214204915.7980-3-mreitz@redhat.com>
In-Reply-To: <20180214204915.7980-1-mreitz@redhat.com>
References: <20180214204915.7980-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] block/ssh: Make ssh_grow_file() blocking
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

At runtime (that is, during a future ssh_truncate()), the SSH session is
non-blocking.  However, ssh_truncate() (or rather, bdrv_truncate() in
general) is not a coroutine, so this resize operation needs to block.

For ssh_create(), that is fine, too; the session is never set to
non-blocking anyway.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/ssh.c b/block/ssh.c
index 964e55f7fe..ff8576f21e 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -803,17 +803,24 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
     return ret;
 }
 
+/* Note: This is a blocking operation */
 static int ssh_grow_file(BDRVSSHState *s, int64_t offset, Error **errp)
 {
     ssize_t ret;
     char c[1] = { '\0' };
+    int was_blocking = libssh2_session_get_blocking(s->session);
 
     /* offset must be strictly greater than the current size so we do
      * not overwrite anything */
     assert(offset > 0 && offset > s->attrs.filesize);
 
+    libssh2_session_set_blocking(s->session, 1);
+
     libssh2_sftp_seek64(s->sftp_handle, offset - 1);
     ret = libssh2_sftp_write(s->sftp_handle, c, 1);
+
+    libssh2_session_set_blocking(s->session, was_blocking);
+
     if (ret < 0) {
         sftp_error_setg(errp, s, "Failed to grow file");
         return -EIO;
-- 
2.14.3
