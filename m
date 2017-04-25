Received: from eggs.gnu.org ([2001:4830:134:3::10]:45049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1d2oGg-0002Fh-47
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 20:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1d2oGb-0004qV-B7
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 20:23:46 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:33416)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1d2oGa-0004nL-Ea
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 20:23:41 -0400
From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Date: Tue, 25 Apr 2017 16:12:20 +0800
Message-Id: <1493107940-29950-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: [Qemu-devel] [PATCH v4] qga: Add support network interface
 statistics in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: berrange@redhat.com, qemu-devel@nongnu.org, ZhiPeng Lu <lu.zhipeng@zte.com.cn>

we can get the network interface statistics inside a virtual machine by
guest-network-get-interfaces command. it is very useful for us to monitor
and analyze network traffic.

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qga/commands-posix.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 qga/qapi-schema.json | 38 +++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 915df9e..1e35340 100644
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
+        long long rx_dropped;
+        long long tx_bytes;
+        long long tx_packets;
+        long long tx_errs;
+        long long tx_dropped;
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
+                  &rx_bytes, &rx_packets, &rx_errs, &rx_dropped,
+                  &dummy, &dummy, &dummy, &dummy,
+                  &tx_bytes, &tx_packets, &tx_errs, &tx_dropped,
+                  &dummy, &dummy, &dummy, &dummy) != 16) {
+                continue;
+            }
+            stats->rx_bytes = rx_bytes;
+            stats->rx_packets = rx_packets;
+            stats->rx_errs = rx_errs;
+            stats->rx_dropped = rx_dropped;
+            stats->tx_bytes = tx_bytes;
+            stats->tx_packets = tx_packets;
+            stats->tx_errs = tx_errs;
+            stats->tx_dropped = tx_dropped;
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
+        GuestNetworkInterfaceStat  *interface_stat = NULL;
         char addr4[INET_ADDRSTRLEN];
         char addr6[INET6_ADDRSTRLEN];
         int sock;
@@ -1773,7 +1833,16 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
 
         info->value->has_ip_addresses = true;
 
-
+        if (!info->value->has_statistics) {
+            interface_stat = g_malloc0(sizeof(*interface_stat));
+            if (guest_get_network_stats(info->value->name,
+                interface_stat) == -1) {
+                error_setg_errno(errp, errno, "guest_get_network_stats failed");
+                goto error;
+            }
+            info->value->statistics = interface_stat;
+            info->value->has_statistics = true;
+        }
     }
 
     freeifaddrs(ifap);
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a02dbf2..948219b 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -635,6 +635,38 @@
            'prefix': 'int'} }
 
 ##
+# @GuestNetworkInterfaceStat:
+#
+# @rx-bytes: total bytes received
+#
+# @rx-packets: total packets received
+#
+# @rx-errs: bad packets received
+#
+# @rx-dropped: receiver dropped packets
+#
+# @tx-bytes: total bytes transmitted
+#
+# @tx-packets: total packets transmitted
+#
+# @tx-errs: packet transmit problems
+#
+# @tx-dropped: dropped packets transmitted
+#
+# Since: 2.10
+##
+{ 'struct': 'GuestNetworkInterfaceStat',
+  'data': {'rx-bytes': 'uint64',
+            'rx-packets': 'uint64',
+            'rx-errs': 'uint64',
+            'rx-dropped': 'uint64',
+            'tx-bytes': 'uint64',
+            'tx-packets': 'uint64',
+            'tx-errs': 'uint64',
+            'tx-dropped': 'uint64'
+           } }
+
+##
 # @GuestNetworkInterface:
 #
 # @name: The name of interface for which info are being delivered
@@ -643,12 +675,16 @@
 #
 # @ip-addresses: List of addresses assigned to @name
 #
+# @statistics: various statistic counters related to @name
+# (since 2.10)
+#
 # Since: 1.1
 ##
 { 'struct': 'GuestNetworkInterface',
   'data': {'name': 'str',
            '*hardware-address': 'str',
-           '*ip-addresses': ['GuestIpAddress'] } }
+           '*ip-addresses': ['GuestIpAddress'],
+           '*statistics': 'GuestNetworkInterfaceStat' } }
 
 ##
 # @guest-network-get-interfaces:
-- 
1.8.3.1
