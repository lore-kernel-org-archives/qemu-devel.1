Received: from eggs.gnu.org ([2001:4830:134:3::10]:38580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7tJI-0003J5-3m
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7tJD-0003eo-2d
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7tJC-0003dH-Pa
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9R1JFNr069138
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:19:34 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dusba44vp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:19:33 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 21:19:32 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 20:18:48 -0500
In-Reply-To: <20171027011849.29195-1-mdroth@linux.vnet.ibm.com>
References: <20171027011849.29195-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171027011849.29195-4-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 3/4] qga: add network stats to
 guest-network-get-interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ZhiPeng Lu <lu.zhipeng@zte.com.cn>

From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>

we can get the network interface statistics inside a virtual machine by
guest-network-get-interfaces command. it is very useful for us tomonitor
and analyze network traffic.

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
* don't rely on sizeof(wchar[]) for wchar[] indexing
* avoid camelCase variable names
* fix up getline() usage
* condensed commit subject line
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 qga/commands-win32.c | 50 +++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 38 ++++++++++++++++++++++++++-
 3 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index ab0c63d931..e809e382eb 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1643,6 +1643,67 @@ guest_find_interface(GuestNetworkInterfaceList *head,
     return head;
 }
 
+static int guest_get_network_stats(const char *name,
+                       GuestNetworkInterfaceStat *stats)
+{
+    int name_len;
+    char const *devinfo = "/proc/net/dev";
+    FILE *fp;
+    char *line = NULL, *colon;
+    size_t n = 0;
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
+            g_free(line);
+            return 0;
+        }
+    }
+    fclose(fp);
+    g_free(line);
+    g_debug("/proc/net/dev: Interface '%s' not found", name);
+    return -1;
+}
+
 /*
  * Build information about guest interfaces
  */
@@ -1659,6 +1720,7 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
     for (ifa = ifap; ifa; ifa = ifa->ifa_next) {
         GuestNetworkInterfaceList *info;
         GuestIpAddressList **address_list = NULL, *address_item = NULL;
+        GuestNetworkInterfaceStat  *interface_stat = NULL;
         char addr4[INET_ADDRSTRLEN];
         char addr6[INET6_ADDRSTRLEN];
         int sock;
@@ -1778,7 +1840,17 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
 
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
index fbd7eb7bbb..0322188a73 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1153,6 +1153,44 @@ out:
 }
 #endif
 
+#define INTERFACE_PATH_BUF_SZ 512
+
+static DWORD get_interface_index(const char *guid)
+{
+    ULONG index;
+    DWORD status;
+    wchar_t wbuf[INTERFACE_PATH_BUF_SZ];
+    snwprintf(wbuf, INTERFACE_PATH_BUF_SZ, L"\\device\\tcpip_%s", guid);
+    wbuf[INTERFACE_PATH_BUF_SZ - 1] = 0;
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
+    DWORD if_index = 0;
+    MIB_IFROW a_mid_ifrow;
+    memset(&a_mid_ifrow, 0, sizeof(a_mid_ifrow));
+    if_index = get_interface_index(name);
+    a_mid_ifrow.dwIndex = if_index;
+    if (NO_ERROR == GetIfEntry(&a_mid_ifrow)) {
+        stats->rx_bytes = a_mid_ifrow.dwInOctets;
+        stats->rx_packets = a_mid_ifrow.dwInUcastPkts;
+        stats->rx_errs = a_mid_ifrow.dwInErrors;
+        stats->rx_dropped = a_mid_ifrow.dwInDiscards;
+        stats->tx_bytes = a_mid_ifrow.dwOutOctets;
+        stats->tx_packets = a_mid_ifrow.dwOutUcastPkts;
+        stats->tx_errs = a_mid_ifrow.dwOutErrors;
+        stats->tx_dropped = a_mid_ifrow.dwOutDiscards;
+        return 0;
+    }
+    return -1;
+}
+
 GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
 {
     IP_ADAPTER_ADDRESSES *adptr_addrs, *addr;
@@ -1160,6 +1198,7 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
     GuestNetworkInterfaceList *head = NULL, *cur_item = NULL;
     GuestIpAddressList *head_addr, *cur_addr;
     GuestNetworkInterfaceList *info;
+    GuestNetworkInterfaceStat *interface_stat = NULL;
     GuestIpAddressList *address_item = NULL;
     unsigned char *mac_addr;
     char *addr_str;
@@ -1239,6 +1278,17 @@ GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
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
index 90a0c8602b..17884c7c70 100644
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
2.11.0
