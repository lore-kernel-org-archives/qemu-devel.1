Received: from eggs.gnu.org ([209.51.188.92]:57810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwS-0002Wc-Tq
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwR-0002Zc-5s
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:28 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwP-0002WJ-L5
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:26 -0500
Received: by mail-wm1-x344.google.com with SMTP id t200so845300wmt.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:28 +0100
Message-Id: <1549562254-41157-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 45/51] sh4-softmmu.mak: express dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com

%-softmmu.mak only keep boards and optional device
definitions in Kconfig mode.

Note that USB_OHCI was missing (it was brought in via pci.mak,
but r2d needs the sysbus version) and SERIAL is not used.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/sh4-softmmu.mak   | 18 +++++++-----------
 default-configs/sh4eb-softmmu.mak | 13 +------------
 hw/sh4/Kconfig                    | 11 +++++++++++
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index 4ba5584..565e8b0 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -1,15 +1,11 @@
 # Default configuration for sh4eb-softmmu
 
-CONFIG_PCI=y
-CONFIG_PCI_DEVICES=y
-CONFIG_SERIAL=y
-CONFIG_PFLASH_CFI02=y
-CONFIG_SH4=y
-CONFIG_IDE_MMIO=y
-CONFIG_SM501=y
-CONFIG_TEST_DEVICES=y
-CONFIG_I82378=y
-CONFIG_I82374=y
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_PCI_DEVICES=n
+#CONFIG_TEST_DEVICES=n
+
+# Boards:
+#
 CONFIG_R2D=y
 CONFIG_SHIX=y
-CONFIG_TEST_DEVICES=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index 9717673..522a7a5 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -1,14 +1,3 @@
 # Default configuration for sh4eb-softmmu
 
-CONFIG_PCI=y
-CONFIG_PCI_DEVICES=y
-CONFIG_SERIAL=y
-CONFIG_PFLASH_CFI02=y
-CONFIG_SH4=y
-CONFIG_IDE_MMIO=y
-CONFIG_SM501=y
-CONFIG_TEST_DEVICES=y
-CONFIG_I82378=y
-CONFIG_I82374=y
-CONFIG_R2D=y
-CONFIG_SHIX=y
+include sh4-softmmu.mak
diff --git a/hw/sh4/Kconfig b/hw/sh4/Kconfig
index 1ea2bc3..8597613 100644
--- a/hw/sh4/Kconfig
+++ b/hw/sh4/Kconfig
@@ -1,8 +1,19 @@
 config R2D
     bool
+    imply PCI_DEVICES
+    imply TEST_DEVICES
+    select I82378 if TEST_DEVICES
+    select IDE_MMIO
+    select PFLASH_CFI02
+    select USB_OHCI
+    select PCI
+    select SM501
+    select SH4
 
 config SHIX
     bool
+    select SH7750
+    select SH4
 
 config SH7750
     bool
-- 
1.8.3.1
