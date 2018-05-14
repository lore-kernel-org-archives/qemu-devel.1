Received: from eggs.gnu.org ([2001:4830:134:3::10]:57903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fI8LD-0007np-5H
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fI8LA-0004SN-GU
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:56:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fI8LA-0004Rq-B3
	for qemu-devel@nongnu.org; Mon, 14 May 2018 03:56:16 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 May 2018 15:55:59 +0800
Message-Id: <1526284560-20266-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1526284560-20266-1-git-send-email-jasowang@redhat.com>
References: <1526284560-20266-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] net: Get rid of 'vlan' terminology and use
 'hub' instead in the source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

'vlan' is very confusing since it does not mean something like IEEE
802.1Q, but rather emulated hubs, so let's switch to that terminology
instead.

Buglink: https://bugs.launchpad.net/qemu/+bug/658904
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/hub.c   | 7 +++----
 net/slirp.c | 8 ++++----
 net/tap.c   | 4 ++--
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/hub.c b/net/hub.c
index 5e84a9a..78b671e 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -23,8 +23,7 @@
 
 /*
  * A hub broadcasts incoming packets to all its ports except the source port.
- * Hubs can be used to provide independent network segments, also confusingly
- * named the QEMU 'vlan' feature.
+ * Hubs can be used to provide independent emulated network segments.
  */
 
 typedef struct NetHub NetHub;
@@ -345,10 +344,10 @@ void net_hub_check_clients(void)
             }
         }
         if (has_host_dev && !has_nic) {
-            warn_report("vlan %d with no nics", hub->id);
+            warn_report("hub %d with no nics", hub->id);
         }
         if (has_nic && !has_host_dev) {
-            warn_report("vlan %d is not connected to host network", hub->id);
+            warn_report("hub %d is not connected to host network", hub->id);
         }
     }
 }
diff --git a/net/slirp.c b/net/slirp.c
index 8991816..6922524 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -415,7 +415,7 @@ static SlirpState *slirp_lookup(Monitor *mon, const char *hub_id,
         if (hub_id) {
             nc = net_hub_find_client_by_name(strtol(hub_id, NULL, 0), name);
             if (!nc) {
-                monitor_printf(mon, "unrecognized (vlan-id, stackname) pair\n");
+                monitor_printf(mon, "unrecognized (hub-id, stackname) pair\n");
                 return NULL;
             }
         } else {
@@ -870,9 +870,9 @@ void hmp_info_usernet(Monitor *mon, const QDict *qdict)
 
     QTAILQ_FOREACH(s, &slirp_stacks, entry) {
         int id;
-        bool got_vlan_id = net_hub_id_for_client(&s->nc, &id) == 0;
-        monitor_printf(mon, "VLAN %d (%s):\n",
-                       got_vlan_id ? id : -1,
+        bool got_hub_id = net_hub_id_for_client(&s->nc, &id) == 0;
+        monitor_printf(mon, "Hub %d (%s):\n",
+                       got_hub_id ? id : -1,
                        s->nc.name);
         slirp_connection_info(s->slirp, mon);
     }
diff --git a/net/tap.c b/net/tap.c
index 2b3a36f..de05f20 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -766,10 +766,10 @@ int net_init_tap(const Netdev *netdev, const char *name,
     queues = tap->has_queues ? tap->queues : 1;
     vhostfdname = tap->has_vhostfd ? tap->vhostfd : NULL;
 
-    /* QEMU vlans does not support multiqueue tap, in this case peer is set.
+    /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
     if (peer && (tap->has_queues || tap->has_fds || tap->has_vhostfds)) {
-        error_setg(errp, "Multiqueue tap cannot be used with QEMU vlans");
+        error_setg(errp, "Multiqueue tap cannot be used with hubs");
         return -1;
     }
 
-- 
2.7.4
