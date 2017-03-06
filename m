Received: from eggs.gnu.org ([2001:4830:134:3::10]:39483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cko1X-0001LT-8d
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cko1U-0006JH-3x
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:29:43 -0500
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:34083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cko1T-0006J8-Tn
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:29:40 -0500
Received: from player756.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 81E4C5C3D7
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 09:29:37 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 06 Mar 2017 09:29:32 +0100
Message-ID: <148878897279.4635.8320563171450519845.stgit@bahia>
In-Reply-To: <148878895545.4635.12311472774377490920.stgit@bahia>
References: <148878895545.4635.12311472774377490920.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 1/2] 9pfs: fix O_PATH build break with older
 glibc versions
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

When O_PATH is used with O_DIRECTORY, it only acts as an optimization: the
openat() syscall simply finds the name in the VFS, and doesn't trigger the
underlying filesystem.

On systems that don't define O_PATH, because they have glibc version 2.13
or older for example, we can safely omit it. We don't want to deactivate
O_PATH globally though, in case it is used without O_DIRECTORY. The is done
with a dedicated macro.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-util.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 091f3ce88e15..cb7b2072d3ac 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -22,7 +22,12 @@ static inline void close_preserve_errno(int fd)
 
 static inline int openat_dir(int dirfd, const char *name)
 {
-    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | O_PATH);
+#ifdef O_PATH
+#define OPENAT_DIR_O_PATH O_PATH
+#else
+#define OPENAT_DIR_O_PATH 0
+#endif
+    return openat(dirfd, name, O_DIRECTORY | O_RDONLY | OPENAT_DIR_O_PATH);
 }
 
 static inline int openat_file(int dirfd, const char *name, int flags,
