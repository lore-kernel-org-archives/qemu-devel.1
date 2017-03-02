Received: from eggs.gnu.org ([2001:4830:134:3::10]:46829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cjNfG-0003jA-5L
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cjNfF-0007iT-85
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:08:50 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cjNfF-0007iB-2f
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:08:49 -0500
Received: by mail-pf0-x242.google.com with SMTP id 67so1972093pfg.2
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 02:08:49 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu,  2 Mar 2017 02:08:13 -0800
Message-Id: <1488449293-80280-4-git-send-email-liqiang6-s@360.cn>
In-Reply-To: <1488449293-80280-1-git-send-email-liqiang6-s@360.cn>
References: <1488449293-80280-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH 3/3] ide: ahci: call cleanup function in ahci
 unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ppandit@redhat.com, Li Qiang <liqiang6-s@360.cn>

This can avoid memory leak when hotunplug the ahci device.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/ide/ahci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 6a17acf..f60826d 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1485,6 +1485,18 @@ void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, int ports)
 
 void ahci_uninit(AHCIState *s)
 {
+    int i, j;
+
+    for (i = 0; i < s->ports; i++) {
+        AHCIDevice *ad = &s->dev[i];
+
+        for (j = 0; j < 2; j++) {
+            IDEState *s = &ad->port.ifs[j];
+
+            ide_exit(s);
+        }
+    }
+
     g_free(s->dev);
 }
 
-- 
1.8.3.1
