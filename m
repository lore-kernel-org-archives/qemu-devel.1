Received: from eggs.gnu.org ([209.51.188.92]:60148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWD-0004yU-QC
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWB-0003nc-Pb
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:36919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCWB-0002Mh-GP
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:11 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:56:05 +0800
Message-Id: <20190123065618.3520-32-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 31/44] build: convert sound.mak to
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

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
---
 default-configs/i386-softmmu.mak        | 2 +-
 default-configs/mips-softmmu-common.mak | 2 +-
 default-configs/ppc-softmmu.mak         | 2 +-
 default-configs/sound.mak               | 4 ----
 hw/audio/Kconfig                        | 8 ++++++++
 5 files changed, 11 insertions(+), 7 deletions(-)
 delete mode 100644 default-configs/sound.mak

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index c885869634..4319bcdea3 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,7 +1,7 @@
 # Default configuration for i386-softmmu
 
 CONFIG_PCI=y
-include sound.mak
+CONFIG_ISA_BUS=y
 include usb.mak
 include hyperv.mak
 CONFIG_VGA_ISA=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index ecb45276f3..6d98ff94a7 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -1,7 +1,7 @@
 # Common mips*-softmmu CONFIG defines
 
-include sound.mak
 include usb.mak
+CONFIG_ISA_BUS=y
 CONFIG_PCI=y
 CONFIG_ESP=y
 CONFIG_SCSI=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 2d69adfabd..c9f1446e0e 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -1,8 +1,8 @@
 # Default configuration for ppc-softmmu
 
-include sound.mak
 include usb.mak
 CONFIG_PCI=y
+CONFIG_ISA_BUS=y
 
 # For embedded PPCs:
 CONFIG_PPC4XX=y
diff --git a/default-configs/sound.mak b/default-configs/sound.mak
deleted file mode 100644
index 4f22c34b5d..0000000000
--- a/default-configs/sound.mak
+++ /dev/null
@@ -1,4 +0,0 @@
-CONFIG_SB16=y
-CONFIG_ADLIB=y
-CONFIG_GUS=y
-CONFIG_CS4231A=y
diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
index af34bbcf0c..bfb30276ec 100644
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
2.17.1
