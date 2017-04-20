Received: from eggs.gnu.org ([2001:4830:134:3::10]:49373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1d19mD-0002Uq-JL
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1d19mA-0001Zs-Eg
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:57:29 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:50712)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1d19m9-0001YO-Jt
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:57:26 -0400
From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Date: Thu, 20 Apr 2017 18:57:31 +0800
Message-Id: <1492685851-27921-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: [Qemu-devel] [PATCH] qga: Add support network interface statistics
 in guest-network-get-interfaces command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: berrange@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, ZhiPeng Lu <lu.zhipeng@zte.com.cn>

we can get the  network interface statistics inside  a virtual machine by
guest-network-get-interfaces command.
it is very userful for us to monitor and analyze network traff.

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Signed-off-by: DanielP.Berrange <berrange@redhat.com>
Reviewed-by: EricBlake  <eblake@redhat.com>
---
 qga/commands-posix.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 qga/qapi-schema.json | 28 +++++++++++++++++++-
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 915df9e..0c48707 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1638,6 +1638,65 @@ guest_find_interface(GuestNetworkInterfaceList *head,
     return head;
 }
 
+ static int guest_get_network_stats(const char *path,
+                       GuestNetworkInterfaceStat *stats)
+{
+    int path_len;
+    char const *devinfo = "/proc/net/dev";
+    FILE *fp;
+    char *line = NULL, *colon;
+    size_t n;
+    fp = fopen(devinfo, "r");
+    if (!fp) {
+        return -1;
+    }
+    path_len = strlen(path);
+    while (getline(&line, &n, fp) != -1) {
+        long long dummy;
+        long long rx_bytes;
+        long long rx_packets;
+        long long rx_errs;
+        long long rx_drop;
+        long long tx_bytes;
+        long long tx_packets;
+        long long tx_errs;
+        long long tx_drop;
+
+  /* The line looks like:
+   *"   eth0:..."
+   *Split it at the colon.
+   */
+        colon = strchr(line, ':');
+        if (!colon) {
+            continue;
+        }
+        *colon = '\0';
+        if (colon - path_len >= line && strcmp(colon - path_len, path) == 0) {
+            if (sscanf(colon + 1,
+                "%lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld",
+                  &rx_bytes, &rx_packets, &rx_errs, &rx_drop,
+                  &dummy, &dummy, &dummy, &dummy,
+                  &tx_bytes, &tx_packets, &tx_errs, &tx_drop,
+                  &dummy, &dummy, &dummy, &dummy) != 16) {
+                continue;
+            }
+            stats->rx_bytes = rx_bytes;
+            stats->rx_packets = rx_packets;
+            stats->rx_errs = rx_errs;
+            stats->rx_drop = rx_drop;
+            stats->tx_bytes = tx_bytes;
+            stats->tx_packets = tx_packets;
+            stats->tx_errs = tx_errs;
+            stats->tx_drop = tx_drop;
+            fclose(fp);
+            return 0;
+        }
+    }
+    fclose(fp);
+    g_debug("/proc/net/dev: Interface not found");
+    return -1;
+}
+
 /*
  * Build information about guest interfaces
  */
@@ -1654,6 +1713,7 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
     for (ifa = ifap; ifa; ifa = ifa->ifa_next) {
         GuestNetworkInterfaceList *info;
         GuestIpAddressList **address_list = NULL, *address_item = NULL;
+        GuestNetworkInterfaceStatList  *interface_stat_item = NULL;
         char addr4[INET_ADDRSTRLEN];
         char addr6[INET6_ADDRSTRLEN];
         int sock;
@@ -1770,9 +1830,20 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
         } else {
             (*address_list)->next = address_item;
         }
-
         info->value->has_ip_addresses = true;
 
+        if (!info->value->has_interface_statics) {
+            interface_stat_item = g_malloc0(sizeof(*interface_stat_item));
+            interface_stat_item->value = g_malloc0(
+               sizeof(*interface_stat_item->value));
+            if (guest_get_network_stats(info->value->name,
+                interface_stat_item->value) == -1) {
+                error_setg_errno(errp, errno, "guest_get_network_stats failed");
+                goto error;
+            }
+            info->value->interface_statics = interface_stat_item;
+        }
+        info->value->has_interface_statics = true;
 
     }
 
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a02dbf2..44bcced 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -635,6 +635,31 @@
            'prefix': 'int'} }
 
 ##
+# @GuestNetworkInterfaceStat:
+#
+# @rx-bytes: received bytes of interface
+# @rx-packets: received packets of interface
+# @rx-errs: received error packets of interface
+# @rx-drop: received drop packets of interface
+#
+# @tx-bytes: send bytes of interface
+# @tx-packets: send packets of interface
+# @tx-errs: send error packets of interface
+# @tx-drop: send drop packets of interface
+# Since: 2.10
+##
+{ 'struct': 'GuestNetworkInterfaceStat',
+  'data': {'rx-bytes': 'uint64',
+            'rx-packets': 'uint64',
+            'rx-errs': 'uint64',
+            'rx-drop': 'uint64',
+            'tx-bytes': 'uint64',
+            'tx-packets': 'uint64',
+            'tx-errs': 'uint64',
+            'tx-drop': 'uint64'
+           } }
+
+##
 # @GuestNetworkInterface:
 #
 # @name: The name of interface for which info are being delivered
@@ -648,7 +673,8 @@
 { 'struct': 'GuestNetworkInterface',
   'data': {'name': 'str',
            '*hardware-address': 'str',
-           '*ip-addresses': ['GuestIpAddress'] } }
+           '*ip-addresses': ['GuestIpAddress'],
+           '*interface-statics': ['GuestNetworkInterfaceStat'] } }
 
 ##
 # @guest-network-get-interfaces:
-- 
1.8.3.1
