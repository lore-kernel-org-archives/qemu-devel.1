Received: from eggs.gnu.org ([2001:4830:134:3::10]:36315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1drgzA-0002bC-UG
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1drgz6-0005rv-5g
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:56:00 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:37544 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lu.zhipeng@zte.com.cn>)
	id 1drgz5-0005nv-ID
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 04:55:56 -0400
From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Date: Tue, 12 Sep 2017 16:54:26 +0800
Message-Id: <1505206466-23361-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: [Qemu-devel] [PATCH v7 RESEND] qga: Add support network interface
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
v1->v2:
 - correct some spelling mistake and add the stats data to the
   guest-network-get-interfaces command instead of adding a new command.
v2-v3:
 - optimize function implementation
v3->v4:
 - modify compile error
v4->v5:
 - rename some temporary variables and add str_trim_off function for
   calculating the space num in front of the string in guest_get_network_stats
v5->v6:
 - use g_strchug instead of str_trim_off implemented by myself
v6->v7:
 - add implementation for windows
---
 qga/commands-posix.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 qga/commands-win32.c | 48 +++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 38 ++++++++++++++++++++++++++-
 3 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index ab0c63d..da5dba0 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1643,6 +1643,65 @@ guest_find_interface(GuestNetworkInterfaceList *head,
     return head;
 }
 
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
+        char *trim_line;
+        trim_line = g_strchug(line);
+        if (trim_line[0] == '\0') {
+            continue;
+        }
+        colon = strchr(trim_line, ':');
+        if (!colon) {
+            continue;
+        }
+        if (colon - name_len  == trim_line &&
+           strncmp(trim_line, name, name_len) == 0) {
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
@@ -1659,6 +1718,7 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
     for (ifa = ifap; ifa; ifa = ifa->ifa_next) {
         GuestNetworkInterfaceList *info;
         GuestIpAddressList **address_list = NULL, *address_item = NULL;
+        GuestNetworkInterfaceStat  *interface_stat = NULL;
         char addr4[INET_ADDRSTRLEN];
         char addr6[INET6_ADDRSTRLEN];
         int sock;
@@ -1778,7 +1838,17 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
 
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
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 619dbd2..e891253 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1152,6 +1152,42 @@ out:
 }
 #endif
 
+static DWORD get_interface_index(const char *guid)
+{
+    ULONG index;
+    DWORD status;
+    wchar_t wbuf[512];
+    snwprintf(wbuf, sizeof(wbuf), L"\\device\\tcpip_%s", guid);
+    wbuf[sizeof(wbuf) - 1] = 0;
+    status = GetAdapterIndex (wbuf, &index);
+    if (status != NO_ERROR) {
+        return (DWORD)~0;
+    } else {
+        return index;
+    }
+}
+static int guest_get_network_stats(const char *name,
+                       GuestNetworkInterfaceStat *stats)
+{
+    DWORD IfIndex = 0;
+    MIB_IFROW aMib_ifrow;
+    memset(&aMib_ifrow, 0, sizeof(aMib_ifrow));
+    IfIndex = get_interface_index(name);
+    aMib_ifrow.dwIndex = IfIndex;
+    if (NO_ERROR == GetIfEntry(&aMib_ifrow)) {
+        stats->rx_bytes = aMib_ifrow.dwInOctets;
+        stats->rx_packets = aMib_ifrow.dwInUcastPkts;
+        stats->rx_errs = aMib_ifrow.dwInErrors;
+        stats->rx_dropped = aMib_ifrow.dwInDiscards;
+        stats->tx_bytes = aMib_ifrow.dwOutOctets;
+        stats->tx_packets = aMib_ifrow.dwOutUcastPkts;
+        stats->tx_errs = aMib_ifrow.dwOutErrors;
+        stats->tx_dropped = aMib_ifrow.dwOutDiscards;
+        return 0;
+    }
+    return -1;
+}
+
 GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
 {
     IP_ADAPTER_ADDRESSES *adptr_addrs, *addr;
@@ -1159,6 +1195,7 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
     GuestNetworkInterfaceList *head = NULL, *cur_item = NULL;
     GuestIpAddressList *head_addr, *cur_addr;
     GuestNetworkInterfaceList *info;
+    GuestNetworkInterfaceStat *interface_stat = NULL;
     GuestIpAddressList *address_item = NULL;
     unsigned char *mac_addr;
     char *addr_str;
@@ -1238,6 +1275,17 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
             info->value->has_ip_addresses = true;
             info->value->ip_addresses = head_addr;
         }
+        if (!info->value->has_statistics) {
+            interface_stat = g_malloc0(sizeof(*interface_stat));
+            if (guest_get_network_stats(addr->AdapterName,
+                interface_stat) == -1) {
+                info->value->has_statistics = false;
+                g_free(interface_stat);
+            } else {
+                info->value->statistics = interface_stat;
+                info->value->has_statistics = true;
+            }
+        }
     }
     WSACleanup();
 out:
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 90a0c86..17884c7 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -643,6 +643,38 @@
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
+# Since: 2.11
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
@@ -651,12 +683,16 @@
 #
 # @ip-addresses: List of addresses assigned to @name
 #
+# @statistics: various statistic counters related to @name
+# (since 2.11)
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
