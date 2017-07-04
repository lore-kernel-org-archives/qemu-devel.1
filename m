Received: from eggs.gnu.org ([2001:4830:134:3::10]:44139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1dSJXo-0008W0-G5
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1dSJXl-00024b-AG
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:50:52 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:45528)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1dSJXk-00022u-Fl
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:50:49 -0400
From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Date: Wed, 5 Jul 2017 00:45:32 +0800
Message-Id: <1499186732-32417-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: [Qemu-devel] [PATCH RESEND v6] qga: Add support network interface
 statistics in guest-network-get-interfaces command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, ZhiPeng Lu <lu.zhipeng@zte.com.cn>

we can get the network interface statistics inside a virtual machine by
guest-network-get-interfaces command. it is very useful for us to monitor
and analyze network traffic.

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
---
 qga/commands-posix.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 qga/qapi-schema.json | 38 ++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 915df9e..233b024 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1638,6 +1638,73 @@ guest_find_interface(GuestNetworkInterfaceList *head,
     return head;
 }
 
+
+static int str_trim_off(const char *s, int off, int lmt)
+{
+    for (; off < lmt; ++off) {
+        if (!isspace(s[off])) {
+            break;
+        }
+    }
+    return off;
+}
+
+static int guest_get_network_stats(const char *name,
+                       GuestNetworkInterfaceStat *stats)
+{
+    int name_len;
+    char const *devinfo = "/proc/net/dev";
+    FILE *fp;
+    char *line = NULL, *colon;
+    size_t n;
+    fp = fopen(devinfo, "r");
+    if (!fp) {
+        return -1;
+    }
+    name_len = strlen(name);
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
+        int trim_off;
+        colon = strchr(line, ':');
+        if (!colon) {
+            continue;
+        }
+        trim_off = str_trim_off(line, 0, strlen(line));
+        if (colon - name_len - trim_off == line &&
+           strncmp(line + trim_off, name, colon - line - trim_off) == 0) {
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
@@ -1654,6 +1721,7 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
     for (ifa = ifap; ifa; ifa = ifa->ifa_next) {
         GuestNetworkInterfaceList *info;
         GuestIpAddressList **address_list = NULL, *address_item = NULL;
+        GuestNetworkInterfaceStat  *interface_stat = NULL;
         char addr4[INET_ADDRSTRLEN];
         char addr6[INET6_ADDRSTRLEN];
         int sock;
@@ -1773,7 +1841,17 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
 
         info->value->has_ip_addresses = true;
 
-
+        if (!info->value->has_statistics) {
+            interface_stat = g_malloc0(sizeof(*interface_stat));
+            if (guest_get_network_stats(info->value->name,
+                interface_stat) == -1) {
+                info->value->has_statistics = false;
+                g_free(interface_stat);
+            } else {
+                info->value->statistics = interface_stat;
+                info->value->has_statistics = true;
+            }
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
