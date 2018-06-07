Received: from eggs.gnu.org ([2001:4830:134:3::10]:57018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwk3-000221-4i
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwjz-0000QS-5V
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43338
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQwjy-0000LH-Vu
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:19 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w57FJqNH105492
	for <qemu-devel@nongnu.org>; Thu, 7 Jun 2018 11:22:08 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jf5pew626-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 11:22:07 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 7 Jun 2018 16:22:05 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu,  7 Jun 2018 17:21:13 +0200
In-Reply-To: <20180607152119.3447-1-groug@kaod.org>
References: <20180607152119.3447-1-groug@kaod.org>
Message-Id: <20180607152119.3447-2-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/7] 9p: proxy: Fix size passed to `connect`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@juliacomputing.com>

The size to pass to the `connect` call is the size of the entire
`struct sockaddr_un`. Passing anything shorter than this causes errors
on darwin.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-proxy.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index e2e03292de2c..47a94e088daa 100644
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
2.14.4
