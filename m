Received: from eggs.gnu.org ([209.51.188.92]:58424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP2-0007sQ-GW
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOu-00023c-OJ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:54 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOu-00022Z-HA
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:52 -0500
Received: by mail-wm1-x343.google.com with SMTP id f188so5997750wmf.5
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:52 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:57 +0100
Message-Id: <1548410831-19553-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 38/52] build: convert sound.mak to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

There is really nothing special in these devices; they are just
ISA devices.  Instead of including them for each target,
set CONFIG_ISA_BUS to true, and make the devices default to present
whenever ISA is available.  More conversion of ISA devices will
follow.

Done with the following script:

  while read i; do
     i=${i%=y}; i=${i#CONFIG_}
     sed -i -e'/^config '$i'$/!b' -en \
            -e'a\' -e'    default y\' -e'    depends on ISA_BUS' \
          `grep -lw $i hw/*/Kconfig`
  done < default-configs/sound.mak

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-32-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/i386-softmmu.mak        | 2 +-
 default-configs/mips-softmmu-common.mak | 2 +-
 default-configs/ppc-softmmu.mak         | 2 +-
 default-configs/sound.mak               | 4 ----
 hw/audio/Kconfig                        | 8 ++++++++
 5 files changed, 11 insertions(+), 7 deletions(-)
 delete mode 100644 default-configs/sound.mak

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index a139bd5..9eb9351 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -2,7 +2,7 @@
 
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
-include sound.mak
+CONFIG_ISA_BUS=y
 include usb.mak
 include hyperv.mak
 CONFIG_VGA_ISA=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index 246af88..981ea2c 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -1,7 +1,7 @@
 # Common mips*-softmmu CONFIG defines
 
-include sound.mak
 include usb.mak
+CONFIG_ISA_BUS=y
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
 CONFIG_ESP=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 763184f..dba071a 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -1,9 +1,9 @@
 # Default configuration for ppc-softmmu
 
-include sound.mak
 include usb.mak
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
+CONFIG_ISA_BUS=y
 
 # For embedded PPCs:
 CONFIG_PPC4XX=y
diff --git a/default-configs/sound.mak b/default-configs/sound.mak
deleted file mode 100644
index 4f22c34..0000000
--- a/default-configs/sound.mak
+++ /dev/null
@@ -1,4 +0,0 @@
-CONFIG_SB16=y
-CONFIG_ADLIB=y
-CONFIG_GUS=y
-CONFIG_CS4231A=y
diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
index aa5c82b..dedb513 100644
--- a/hw/audio/Kconfig
+++ b/hw/audio/Kconfig
@@ -1,5 +1,7 @@
 config SB16
     bool
+    default y
+    depends on ISA_BUS
 
 config ES1370
     bool
@@ -13,12 +15,18 @@ config AC97
 
 config ADLIB
     bool
+    default y
+    depends on ISA_BUS
 
 config GUS
     bool
+    default y
+    depends on ISA_BUS
 
 config CS4231A
     bool
+    default y
+    depends on ISA_BUS
 
 config HDA
     bool
-- 
1.8.3.1
