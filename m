Received: from eggs.gnu.org ([2001:4830:134:3::10]:34621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpGHR-0006Pv-W2
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpGHI-0000Q9-Nx
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:00:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dpGHI-0000Oy-DE
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:00:40 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85G0Z6b110997
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 12:00:39 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csu2wd7e3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 12:00:38 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 5 Sep 2017 17:00:33 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue,  5 Sep 2017 18:00:25 +0200
In-Reply-To: <20170905160027.15081-1-groug@kaod.org>
References: <20170905160027.15081-1-groug@kaod.org>
Message-Id: <20170905160027.15081-3-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 2/4] fsdev: fix memory leak in main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, ZhiPeng Lu <lu.zhipeng@zte.com.cn>

From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>

@rpath and @sock_name are not freed and leaked.

[groug, not really leaked since the program exits just after that. But it
 is always good practice to free allocated memory]

Signed-off-by: Zhipeng Lu <lu.zhipeng@zte.com.cn>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/virtfs-proxy-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index 6c066ec9a0ce..8e48500dd53a 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -1162,6 +1162,8 @@ int main(int argc, char **argv)
 
     process_requests(sock);
 error:
+    g_free(rpath);
+    g_free(sock_name);
     do_log(LOG_INFO, "Done\n");
     closelog();
     return 0;
-- 
2.13.5
