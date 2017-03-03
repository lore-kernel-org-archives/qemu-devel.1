Received: from eggs.gnu.org ([2001:4830:134:3::10]:47485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjqxZ-0000Si-N7
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjqxV-0006S8-Oq
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:25:41 -0500
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:39862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjqxV-0006Qe-IJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:25:37 -0500
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id B974426A7F
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 18:25:35 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 03 Mar 2017 18:25:30 +0100
Message-ID: <148856193073.554.6631259860971664030.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: fix vulnerability in openat_dir() and
 local_unlinkat_common()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Greg Kurz <groug@kaod.org>

We should pass O_NOFOLLOW otherwise openat() will follow symlinks and make
QEMU vulnerable.

O_PATH was used as an optimization: the fd returned by openat_dir() is only
passed to openat() actually, so we don't really need to reach the underlying
filesystem.

O_NOFOLLOW | O_PATH isn't an option: if name is a symlink, openat() will
return a fd, forcing us to do some other syscall to detect we have a
symlink. Also, O_PATH doesn't exist in glibc 2.13 and older.

The only sane thing to do is hence to drop O_PATH, and only pass O_NOFOLLOW.

While here, we also fix local_unlinkat_common() to use openat_dir() for
the same reasons (it was a leftover in the original patchset actually).

This fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |    2 +-
 hw/9pfs/9p-util.h  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 5db7104334d6..e31309a29c58 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -959,7 +959,7 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
         if (flags == AT_REMOVEDIR) {
             int fd;
 
-            fd = openat(dirfd, name, O_RDONLY | O_DIRECTORY | O_PATH);
+            fd = openat_dir(dirfd, name);
             if (fd == -1) {
                 goto err_out;
             }
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 091f3ce88e15..4001d1fd8398 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -22,7 +22,7 @@ static inline void close_preserve_errno(int fd)
 
 static inline int openat_dir(int dirfd, const char *name)
 {
-    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_PATH);
+    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_NOFOLLOW);
 }
 
 static inline int openat_file(int dirfd, const char *name, int flags,
