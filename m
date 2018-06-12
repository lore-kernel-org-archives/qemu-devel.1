Received: from eggs.gnu.org ([2001:4830:134:3::10]:46619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fSYzm-0007wO-0U
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fSYzi-0007VW-Qt
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:25:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2550 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1fSYzi-0007Sa-CP
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:25:14 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 12 Jun 2018 10:24:45 +0800
Message-ID: <20180612022445.5192-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] vhost-user: delete net client if necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, wangxinxin.wang@huawei.com, liujunjie23@huawei.com, linzhecheng <linzhecheng@huawei.com>

As qemu_new_net_client create new ncs but error happens later,
ncs will be left in global net_clients list and we can't use them any
more, so we need to cleanup them.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 608b837175..a39f9c9974 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -345,6 +345,9 @@ err:
             s->vhost_user = NULL;
         }
     }
+    if (nc0) {
+        qemu_del_net_client(nc0);
+    }
 
     return -1;
 }
-- 
2.12.2.windows.2
