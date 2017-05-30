Received: from eggs.gnu.org ([2001:4830:134:3::10]:40413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFhOg-0007H7-0C
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFhOa-00021d-UQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFhOa-00021F-Ki
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:12 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4UDcdZZ038338
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:41:11 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2as67h9q5d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:41:10 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 30 May 2017 14:41:08 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 30 May 2017 15:40:33 +0200
In-Reply-To: <1496151640-29919-1-git-send-email-groug@kaod.org>
References: <1496151640-29919-1-git-send-email-groug@kaod.org>
Message-Id: <1496151640-29919-5-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 04/11] 9pfs: local: fix unlink of alien files
 in mapped-file mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>

When trying to remove a file from a directory, both created in non-mapped
mode, the file remains and EBADF is returned to the guest.

This is a regression introduced by commit "df4938a6651b 9pfs: local:
unlinkat: don't follow symlinks" when fixing CVE-2016-9602. It changed the
way we unlink the metadata file from

    ret = remove("$dir/.virtfs_metadata/$name");
    if (ret < 0 && errno != ENOENT) {
         /* Error out */
    }
    /* Ignore absence of metadata */

to

    fd = openat("$dir/.virtfs_metadata")
    unlinkat(fd, "$name")
    if (ret < 0 && errno != ENOENT) {
         /* Error out */
    }
    /* Ignore absence of metadata */

If $dir was created in non-mapped mode, openat() fails with ENOENT and
we pass -1 to unlinkat(), which fails in turn with EBADF.

We just need to check the return of openat() and ignore ENOENT, in order
to restore the behaviour we had with remove().

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
[groug: rewrote the comments as suggested by Eric]
---
 hw/9pfs/9p-local.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index a2486566afb7..226234d38642 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -992,6 +992,14 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         int map_dirfd;
 
+        /* We need to remove the metadata as well:
+         * - the metadata directory if we're removing a directory
+         * - the metadata file in the parent's metadata directory
+         *
+         * If any of these are missing (ie, ENOENT) then we're probably
+         * trying to remove something that wasn't created in mapped-file
+         * mode. We just ignore the error.
+         */
         if (flags == AT_REMOVEDIR) {
             int fd;
 
@@ -999,32 +1007,20 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
             if (fd == -1) {
                 goto err_out;
             }
-            /*
-             * If directory remove .virtfs_metadata contained in the
-             * directory
-             */
             ret = unlinkat(fd, VIRTFS_META_DIR, AT_REMOVEDIR);
             close_preserve_errno(fd);
             if (ret < 0 && errno != ENOENT) {
-                /*
-                 * We didn't had the .virtfs_metadata file. May be file created
-                 * in non-mapped mode ?. Ignore ENOENT.
-                 */
                 goto err_out;
             }
         }
-        /*
-         * Now remove the name from parent directory
-         * .virtfs_metadata directory.
-         */
         map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
-        ret = unlinkat(map_dirfd, name, 0);
-        close_preserve_errno(map_dirfd);
-        if (ret < 0 && errno != ENOENT) {
-            /*
-             * We didn't had the .virtfs_metadata file. May be file created
-             * in non-mapped mode ?. Ignore ENOENT.
-             */
+        if (map_dirfd != -1) {
+            ret = unlinkat(map_dirfd, name, 0);
+            close_preserve_errno(map_dirfd);
+            if (ret < 0 && errno != ENOENT) {
+                goto err_out;
+            }
+        } else if (errno != ENOENT) {
             goto err_out;
         }
     }
-- 
2.7.5
