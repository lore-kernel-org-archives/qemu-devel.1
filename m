Received: from eggs.gnu.org ([2001:4830:134:3::10]:41748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHT-0004AT-Ix
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHR-0007cb-BD
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:51 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHR-0007cG-5C
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:49 -0500
Received: by mail-wm0-x242.google.com with SMTP id i186so15518777wmi.4
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:18 +0100
Message-Id: <1518523252-49106-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/48] sdhci: use error_propagate(local_err) in
 realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

avoid the "errp && *errp" pattern (not recommended in "qapi/error.h" comments).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <20180208164818.7961-2-f4bug@amsat.org>
---
 hw/sd/sdhci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ee95e78..3602286 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1302,10 +1302,12 @@ static Property sdhci_pci_properties[] = {
 static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
 {
     SDHCIState *s = PCI_SDHCI(dev);
+    Error *local_err = NULL;
 
     sdhci_initfn(s);
     sdhci_common_realize(s, errp);
-    if (errp && *errp) {
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
 
@@ -1383,9 +1385,11 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
 {
     SDHCIState *s = SYSBUS_SDHCI(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    Error *local_err = NULL;
 
     sdhci_common_realize(s, errp);
-    if (errp && *errp) {
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
 
-- 
1.8.3.1
