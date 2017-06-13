Received: from eggs.gnu.org ([2001:4830:134:3::10]:38462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <li.ping288@zte.com.cn>) id 1dKiyI-0002M5-Ao
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <li.ping288@zte.com.cn>) id 1dKiyE-0005z3-EG
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:22:50 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:36294)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <li.ping288@zte.com.cn>) id 1dKiyE-0005y0-33
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:22:46 -0400
From: Li Ping <li.ping288@zte.com.cn>
Date: Tue, 13 Jun 2017 18:21:43 +0800
Message-Id: <1497349303-3076-1-git-send-email-li.ping288@zte.com.cn>
Subject: [Qemu-devel] [PATCH] QEMU Guest Agent: Fix memory leak of device
 information set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, Li Ping <li.ping288@zte.com.cn>

The caller of SetupDiGetClassDevs must delete the returned device information
 set when it is no longer needed by calling SetupDiDestroyDeviceInfoList.

Signed-off-by: Li Ping<li.ping288@zte.com.cn>
---
 qga/commands-win32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 439d229..6f16457 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -512,7 +512,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
             } else {
                 error_setg_win32(errp, GetLastError(),
                         "failed to get device name");
-                goto out;
+                goto free_dev_info;
             }
         }
 
@@ -560,6 +560,9 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
         pci->bus = bus;
         break;
     }
+
+free_dev_info:
+    SetupDiDestroyDeviceInfoList(dev_info);
 out:
     g_free(buffer);
     g_free(name);
-- 
1.8.3.1
