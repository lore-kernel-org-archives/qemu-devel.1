Received: from eggs.gnu.org ([2001:4830:134:3::10]:48509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJf9-00067l-CL
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJf8-0006nK-JS
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:53:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1coJf8-0006n7-Dg
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:53:06 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 Mar 2017 20:52:59 -0400
Message-Id: <20170316005259.21970-4-jsnow@redhat.com>
In-Reply-To: <20170316005259.21970-1-jsnow@redhat.com>
References: <20170316005259.21970-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL for-rc1 3/3] ide: ahci: call cleanup function in
 ahci unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Li Qiang <liq3ea@gmail.com>, Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liq3ea@gmail.com>

This can avoid memory leak when hotunplug the ahci device.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Message-id: 1488449293-80280-4-git-send-email-liqiang6-s@360.cn
Signed-off-by: John Snow <jsnow@redhat.com>
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
2.9.3
