Received: from eggs.gnu.org ([2001:4830:134:3::10]:35001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fE796-0007Ap-Um
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fE793-0004bQ-Rc
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:51:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fE793-0004aY-Mb
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:51:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AF96401DE9F
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 05:51:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  3 May 2018 07:50:58 +0200
Message-Id: <1525326658-3078-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] net: Silence 'has no peer' messages in testing
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

When running qtests with -nodefaults, we are not interested in
these 'XYZ has no peer' messages.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/net.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/net.c b/net/net.c
index 29f8398..58bf85e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1427,12 +1427,13 @@ void net_check_clients(void)
 
     net_hub_check_clients();
 
-    QTAILQ_FOREACH(nc, &net_clients, next) {
-        if (!nc->peer) {
-            warn_report("%s %s has no peer",
-                        nc->info->type == NET_CLIENT_DRIVER_NIC
-                        ? "nic" : "netdev",
-                        nc->name);
+    if (!qtest_enabled() || nd_table[0].used) {
+        QTAILQ_FOREACH(nc, &net_clients, next) {
+            if (!nc->peer) {
+                warn_report("%s %s has no peer",
+                            nc->info->type == NET_CLIENT_DRIVER_NIC
+                            ? "nic" : "netdev", nc->name);
+            }
         }
     }
 
-- 
1.8.3.1
