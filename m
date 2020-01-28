Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A08C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D88214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPyQYAvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D88214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWd2-0008Tv-13
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8y-0005TX-W8
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8u-0002Fi-Km
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:20 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8t-0002Ag-Tm
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:16 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so3554506wmi.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qg0rqhelSxqHAuBbEP3yj5gLyfUEdSUsRIW3yTOCip8=;
 b=vPyQYAvHqJrc7PMBGuGrGfVzu8kaCfy3aq/eLjFBZpvuzNmAPzXW44twuTDqJ2P6PF
 HslNvet8wYX383JG1Ldto/dYIlSIK1iK9C1840MvtOOsJf9qP36IOsWN2kE/QZpECeK7
 z1n74uNC1m60VnaNeDbxoQaMQsilpyX9cR+I33CNYWhWLPhbtkPrMfjqyxw/jNlPVZdT
 8RhRU6fDMk76CtZkrCHl0N+1tNyu6XcDweIl0XNOANP65KM5RpIo1KYtMW264nag4euS
 CfFoRrF1xBfUF6IuWhGbmHIYsmqqD9jopMYbFsgCkknCWn6PqtIw83xh3cKIN6I6zF+L
 P0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Qg0rqhelSxqHAuBbEP3yj5gLyfUEdSUsRIW3yTOCip8=;
 b=DmHO86x+sDecqC1AjLpEkpLWfRC6d8v6PFT67ULOauR2p6BsYKpOYHMdiS89/xW9Bm
 iNUCtvHXZqH5CKcF5jESbO4HIPDsJHXwAFKngzi6iNjp6il1+CHRptatlK5bnqy/IHql
 FcvlPgXQL3/exA3+In2ViO26DT4+K2vV7T8FVK1dyVLEes170NLoWXoyeuHjSnCQGs/b
 RvrKDD5QlYl5ymQyyyTteK0lqcnU1gc87/6G6d8Lxz/spYIJAAfK+dbF5lOhmBdAPbuV
 viQ6Oesz1Q7qHYd8cRCdXDTE2qa8tNaKKLp8aB1zWTJfL0cLM97JuIvTA9ySEhjtcsVx
 uBjg==
X-Gm-Message-State: APjAAAUV4/tq4JNDLaHrcyeKZNJdaJauKQumaP7If/Zv5nGyWSJqaNft
 /4S1HwYiOeeMKpf9yf+2C2JyEGw/
X-Google-Smtp-Source: APXvYqwB4+H5/WC3t8VfddLyvhelDGnGPfu6sSBlTKf41ld252w21zNnR4q20gCaxjBM8leteLRLrg==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr6298440wml.171.1580234351951; 
 Tue, 28 Jan 2020 09:59:11 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:59:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 137/142] meson: convert pc-bios/optionrom
Date: Tue, 28 Jan 2020 18:53:37 +0100
Message-Id: <20200128175342.9066-138-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
---
 Makefile                      | 18 ++------
 configure                     | 20 +--------
 pc-bios/meson.build           |  4 ++
 pc-bios/optionrom/Makefile    | 77 -----------------------------------
 pc-bios/optionrom/meson.build | 72 ++++++++++++++++++++++++++++++++
 scripts/signrom.py            |  2 +
 6 files changed, 82 insertions(+), 111 deletions(-)
 delete mode 100644 pc-bios/optionrom/Makefile
 create mode 100644 pc-bios/optionrom/meson.build

diff --git a/Makefile b/Makefile
index 112bae68b2..e95042fa3d 100644
--- a/Makefile
+++ b/Makefile
@@ -112,8 +112,7 @@ generated-files-y += .git-submodule-status
 Makefile: ;
 configure: ;
 
-.PHONY: all clean cscope distclean install \
-	recurse-all dist msi FORCE
+.PHONY: all clean cscope distclean install dist msi FORCE
 
 $(call set-vpath, $(SRC_PATH))
 
@@ -127,7 +126,7 @@ endif
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: recurse-all modules
+all: modules
 
 DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_srcdir=$(SRC_PATH)/dtc/libfdt
 DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
@@ -170,20 +169,9 @@ subdir-dtc: dtc/all
 subdir-capstone: capstone/all
 subdir-slirp: slirp/all
 
-ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
-ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
-# Only keep -O and -g cflags
-.PHONY: $(ROM_DIRS_RULES)
-$(ROM_DIRS_RULES):
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))" $(notdir $@),)
-
-.PHONY: recurse-all recurse-clean
-recurse-all: $(ROM_DIRS)
-recurse-clean: $(addsuffix /clean, $(ROM_DIRS))
-
 ######################################################################
 
-clean: recurse-clean
+clean:
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f \
diff --git a/configure b/configure
index 64d52fa589..ef9640344c 100755
--- a/configure
+++ b/configure
@@ -6314,23 +6314,6 @@ if test "$guest_agent_msi" = "yes"; then
   esac
 fi
 
-# Mac OS X ships with a broken assembler
-roms=
-if { test "$cpu" = "i386" || test "$cpu" = "x86_64"; } && \
-        test "$targetos" != "Darwin" && test "$targetos" != "SunOS" && \
-        test "$softmmu" = yes ; then
-    # Different host OS linkers have different ideas about the name of the ELF
-    # emulation. Linux and OpenBSD/amd64 use 'elf_i386'; FreeBSD uses the _fbsd
-    # variant; OpenBSD/i386 uses the _obsd variant; and Windows uses i386pe.
-    for emu in elf_i386 elf_i386_fbsd elf_i386_obsd i386pe; do
-        if "$ld" -verbose 2>&1 | grep -q "^[[:space:]]*$emu[[:space:]]*$"; then
-            ld_i386_emulation="$emu"
-            roms="optionrom"
-            break
-        fi
-    done
-fi
-
 # Probe for the need for relocating the user-only binary.
 if ( [ "$linux_user" = yes ] || [ "$bsd_user" = yes ] ) && [ "$pie" = no ]; then
   textseg_addr=
@@ -7497,7 +7480,6 @@ else
 fi
 QEMU_INCLUDES="-iquote ${source_path}/tcg $QEMU_INCLUDES"
 
-echo "ROMS=$roms" >> $config_host_mak
 echo "MAKE=$make" >> $config_host_mak
 echo "INSTALL=$install" >> $config_host_mak
 echo "INSTALL_DIR=$install -d -m 0755" >> $config_host_mak
@@ -8024,7 +8006,7 @@ LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target tests/fp/Makefile"
 LINKS="$LINKS tests/plugin/Makefile"
-LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
+LINKS="$LINKS pc-bios/keymaps"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
 LINKS="$LINKS pc-bios/qemu-icon.bmp"
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 013c75ce43..ef062457a1 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -102,6 +102,10 @@ if dtc.found()
   alias_target('update-dtb', t)
 endif
 
+if host_machine.cpu_family() in ['x86', 'x86_64']
+  subdir('optionrom')
+endif
+
 cc = meson.get_compiler('c')
 if host_machine.cpu_family() == 's390x' and cc.has_argument('-march=z900')
   subdir('s390-ccw')
diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
deleted file mode 100644
index 51cb6ca9d8..0000000000
--- a/pc-bios/optionrom/Makefile
+++ /dev/null
@@ -1,77 +0,0 @@
-CURRENT_MAKEFILE := $(realpath $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
-SRC_DIR := $(dir $(CURRENT_MAKEFILE))
-TOPSRC_DIR := $(SRC_DIR)/../..
-VPATH = $(SRC_DIR)
-
-all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
-# Dummy command so that make thinks it has done something
-	@true
-
-include ../../config-host.mak
-
-quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
-cc-option = $(if $(shell $(CC) $1 -S -o /dev/null -xc /dev/null >/dev/null 2>&1 && echo OK), $1, $2)
-
-# Compiling with no optimization creates ROMs that are too large
-ifeq ($(lastword $(filter -O%, -O0 $(CFLAGS))),-O0)
-override CFLAGS += -O2
-endif
-override CFLAGS += -march=i486
-
-# Flags for dependency generation
-override CPPFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
-
-override CFLAGS += $(filter -W%, $(QEMU_CFLAGS))
-override CFLAGS += $(CFLAGS_NOPIE) -ffreestanding -I$(TOPSRC_DIR)/include
-override CFLAGS += $(call cc-option, -fno-stack-protector)
-override CFLAGS += $(call cc-option, -m16)
-
-ifeq ($(filter -m16, $(CFLAGS)),)
-# Attempt to work around compilers that lack -m16 (GCC <= 4.8, clang <= ??)
-# On GCC we add -fno-toplevel-reorder to keep the order of asm blocks with
-# respect to the rest of the code.  clang does not have -fno-toplevel-reorder,
-# but it places all asm blocks at the beginning and we're relying on it for
-# the option ROM header.  So just force clang not to use the integrated
-# assembler, which doesn't support .code16gcc.
-override CFLAGS += $(call cc-option, -fno-toplevel-reorder)
-override CFLAGS += $(call cc-option, -no-integrated-as)
-override CFLAGS += -m32 -include $(SRC_DIR)/code16gcc.h
-endif
-
-Wa = -Wa,
-override ASFLAGS += -32
-override CFLAGS += $(call cc-option, $(Wa)-32)
-
-
-LD_I386_EMULATION ?= elf_i386
-override LDFLAGS = -m $(LD_I386_EMULATION) -T $(SRC_DIR)/flat.lds
-override LDFLAGS += $(LDFLAGS_NOPIE)
-
-all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
-
-pvh.img: pvh.o pvh_main.o
-
-%.o: %.S
-	$(call quiet-command,$(CPP) $(CPPFLAGS) -c -o - $< | $(AS) $(ASFLAGS) -o $@,"AS","$@")
-
-%.o: %.c
-	$(call quiet-command,$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@,"CC","$@")
-
-%.img: %.o
-	$(call quiet-command,$(LD) $(LDFLAGS) -s -o $@ $^,"BUILD","$@")
-
-%.raw: %.img
-	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,"BUILD","$@")
-
-%.bin: %.raw
-	$(call quiet-command,$(PYTHON) $(TOPSRC_DIR)/scripts/signrom.py $< $@,"SIGN","$@")
-
-include $(wildcard *.d)
-
-clean:
-	rm -f *.o *.d *.raw *.img *.bin *~
-
-# suppress auto-removal of intermediate files
-.SECONDARY:
-
-.PHONY: all clean
diff --git a/pc-bios/optionrom/meson.build b/pc-bios/optionrom/meson.build
new file mode 100644
index 0000000000..5761736a68
--- /dev/null
+++ b/pc-bios/optionrom/meson.build
@@ -0,0 +1,72 @@
+cc = meson.get_compiler('c')
+objcopy = find_program('objcopy')
+signrom = find_program(meson.current_source_dir() / '../../scripts/signrom.py')
+
+emu = ''
+foreach e: ['elf_i386', 'elf_i386_fbsd', 'elf_i386_obsd', 'i386pe']
+  if cc.has_multi_link_arguments('-m32', '-Wl,-m' + e)
+    emu = e
+    break
+  endif
+endforeach
+
+if emu == ''
+  message('No suitable compiler/linker found to build optionrom')
+else
+  link_args = ['-nostdlib', '-m32', '-Wl,-m' + e]
+  link_args += cc.get_supported_link_arguments('-Wl,--build-id=none')
+  if cc.has_multi_link_arguments('-fno-pie', '-no-pie')
+    link_args += ['-no-pie']
+  endif
+
+  link_args += '-Wl,-T' + meson.current_source_dir() / 'flat.lds'
+
+  c_args = ['-ffreestanding', '-march=i486']
+  c_args += cc.get_supported_arguments('-fno-pie', '-fno-stack-protector', '-m32')
+
+  # Compiling with no optimization creates ROMs that are too large
+  code16_c_args = ['-O2']
+  if cc.has_argument('-m16')
+    code16_c_args += '-m16'
+  else
+    # Attempt to work around compilers that lack -m16 (GCC <= 4.8, clang <= ??)
+    # On GCC we add -fno-toplevel-reorder to keep the order of asm blocks with
+    # respect to the rest of the code.  clang does not have -fno-toplevel-reorder,
+    # but it places all asm blocks at the beginning and we're relying on it for
+    # the option ROM header.  So just force clang not to use the integrated
+    # assembler, which doesn't support .code16gcc.
+    code16_c_args += cc.get_supported_arguments('-fno-toplevel-reorder', '-no-integrated-as')
+    code16_c_args += ['-m32', '-include', meson.current_source_dir() / 'code16gcc.h']
+  endif
+
+  foreach target, opt: {
+    'multiboot': {'src': ['multiboot.S'], 'cargs': ['-m32', '-g0']},
+    'linuxboot_dma': {'src': ['linuxboot_dma.c'], 'cargs': code16_c_args},
+    'linuxboot': {'src': ['linuxboot.S']},
+    'kvmvapic': {'src': ['kvmvapic.S']},
+    'pvh': {'src': ['pvh.S', 'pvh_main.c']},
+   }
+    img = executable(
+      target + '.img',
+      opt['src'],
+      c_args: [c_args, opt.get('cargs', [])],
+      include_directories: include_directories('../../include'),
+      link_args: link_args,
+    )
+
+    raw = custom_target(
+      target + '.raw',
+      output: target + '.raw',
+      input: img,
+      command: [objcopy, '-O', 'binary', '-j', '.text', '@INPUT@', '@OUTPUT@'],
+    )
+
+    bin = custom_target(
+      target + '.bin',
+      output: target + '.bin',
+      input: raw,
+      command: [signrom, '@INPUT@', '@OUTPUT@'],
+      build_by_default: true,
+    )
+  endforeach
+endif
diff --git a/scripts/signrom.py b/scripts/signrom.py
index 313ee28a17..ba9ac0350e 100644
--- a/scripts/signrom.py
+++ b/scripts/signrom.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python
+
 from __future__ import print_function
 #
 # Option ROM signing utility
-- 
2.21.0



