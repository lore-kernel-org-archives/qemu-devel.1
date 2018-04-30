Received: from eggs.gnu.org ([2001:4830:134:3::10]:40539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fD3DD-0001IE-Qs
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fD3DA-0002JG-Mq
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:27:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fD3DA-0002Iu-Ir
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:27:00 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 30 Apr 2018 09:26:45 +0200
Message-Id: <1525073205-22394-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] net: Fix memory leak in net_param_nic()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The early exits in case of errors leak the memory allocated for nd_id.
Fix it by using a "goto out" to the cleanup at the end of the function
instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/net.c b/net/net.c
index 29f8398..65457b7 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1502,11 +1502,12 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
         g_free(mac);
         if (ret) {
             error_setg(errp, "invalid syntax for ethernet address");
-            return -1;
+            goto out;
         }
         if (is_multicast_ether_addr(ni->macaddr.a)) {
             error_setg(errp, "NIC cannot have multicast MAC address");
-            return -1;
+            ret = -1;
+            goto out;
         }
     }
     qemu_macaddr_default_if_unset(&ni->macaddr);
@@ -1518,6 +1519,7 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
         nb_nics++;
     }
 
+out:
     g_free(nd_id);
     return ret;
 }
-- 
1.8.3.1
