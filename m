Received: from eggs.gnu.org ([2001:4830:134:3::10]:39528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cko1h-0001SO-Hb
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cko1e-0006Ls-CQ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:29:53 -0500
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:46500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cko1e-0006LV-5R
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:29:50 -0500
Received: from player756.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id C856E5C3DA
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 09:29:47 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 06 Mar 2017 09:29:42 +0100
Message-ID: <148878898250.4635.16941960568938577780.stgit@bahia>
In-Reply-To: <148878895545.4635.12311472774377490920.stgit@bahia>
References: <148878895545.4635.12311472774377490920.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 2/2] 9pfs: fix vulnerability in openat_dir()
 and local_unlinkat_common()
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

While here, we also fix local_unlinkat_common() to use openat_dir() for
the same reasons (it was a leftover in the original patchset actually).

This fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
--
v2: - keep O_PATH (Eric Blake)
---
 hw/9pfs/9p-local.c |    2 +-
 hw/9pfs/9p-util.h  |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 0ca4c94ee4a8..45e9a1f9b0ca 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -960,7 +960,7 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
         if (flags == AT_REMOVEDIR) {
             int fd;
 
-            fd = openat(dirfd, name, O_RDONLY | O_DIRECTORY | O_PATH);
+            fd = openat_dir(dirfd, name);
             if (fd == -1) {
                 goto err_out;
             }
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index cb7b2072d3ac..517027c52032 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -27,7 +27,8 @@ static inline int openat_dir(int dirfd, const char *name)
 #else
 #define OPENAT_DIR_O_PATH 0
 #endif
-    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | OPENAT_DIR_O_PATH);
+    return openat(dirfd, name,
+                  O_DIRECTORY | O_RDONLY | O_NOFOLLOW | OPENAT_DIR_O_PATH);
 }
 
 static inline int openat_file(int dirfd, const char *name, int flags,
