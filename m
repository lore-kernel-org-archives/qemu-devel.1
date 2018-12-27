Received: from eggs.gnu.org ([208.118.235.92]:54770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGQ-0002xD-IF
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGO-0004NW-Hu
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:57867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPGO-0004Bd-7p
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:24 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:34:05 +0800
Message-Id: <20181227063419.12981-12-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
References: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 11/25] build: convert sound.mak to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

There is really nothing special in these devices; they are just
ISA devices.  Instead of including them for each target,
set CONFIG_ISA to true, and make the devices default to present
whenever ISA is available.  More conversion of ISA devices will
follow.

Done with the following script:

  while read i; do
     i=${i%=y}; i=${i#CONFIG_}
     sed -i -e'/^config '$i'$/!b' -en \
            -e'a\' -e'    default y\' -e'    depends on ISA' \
          `grep -lw $i hw/*/Kconfig`
  done < default-configs/sound.mak

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/i386-softmmu.mak | 2 +-
 default-configs/sound.mak        | 4 ----
 hw/audio/Kconfig                 | 8 ++++++++
 3 files changed, 9 insertions(+), 5 deletions(-)
 delete mode 100644 default-configs/sound.mak

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 61f19e5231..275e72f3c6 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,7 +1,7 @@
 # Default configuration for i386-softmmu
 
 CONFIG_PCI=y
-include sound.mak
+CONFIG_ISA=y
 include usb.mak
 include hyperv.mak
 CONFIG_VGA_ISA=y
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
