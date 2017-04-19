Received: from eggs.gnu.org ([2001:4830:134:3::10]:37525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1d0lWr-0008My-08
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1d0lWk-0003mw-Ni
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:04:01 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:46939)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1d0lWj-0003m5-SZ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:03:54 -0400
From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Date: Thu, 20 Apr 2017 00:57:08 +0800
Message-Id: <1492621028-16280-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: [Qemu-devel] [PATCH] qemu-ga: add guest-network-get-interface-stat
 command
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

we can get the  network card statistics inside  a virtual machine by guest-network-get-interface-stat command.
it is very userful for us to monitor and analyze network traff.

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
---
 qga/commands-posix.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 qga/commands-win32.c |   6 ++
 qga/qapi-schema.json |  34 +++++++++++
 3 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 915df9e..3166bf4 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2357,6 +2357,163 @@ GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
 
     return info;
 }
+static int ga_get_netname(int bus, int dev, int func, char *netname,
+           int name_len)
+{
+    int cnt = 0;
+    int result = -1;
+
+    FILE *pfilein = NULL;
+
+    bool findnet = false;
+    char *netpos = NULL;
+
+    char netstr[32] = {0};
+    char buffer[1024] = {0};
+
+    if (NULL == netname) {
+        return -1;
+    }
+    snprintf(netstr, 31, "%02x:%02x.%01x", bus, dev, func);
+    g_debug("qga net pci is : %s ", netstr);
+
+    pfilein = popen("ls -l /sys/class/net", "r");
+    if (NULL == pfilein) {
+        g_debug("failed to do shell command for [%s] getting net name", netstr);
+        return -1;
+    }
+
+    while (fgets(buffer, 1023, pfilein) != NULL) {
+        if (strstr(buffer, netstr)) {
+            findnet = true;
+            g_debug("find pci  [%s] net string: %s", netstr, buffer);
+            break;
+        }
+    }
+
+    result = ferror(pfilein);
+    if (pclose(pfilein) || result) {
+        g_debug("error happened while finding pci [%s] net string", netstr);
+        return -1;
+    }
+
+    if (!findnet) {
+        g_debug("didn't finding bdf [%s] block string", netstr);
+        return -1;
+    }
+
+    netpos = strrchr(buffer, '/');
+    if (NULL == netpos) {
+        g_debug("can't get net name for [%s]", netstr);
+        return -1;
+    }
+
+    netpos++;
+    if (name_len < strlen(netpos)) {
+        g_debug("net name buffer of [%s] is not enough", netstr);
+        return -1;
+    }
+
+    cnt = 0;
+    while (('\0' != *netpos) && ('\n' != *netpos)) {
+        netname[cnt] = *netpos;
+        cnt++;
+        netpos++;
+    }
+    netname[cnt] = '\0';
+
+    if ('\0' == netname[0]) {
+        g_debug("net name for pci  [%s] is invalid", netstr);
+        return -1;
+    }
+
+    g_debug("succeed to get pci [%s] actual net name: %s", netstr, netname);
+    return 0;
+}
+
+
+static int ga_get_net_stats(const char *path,
+                     GuestNetworkInterfaceStat *stats)
+{
+    int path_len;
+    FILE *fp;
+    char line[256], *colon;
+
+    fp = fopen("/proc/net/dev", "r");
+    if (!fp) {
+        slog("Could not open /proc/net/dev");
+        return -1;
+    }
+    path_len = strlen(path);
+    while (fgets(line, sizeof(line), fp)) {
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
+        /* The line looks like:
+ *          *   "   eth0:..."
+ *                   * Split it at the colon.
+ *                            */
+        colon = strchr(line, ':');
+        if (!colon) {
+            continue;
+        }
+        *colon = '\0';
+        if (colon - path_len >= line && strcmp(colon - path_len, path) == 0) {
+            if (sscanf(colon + 1,
+                "%lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld",
+                &rx_bytes, &rx_packets, &rx_errs, &rx_drop,
+                &dummy, &dummy, &dummy, &dummy,
+                &tx_bytes, &tx_packets, &tx_errs, &tx_drop,
+                &dummy, &dummy, &dummy, &dummy) != 16) {
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
+
+    g_debug("/proc/net/dev: Interface not found");
+    return -1;
+}
+
+GuestNetworkInterfaceStatList *qmp_guest_network_get_interface_stat(int64_t bus,
+    int64_t slot, int64_t function, const char *netname, Error **errp)
+{
+    char guestnetname[14] = {0};
+    GuestNetworkInterfaceStat *info = NULL;
+    GuestNetworkInterfaceStatList *new, *ret = NULL;
+    if (ga_get_netname(bus, slot,
+        function, guestnetname, sizeof(guestnetname))) {
+        return NULL;
+    }
+    info = g_malloc0(sizeof(*info));
+    if (ga_get_net_stats(guestnetname, info)) {
+        g_free(info);
+        return NULL;
+    }
+
+    new = g_malloc(sizeof(*ret));
+    new->value = info;
+    new->next = ret;
+    ret = new;
+    return ret;
+}
 
 #else /* defined(__linux__) */
 
@@ -2419,6 +2576,12 @@ GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
     error_setg(errp, QERR_UNSUPPORTED);
     return NULL;
 }
+GuestNetworkInterfaceStatList *qmp_guest_network_get_interface_stat(int64_t bus,
+   int64_t slot, int64_t function, const char *netname, Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
 
 #endif
 
@@ -2480,7 +2643,8 @@ GList *ga_command_blacklist_init(GList *blacklist)
             "guest-suspend-hybrid", "guest-network-get-interfaces",
             "guest-get-vcpus", "guest-set-vcpus",
             "guest-get-memory-blocks", "guest-set-memory-blocks",
-            "guest-get-memory-block-size", NULL};
+            "guest-get-memory-block-size",
+            "guest-network-get-interfaces-stat", NULL};
         char **p = (char **)list;
 
         while (*p) {
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 19d72b2..dee939c 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1497,6 +1497,12 @@ GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
     error_setg(errp, QERR_UNSUPPORTED);
     return NULL;
 }
+GuestNetworkInterfaceStatList *qmp_guest_network_get_interface_stat(int64_t bus,
+   int64_t slot, int64_t function, const char *netname, Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
 
 /* add unsupported commands to the blacklist */
 GList *ga_command_blacklist_init(GList *blacklist)
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a02dbf2..60111dc 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1042,3 +1042,37 @@
   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
                '*input-data': 'str', '*capture-output': 'bool' },
   'returns': 'GuestExec' }
+##
+# @GuestNetworkInterfaceStat:
+#
+# @rx_bytes: received bytes of interface
+#
+# @rx_packets: received packets of interface
+#
+# @rx_errs: received error packets of interface
+# @rx_drop: received drop packets of interface
+#
+# Since: 2.10
+##
+{ 'struct': 'GuestNetworkInterfaceStat',
+  'data': {'rx_bytes': 'uint64',
+            'rx_packets': 'uint64',
+            'rx_errs': 'uint64',
+            'rx_drop': 'uint64',
+            'tx_bytes': 'uint64',
+            'tx_packets': 'uint64',
+            'tx_errs': 'uint64',
+            'tx_drop': 'uint64'
+           } }
+##
+# @guest-network-get-interface-stat:
+#
+# Get list of interface stat
+#
+# Returns: List of GuestNetworkInterfaceStat on success.
+#
+# Since: 2.10
+##
+{ 'command': 'guest-network-get-interface-stat',
+  'data':    {'bus': 'int64', 'slot': 'int64', 'function': 'int64','netname':'str'},
+  'returns': ['GuestNetworkInterfaceStat'] }
-- 
1.8.3.1
