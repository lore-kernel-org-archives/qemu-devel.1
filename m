Received: from eggs.gnu.org ([2001:4830:134:3::10]:56865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1eAdMk-0002xN-6l
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1eAdMh-0000Az-5b
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:54:38 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:54406 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lu.zhipeng@zte.com.cn>)
	id 1eAdMg-00009f-Oz
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:54:35 -0400
From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Date: Fri, 3 Nov 2017 22:54:20 +0800
Message-Id: <1509720860-10065-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: [Qemu-devel] [PATCH v2] qga: replace GetIfEntry
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

The data obtained by GetIfEntry is 32 bits, and it may overflow. Thus using GetIfEntry2 instead of GetIfEntry.

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
---
 qga/commands-win32.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0322188..d096dc2 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1173,20 +1173,25 @@ static int guest_get_network_stats(const char *name,
                        GuestNetworkInterfaceStat *stats)
 {
     DWORD if_index = 0;
-    MIB_IFROW a_mid_ifrow;
-    memset(&a_mid_ifrow, 0, sizeof(a_mid_ifrow));
+    OSVERSIONINFO OSver;
     if_index = get_interface_index(name);
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
+    OSver.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
+    GetVersionEx(&OSver);
+    if (OSver.dwMajorVersion >= 6) {
+        MIB_IF_ROW2 a_mid_ifrow;
+        memset(&a_mid_ifrow, 0, sizeof(a_mid_ifrow));
+        a_mid_ifrow.dwIndex = if_index;
+        if (NO_ERROR == GetIfEntry2(&a_mid_ifrow)) {
+            stats->rx_bytes = a_mid_ifrow.dwInOctets;
+            stats->rx_packets = a_mid_ifrow.dwInUcastPkts;
+            stats->rx_errs = a_mid_ifrow.dwInErrors;
+            stats->rx_dropped = a_mid_ifrow.dwInDiscards;
+            stats->tx_bytes = a_mid_ifrow.dwOutOctets;
+            stats->tx_packets = a_mid_ifrow.dwOutUcastPkts;
+            stats->tx_errs = a_mid_ifrow.dwOutErrors;
+            stats->tx_dropped = a_mid_ifrow.dwOutDiscards;
+            return 0;
+        }
     }
     return -1;
 }
-- 
1.8.3.1
