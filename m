Received: from eggs.gnu.org ([2001:4830:134:3::10]:43501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciYsI-0005ew-C5
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciYsF-0004Cr-Bo
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:54:54 -0500
Received: from [45.249.212.188] (port=2945 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ciYsF-0004B7-0l
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 22:54:51 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Tue, 28 Feb 2017 11:54:18 +0800
Message-ID: <1488254059-22716-2-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1488254059-22716-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1488254059-22716-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/2] net/colo: fix memory double free error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>

The 'primary_list' and 'secondary_list' members of struct Connection
is not allocated through dynamically g_queue_new(), but we free it by using
g_queue_free(), which will lead to a double-free bug.

Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
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
1.8.3.1
