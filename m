Received: from eggs.gnu.org ([2001:4830:134:3::10]:58493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAM-00088K-SL
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAM-0001Gz-6M
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cklAM-0001GP-0Q
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:38 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:49 +0800
Message-Id: <1488777954-4578-15-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 14/19] net/colo: fix memory double free
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

The 'primary_list' and 'secondary_list' members of struct Connection
is not allocated through dynamically g_queue_new(), but we free it by using
g_queue_free(), which will lead to a double-free bug.

Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/colo.c b/net/colo.c
index 6a6eacd..8cc166b 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -147,9 +147,9 @@ void connection_destroy(void *opaque)
     Connection *conn = opaque;
 
     g_queue_foreach(&conn->primary_list, packet_destroy, NULL);
-    g_queue_free(&conn->primary_list);
+    g_queue_clear(&conn->primary_list);
     g_queue_foreach(&conn->secondary_list, packet_destroy, NULL);
-    g_queue_free(&conn->secondary_list);
+    g_queue_clear(&conn->secondary_list);
     g_slice_free(Connection, conn);
 }
 
-- 
2.7.4
