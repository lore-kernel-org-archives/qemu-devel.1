Received: from eggs.gnu.org ([2001:4830:134:3::10]:33282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYqs-0002wm-Mq
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYqo-0002qE-T6
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:34 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOYqo-0002pr-OE
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:30 -0400
Received: by mail-qt0-x243.google.com with SMTP id q13-v6so30303423qtp.4
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 18:27:30 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 21:25:57 -0400
Message-Id: <62bbed45cc9c775ba23cd5572e8cf2d77d769dfb.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v2 02/20] 9p: proxy: Fix size passed to
 `connect`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

The size to pass to the `connect` call is the size of the entire
`struct sockaddr_un`. Passing anything shorter than this causes errors
on darwin.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes since v1: New patch

 hw/9pfs/9p-proxy.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index e2e0329..47a94e0 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -1088,7 +1088,7 @@ static int proxy_ioc_getversion(FsContext *fs_ctx, V9fsPath *path,
 
 static int connect_namedsocket(const char *path, Error **errp)
 {
-    int sockfd, size;
+    int sockfd;
     struct sockaddr_un helper;
 
     if (strlen(path) >= sizeof(helper.sun_path)) {
@@ -1102,8 +1102,7 @@ static int connect_namedsocket(const char *path, Error **errp)
     }
     strcpy(helper.sun_path, path);
     helper.sun_family = AF_UNIX;
-    size = strlen(helper.sun_path) + sizeof(helper.sun_family);
-    if (connect(sockfd, (struct sockaddr *)&helper, size) < 0) {
+    if (connect(sockfd, (struct sockaddr *)&helper, sizeof(helper)) < 0) {
         error_setg_errno(errp, errno, "failed to connect to '%s'", path);
         close(sockfd);
         return -1;
-- 
2.8.1
