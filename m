Received: from eggs.gnu.org ([2001:4830:134:3::10]:56143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdR-0000Sr-3z
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdQ-000439-94
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:49 -0400
Received: from [59.151.112.132] (port=61908 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdP-0003zx-Tc
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:48 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 12 May 2017 09:41:28 +0800
Message-ID: <1494553288-30764-13-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V4 12/12] net/filter-rewriter.c: Make
 filter-rewriter support vnet_hdr_len
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

We get the vnet_hdr_len from NetClientState that make us
parse net packet correctly.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-rewriter.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index bc6d12a..be129c7 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -17,6 +17,7 @@
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/error-report.h"
 #include "qapi-visit.h"
 #include "qom/object.h"
 #include "qemu/main-loop.h"
@@ -156,10 +157,24 @@ static ssize_t colo_rewriter_receive_iov(NetFilterState *nf,
     ConnectionKey key;
     Packet *pkt;
     ssize_t size = iov_size(iov, iovcnt);
+    ssize_t vnet_hdr_len = 0;
     char *buf = g_malloc0(size);
 
     iov_to_buf(iov, iovcnt, 0, buf, size);
-    pkt = packet_new(buf, size, 0);
+
+    if (s->vnet_hdr) {
+        if (nf->netdev->using_vnet_hdr) {
+            vnet_hdr_len = nf->netdev->vnet_hdr_len;
+        } else if (nf->netdev->peer->using_vnet_hdr) {
+            vnet_hdr_len = nf->netdev->peer->vnet_hdr_len;
+        } else {
+            error_report("filter-rewriter get vnet_hdr_len failed");
+            /* When error occurred we drop the packet  */
+            return 1;
+        }
+    }
+
+    pkt = packet_new(buf, size, vnet_hdr_len);
     g_free(buf);
 
     /*
-- 
2.7.4
