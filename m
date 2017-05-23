Received: from eggs.gnu.org ([2001:4830:134:3::10]:50067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCzoE-0004vg-Or
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCzoD-0005MC-S0
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dCzoD-0005LU-IL
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:29 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 May 2017 10:43:55 +0800
Message-Id: <1495507439-1784-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
References: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] hmp / net: Mark host_net_add/remove as
 deprecated
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

The netdev_add and netdev_del commands should be used nowadays instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hmp-commands.hx |  8 ++++----
 net/net.c       | 13 +++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 0aca984..baeac47 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1296,7 +1296,7 @@ ETEXI
         .name       = "host_net_add",
         .args_type  = "device:s,opts:s?",
         .params     = "tap|user|socket|vde|netmap|bridge|vhost-user|dump [options]",
-        .help       = "add host VLAN client",
+        .help       = "add host VLAN client (deprecated, use netdev_add instead)",
         .cmd        = hmp_host_net_add,
         .command_completion = host_net_add_completion,
     },
@@ -1304,14 +1304,14 @@ ETEXI
 STEXI
 @item host_net_add
 @findex host_net_add
-Add host VLAN client.
+Add host VLAN client. Deprecated, please use @code{netdev_add} instead.
 ETEXI
 
     {
         .name       = "host_net_remove",
         .args_type  = "vlan_id:i,device:s",
         .params     = "vlan_id name",
-        .help       = "remove host VLAN client",
+        .help       = "remove host VLAN client (deprecated, use netdev_del instead)",
         .cmd        = hmp_host_net_remove,
         .command_completion = host_net_remove_completion,
     },
@@ -1319,7 +1319,7 @@ ETEXI
 STEXI
 @item host_net_remove
 @findex host_net_remove
-Remove host VLAN client.
+Remove host VLAN client. Deprecated, please use @code{netdev_del} instead.
 ETEXI
 
     {
diff --git a/net/net.c b/net/net.c
index 0ac3b9e..6235aab 100644
--- a/net/net.c
+++ b/net/net.c
@@ -45,6 +45,7 @@
 #include "qapi-visit.h"
 #include "qapi/opts-visitor.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
 #include "net/filter.h"
 #include "qapi/string-output-visitor.h"
 
@@ -1149,6 +1150,12 @@ void hmp_host_net_add(Monitor *mon, const QDict *qdict)
     const char *opts_str = qdict_get_try_str(qdict, "opts");
     Error *local_err = NULL;
     QemuOpts *opts;
+    static bool warned;
+
+    if (!warned && !qtest_enabled()) {
+        error_report("host_net_add is deprecated, use netdev_add instead");
+        warned = true;
+    }
 
     if (!net_host_check_device(device)) {
         monitor_printf(mon, "invalid host network device %s\n", device);
@@ -1175,6 +1182,12 @@ void hmp_host_net_remove(Monitor *mon, const QDict *qdict)
     NetClientState *nc;
     int vlan_id = qdict_get_int(qdict, "vlan_id");
     const char *device = qdict_get_str(qdict, "device");
+    static bool warned;
+
+    if (!warned && !qtest_enabled()) {
+        error_report("host_net_remove is deprecated, use netdev_del instead");
+        warned = true;
+    }
 
     nc = net_hub_find_client_by_name(vlan_id, device);
     if (!nc) {
-- 
2.7.4
