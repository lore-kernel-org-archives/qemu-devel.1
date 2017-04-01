Received: from eggs.gnu.org ([2001:4830:134:3::10]:35884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yaolujing@huawei.com>) id 1cu8nS-0002ja-5G
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 22:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yaolujing@huawei.com>) id 1cu8nO-0004W9-Vt
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 22:29:46 -0400
From: yaolujing <yaolujing@huawei.com>
Date: Sat, 1 Apr 2017 08:15:09 +0800
Message-ID: <1491005709-29989-1-git-send-email-yaolujing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] nbd: fix memory leak on socket_connect failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: sochin.jiang@huawei.com, xieyingtai@huawei.com, eric.fangyi@huawei.com, subo7@huawei.com, wangjie88@huawei.com, zhangshuai13@huawei.com, yaolujing@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

From: y00357587 <yaolujing@huawei.com>

When TCP connection fails between nbd server and client,
the local var, sioc, memory leak.

This patch fixes the memory leak.

Signed-off-by: y00357587 <yaolujing@huawei.com>
---
 block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nbd.c b/block/nbd.c
index 35f24be..102285e 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -313,6 +313,7 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
                                     saddr,
                                     &local_err);
     if (local_err) {
+        object_unref(OBJECT(sioc));
         error_propagate(errp, local_err);
         return NULL;
     }
-- 
1.8.3.1
