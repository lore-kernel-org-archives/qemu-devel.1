Received: from eggs.gnu.org ([209.51.188.92]:57807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwS-0002WW-S1
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwP-0002YV-Q0
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwN-0002Td-6D
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:25 -0500
Received: by mail-wm1-x344.google.com with SMTP id m1so822942wml.2
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:21 +0100
Message-Id: <1549562254-41157-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 38/51] lm32-softmmu.mak: express dependencies
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/lm32-softmmu.mak | 10 ++++++----
 hw/display/Kconfig               |  3 +--
 hw/lm32/Kconfig                  |  6 ++++++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/default-configs/lm32-softmmu.mak b/default-configs/lm32-softmmu.mak
index f489838..6d25966 100644
--- a/default-configs/lm32-softmmu.mak
+++ b/default-configs/lm32-softmmu.mak
@@ -1,8 +1,10 @@
 # Default configuration for lm32-softmmu
 
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_MILKYMIST_TMU2=n        # disabling it actually causes compile-time failures
+
+# Boards:
+#
 CONFIG_LM32=y
 CONFIG_MILKYMIST=y
-CONFIG_FRAMEBUFFER=y
-CONFIG_PFLASH_CFI01=y
-CONFIG_PFLASH_CFI02=y
-CONFIG_SD=y
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 69f8a7e..ee3acd9 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -71,8 +71,7 @@ config FRAMEBUFFER
 
 config MILKYMIST_TMU2
     bool
-    default y
-    depends on OPENGL && X11 && MILKYMIST
+    depends on OPENGL && X11
 
 config SM501
     bool
diff --git a/hw/lm32/Kconfig b/hw/lm32/Kconfig
index 4f45840..3d09c2d 100644
--- a/hw/lm32/Kconfig
+++ b/hw/lm32/Kconfig
@@ -1,7 +1,13 @@
 config LM32
     bool
     select PTIMER
+    select PFLASH_CFI02
 
 config MILKYMIST
     bool
+    # FIXME: disabling it results in compile-time errors
+    select MILKYMIST_TMU2 if OPENGL && X11
     select PTIMER
+    select PFLASH_CFI01
+    select FRAMEBUFFER
+    select SD
-- 
1.8.3.1
