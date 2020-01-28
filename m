Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FD2C3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310D0207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9bhI40D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310D0207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVoL-0004nj-8K
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5P-00005R-5F
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5L-0002Nd-8r
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:38 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:54795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5K-0002KI-Tg
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:55:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id g1so3496251wmh.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KT2JbGJ/HA8rgNiT/l0Gk+a3RsCD0qgaD3Zw3DiwGRA=;
 b=A9bhI40DpbbcfqrJcsJo8oC8IITMeDx0+SaPwbitT7abuQfD2lkUep4K1AOxUBQkMP
 AY8wLxpzg4uNKx/5tTnzB1jof+wTxIvez0Vt5q0GRE3xwswaz0Y86d7EKY2xDmPEUvFR
 IjjbPiP3RbZaoG0VZKoe9BK5LOHBDLHPVq2fYBP83RqrgnHPgvBkM07QRVcPXVG15RJG
 FsDHTcj8u7RC9j7A9Yf1D3qeGLp6iI4SshZyWsSeUv0EssZrSP65+ZYxFZ1j/C7HjqsY
 rQMslpwHRiXCsOck2XbIxn1buhDN/sJ/LzKNfUj0tjG4kIakHhfMeTfMDH54CJvXgbqT
 YnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KT2JbGJ/HA8rgNiT/l0Gk+a3RsCD0qgaD3Zw3DiwGRA=;
 b=a2CChujyT6q/s7ggauhf7KJyNxckLsMMDIVUT4Zl0k3kP16P0a3bYrE1oFEJh2qNCJ
 snZHN3N7pcZZxpkRp0DnfzDwLHYLYA9jUCsQ2xkeiJ2io+cBXNV/FrvFWoGB9SG8/gCx
 z9JPRFp8SuINtKNLnymrK7fYzWd1YmeCGds4qaGWy3MGbkQGff/M5MPBXihoun0s5KEi
 m/0N0OHfNZgd30COaV4RMI7FspSsl5aUEErUXR8llZu07n/RYj17SSnqkOcYXpgUzBXU
 fhbnWl1Y+/g38RvKyM3FKCjNFI2//1lbRtWX4MViLsUyRbh1Aigd0qhU151zjNja7XCC
 vj3A==
X-Gm-Message-State: APjAAAUFTfS6V9p6kE3rY90j3krZcpcA1BhY+3Ue9DTie5uz0ZrtBQ+n
 44rmS3ZA8O45E+cNIRnYBVkLrhTZ
X-Google-Smtp-Source: APXvYqwWFO9vxGx9i+nH2mBOmUKIuU23en7YOiAqjOkkBWlcCWxCzGtPnQK/SlfwcoSWL6rGi0WFHA==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr6673269wmc.154.1580234132383; 
 Tue, 28 Jan 2020 09:55:32 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 044/142] meson: infrastructure for building emulators
Date: Tue, 28 Jan 2020 18:52:04 +0100
Message-Id: <20200128175342.9066-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile              |  78 +++-----------------
 Makefile.target       |  19 +++--
 configure             |   6 --
 hw/i386/fw_cfg.c      |   2 +-
 hw/i386/pc.c          |   2 +-
 hw/i386/pc_piix.c     |   2 +-
 hw/i386/x86.c         |   2 +-
 include/qemu/osdep.h  |   2 +-
 meson.build           | 162 +++++++++++++++++++++++++++++++++++++++++-
 rules.mak             |   8 ---
 scripts/create_config |   2 +
 scripts/grepy.sh      |   3 +
 scripts/minikconf.py  |   1 +
 13 files changed, 189 insertions(+), 100 deletions(-)
 create mode 100755 scripts/grepy.sh
 mode change 100644 => 100755 scripts/minikconf.py

diff --git a/Makefile b/Makefile
index f238cb5461..af62f4ed9d 100644
--- a/Makefile
+++ b/Makefile
@@ -106,8 +106,6 @@ include $(SRC_PATH)/rules.mak
 # lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
-generated-files-y = config-host.h
-
 generated-files-y += module_block.h
 generated-files-y += target/s390x/gen-features.h
 target/s390x/gen-features.h: Makefile.ninja
@@ -157,65 +155,6 @@ DOCS=
 endif
 
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
-SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(filter %-softmmu, $(TARGET_DIRS)))
-SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %.d, $(SUBDIR_DEVICES_MAK))
-
-ifeq ($(SUBDIR_DEVICES_MAK),)
-config-all-devices.mak: config-host.mak
-	$(call quiet-command,echo '# no devices' > $@,"GEN","$@")
-else
-config-all-devices.mak: $(SUBDIR_DEVICES_MAK) config-host.mak
-	$(call quiet-command, sed -n \
-             's|^\([^=]*\)=\(.*\)$$|\1:=$$(findstring y,$$(\1)\2)|p' \
-             $(SUBDIR_DEVICES_MAK) | sort -u > $@, \
-             "GEN","$@")
-endif
-
--include $(SUBDIR_DEVICES_MAK_DEP)
-
-# This has to be kept in sync with Kconfig.host.
-MINIKCONF_ARGS = \
-    $(CONFIG_MINIKCONF_MODE) \
-    $@ $*/config-devices.mak.d $< $(MINIKCONF_INPUTS) \
-    CONFIG_KVM=$(CONFIG_KVM) \
-    CONFIG_SPICE=$(CONFIG_SPICE) \
-    CONFIG_IVSHMEM=$(CONFIG_IVSHMEM) \
-    CONFIG_TPM=$(CONFIG_TPM) \
-    CONFIG_XEN=$(CONFIG_XEN) \
-    CONFIG_OPENGL=$(CONFIG_OPENGL) \
-    CONFIG_X11=$(CONFIG_X11) \
-    CONFIG_VHOST_USER=$(CONFIG_VHOST_USER) \
-    CONFIG_VHOST_KERNEL=$(CONFIG_VHOST_KERNEL) \
-    CONFIG_VIRTFS=$(CONFIG_VIRTFS) \
-    CONFIG_LINUX=$(CONFIG_LINUX) \
-    CONFIG_PVRDMA=$(CONFIG_PVRDMA)
-
-MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig \
-                   $(wildcard $(SRC_PATH)/hw/*/Kconfig)
-MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
-
-$(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MINIKCONF_INPUTS) $(BUILD_DIR)/config-host.mak
-	$(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) > $@.tmp, "GEN", "$@.tmp")
-	$(call quiet-command, if test -f $@; then \
-	  if cmp -s $@.old $@; then \
-	    mv $@.tmp $@; \
-	    cp -p $@ $@.old; \
-	  else \
-	    if test -f $@.old; then \
-	      echo "WARNING: $@ (user modified) out of date.";\
-	    else \
-	      echo "WARNING: $@ out of date.";\
-	    fi; \
-	    echo "Run \"$(MAKE) defconfig\" to regenerate."; \
-	    rm $@.tmp; \
-	  fi; \
-	 else \
-	  mv $@.tmp $@; \
-	  cp -p $@ $@.old; \
-	 fi,"GEN","$@");
-
-defconfig:
-	rm -f config-all-devices.mak $(SUBDIR_DEVICES_MAK)
 
 ifneq ($(wildcard config-host.mak),)
 include $(SRC_PATH)/Makefile.objs
@@ -232,10 +171,9 @@ include $(SRC_PATH)/tests/Makefile.include
 
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
 
-config-host.h: config-host.h-timestamp
-config-host.h-timestamp: config-host.mak
-
 TARGET_DIRS_RULES := $(foreach t, all clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
+SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_DIRS))
+SOFTMMU_SUBDIR_RULES=$(filter %-softmmu,$(SUBDIR_RULES))
 
 SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
 $(SOFTMMU_ALL_RULES): $(authz-obj-y)
@@ -246,10 +184,15 @@ $(SOFTMMU_ALL_RULES): $(io-obj-y)
 $(SOFTMMU_ALL_RULES): $(qom-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
 
+# meson: this is sub-optimal but going away after conversion
+TARGET_DEPS = $(patsubst %,%-config-target.h, $(TARGET_DIRS))
+TARGET_DEPS += $(patsubst %,%-config-devices.h, $(filter %-softmmu,$(TARGET_DIRS)))
+TARGET_DEPS += $(patsubst %,libqemu-%.fa, $(TARGET_DIRS))
+
 .PHONY: $(TARGET_DIRS_RULES)
 # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
 # $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
-$(TARGET_DIRS_RULES):
+$(TARGET_DIRS_RULES): $(TARGET_DEPS)
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
 
 DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_srcdir=$(SRC_PATH)/dtc/libfdt
@@ -337,7 +280,6 @@ module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 clean: recurse-clean
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
-	rm -f qemu-options.def
 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
@@ -346,7 +288,6 @@ clean: recurse-clean
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
-	rm -f config-all-devices.mak
 
 VERSION ?= $(shell cat VERSION)
 
@@ -363,8 +304,7 @@ endef
 distclean: clean
 	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
 	rm -f tests/tcg/config-*.mak
-	rm -f config-all-devices.mak config-all-disas.mak config.status
-	rm -f $(SUBDIR_DEVICES_MAK)
+	rm -f config-all-disas.mak config.status
 	rm -f po/*.mo tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
 	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
diff --git a/Makefile.target b/Makefile.target
index 5537f3897b..13e21b0c44 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -6,8 +6,10 @@ include ../config-host.mak
 include config-target.mak
 include $(SRC_PATH)/rules.mak
 
+FULL_TARGET_NAME=$(TARGET_NAME)-$(if $(CONFIG_SOFTMMU),softmmu,linux-user)
+
 ifdef CONFIG_SOFTMMU
-include config-devices.mak
+include ../$(FULL_TARGET_NAME)-config-devices.mak
 endif
 
 $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
@@ -18,6 +20,9 @@ QEMU_CFLAGS += -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE_ARCH) -DNEED_
 
 QEMU_CFLAGS+=-iquote $(SRC_PATH)/include
 
+QEMU_CFLAGS += -DCONFIG_TARGET=\"../$(FULL_TARGET_NAME)-config-target.h\"
+QEMU_CFLAGS += -DCONFIG_DEVICES=\"../$(FULL_TARGET_NAME)-config-devices.h\"
+
 ifdef CONFIG_USER_ONLY
 # user emulator name
 QEMU_PROG=qemu-$(TARGET_NAME)
@@ -36,15 +41,10 @@ QEMU_PROG_BUILD = $(QEMU_PROG)
 endif
 endif
 
+LIBQEMU = ../libqemu-$(FULL_TARGET_NAME).fa
 PROGS=$(QEMU_PROG) $(QEMU_PROGW)
 STPFILES=
 
-config-target.h: config-target.h-timestamp
-config-target.h-timestamp: config-target.mak
-
-config-devices.h: config-devices.h-timestamp
-config-devices.h-timestamp: config-devices.mak
-
 ifdef CONFIG_TRACE_SYSTEMTAP
 stap: $(QEMU_PROG).stp-installed $(QEMU_PROG).stp $(QEMU_PROG)-simpletrace.stp $(QEMU_PROG)-log.stp
 
@@ -103,6 +103,7 @@ all: $(PROGS) stap
 # Dummy command so that make thinks it has done something
 	@true
 
+obj-y += $(LIBQEMU)
 obj-y += trace/
 
 #########################################################
@@ -170,7 +171,6 @@ obj-y += hw/$(TARGET_BASE_ARCH)/
 endif
 
 generated-files-y += hmp-commands.h hmp-commands-info.h
-generated-files-y += config-devices.h
 
 endif # CONFIG_SOFTMMU
 
@@ -197,7 +197,7 @@ all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
 ifdef CONFIG_SOFTMMU
-$(QEMU_PROG_BUILD): config-devices.mak
+$(QEMU_PROG_BUILD): ../$(FULL_TARGET_NAME)-config-devices.mak
 endif
 
 COMMON_LDADDS = ../libqemuutil.a
@@ -233,5 +233,4 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) $(QEMU_PROG)-log.stp "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG)-log.stp"
 endif
 
-generated-files-y += config-target.h
 Makefile: $(generated-files-y)
diff --git a/configure b/configure
index 36a6f8682f..f5705bbf2e 100755
--- a/configure
+++ b/configure
@@ -7786,18 +7786,12 @@ fi
 
 if supported_xen_target $target; then
     echo "CONFIG_XEN=y" >> $config_target_mak
-    echo "$target/config-devices.mak: CONFIG_XEN=y" >> $config_host_mak
     if test "$xen_pci_passthrough" = yes; then
         echo "CONFIG_XEN_PCI_PASSTHROUGH=y" >> "$config_target_mak"
     fi
-else
-    echo "$target/config-devices.mak: CONFIG_XEN=n" >> $config_host_mak
 fi
 if supported_kvm_target $target; then
     echo "CONFIG_KVM=y" >> $config_target_mak
-    echo "$target/config-devices.mak: CONFIG_KVM=y" >> $config_host_mak
-else
-    echo "$target/config-devices.mak: CONFIG_KVM=n" >> $config_host_mak
 fi
 if supported_hax_target $target; then
     echo "CONFIG_HAX=y" >> $config_target_mak
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index da60ada594..999247a588 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -21,7 +21,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "e820_memory_layout.h"
 #include "kvm_i386.h"
-#include "config-devices.h"
+#include CONFIG_DEVICES
 
 struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 42014b06de..393076e1cf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -88,10 +88,10 @@
 #include "hw/mem/memory-device.h"
 #include "sysemu/replay.h"
 #include "qapi/qmp/qerror.h"
-#include "config-devices.h"
 #include "e820_memory_layout.h"
 #include "fw_cfg.h"
 #include "trace.h"
+#include CONFIG_DEVICES
 
 GlobalProperty pc_compat_4_2[] = {};
 const size_t pc_compat_4_2_len = G_N_ELEMENTS(pc_compat_4_2);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 721c7aa64e..ca9d3b5d4c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "config-devices.h"
+#include CONFIG_DEVICES
 
 #include "qemu/units.h"
 #include "hw/loader.h"
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index d8bb5c2a96..1a1b49939b 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -49,7 +49,7 @@
 #include "multiboot.h"
 #include "elf.h"
 #include "standard-headers/asm-x86/bootparam.h"
-#include "config-devices.h"
+#include CONFIG_DEVICES
 #include "kvm_i386.h"
 
 #define BIOS_FILENAME "bios.bin"
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 0f97d68586..3ab72a700f 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -29,7 +29,7 @@
 
 #include "config-host.h"
 #ifdef NEED_CPU_H
-#include "config-target.h"
+#include CONFIG_TARGET
 #else
 #include "exec/poison.h"
 #endif
diff --git a/meson.build b/meson.build
index a81e0c4128..06f531d2b7 100644
--- a/meson.build
+++ b/meson.build
@@ -4,6 +4,7 @@ cc = meson.get_compiler('c')
 kconfig = import('unstable-kconfig')
 ss = import('sourceset')
 config_host = kconfig.load(meson.current_build_dir() / 'config-host.mak')
+config_all_disas = kconfig.load(meson.current_build_dir() / 'config-all-disas.mak')
 
 add_project_arguments(config_host['CFLAGS'].split(),
                       language: ['c', 'objc'])
@@ -109,16 +110,96 @@ if 'CONFIG_LIBUDEV' in config_host
   libudev = declare_dependency(link_args: config_host['LIBUDEV_LIBS'].split())
 endif
 
+create_config = find_program('scripts/create_config')
+minikconf = find_program('scripts/minikconf.py')
 target_dirs = config_host['TARGET_DIRS'].split()
 have_user = false
 have_system = false
+target_devices_kconfs = []
+target_devices_h = {}
+target_config = {}
+kconfig_external_symbols = [
+  'CONFIG_KVM',
+  'CONFIG_XEN',
+  'CONFIG_TPM',
+  'CONFIG_SPICE',
+  'CONFIG_IVSHMEM',
+  'CONFIG_OPENGL',
+  'CONFIG_X11',
+  'CONFIG_VHOST_USER',
+  'CONFIG_VHOST_KERNEL',
+  'CONFIG_VIRTFS',
+  'CONFIG_LINUX',
+  'CONFIG_PVRDMA',
+]
 foreach target : target_dirs
   have_user = have_user or target.endswith('-user')
-  have_system = have_system or target.endswith('-softmmu')
+  config_target = kconfig.load(meson.current_build_dir() / target / 'config-target.mak') + config_host
+
+  if target.endswith('-softmmu')
+    have_system = true
+
+    base_kconfig = []
+    foreach sym : kconfig_external_symbols
+      if sym in config_target
+        base_kconfig += '@0@=y'.format(sym)
+      endif
+    endforeach
+
+    config_devices_mak = target + '-config-devices.mak'
+    config_devices_mak = configure_file(
+      input: ['default-configs' / target + '.mak', 'Kconfig.host', 'hw/Kconfig'],
+      output: config_devices_mak,
+      depfile: config_devices_mak + '.d',
+      capture: true,
+      command: [minikconf, config_host['CONFIG_MINIKCONF_MODE'],
+                config_devices_mak, '@DEPFILE@', '@INPUT@',
+                base_kconfig])
+    config_devices_h = custom_target(
+      target + '-config-devices.h',
+      input: config_devices_mak,
+      output: target + '-config-devices.h',
+      capture: true,
+      command: [create_config, '@INPUT@'])
+    target_devices_kconfs += config_devices_mak
+    target_devices_h += {target: config_devices_h}
+    config_target += kconfig.load(config_devices_mak)
+  endif
+  target_config += {target: config_target}
 endforeach
 have_tools = 'CONFIG_TOOLS' in config_host
 have_block = have_system or have_tools
 
+grepy = find_program('scripts/grepy.sh')
+# This configuration is used to build files that are shared by
+# multiple binaries, and then extracted out of the "common"
+# static_library target.
+#
+# We do not use all_sources()/all_dependencies(), because it would
+# build literally all source files, including devices only used by
+# targets that are not built for this compilation.  The CONFIG_ALL
+# pseudo symbol replaces it.
+
+config_all = {}
+if have_system
+  config_all_devices_inputs = []
+  config_all_devices = configure_file(
+    output: 'config-all-devices.mak',
+    input: target_devices_kconfs,
+    capture: true,
+    command: [grepy, '@INPUT@'],
+  )
+  config_all += kconfig.load(config_all_devices)
+endif
+config_all += config_host
+config_all += config_all_disas
+config_all += {
+  'CONFIG_XEN': config_host.has_key('CONFIG_XEN_BACKEND'),
+  'CONFIG_SOFTMMU': have_system,
+  'CONFIG_USER_ONLY': have_user,
+  'CONFIG_ALL': true,
+}
+
 # Generators
 
 hxtool = find_program('scripts/hxtool')
@@ -142,6 +223,12 @@ qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/__init__.py',
                      meson.source_root() / 'scripts/qapi/doc.py',
 ]
 
+config_host_h = custom_target('config-host.h',
+                              input: meson.current_build_dir() / 'config-host.mak',
+                              output: 'config-host.h',
+                              capture: true,
+                              command: [create_config, '@INPUT@'])
+
 hxdep = []
 hx_headers = [
   ['qemu-options.hx', 'qemu-options.def'],
@@ -181,6 +268,16 @@ endforeach
 util_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
+common_ss = ss.source_set()
+softmmu_ss = ss.source_set()
+user_ss = ss.source_set()
+bsd_user_ss = ss.source_set()
+linux_user_ss = ss.source_set()
+specific_ss = ss.source_set()
+
+hw_arch = {}
+target_arch = {}
+target_softmmu_arch = {}
 
 # TODO: add each directory to the subdirs from its own meson.build, once
 # we have those
@@ -270,7 +367,7 @@ trace_events_subdirs += [
   'util',
 ]
 
-genh = []
+genh = [config_host_h]
 subdir('qapi')
 subdir('qobject')
 subdir('stubs')
@@ -297,6 +394,67 @@ subdir('io')
 subdir('fsdev')
 subdir('target')
 
+common_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: softmmu_ss)
+common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
+
+common_all = common_ss.apply(config_all, strict: false)
+common_all = static_library('common',
+                            sources: common_all.sources(),
+                            dependencies: common_all.dependencies(),
+                            name_suffix: 'fa')
+
+foreach target : target_dirs
+  config_target = target_config[target]
+  target_name = config_target['TARGET_NAME']
+  arch = config_target['TARGET_BASE_ARCH']
+  arch_srcs = []
+
+  target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
+  if host_machine.system() == 'linux'
+    target_inc += include_directories('linux-headers')
+  endif
+  if target.endswith('-softmmu')
+    qemu_target_name = 'qemu-system-' + target_name
+    target_type='system'
+    arch_srcs += target_devices_h[target]
+  else
+    target_type='user'
+    qemu_target_name = 'qemu-' + target_name
+    if 'CONFIG_LINUX_USER' in config_target
+      base_dir = 'linux-user'
+      target_inc += include_directories('linux-user/host/' / config_host['ARCH'])
+    else
+      base_dir = 'bsd-user'
+    endif
+    target_inc += include_directories(
+      base_dir,
+      base_dir / config_target['TARGET_ABI_DIR'],
+    )
+  endif
+
+  target_common = common_ss.apply(config_target, strict: false)
+  objects = common_all.extract_objects(target_common.sources())
+
+  # TODO: Change to generator once obj-y goes away
+  config_target_h = custom_target(target + '-config-target.h',
+                              input: meson.current_build_dir() / target / 'config-target.mak',
+                              output: target + '-config-target.h',
+                              capture: true,
+                              command: [create_config, '@INPUT@'])
+
+  target_specific = specific_ss.apply(config_target, strict: false)
+  arch_srcs += target_specific.sources()
+
+  static_library('qemu-' + target,
+                 sources: arch_srcs + [config_target_h],
+                 objects: objects,
+                 include_directories: target_inc,
+                 c_args: ['-DNEED_CPU_H',
+                          '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
+                          '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)],
+                 name_suffix: 'fa')
+endforeach
+
 # Other build targets
 if 'CONFIG_GUEST_AGENT' in config_host
   subdir('qga')
diff --git a/rules.mak b/rules.mak
index a10a972521..9dd3b7e2ec 100644
--- a/rules.mak
+++ b/rules.mak
@@ -203,14 +203,6 @@ notempty = $(if $1,y,n)
 # Generate files with tracetool
 TRACETOOL=$(PYTHON) $(SRC_PATH)/scripts/tracetool.py
 
-# Generate timestamp files for .h include files
-
-config-%.h: config-%.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-
-config-%.h-timestamp: config-%.mak $(SRC_PATH)/scripts/create_config
-	$(call quiet-command, sh $(SRC_PATH)/scripts/create_config < $< > $@,"GEN","$(TARGET_DIR)config-$*.h")
-
 .PHONY: clean-timestamp
 clean-timestamp:
 	rm -f *.timestamp
diff --git a/scripts/create_config b/scripts/create_config
index 6d8f08b39d..bc82661041 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -1,5 +1,7 @@
 #!/bin/sh
 
+test $# -gt 0 && exec < $1
+
 echo "/* Automatically generated by create_config - do not modify */"
 
 while read line; do
diff --git a/scripts/grepy.sh b/scripts/grepy.sh
new file mode 100755
index 0000000000..33c74c6029
--- /dev/null
+++ b/scripts/grepy.sh
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+grep --no-filename '=y$' "$@" | sort -u
diff --git a/scripts/minikconf.py b/scripts/minikconf.py
old mode 100644
new mode 100755
index febd9a479f..e4cbd576d3
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -1,3 +1,4 @@
+#!/usr/bin/env python3
 #
 # Mini-Kconfig parser
 #
-- 
2.21.0



