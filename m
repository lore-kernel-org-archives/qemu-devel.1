Received: from eggs.gnu.org ([2001:4830:134:3::10]:50830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dolkv-00089n-3J
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dolkr-0001SZ-R5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:25:13 -0400
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:48657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dolkr-0001JZ-Kw
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:25:09 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 15461517A5
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 09:25:01 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 04 Sep 2017 09:24:53 +0200
Message-ID: <150450989314.1143.5582306195355968158.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: local: clarify fchmodat_nofollow()
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since fchmodat(2) on Linux doesn't support AT_SYMLINK_NOFOLLOW, we have to
implement it using workarounds. There are two different ways, depending on
whether the system supports O_PATH or not.

In the case O_PATH is supported, we rely on the behavhior of openat(2)
when passing O_NOFOLLOW | O_PATH and the file is a symbolic link. Even
if openat_file() already adds O_NOFOLLOW to the flags, this patch makes
it explicit that we need both creation flags to obtain the expected
behavior.

This is only cleanup, no functional change.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index efb0b79a74bf..e51af87309c6 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -349,11 +349,11 @@ static int fchmodat_nofollow(int dirfd, const char *name, mode_t mode)
         return -1;
     }
 
-    /* Access modes are ignored when O_PATH is supported. We try O_RDONLY and
-     * O_WRONLY for old-systems that don't support O_PATH.
-     */
-    fd = openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL, 0);
+    fd = openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
 #if O_PATH_9P_UTIL == 0
+    /* Fallback for systems that don't support O_PATH: we depend on the file
+     * being readable or writable.
+     */
     if (fd == -1) {
         /* In case the file is writable-only and isn't a directory. */
         if (errno == EACCES) {
@@ -368,6 +368,10 @@ static int fchmodat_nofollow(int dirfd, const char *name, mode_t mode)
     }
     ret = fchmod(fd, mode);
 #else
+    /* Access modes are ignored when O_PATH is supported. If name is a symbolic
+     * link, O_PATH | O_NOFOLLOW causes openat(2) to return a file descriptor
+     * referring to the symbolic link.
+     */
     if (fd == -1) {
         return -1;
     }
