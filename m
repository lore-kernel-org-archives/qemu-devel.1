Received: from eggs.gnu.org ([2001:4830:134:3::10]:59238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cbimN-0003L8-Dn
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 02:04:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cbimI-00027S-IM
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 02:04:31 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:33841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cbimI-00027L-DQ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 02:04:26 -0500
Received: by mail-io0-x243.google.com with SMTP id c80so1278281iod.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 23:04:24 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed,  8 Feb 2017 23:04:04 -0800
Message-Id: <1486623844-13140-3-git-send-email-liqiang6-s@360.cn>
In-Reply-To: <1486623844-13140-1-git-send-email-liqiang6-s@360.cn>
References: <1486623844-13140-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH 2/2] ide: ahci: call cleanup function in ahci
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
Cc: Li Qiang <liqiang6-s@360.cn>

This can avoid memory leak when hotunplug the ahci device.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/ide/ahci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 3c19bda..56f68a8 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1485,6 +1485,14 @@ void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, int ports)
 
 void ahci_uninit(AHCIState *s)
 {
+    int i;
+
+    for (i = 0; i < s->ports; i++) {
+        AHCIDevice *ad = &s->dev[i];
+
+        ide_unregister_restart_cb(&ad->port);
+        ide_exit(&ad->port);
+    }
     g_free(s->dev);
 }
 
-- 
1.8.3.1
