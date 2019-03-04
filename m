Received: from eggs.gnu.org ([209.51.188.92]:46220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sD3-0002QF-Nh
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCz-0004x9-KW
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:05 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCx-0004h1-EV
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:21:01 -0500
Received: by mail-wr1-x444.google.com with SMTP id f14so6649474wrg.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:55 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:20:00 +0100
Message-Id: <1551723614-1823-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 40/54] lm32-softmmu.mak: express dependencies
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
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

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
index e126cbb..a96ea76 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -70,8 +70,7 @@ config FRAMEBUFFER
 
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
