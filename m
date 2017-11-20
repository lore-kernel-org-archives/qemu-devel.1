Received: from eggs.gnu.org ([2001:4830:134:3::10]:42292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eGty1-0006WI-1O
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eGtxx-00061m-Ou
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:51:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46392
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eGtxx-00060W-K3
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:50:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAKLnmLq046573
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 16:50:52 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ec5ue400v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 16:50:52 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Nov 2017 16:50:51 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Nov 2017 15:50:34 -0600
In-Reply-To: <20171120215034.22212-1-mdroth@linux.vnet.ibm.com>
References: <20171120215034.22212-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171120215034.22212-2-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL for-2.11 1/1] qga: replace GetIfEntry with
 GetIfEntry2 for interface stats
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

The data obtained by GetIfEntry is 32 bits, and it may overflow. Thus
using GetIfEntry2 instead of GetIfEntry.

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
*avoid CamelCase variable names
*update field names for MIB_IFROW -> MIB_IF_ROW2
*dynamically probe for GetIfIndex2 to deal with older OSs
*check return value from get_interface_index
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 54 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0322188a73..d79974f212 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1169,24 +1169,46 @@ static DWORD get_interface_index(const char *guid)
         return index;
     }
 }
+
+typedef NETIOAPI_API (WINAPI *GetIfEntry2Func)(PMIB_IF_ROW2 Row);
+
 static int guest_get_network_stats(const char *name,
-                       GuestNetworkInterfaceStat *stats)
+                                   GuestNetworkInterfaceStat *stats)
 {
-    DWORD if_index = 0;
-    MIB_IFROW a_mid_ifrow;
-    memset(&a_mid_ifrow, 0, sizeof(a_mid_ifrow));
-    if_index = get_interface_index(name);
-    a_mid_ifrow.dwIndex = if_index;
-    if (NO_ERROR == GetIfEntry(&a_mid_ifrow)) {
-        stats->rx_bytes = a_mid_ifrow.dwInOctets;
-        stats->rx_packets = a_mid_ifrow.dwInUcastPkts;
-        stats->rx_errs = a_mid_ifrow.dwInErrors;
-        stats->rx_dropped = a_mid_ifrow.dwInDiscards;
-        stats->tx_bytes = a_mid_ifrow.dwOutOctets;
-        stats->tx_packets = a_mid_ifrow.dwOutUcastPkts;
-        stats->tx_errs = a_mid_ifrow.dwOutErrors;
-        stats->tx_dropped = a_mid_ifrow.dwOutDiscards;
-        return 0;
+    OSVERSIONINFO os_ver;
+
+    os_ver.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
+    GetVersionEx(&os_ver);
+    if (os_ver.dwMajorVersion >= 6) {
+        MIB_IF_ROW2 a_mid_ifrow;
+        GetIfEntry2Func getifentry2_ex;
+        DWORD if_index = 0;
+        HMODULE module = GetModuleHandle("iphlpapi");
+        PVOID func = GetProcAddress(module, "GetIfEntry2");
+
+        if (func == NULL) {
+            return -1;
+        }
+
+        getifentry2_ex = (GetIfEntry2Func)func;
+        if_index = get_interface_index(name);
+        if (if_index == (DWORD)~0) {
+            return -1;
+        }
+
+        memset(&a_mid_ifrow, 0, sizeof(a_mid_ifrow));
+        a_mid_ifrow.InterfaceIndex = if_index;
+        if (NO_ERROR == getifentry2_ex(&a_mid_ifrow)) {
+            stats->rx_bytes = a_mid_ifrow.InOctets;
+            stats->rx_packets = a_mid_ifrow.InUcastPkts;
+            stats->rx_errs = a_mid_ifrow.InErrors;
+            stats->rx_dropped = a_mid_ifrow.InDiscards;
+            stats->tx_bytes = a_mid_ifrow.OutOctets;
+            stats->tx_packets = a_mid_ifrow.OutUcastPkts;
+            stats->tx_errs = a_mid_ifrow.OutErrors;
+            stats->tx_dropped = a_mid_ifrow.OutDiscards;
+            return 0;
+        }
     }
     return -1;
 }
-- 
2.11.0
