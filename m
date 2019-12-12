Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74036C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F103206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYZ3/z+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F103206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOTH-0001Hd-KI
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyN-0003Y9-TF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyL-0006kU-AL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:39 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42365)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyK-0006ih-WC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:37 -0500
Received: by mail-wr1-x42f.google.com with SMTP id q6so2582936wro.9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pa3Lkx+CsIop0JEWRcLrRpLqD2Xhtkc5mBSulFY1kvo=;
 b=oYZ3/z+igD9irISKu4jBE0fxAVORV7BhmjL6j4YGV05oipVT5DAyKsVQMXWUAfIldW
 0/k1ra99tkUkMrmvt3f+kDrOn1QOlhwgN6l5Ku3F4OvmbkzVgBuJXNyHRyRURHepJb0/
 loe9xQu5rAxC/cWa7E5X5+cEdHBIeKbEjpmAkD+OeQqhfmzPYcN32ipw6ohT07ezcKzw
 btVahJgFg3LqZSfJgGb0hrFCap5KWiiECrJWuGmj0G77zst5f5KtmIkuKunDRPbFPZ3A
 dvLf1tHhKt3acDqAADdD3aOMJ8oMIupkPz+ItPhs8baTiIzSbY+uT2qi6f1SMYZnh9VK
 +RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pa3Lkx+CsIop0JEWRcLrRpLqD2Xhtkc5mBSulFY1kvo=;
 b=HFY2iqR340MxXWK/oLG0IHCYmt+vIH5debhi/6IuFakCOdE91cLsSqG8/i+3JivdYh
 rpRhZruayAxoFNmVDNADe4UvHKP8zisffJRtZbeMp8tTfidp2RkLEbGzUk6K+mUfRD3z
 bP/zXI8NpAs2jyZXPsraM50FSAUZ6oAccavGAREqRQ/nZyeso2DmXsVXybLM6Sq4lkqc
 JeRgEjDwwYDxHlatyFc73cwoCLW/Ju3r/8+oP1xTZ/YqGIJgycZOpT2oyTd5f9FQOzJH
 K8YP+XOsDGzEhEAeqWr0Bjxd9Tz5lqwkX3RQi4OIGh+yE/+xUKh0dxnT9qFVNeMtbCnO
 s4SA==
X-Gm-Message-State: APjAAAUSeG2QkO/6ZFLd9e742b3ITuBzAnIG3wYEOREEFrPoWTj6fHYo
 cge45oaEDwVf5jNsAkZd7opodECo
X-Google-Smtp-Source: APXvYqyKCsvOP8exqX+8gFU44lQ3cBFs7d8yFYi2CqOibkftrtis5nRR9vq8CUJoMSEwjJz/srT/0g==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr6189962wrr.116.1576155215326; 
 Thu, 12 Dec 2019 04:53:35 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 038/132] meson: infrastructure for building emulators
Date: Thu, 12 Dec 2019 13:51:22 +0100
Message-Id: <1576155176-2464-39-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile              |  72 +++-----------------
 Makefile.target       |  19 +++---
 configure             |   6 --
 hw/i386/pc.c          |   2 +-
 hw/i386/pc_piix.c     |   2 +-
 include/qemu/osdep.h  |   2 +-
 meson.build           | 182 +++++++++++++++++++++++++++++++++++++++++++++++++-
 rules.mak             |   8 ---
 scripts/create_config |   2 +
 scripts/grepy.sh      |   3 +
 scripts/minikconf.py  |   1 +
 11 files changed, 207 insertions(+), 92 deletions(-)
 create mode 100755 scripts/grepy.sh
 mode change 100644 => 100755 scripts/minikconf.py

diff --git a/Makefile b/Makefile
index 77ac1ea..bae96ec 100644
--- a/Makefile
+++ b/Makefile
@@ -134,63 +134,6 @@ DOCS=
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
-    CONFIG_VIRTFS=$(CONFIG_VIRTFS) \
-    CONFIG_LINUX=$(CONFIG_LINUX) \
-    CONFIG_PVRDMA=$(CONFIG_PVRDMA)
-
-MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
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
@@ -207,10 +150,9 @@ include $(SRC_PATH)/tests/Makefile.include
 
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
 
-config-host.h: config-host.h-timestamp
-config-host.h-timestamp: config-host.mak
-
 TARGET_DIRS_RULES := $(foreach t, all clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
+SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_DIRS))
+SOFTMMU_SUBDIR_RULES=$(filter %-softmmu,$(SUBDIR_RULES))
 
 SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
 $(SOFTMMU_ALL_RULES): $(authz-obj-y)
@@ -221,10 +163,15 @@ $(SOFTMMU_ALL_RULES): $(io-obj-y)
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
@@ -356,8 +303,7 @@ endef
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
index f912ba0..74e8295 100644
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
@@ -168,7 +169,6 @@ obj-y += hw/$(TARGET_BASE_ARCH)/
 endif
 
 generated-files-y += hmp-commands.h hmp-commands-info.h
-generated-files-y += config-devices.h
 
 endif # CONFIG_SOFTMMU
 
@@ -195,7 +195,7 @@ all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
 ifdef CONFIG_SOFTMMU
-$(QEMU_PROG_BUILD): config-devices.mak
+$(QEMU_PROG_BUILD): ../$(FULL_TARGET_NAME)-config-devices.mak
 endif
 
 COMMON_LDADDS = ../libqemuutil.a
@@ -231,5 +231,4 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) $(QEMU_PROG)-log.stp "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG)-log.stp"
 endif
 
-generated-files-y += config-target.h
 Makefile: $(generated-files-y)
diff --git a/configure b/configure
index ca91a76..d65b79e 100755
--- a/configure
+++ b/configure
@@ -7582,18 +7582,12 @@ fi
 
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
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c14ed86..87aef3c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -86,7 +86,7 @@
 #include "hw/mem/memory-device.h"
 #include "sysemu/replay.h"
 #include "qapi/qmp/qerror.h"
-#include "config-devices.h"
+#include CONFIG_DEVICES
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2362675..46cfb16 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "config-devices.h"
+#include CONFIG_DEVICES
 
 #include "qemu/units.h"
 #include "hw/loader.h"
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index af2b91f..280fd40 100644
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
index bdc2f3e..5949e6d 100644
--- a/meson.build
+++ b/meson.build
@@ -4,6 +4,7 @@ cc = meson.get_compiler('c')
 kconfig = import('unstable-kconfig')
 ss = import('sourceset')
 config_host = kconfig.load(meson.current_build_dir() / 'config-host.mak')
+config_all_disas = kconfig.load(meson.current_build_dir() / 'config-all-disas.mak')
 
 add_project_arguments(config_host['CFLAGS'].split(),
                       language: ['c', 'objc'])
@@ -105,16 +106,96 @@ if 'CONFIG_LIBUDEV' in config_host
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
@@ -128,6 +209,12 @@ qapi_gen_depends = [ meson.source_root() / 'scripts/qapi/events.py',
                      meson.source_root() / 'scripts/qapi/doc.py',
                      meson.source_root() / 'scripts/qapi-gen.py' ]
 
+config_host_h = custom_target('config-host.h',
+                              input: meson.current_build_dir() / 'config-host.mak',
+                              output: 'config-host.h',
+                              capture: true,
+                              command: [create_config, '@INPUT@'])
+
 hxdep = []
 hx_headers = [
   ['qemu-options.hx', 'qemu-options.def'],
@@ -167,6 +254,16 @@ endforeach
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
@@ -254,7 +351,7 @@ trace_events_subdirs += [
   'util',
 ]
 
-genh = []
+genh = [config_host_h]
 subdir('qapi')
 subdir('qobject')
 subdir('stubs')
@@ -280,6 +377,87 @@ qemuutil = declare_dependency(link_with: libqemuutil,
 subdir('io')
 subdir('fsdev')
 
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
+  arch_deps = []
+
+  target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
+  if host_machine.system() == 'linux'
+    target_inc += include_directories('linux-headers')
+  endif
+  if target.endswith('-softmmu')
+    qemu_target_name = 'qemu-system-' + target_name
+    target_type='system'
+    t = target_softmmu_arch[arch].apply(config_target, strict: false)
+    arch_srcs += t.sources()
+    arch_deps += t.dependencies()
+
+    if target_name == 'sparc64'
+      hw = hw_arch['sparc64'].apply(config_target, strict: false)
+    else
+      hw = hw_arch[arch].apply(config_target, strict: false)
+    endif
+    arch_srcs += hw.sources()
+    arch_srcs += target_devices_h[target]
+    arch_deps += hw.dependencies()
+  else
+    target_type='user'
+    qemu_target_name = 'qemu-' + target_name
+    if 'CONFIG_LINUX_USER' in config_target
+      base_dir = 'linux-user'
+    else
+      base_dir = 'bsd-user'
+    endif
+    target_inc += include_directories(
+      base_dir,
+      base_dir / config_target['TARGET_ABI_DIR'],
+    )
+    if 'CONFIG_LINUX_USER' in config_target
+      dir = base_dir / config_target['TARGET_ABI_DIR']
+      target_inc += include_directories(base_dir / 'host' / config_target['ARCH'])
+      arch_srcs += files(dir / 'signal.c', dir / 'cpu_loop.c')
+    endif
+  endif
+
+  t = target_arch[arch].apply(config_target, strict: false)
+  arch_srcs += t.sources()
+  arch_deps += t.dependencies()
+
+  target_common = common_ss.apply(config_target, strict: false)
+  objects = common_all.extract_objects(target_common.sources())
+  deps = target_common.dependencies()
+
+  # TODO: Change to generator once obj-y goes away
+  config_target_h = custom_target(target + '-config-target.h',
+                              input: meson.current_build_dir() / target / 'config-target.mak',
+                              output: target + '-config-target.h',
+                              capture: true,
+                              command: [create_config, '@INPUT@'])
+
+  target_specific = specific_ss.apply(config_target, strict: false)
+  static_library('qemu-' + target,
+                 sources: target_specific.sources() + arch_srcs + [config_target_h],
+                 dependencies: target_specific.dependencies() + arch_deps + deps,
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
index a10a972..9dd3b7e 100644
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
index 6d8f08b..bc82661 100755
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
index 0000000..33c74c6
--- /dev/null
+++ b/scripts/grepy.sh
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+grep --no-filename '=y$' "$@" | sort -u
diff --git a/scripts/minikconf.py b/scripts/minikconf.py
old mode 100644
new mode 100755
index febd9a4..e4cbd57
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -1,3 +1,4 @@
+#!/usr/bin/env python3
 #
 # Mini-Kconfig parser
 #
-- 
1.8.3.1



