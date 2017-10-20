Received: from eggs.gnu.org ([2001:4830:134:3::10]:54055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1e5NWj-0005Ft-JL
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 22:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1e5NWg-0007ns-Bl
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 22:59:13 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:57790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lu.zhipeng@zte.com.cn>)
	id 1e5NWg-0007mP-1T
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 22:59:10 -0400
From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Date: Fri, 20 Oct 2017 10:58:46 +0800
Message-Id: <1508468326-18354-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: [Qemu-devel] [PATCH] net: add print link status of nics in
 print_net_client function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, ZhiPeng Lu <lu.zhipeng@zte.com.cn>

We can directly know the information of vm by executing "info network" command,
 including the link state of nics, without excuting other commands again.

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Reviewed-by: Jiyun Fan <fan.jiyun@zte.com.cn>
---
 net/net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index 39ef546..9e349cb 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1298,10 +1298,14 @@ void print_net_client(Monitor *mon, NetClientState *nc)
 {
     NetFilterState *nf;
 
-    monitor_printf(mon, "%s: index=%d,type=%s,%s\n", nc->name,
+    monitor_printf(mon, "%s: index=%d,type=%s,%s", nc->name,
                    nc->queue_index,
                    NetClientDriver_str(nc->info->type),
                    nc->info_str);
+    if (nc->info->type == NET_CLIENT_DRIVER_NIC) {
+        monitor_printf(mon, ",link status:%s", nc->link_down ? "down" : "up");
+    }
+    monitor_printf(mon, "\n");
     if (!QTAILQ_EMPTY(&nc->filters)) {
         monitor_printf(mon, "filters:\n");
     }
-- 
1.8.3.1
