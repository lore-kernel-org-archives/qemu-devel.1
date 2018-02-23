Received: from eggs.gnu.org ([2001:4830:134:3::10]:59848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1epLN5-0001Zy-AG
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1epLN2-0007YC-6M
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:59:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei@redhat.com>) id 1epLN2-0007Wv-1Y
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:59:12 -0500
From: Wei Huang <wei@redhat.com>
Date: Fri, 23 Feb 2018 15:58:55 -0600
Message-Id: <20180223215858.16987-2-wei@redhat.com>
In-Reply-To: <20180223215858.16987-1-wei@redhat.com>
References: <20180223215858.16987-1-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V5 1/4] rules: Move cross compilation auto
 detection functions to rules.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, drjones@redhat.com

This patch moves the auto detection functions for cross compilation from
roms/Makefile to rules.mak. So the functions can be shared among Makefiles
in QEMU.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 roms/Makefile | 24 +++++++-----------------
 rules.mak     | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index b5e5a69e91..e972c65333 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -21,23 +21,6 @@ pxe-rom-virtio   efi-rom-virtio   : DID := 1000
 pxe-rom-vmxnet3  efi-rom-vmxnet3  : VID := 15ad
 pxe-rom-vmxnet3  efi-rom-vmxnet3  : DID := 07b0
 
-#
-# cross compiler auto detection
-#
-path := $(subst :, ,$(PATH))
-system := $(shell uname -s | tr "A-Z" "a-z")
-
-# first find cross binutils in path
-find-cross-ld = $(firstword $(wildcard $(patsubst %,%/$(1)-*$(system)*-ld,$(path))))
-# then check we have cross gcc too
-find-cross-gcc = $(firstword $(wildcard $(patsubst %ld,%gcc,$(call find-cross-ld,$(1)))))
-# finally strip off path + toolname so we get the prefix
-find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
-
-powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
-powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
-x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
-
 # tag our seabios builds
 SEABIOS_EXTRAVERSION="-prebuilt.qemu-project.org"
 
@@ -66,6 +49,13 @@ default:
 	@echo "  skiboot        -- update skiboot.lid"
 	@echo "  u-boot.e500    -- update u-boot.e500"
 
+SRC_PATH=..
+include $(SRC_PATH)/rules.mak
+
+powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
+powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
+x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
+
 bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
 	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
 	cp seabios/builds/seabios-256k/bios.bin ../pc-bios/bios-256k.bin
diff --git a/rules.mak b/rules.mak
index 6e943335f3..ef8adee3f8 100644
--- a/rules.mak
+++ b/rules.mak
@@ -62,6 +62,21 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
                   $(foreach o,$(filter %.mo,$1),$($o-objs)) \
                   $(filter-out %.o %.mo,$1))
 
+# Cross compilation auto detection. Use find-cross-prefix to detect the
+# target archtecture's prefix, and then append it to the build tool or pass
+# it to CROSS_COMPILE directly. Here is one example:
+#      x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
+#      $(x86_64_cross_prefix)gcc -c test.c -o test.o
+#      make -C testdir CROSS_COMPILE=$(x86_64_cross_prefix)
+cross-search-path := $(subst :, ,$(PATH))
+cross-host-system := $(shell uname -s | tr "A-Z" "a-z")
+
+find-cross-ld = $(firstword $(wildcard $(patsubst \
+                    %,%/$(1)-*$(cross-host-system)*-ld,$(cross-search-path))))
+find-cross-gcc = $(firstword $(wildcard \
+                    $(patsubst %ld,%gcc,$(call find-cross-ld,$(1)))))
+find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
+
 %.o: %.c
 	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
 	       $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
-- 
2.14.3
