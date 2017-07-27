Received: from eggs.gnu.org ([2001:4830:134:3::10]:60636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1daWjl-0001zC-0k
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 20:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1daWjg-0002rC-B1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 20:33:09 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:48530)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1daWjg-0002q6-0N
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 20:33:04 -0400
From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Date: Thu, 27 Jul 2017 08:31:42 +0800
Message-Id: <1501115502-15185-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: [Qemu-devel] [PATCH] fsdev: fix memory leak in main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: qemu-devel@nongnu.org, ZhiPeng Lu <lu.zhipeng@zte.com.cn>

@rpath and @ sock_name are not freed and leaked.

Signed-off-by: Zhipeng Lu lu.zhipeng@zte.com.cn
---
 fsdev/virtfs-proxy-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index 6c066ec..8e48500 100644
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
1.8.3.1
