Received: from eggs.gnu.org ([2001:4830:134:3::10]:43778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d41gB-0001Ph-8o
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d41g6-0001nv-PN
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:55:07 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:42303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d41g6-0001l3-Ih
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:55:02 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id CF4CAEA8B7
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 10:54:54 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 28 Apr 2017 10:54:42 +0200
Message-ID: <149336968270.4566.7770744042249761246.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: local: fix unlink of alien files in
 mapped-file mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

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
---
 hw/9pfs/9p-local.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index f3ebca4f7a56..4e9823b08e74 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -983,12 +983,20 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
          * .virtfs_metadata directory.
          */
         map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
-        ret = unlinkat(map_dirfd, name, 0);
-        close_preserve_errno(map_dirfd);
-        if (ret < 0 && errno != ENOENT) {
+        if (map_dirfd != -1) {
+            ret = unlinkat(map_dirfd, name, 0);
+            close_preserve_errno(map_dirfd);
+            if (ret < 0 && errno != ENOENT) {
+                /*
+                 * We didn't had the .virtfs_metadata file. May be file created
+                 * in non-mapped mode ?. Ignore ENOENT.
+                 */
+                goto err_out;
+            }
+        } else if (errno != ENOENT) {
             /*
-             * We didn't had the .virtfs_metadata file. May be file created
-             * in non-mapped mode ?. Ignore ENOENT.
+             * We didn't had the parent .virtfs_metadata directory. May be
+             * file created in non-mapped mode ?. Ignore ENOENT.
              */
             goto err_out;
         }
