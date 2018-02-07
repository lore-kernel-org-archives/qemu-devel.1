Received: from eggs.gnu.org ([2001:4830:134:3::10]:33751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUJp-0001j0-Ko
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUJo-0004qM-Qe
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:19:41 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:40223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejUJo-0004q3-Ms
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:19:40 -0500
Received: by mail-qk0-x242.google.com with SMTP id e20so2316489qkm.7
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 10:19:40 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  7 Feb 2018 15:19:14 -0300
Message-Id: <20180207181929.8701-2-f4bug@amsat.org>
In-Reply-To: <20180207181929.8701-1-f4bug@amsat.org>
References: <20180207181929.8701-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v10 01/16] sdhci: use
 error_propagate(local_err) in realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

avoid the "errp && *errp" pattern (not recommended in "qapi/error.h" comments).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index fac7fa5c72..817c2525e6 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1300,10 +1300,12 @@ static Property sdhci_pci_properties[] = {
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
 
@@ -1381,9 +1383,11 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
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
2.16.1
