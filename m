Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA890C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946312074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBvvnxtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946312074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Wgl-0006oK-R2
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vnw-0008M0-Jv
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vnp-0003Cm-Oz
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uO0PMXD16yzCYlX859hntHtXpdolOvuuR7AUHHtBD7g=;
 b=gBvvnxtxPWsC2MdLES88zP7eRVmDYuIWSXoYH1sJEZVKRc5DGR4J27B4O0QcvG5ha1vDrQ
 0s9DVVquf4oAj2mbZ/Uwe266MuKtmbeM228uMNvMP6LdyboRP2vzNqunCGVnEJ6bU5CGd+
 9oVgRuDYBNND/U68ESCkoUe715PKi1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-tIh7Sq_FPLqK3LSiNQ0waw-1; Fri, 14 Aug 2020 05:15:06 -0400
X-MC-Unique: tIh7Sq_FPLqK3LSiNQ0waw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC96F1DDE5
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:15:05 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 787C8196F3;
 Fri, 14 Aug 2020 09:15:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 134/150] meson: link emulators without Makefile.target
Date: Fri, 14 Aug 2020 05:13:10 -0400
Message-Id: <20200814091326.16173-135-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The binaries move to the root directory, e.g. qemu-system-i386 or
qemu-arm.  This requires changes to qtests, CI, etc.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.yml                            |   6 +-
 Makefile                                  |  35 +----
 Makefile.objs                             |  32 -----
 Makefile.target                           | 153 +---------------------
 configure                                 |  41 +-----
 docs/devel/blkverify.txt                  |   4 +-
 docs/devel/testing.rst                    |   4 +-
 docs/interop/live-block-operations.rst    |   4 +-
 meson.build                               |  73 ++++++++++-
 os-posix.c                                |   2 +-
 plugins/meson.build                       |  10 +-
 rules.mak                                 |   1 -
 scripts/device-crash-test                 |   2 +-
 scripts/oss-fuzz/build.sh                 |  20 +--
 softmmu/Makefile.objs                     |   2 -
 target/s390x/meson.build                  |  13 ++
 tests/Makefile.include                    |   4 +-
 tests/acceptance/avocado_qemu/__init__.py |   3 +-
 tests/data/acpi/rebuild-expected-aml.sh   |   2 +-
 tests/multiboot/run_test.sh               |   2 +-
 tests/qemu-iotests/check                  |   6 +-
 tests/qtest/fuzz/Makefile.include         |  39 ------
 tests/qtest/fuzz/i440fx_fuzz.c            |   4 +-
 tests/qtest/fuzz/meson.build              |  35 +++++
 tests/qtest/fuzz/qtest_wrappers.c         |   2 +-
 tests/qtest/fuzz/virtio_net_fuzz.c        |   3 +-
 tests/qtest/fuzz/virtio_scsi_fuzz.c       |   8 +-
 tests/qtest/libqos/qgraph.h               |   2 +-
 tests/qtest/meson.build                   |   2 +-
 tests/qtest/rtas-test.c                   |   2 +-
 tests/tcg/configure.sh                    |   4 +-
 31 files changed, 180 insertions(+), 340 deletions(-)
 delete mode 100644 softmmu/Makefile.objs
 delete mode 100644 tests/qtest/fuzz/Makefile.include
 create mode 100644 tests/qtest/fuzz/meson.build

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9820066379..b7967b9a13 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -265,9 +265,9 @@ build-tci:
     - make run-tcg-tests-x86_64-softmmu
     - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/pxe-test
     - for tg in $TARGETS ; do
-        export QTEST_QEMU_BINARY="${tg}-softmmu/qemu-system-${tg}" ;
+        export QTEST_QEMU_BINARY="./qemu-system-${tg}" ;
         ./tests/qtest/boot-serial-test || exit 1 ;
         ./tests/qtest/cdrom-test || exit 1 ;
       done
-    - QTEST_QEMU_BINARY="x86_64-softmmu/qemu-system-x86_64" ./tests/qtest/pxe-test
-    - QTEST_QEMU_BINARY="s390x-softmmu/qemu-system-s390x" ./tests/qtest/pxe-test -m slow
+    - QTEST_QEMU_BINARY="./qemu-system-x86_64" ./tests/qtest/pxe-test
+    - QTEST_QEMU_BINARY="./qemu-system-s390x" ./tests/qtest/pxe-test -m slow
diff --git a/Makefile b/Makefile
index 4d1e42d0f1..8331c0fd39 100644
--- a/Makefile
+++ b/Makefile
@@ -112,9 +112,6 @@ include $(SRC_PATH)/rules.mak
 # lor is defined in rules.mak
 CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
 
-generated-files-y += target/s390x/gen-features.h
-target/s390x/gen-features.h: Makefile.ninja
-
 generated-files-y += .git-submodule-status
 
 # Don't try to regenerate Makefile or configure
@@ -178,29 +175,6 @@ config-host.h-timestamp: config-host.mak
 
 TARGET_DIRS_RULES := $(foreach t, all fuzz clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
 
-SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
-$(SOFTMMU_ALL_RULES): $(authz-obj-y)
-$(SOFTMMU_ALL_RULES): $(block-obj-y)
-$(SOFTMMU_ALL_RULES): $(chardev-obj-y)
-$(SOFTMMU_ALL_RULES): $(crypto-obj-y)
-$(SOFTMMU_ALL_RULES): $(io-obj-y)
-$(SOFTMMU_ALL_RULES): $(qom-obj-y)
-$(SOFTMMU_ALL_RULES): config-all-devices.mak
-
-SOFTMMU_FUZZ_RULES=$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
-$(SOFTMMU_FUZZ_RULES): $(authz-obj-y)
-$(SOFTMMU_FUZZ_RULES): $(block-obj-y)
-$(SOFTMMU_FUZZ_RULES): $(chardev-obj-y)
-$(SOFTMMU_FUZZ_RULES): $(crypto-obj-y)
-$(SOFTMMU_FUZZ_RULES): $(io-obj-y)
-$(SOFTMMU_FUZZ_RULES): config-all-devices.mak
-$(SOFTMMU_FUZZ_RULES): $(edk2-decompressed)
-
-# meson: this is sub-optimal but going away after conversion
-TARGET_DEPS = $(patsubst %,%-config-target.h, $(TARGET_DIRS))
-TARGET_DEPS += $(patsubst %,%-config-devices.h, $(filter %-softmmu,$(TARGET_DIRS)))
-TARGET_DEPS += $(patsubst %,libqemu-%.fa, $(TARGET_DIRS))
-
 .PHONY: $(TARGET_DIRS_RULES)
 # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
 # $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
@@ -243,11 +217,7 @@ slirp/all: .git-submodule-status
 		CC="$(CC)" AR="$(AR)" 	LD="$(LD)" RANLIB="$(RANLIB)"	\
 		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)")
 
-$(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
-	$(qom-obj-y) block.syms qemu.syms
-
-$(filter %/fuzz, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
-	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
+$(filter %/all, $(TARGET_DIRS_RULES)):
 
 ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
@@ -269,8 +239,6 @@ Makefile: $(version-obj-y)
 
 ######################################################################
 
-COMMON_LDADDS = libqemuutil.a
-
 clean: recurse-clean ninja-clean clean-ctlist
 	-test -f ninjatool && ./ninjatool $(if $(V),-v,) -t clean
 # avoid old build problems by removing potentially incorrect old files
@@ -304,6 +272,7 @@ distclean: clean ninja-distclean
 	rm -f po/*.mo tests/qemu-iotests/common.env
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
 	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
+	rm -f *-config-target.h *-config-devices.mak *-config-devices.h
 	rm -rf meson-private meson-logs meson-info compile_commands.json
 	rm -f Makefile.ninja ninjatool ninjatool.stamp Makefile.mtest
 	rm -f config.log
diff --git a/Makefile.objs b/Makefile.objs
index 83622c58a5..5295c3a623 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -33,38 +33,6 @@ io-obj-y = io/libio.fa
 
 endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 
-######################################################################
-# Target independent part of system emulation. The long term path is to
-# suppress *all* target specific code in case of system emulation, i.e. a
-# single QEMU executable should support all CPUs and machines.
-
-ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y =
-
-common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
-common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
-common-obj-$(CONFIG_AUDIO_PA) += audio-pa$(DSOSUF)
-common-obj-$(CONFIG_AUDIO_SDL) += audio-sdl$(DSOSUF)
-
-common-obj-$(if $(CONFIG_CURSES),m) += ui-curses$(DSOSUF)
-common-obj-$(if $(CONFIG_GTK),m) += ui-gtk$(DSOSUF)
-common-obj-$(if $(CONFIG_SDL),m) += ui-sdl$(DSOSUF)
-common-obj-$(if $(CONFIG_SPICE),m) += ui-spice-app$(DSOSUF)
-
-common-obj-$(if $(CONFIG_CURL),m) += block-curl$(DSOSUF)
-common-obj-$(if $(CONFIG_GLUSTERFS),m) += block-gluster$(DSOSUF)
-common-obj-$(if $(CONFIG_LIBISCSI),m) += block-iscsi$(DSOSUF)
-common-obj-$(if $(CONFIG_LIBNFS),m) += block-nfs$(DSOSUF)
-common-obj-$(if $(CONFIG_LIBSSH),m) += block-ssh$(DSOSUF)
-common-obj-$(if $(CONFIG_RBD),m) += block-rbd$(DSOSUF)
-
-common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
-common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
-
-common-obj-y += libqmp.fa
-
-endif # CONFIG_SOFTMMU
-
 ######################################################################
 # Resource file for Windows executables
 version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
diff --git a/Makefile.target b/Makefile.target
index 2b7280b272..8ee4c78b3f 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -6,43 +6,16 @@ include ../config-host.mak
 include config-target.mak
 include $(SRC_PATH)/rules.mak
 
-FULL_TARGET_NAME=$(TARGET_NAME)-$(if $(CONFIG_SOFTMMU),softmmu,linux-user)
-
-ifdef CONFIG_SOFTMMU
-include ../$(FULL_TARGET_NAME)-config-devices.mak
-endif
-
 $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
-ifdef CONFIG_LINUX
-QEMU_CFLAGS += -isystem ../linux-headers
-endif
-QEMU_CFLAGS += -iquote .. -iquote $(SRC_PATH)/target/$(TARGET_BASE_ARCH) -DNEED_CPU_H
-
-QEMU_CFLAGS+=-iquote $(SRC_PATH)/include
-
-QEMU_CFLAGS += -DCONFIG_TARGET=\"../$(FULL_TARGET_NAME)-config-target.h\"
-QEMU_CFLAGS += -DCONFIG_DEVICES=\"../$(FULL_TARGET_NAME)-config-devices.h\"
 
 ifdef CONFIG_USER_ONLY
 # user emulator name
 QEMU_PROG=qemu-$(TARGET_NAME)
-QEMU_PROG_BUILD = $(QEMU_PROG)
 else
 # system emulator name
 QEMU_PROG=qemu-system-$(TARGET_NAME)$(EXESUF)
-ifneq (,$(findstring -mwindows,$(SDL_LIBS)))
-# Terminate program name with a 'w' because the linker builds a windows executable.
-QEMU_PROGW=qemu-system-$(TARGET_NAME)w$(EXESUF)
-$(QEMU_PROG): $(QEMU_PROGW)
-	$(call quiet-command,$(OBJCOPY) --subsystem console $(QEMU_PROGW) $(QEMU_PROG),"GEN","$(TARGET_DIR)$(QEMU_PROG)")
-QEMU_PROG_BUILD = $(QEMU_PROGW)
-else
-QEMU_PROG_BUILD = $(QEMU_PROG)
-endif
 endif
 
-LIBQEMU = ../libqemu-$(FULL_TARGET_NAME).fa
-PROGS=$(QEMU_PROG) $(QEMU_PROGW)
 STPFILES=
 
 ifdef CONFIG_TRACE_SYSTEMTAP
@@ -98,109 +71,10 @@ stap:
 endif
 .PHONY: stap
 
-all: $(PROGS) stap
-
-# Dummy command so that make thinks it has done something
-	@true
-
-obj-y += $(LIBQEMU)
-
-obj-y += trace/
-
-#########################################################
-LIBS := $(libs_cpu) $(LIBS)
-
-#########################################################
-# Linux user emulator target
-
-ifdef CONFIG_LINUX_USER
-
-QEMU_CFLAGS+=-I$(SRC_PATH)/linux-user/$(TARGET_ABI_DIR) \
-             -I$(SRC_PATH)/linux-user/host/$(ARCH) \
-             -I$(SRC_PATH)/linux-user \
-             -Ilinux-user/$(TARGET_ABI_DIR)
-
-endif #CONFIG_LINUX_USER
-
-#########################################################
-# BSD user emulator target
-
-ifdef CONFIG_BSD_USER
-
-QEMU_CFLAGS+=-I$(SRC_PATH)/bsd-user -I$(SRC_PATH)/bsd-user/$(TARGET_ABI_DIR) \
-			 -I$(SRC_PATH)/bsd-user/$(HOST_VARIANT_DIR)
-
-endif #CONFIG_BSD_USER
-
-#########################################################
-# System emulator target
-ifdef CONFIG_SOFTMMU
-obj-y += softmmu/
-obj-y += gdbstub.o
-LIBS := $(libs_softmmu) $(LIBS)
-
-# Temporary until emulators are linked by Meson
-LIBS := $(LIBS) @../block.syms @../qemu.syms
-ifneq ($(CONFIG_MODULES),y)
-LIBS := $(LIBS) $(ALSA_LIBS) $(OSS_LIBS) $(PULSE_LIBS) $(SDL_LIBS)
-LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS) $(GIO_LIBS)
-endif
-LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
-LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
-LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
-LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
-LIBS := $(LIBS) $(VIRGL_LIBS) $(CURSES_LIBS)
-
-ifeq ($(CONFIG_PLUGIN),y)
-ifdef CONFIG_HAS_LD_DYNAMIC_LIST
-LIBS += -Wl,--dynamic-list=$(BUILD_DIR)/qemu-plugins-ld.symbols
-else
-ifdef CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST
-LIBS += -Wl,-exported_symbols_list,$(BUILD_DIR)/qemu-plugins-ld64.symbols
-endif
-endif
-endif
-
-generated-files-y += hmp-commands.h hmp-commands-info.h
-
-endif # CONFIG_SOFTMMU
-
-dummy := $(call unnest-vars,,obj-y)
-all-obj-y := $(obj-y)
-
-include $(SRC_PATH)/Makefile.objs
-dummy := $(call fix-paths,../,, \
-              authz-obj-y \
-              block-obj-y \
-              chardev-obj-y \
-              crypto-obj-y \
-              io-obj-y \
-              qom-obj-y)
-dummy := $(call unnest-vars,..,common-obj-y)
-
-all-obj-y += $(common-obj-y)
-all-obj-y += $(qom-obj-y)
-all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
-all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
-all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
-all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
-
-ifdef CONFIG_SOFTMMU
-$(QEMU_PROG_BUILD): ../$(FULL_TARGET_NAME)-config-devices.mak
-endif
-
-COMMON_LDADDS = ../libqemuutil.a
-
-# build either PROG or PROGW
-$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS) $(softmmu-main-y)
-	$(call LINK, $(filter-out %.mak, $^))
-ifdef CONFIG_DARWIN
-	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"REZ","$(TARGET_DIR)$@")
-	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
-endif
+all: stap
 
-clean: clean-target
-	rm -f *.a *~ $(PROGS)
+clean:
+	rm -f *.a *~
 	rm -f $(shell find . -name '*.[od]')
 	rm -f hmp-commands.h gdbstub-xml.c
 	rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
@@ -208,26 +82,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	rm -f *.stp
 endif
 
-ifdef CONFIG_FUZZ
-include $(SRC_PATH)/tests/qtest/fuzz/Makefile.include
-include $(SRC_PATH)/tests/qtest/Makefile.include
-
-fuzz: fuzz-vars
-fuzz-vars: QEMU_CFLAGS := $(FUZZ_CFLAGS) $(QEMU_CFLAGS)
-fuzz-vars: QEMU_LDFLAGS := $(FUZZ_LDFLAGS) $(QEMU_LDFLAGS)
-fuzz-vars: $(QEMU_PROG_FUZZ)
-dummy := $(call unnest-vars,, fuzz-obj-y)
-
-
-$(QEMU_PROG_FUZZ): config-devices.mak $(all-obj-y) $(COMMON_LDADDS) $(fuzz-obj-y)
-	$(call LINK, $(filter-out %.mak, $^))
-
-endif
-
 install: all
-ifneq ($(PROGS),)
-	$(call install-prog,$(PROGS),$(DESTDIR)$(bindir))
-endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset"
 	$(INSTALL_DATA) $(QEMU_PROG).stp-installed "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG).stp"
@@ -235,4 +90,4 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) $(QEMU_PROG)-log.stp "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG)-log.stp"
 endif
 
-Makefile: $(generated-files-y)
+.PHONY: all clean install
diff --git a/configure b/configure
index 0594ff4159..c421d2b91a 100755
--- a/configure
+++ b/configure
@@ -316,7 +316,6 @@ audio_drv_list=""
 block_drv_rw_whitelist=""
 block_drv_ro_whitelist=""
 host_cc="cc"
-libs_cpu=""
 libs_softmmu=""
 libs_tools=""
 audio_win_int=""
@@ -5428,7 +5427,6 @@ case "$capstone" in
     else
       LIBCAPSTONE=libcapstone.a
     fi
-    libs_cpu="-L$PWD/capstone -lcapstone $libs_cpu"
     capstone_libs="-L$PWD/capstone -lcapstone"
     capstone_cflags="-I${source_path}/capstone/include"
     ;;
@@ -5437,7 +5435,6 @@ case "$capstone" in
     capstone_libs="$($pkg_config --libs capstone)"
     capstone_cflags="$($pkg_config --cflags capstone)"
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
-    libs_cpu="$($pkg_config --libs capstone) $libs_cpu"
     ;;
 
   no)
@@ -6354,7 +6351,10 @@ fi
 if test "$fuzzing" = "yes" ; then
   write_c_fuzzer_skeleton
   if compile_prog "$CPU_CFLAGS -Werror -fsanitize=fuzzer" ""; then
-      have_fuzzer=yes
+    have_fuzzer=yes
+  else
+    error_exit "Your compiler doesn't support -fsanitize=fuzzer"
+    exit 1
   fi
 fi
 
@@ -6866,7 +6866,6 @@ echo "qemu_helperdir=$libexecdir" >> $config_host_mak
 echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
 echo "qemu_icondir=$qemu_icondir" >> $config_host_mak
 echo "qemu_desktopdir=$qemu_desktopdir" >> $config_host_mak
-echo "libs_cpu=$libs_cpu" >> $config_host_mak
 echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
 echo "GIT=$git" >> $config_host_mak
 echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
@@ -7731,14 +7730,7 @@ if test "$have_mlockall" = "yes" ; then
   echo "HAVE_MLOCKALL=y" >> $config_host_mak
 fi
 if test "$fuzzing" = "yes" ; then
-  if test "$have_fuzzer" = "yes"; then
-    FUZZ_LDFLAGS=" -fsanitize=fuzzer"
-    FUZZ_CFLAGS=" -fsanitize=fuzzer"
-    QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer-no-link"
-  else
-    error_exit "Your compiler doesn't support -fsanitize=fuzzer"
-    exit 1
-  fi
+  QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer-no-link"
 fi
 
 if test "$plugins" = "yes" ; then
@@ -7853,8 +7845,6 @@ if test "$libudev" != "no"; then
 fi
 if test "$fuzzing" != "no"; then
     echo "CONFIG_FUZZ=y" >> $config_host_mak
-    echo "FUZZ_CFLAGS=$FUZZ_CFLAGS" >> $config_host_mak
-    echo "FUZZ_LDFLAGS=$FUZZ_LDFLAGS" >> $config_host_mak
 fi
 
 if test "$edk2_blobs" = "yes" ; then
@@ -8204,9 +8194,6 @@ fi
 
 # generate QEMU_CFLAGS/QEMU_LDFLAGS for targets
 
-cflags=""
-ldflags=""
-
 disas_config() {
   echo "CONFIG_${1}_DIS=y" >> $config_target_mak
   echo "CONFIG_${1}_DIS=y" >> config-all-disas.mak
@@ -8291,24 +8278,6 @@ if test "$tcg_interpreter" = "yes" ; then
   disas_config "TCI"
 fi
 
-# Newer kernels on s390 check for an S390_PGSTE program header and
-# enable the pgste page table extensions in that case. This makes
-# the vm.allocate_pgste sysctl unnecessary. We enable this program
-# header if
-#  - we build on s390x
-#  - we build the system emulation for s390x (qemu-system-s390x)
-#  - KVM is enabled
-#  - the linker supports --s390-pgste
-if test "$TARGET_ARCH" = "s390x" && test "$target_softmmu" = "yes" && \
-        test "$ARCH" = "s390x" && test "$kvm" = "yes"; then
-    if ld_has --s390-pgste ; then
-        ldflags="-Wl,--s390-pgste $ldflags"
-    fi
-fi
-
-echo "QEMU_LDFLAGS+=$ldflags" >> $config_target_mak
-echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
-
 done # for target in $targets
 
 echo "PIXMAN_CFLAGS=$pixman_cflags" >> $config_host_mak
diff --git a/docs/devel/blkverify.txt b/docs/devel/blkverify.txt
index d556dc4e6d..aca826c51c 100644
--- a/docs/devel/blkverify.txt
+++ b/docs/devel/blkverify.txt
@@ -62,8 +62,8 @@ A more realistic scenario is verifying the installation of a guest OS:
 
     $ ./qemu-img create raw.img 16G
     $ ./qemu-img create -f qcow2 test.qcow2 16G
-    $ x86_64-softmmu/qemu-system-x86_64 -cdrom debian.iso \
-                                        -drive file=blkverify:raw.img:test.qcow2
+    $ ./qemu-system-x86_64 -cdrom debian.iso \
+          -drive file=blkverify:raw.img:test.qcow2
 
 If the installation is aborted when blkverify detects corruption, use qemu-io
 to explore the contents of the disk image at the sector in question.
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index a4264691be..196e3bc35e 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -819,7 +819,7 @@ the following approaches:
 1) Set ``qemu_bin``, and use the given binary
 
 2) Do not set ``qemu_bin``, and use a QEMU binary named like
-   "${arch}-softmmu/qemu-system-${arch}", either in the current
+   "qemu-system-${arch}", either in the current
    working directory, or in the current source tree.
 
 The resulting ``qemu_bin`` value will be preserved in the
@@ -886,7 +886,7 @@ like the following:
 
 .. code::
 
-  PARAMS (key=qemu_bin, path=*, default=x86_64-softmmu/qemu-system-x86_64) => 'x86_64-softmmu/qemu-system-x86_64
+  PARAMS (key=qemu_bin, path=*, default=./qemu-system-x86_64) => './qemu-system-x86_64
 
 arch
 ~~~~
diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live-block-operations.rst
index 48afdc7927..e13f5a21f8 100644
--- a/docs/interop/live-block-operations.rst
+++ b/docs/interop/live-block-operations.rst
@@ -129,7 +129,7 @@ To show some example invocations of command-line, we will use the
 following invocation of QEMU, with a QMP server running over UNIX
 socket::
 
-    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -no-user-config \
+    $ ./qemu-system-x86_64 -display none -no-user-config \
         -M q35 -nodefaults -m 512 \
         -blockdev node-name=node-A,driver=qcow2,file.driver=file,file.node-name=file,file.filename=./a.qcow2 \
         -device virtio-blk,drive=node-A,id=virtio0 \
@@ -694,7 +694,7 @@ instance, with the following invocation.  (As noted earlier, for
 simplicity's sake, the destination QEMU is started on the same host, but
 it could be located elsewhere)::
 
-    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -no-user-config \
+    $ ./qemu-system-x86_64 -display none -no-user-config \
         -M q35 -nodefaults -m 512 \
         -blockdev node-name=node-TargetDisk,driver=qcow2,file.driver=file,file.node-name=file,file.filename=./target-disk.qcow2 \
         -device virtio-blk,drive=node-TargetDisk,id=virtio0 \
diff --git a/meson.build b/meson.build
index 33533f29f9..45d37357c8 100644
--- a/meson.build
+++ b/meson.build
@@ -211,10 +211,12 @@ brlapi = not_found
 if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
 endif
+sdlwindows = false
 sdl = not_found
 if 'CONFIG_SDL' in config_host
   sdl = declare_dependency(compile_args: config_host['SDL_CFLAGS'].split(),
                            link_args: config_host['SDL_LIBS'].split())
+  sdlwindows = config_host['SDL_LIBS'].contains('-mwindows')
 endif
 rbd = not_found
 if 'CONFIG_RBD' in config_host
@@ -525,6 +527,7 @@ user_ss = ss.source_set()
 bsd_user_ss = ss.source_set()
 linux_user_ss = ss.source_set()
 specific_ss = ss.source_set()
+specific_fuzz_ss = ss.source_set()
 
 modules = {}
 hw_arch = {}
@@ -739,6 +742,7 @@ specific_ss.add_all(when: 'CONFIG_LINUX_USER', if_true: linux_user_ss)
 
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
+subdir('tests/qtest/fuzz')
 
 mods = []
 block_mods = []
@@ -793,6 +797,9 @@ libqmp = static_library('qmp', qmp_ss.sources(),
 
 qmp = declare_dependency(link_whole: [libqmp])
 
+softmmu_ss.add(authz, block, chardev, crypto, io, qmp)
+common_ss.add(qom, qemuutil)
+
 foreach m : mods
   shared_module(m['dir'] + '-' + m['name'],
                 name_prefix: '',
@@ -801,7 +808,7 @@ foreach m : mods
                 install_dir: config_host['qemu_moddir'])
 endforeach
 
-common_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: softmmu_ss)
+common_ss.add_all(when: 'CONFIG_SOFTMMU', if_true: [softmmu_ss])
 common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 
 common_all = common_ss.apply(config_all, strict: false)
@@ -813,11 +820,17 @@ common_all = static_library('common',
 
 feature_to_c = find_program('scripts/feature_to_c.sh')
 
+emulators = []
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
   arch = config_target['TARGET_BASE_ARCH']
   arch_srcs = []
+  arch_deps = []
+  c_args = ['-DNEED_CPU_H',
+            '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
+            '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
+  link_args = []
 
   target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
   if host_machine.system() == 'linux'
@@ -828,12 +841,15 @@ foreach target : target_dirs
     target_type='system'
     t = target_softmmu_arch[arch].apply(config_target, strict: false)
     arch_srcs += t.sources()
+    arch_deps += t.dependencies()
 
     hw_dir = target_name == 'sparc64' ? 'sparc64' : arch
     hw = hw_arch[hw_dir].apply(config_target, strict: false)
     arch_srcs += hw.sources()
+    arch_deps += hw.dependencies()
 
     arch_srcs += config_devices_h[target]
+    link_args += ['@block.syms', '@qemu.syms']
   else
     abi = config_target['TARGET_ABI_DIR']
     target_type='user'
@@ -870,9 +886,11 @@ foreach target : target_dirs
 
   t = target_arch[arch].apply(config_target, strict: false)
   arch_srcs += t.sources()
+  arch_deps += t.dependencies()
 
   target_common = common_ss.apply(config_target, strict: false)
   objects = common_all.extract_objects(target_common.sources())
+  deps = target_common.dependencies()
 
   # TODO: Change to generator once obj-y goes away
   config_target_h = custom_target(target + '-config-target.h',
@@ -883,15 +901,60 @@ foreach target : target_dirs
 
   target_specific = specific_ss.apply(config_target, strict: false)
   arch_srcs += target_specific.sources()
+  arch_deps += target_specific.dependencies()
 
-  static_library('qemu-' + target,
+  lib = static_library('qemu-' + target,
                  sources: arch_srcs + [config_target_h] + genh,
                  objects: objects,
                  include_directories: target_inc,
-                 c_args: ['-DNEED_CPU_H',
-                          '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
-                          '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)],
+                 c_args: c_args,
+                 build_by_default: false,
                  name_suffix: 'fa')
+
+  if target.endswith('-softmmu')
+    execs = [{
+      'name': 'qemu-system-' + target_name,
+      'gui': false,
+      'sources': files('softmmu/main.c'),
+      'dependencies': []
+    }]
+    if sdlwindows
+      execs += [{
+        'name': 'qemu-system-' + target_name + 'w',
+        'gui': true,
+        'sources': files('softmmu/main.c'),
+        'dependencies': []
+      }]
+    endif
+    if config_host.has_key('CONFIG_FUZZ')
+      specific_fuzz = specific_fuzz_ss.apply(config_target, strict: false)
+      execs += [{
+        'name': 'qemu-fuzz-' + target_name,
+        'gui': false,
+        'sources': specific_fuzz.sources(),
+        'dependencies': specific_fuzz.dependencies(),
+        'link_depends': [files('tests/qtest/fuzz/fork_fuzz.ld')],
+      }]
+    endif
+  else
+    execs = [{
+      'name': 'qemu-' + target_name,
+      'gui': false,
+      'sources': [],
+      'dependencies': []
+    }]
+  endif
+  foreach exe: execs
+    emulators += executable(exe['name'], exe['sources'],
+               install: true,
+               c_args: c_args,
+               dependencies: arch_deps + deps + exe['dependencies'],
+               objects: lib.extract_all_objects(recursive: true),
+               link_language: 'cpp',
+               link_depends: [block_syms, qemu_syms] + exe.get('link_depends', []),
+               link_args: link_args,
+               gui_app: exe['gui'])
+  endforeach
 endforeach
 
 # Other build targets
diff --git a/os-posix.c b/os-posix.c
index 3572db3f44..8334193363 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -96,7 +96,7 @@ char *os_find_datadir(void)
     exec_dir = qemu_get_exec_dir();
     g_return_val_if_fail(exec_dir != NULL, NULL);
 
-    dir = g_build_filename(exec_dir, "..", "pc-bios", NULL);
+    dir = g_build_filename(exec_dir, "pc-bios", NULL);
     if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
         return g_steal_pointer(&dir);
     }
diff --git a/plugins/meson.build b/plugins/meson.build
index 9608e5293f..e77723010e 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -1,5 +1,13 @@
+if 'CONFIG_HAS_LD_DYNAMIC_LIST' in config_host
+  plugin_ldflags = ['-Wl,--dynamic-list=' + (meson.build_root() / 'qemu-plugins-ld.symbols')]
+elif 'CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST' in config_host
+  plugin_ldflags = ['-Wl,-exported_symbols_list,' + (meson.build_root() / 'qemu-plugins-ld64.symbols')]
+else
+  plugin_ldflags = []
+endif
+
 specific_ss.add(when: 'CONFIG_PLUGIN', if_true: [files(
   'loader.c',
   'core.c',
   'api.c',
-)])
+), declare_dependency(link_args: plugin_ldflags)])
diff --git a/rules.mak b/rules.mak
index 8285fe529a..6488dc3dc6 100644
--- a/rules.mak
+++ b/rules.mak
@@ -21,7 +21,6 @@ MAKEFLAGS += -rR
 %.cpp:
 %.m:
 %.mak:
-clean-target:
 
 # Flags for dependency generation
 QEMU_DGFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 305d0427af..866baf7058 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -383,7 +383,7 @@ def binariesToTest(args, testcase):
     if args.qemu:
         r = args.qemu
     else:
-        r = glob.glob('./*-softmmu/qemu-system-*')
+        r = glob.glob('./qemu-system-*')
     return r
 
 
diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index 52430cb620..f0b7442c96 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -64,24 +64,26 @@ mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
 
 # Build once to get the list of dynamic lib paths, and copy them over
 ../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
+    --prefix="$DEST_DIR" --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" \
     --extra-cflags="$EXTRA_CFLAGS" --target-list="i386-softmmu"
 
-if ! make "-j$(nproc)" i386-softmmu/fuzz; then
+if ! make "-j$(nproc)" qemu-fuzz-i386; then
     fatal "Build failed. Please specify a compiler with fuzzing support"\
           "using the \$CC and \$CXX environemnt variables"\
           "\nFor example: CC=clang CXX=clang++ $0"
 fi
 
-for i in $(ldd ./i386-softmmu/qemu-fuzz-i386 | cut -f3 -d' '); do
+for i in $(ldd ./qemu-fuzz-i386 | cut -f3 -d' '); do
     cp "$i" "$DEST_DIR/lib/"
 done
-rm ./i386-softmmu/qemu-fuzz-i386
+rm qemu-fuzz-i386
 
 # Build a second time to build the final binary with correct rpath
-../configure --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" --disable-werror \
-    --cc="$CC" --cxx="$CXX" --extra-cflags="$EXTRA_CFLAGS" \
-    --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'"
-make "-j$(nproc)" i386-softmmu/fuzz
+../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
+    --prefix="$DEST_DIR" --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" \
+    --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'" \
+    --target-list="i386-softmmu"
+make "-j$(nproc)" qemu-fuzz-i386 V=1
 
 # Copy over the datadir
 cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
@@ -90,9 +92,9 @@ cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
 # of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
 # to each available fuzz target (See 05509c8e6d fuzz: select fuzz target using
 # executable name)
-for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
+for target in $(./qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
 do
-    cp ./i386-softmmu/qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
+    cp qemu-fuzz-i386 "$DEST_DIR/qemu-fuzz-i386-target-$target"
 done
 
 echo "Done. The fuzzers are located in $DEST_DIR"
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
deleted file mode 100644
index ec74d8a9fa..0000000000
--- a/softmmu/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-softmmu-main-y = softmmu/main.o
-main.o-cflags := $(SDL_CFLAGS)
diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 27d248ef6e..d2a3315903 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -45,5 +45,18 @@ s390x_softmmu_ss.add(files(
   'sigp.c',
 ))
 
+# Newer kernels on s390 check for an S390_PGSTE program header and
+# enable the pgste page table extensions in that case. This makes
+# the vm.allocate_pgste sysctl unnecessary. We enable this program
+# header if
+#  - we build on s390x
+#  - we build the system emulation for s390x (qemu-system-s390x)
+#  - KVM is enabled
+#  - the linker supports --s390-pgste
+if host_machine.cpu_family() == 's390x' and cc.has_link_argument('-Wl,--s390-pgste')
+  s390x_softmmu_ss.add(when: 'CONFIG_KVM',
+                       if_true: declare_dependency(link_args: ['-Wl,--s390-pgste']))
+endif
+
 target_arch += {'s390x': s390x_ss}
 target_softmmu_arch += {'s390x': s390x_softmmu_ss}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index b6d96614cb..c3874cafd2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -457,7 +457,7 @@ build-tcg-tests-%: $(if $(CONFIG_PLUGIN),plugins)
 	       	V="$(V)" TARGET="$*" guest-tests, \
 		"BUILD", "TCG tests for $*")
 
-run-tcg-tests-%: build-tcg-tests-% %/all
+run-tcg-tests-%: build-tcg-tests-% all
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
 		SRC_PATH=$(SRC_PATH) SPEED="$(SPEED)" \
@@ -485,7 +485,7 @@ QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu
 .PHONY: check-tests/check-block.sh
 check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
 		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
-		$(patsubst %,%/all,$(filter %-softmmu,$(TARGET_DIRS)))
+		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
 	@$<
 
 # Python venv for running tests
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 77d1c1d9ff..db9c0f5d79 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -57,8 +57,7 @@ def pick_default_qemu_bin(arch=None):
     # qemu binary path does not match arch for powerpc, handle it
     if 'ppc64le' in arch:
         arch = 'ppc64'
-    qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
-                                          "qemu-system-%s" % arch)
+    qemu_bin_relative_path = "./qemu-system-%s" % arch
     if is_readable_executable_file(qemu_bin_relative_path):
         return qemu_bin_relative_path
 
diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index 76cd797d1e..fc78770544 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -12,7 +12,7 @@
 # This work is licensed under the terms of the GNU GPLv2.
 # See the COPYING.LIB file in the top-level directory.
 
-qemu_bins="x86_64-softmmu/qemu-system-x86_64 aarch64-softmmu/qemu-system-aarch64"
+qemu_bins="./qemu-system-x86_64 ./qemu-system-aarch64"
 
 if [ ! -e "tests/qtest/bios-tables-test" ]; then
     echo "Test: bios-tables-test is required! Run make check before this script."
diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
index 98df91e6af..f968bf797e 100755
--- a/tests/multiboot/run_test.sh
+++ b/tests/multiboot/run_test.sh
@@ -20,7 +20,7 @@
 # OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 # THE SOFTWARE.
 
-QEMU=${QEMU:-"../../x86_64-softmmu/qemu-system-x86_64"}
+QEMU=${QEMU:-"../../qemu-system-x86_64"}
 
 run_qemu() {
     local kernel=$1
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 0657f7286c..3ab859ac1a 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -577,11 +577,11 @@ if [ -z "$QEMU_PROG" ]
 then
     if [ -x "$build_iotests/qemu" ]; then
         export QEMU_PROG="$build_iotests/qemu"
-    elif [ -x "$build_root/${qemu_arch}-softmmu/qemu-system-${qemu_arch}" ]; then
-        export QEMU_PROG="$build_root/${qemu_arch}-softmmu/qemu-system-${qemu_arch}"
+    elif [ -x "$build_root/qemu-system-${qemu_arch}" ]; then
+        export QEMU_PROG="$build_root/qemu-system-${qemu_arch}"
     else
         pushd "$build_root" > /dev/null
-        for binary in *-softmmu/qemu-system-*
+        for binary in qemu-system-*
         do
             if [ -x "$binary" ]
             then
diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
deleted file mode 100644
index 5bde793bf2..0000000000
--- a/tests/qtest/fuzz/Makefile.include
+++ /dev/null
@@ -1,39 +0,0 @@
-QEMU_PROG_FUZZ=qemu-fuzz-$(TARGET_NAME)$(EXESUF)
-
-fuzz-obj-y += tests/qtest/libqtest.o
-fuzz-obj-y += $(libqos-obj-y)
-fuzz-obj-y += tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
-fuzz-obj-y += tests/qtest/fuzz/fork_fuzz.o
-fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
-fuzz-obj-y += tests/qtest/fuzz/qtest_wrappers.o
-
-# Targets
-fuzz-obj-$(CONFIG_PCI_I440FX) += tests/qtest/fuzz/i440fx_fuzz.o
-fuzz-obj-$(CONFIG_VIRTIO_NET) += tests/qtest/fuzz/virtio_net_fuzz.o
-fuzz-obj-$(CONFIG_SCSI) += tests/qtest/fuzz/virtio_scsi_fuzz.o
-
-FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
-
-# Linker Script to force coverage-counters into known regions which we can mark
-# shared
-FUZZ_LDFLAGS += -Xlinker -T$(SRC_PATH)/tests/qtest/fuzz/fork_fuzz.ld
-
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_inb
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_inw
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_inl
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_outb
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_outw
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_outl
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_readb
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_readw
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_readl
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_readq
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_writeb
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_writew
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_writel
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_writeq
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_memread
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_bufread
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_memwrite
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_bufwrite
-FUZZ_LDFLAGS += -Wl,-wrap,qtest_memset
diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index f45373f5d3..86796bff2b 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -17,8 +17,8 @@
 #include "tests/qtest/libqos/pci.h"
 #include "tests/qtest/libqos/pci-pc.h"
 #include "fuzz.h"
-#include "fuzz/qos_fuzz.h"
-#include "fuzz/fork_fuzz.h"
+#include "qos_fuzz.h"
+#include "fork_fuzz.h"
 
 
 #define I440FX_PCI_HOST_BRIDGE_CFG 0xcf8
diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
new file mode 100644
index 0000000000..bb0a3f271d
--- /dev/null
+++ b/tests/qtest/fuzz/meson.build
@@ -0,0 +1,35 @@
+specific_fuzz_ss.add(files('fuzz.c', 'fork_fuzz.c', 'qos_fuzz.c',
+                           'qtest_wrappers.c'), qos)
+
+# Targets
+specific_fuzz_ss.add(when: 'CONFIG_I440FX', if_true: files('i440fx_fuzz.c'))
+specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio_net_fuzz.c'))
+specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuzz.c'))
+
+# unfortunately declare_dependency does not support link_depends, so
+# this will be duplicated in meson.build
+fork_fuzz = declare_dependency(
+  link_args: ['-fsanitize=fuzzer',
+              '-Wl,-T,' + (meson.current_source_dir() / 'fork_fuzz.ld'),
+              '-Wl,-wrap,qtest_inb',
+              '-Wl,-wrap,qtest_inw',
+              '-Wl,-wrap,qtest_inl',
+              '-Wl,-wrap,qtest_outb',
+              '-Wl,-wrap,qtest_outw',
+              '-Wl,-wrap,qtest_outl',
+              '-Wl,-wrap,qtest_readb',
+              '-Wl,-wrap,qtest_readw',
+              '-Wl,-wrap,qtest_readl',
+              '-Wl,-wrap,qtest_readq',
+              '-Wl,-wrap,qtest_writeb',
+              '-Wl,-wrap,qtest_writew',
+              '-Wl,-wrap,qtest_writel',
+              '-Wl,-wrap,qtest_writeq',
+              '-Wl,-wrap,qtest_memread',
+              '-Wl,-wrap,qtest_bufread',
+              '-Wl,-wrap,qtest_memwrite',
+              '-Wl,-wrap,qtest_bufwrite',
+              '-Wl,-wrap,qtest_memset']
+)
+
+specific_fuzz_ss.add(fork_fuzz)
diff --git a/tests/qtest/fuzz/qtest_wrappers.c b/tests/qtest/fuzz/qtest_wrappers.c
index 713c830cdb..0580f8df86 100644
--- a/tests/qtest/fuzz/qtest_wrappers.c
+++ b/tests/qtest/fuzz/qtest_wrappers.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "hw/core/cpu.h"
 #include "exec/ioport.h"
 
 #include "fuzz.h"
diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
index 277a9e2b64..0e873ab8e2 100644
--- a/tests/qtest/fuzz/virtio_net_fuzz.c
+++ b/tests/qtest/fuzz/virtio_net_fuzz.c
@@ -61,7 +61,8 @@ static void virtio_net_fuzz_multi(QTestState *s,
          * backend. Otherwise, always place the input on a virtqueue.
          */
         if (vqa.rx && sockfds_initialized) {
-            write(sockfds[0], Data, vqa.length);
+            int ignored = write(sockfds[0], Data, vqa.length);
+            (void) ignored;
         } else {
             vqa.rx = 0;
             uint64_t req_addr = guest_alloc(t_alloc, vqa.length);
diff --git a/tests/qtest/fuzz/virtio_scsi_fuzz.c b/tests/qtest/fuzz/virtio_scsi_fuzz.c
index 3a9ea13736..6ff6fabe4a 100644
--- a/tests/qtest/fuzz/virtio_scsi_fuzz.c
+++ b/tests/qtest/fuzz/virtio_scsi_fuzz.c
@@ -12,10 +12,10 @@
 
 #include "qemu/osdep.h"
 
-#include "tests/qtest/libqtest.h"
-#include "libqos/virtio-scsi.h"
-#include "libqos/virtio.h"
-#include "libqos/virtio-pci.h"
+#include "tests/qtest/libqos/libqtest.h"
+#include "tests/qtest/libqos/virtio-scsi.h"
+#include "tests/qtest/libqos/virtio.h"
+#include "tests/qtest/libqos/virtio-pci.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "standard-headers/linux/virtio_scsi.h"
diff --git a/tests/qtest/libqos/qgraph.h b/tests/qtest/libqos/qgraph.h
index 10543269ce..5f63d352ca 100644
--- a/tests/qtest/libqos/qgraph.h
+++ b/tests/qtest/libqos/qgraph.h
@@ -226,7 +226,7 @@ typedef void *(*QOSBeforeTest) (GString *cmd_line, void *arg);
  *        my_test <--consumed_by-- my_interface <--produces--+
  *
  * Assuming there the binary is
- * QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
+ * QTEST_QEMU_BINARY=./qemu-system-x86_64
  * a valid test path will be:
  * "/x86_64/pc/other_node/my_driver/my_interface/my_test".
  *
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 30cb88d919..8f8fdb1336 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -234,7 +234,7 @@ foreach dir : target_dirs
   qtest_env = environment()
   qtest_env.set('QTEST_QEMU_IMG', './qemu-img')
   qtest_env.set('G_TEST_DBUS_DAEMON', meson.source_root() / 'tests/dbus-vmstate-daemon.sh')
-  qtest_env.set('QTEST_QEMU_BINARY', '@0@-softmmu/qemu-system-@0@'.format(target_base))
+  qtest_env.set('QTEST_QEMU_BINARY', './qemu-system-' + target_base)
   
   foreach test : qtests
     # Executables are shared across targets, declare them only the first time we
diff --git a/tests/qtest/rtas-test.c b/tests/qtest/rtas-test.c
index a7e83e7d40..16751dbd2f 100644
--- a/tests/qtest/rtas-test.c
+++ b/tests/qtest/rtas-test.c
@@ -31,7 +31,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     if (strcmp(arch, "ppc64")) {
-        g_printerr("RTAS requires ppc64-softmmu/qemu-system-ppc64\n");
+        g_printerr("RTAS requires qemu-system-ppc64\n");
         exit(EXIT_FAILURE);
     }
     qtest_add_func("rtas/get-time-of-day", test_rtas_get_time_of_day);
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 102578caa5..7d714f902a 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -193,11 +193,11 @@ for target in $target_list; do
   case $target in
     *-linux-user | *-bsd-user)
       echo "CONFIG_USER_ONLY=y" >> $config_target_mak
-      echo "QEMU=\$(BUILD_DIR)/$target/qemu-$arch" >> $config_target_mak
+      echo "QEMU=\$(BUILD_DIR)/qemu-$arch" >> $config_target_mak
       ;;
     *-softmmu)
       echo "CONFIG_SOFTMMU=y" >> $config_target_mak
-      echo "QEMU=\$(BUILD_DIR)/$target/qemu-system-$arch" >> $config_target_mak
+      echo "QEMU=\$(BUILD_DIR)/qemu-system-$arch" >> $config_target_mak
       ;;
   esac
 
-- 
2.26.2



