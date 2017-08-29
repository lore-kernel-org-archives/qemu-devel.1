Received: from eggs.gnu.org ([2001:4830:134:3::10]:47374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC7-0000r8-5L
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC3-000553-7O
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUC2-00054A-Uq
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:47 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EDPc077706
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:46 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmnx0yuc7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:45 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:15:44 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:48 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-14-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 13/79] 9pfs: local: fix unlink of alien files
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
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

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

(cherry picked from commit 6a87e7929f97b86c5823d4616fa1aa7636b2f116)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index f3ebca4..7a0c383 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -957,6 +957,14 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
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
 
@@ -964,32 +972,20 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
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
2.7.4
