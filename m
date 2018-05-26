Received: from eggs.gnu.org ([2001:4830:134:3::10]:35810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgd-0006Nh-U0
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgd-0004bv-2c
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:15 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:41946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRgc-0004bl-To
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:14 -0400
Received: by mail-qk0-x243.google.com with SMTP id d125-v6so5668761qkb.8
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:24:14 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:13 -0400
Message-Id: <e47c58ca95c93503a9d85dc6d749acf9fe9c6e76.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 11/13] 9p: darwin: Mark mknod as unsupported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@alumni.harvard.edu>, groug@kaod.org, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@alumni.harvard.edu>

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 hw/9pfs/9p-local.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index c55ea25..3e358b7 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -669,6 +669,13 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
         return -1;
     }
 
+#ifdef CONFIG_DARWIN
+    /* Darwin doesn't have mknodat and it's unlikely to work anyway,
+       so let's just mark it as unsupported */
+    err = -1;
+    errno = EOPNOTSUPP;
+    goto out;
+#else
     if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
         fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         err = mknodat(dirfd, name, fs_ctx->fmode | S_IFREG, 0);
@@ -699,6 +706,8 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
 
 err_end:
     unlinkat_preserve_errno(dirfd, name, 0);
+#endif
+
 out:
     close_preserve_errno(dirfd);
     return err;
-- 
2.8.1
