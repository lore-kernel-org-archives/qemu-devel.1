Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937C9C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115C822208
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BV+FDtsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115C822208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNnY-0003Ih-3L
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kJNJ5-0003BD-JK
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kJNJ3-0006TF-87
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600462111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rg1vUGg+NQh0UsEWhYotEM8dC8ClGTsLqERdGE5uJ44=;
 b=BV+FDtsuzKQ9i8hEUAwU/nIZVVeeEkOnuwuzQGheAdBoGUJynlSS3go8NO92ZovwURacS6
 phL1vrrI8HjZGKu0vRMT/tmce6cOc7jzHTekEPgTKINgGmAhCl642HXFw1+sG7pHUUhvcG
 zncN1Tf+nOupb0BWt3SBt/8MffI8n2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-Men7KVHGPbOIGiijL_DFUw-1; Fri, 18 Sep 2020 16:48:27 -0400
X-MC-Unique: Men7KVHGPbOIGiijL_DFUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4AC618BA288;
 Fri, 18 Sep 2020 20:48:26 +0000 (UTC)
Received: from localhost (unknown [10.36.110.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE17510013C1;
 Fri, 18 Sep 2020 20:48:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] meson: convert pc-bios/optionrom
Date: Sat, 19 Sep 2020 00:47:56 +0400
Message-Id: <20200918204759.225810-4-marcandre.lureau@redhat.com>
In-Reply-To: <20200918204759.225810-1-marcandre.lureau@redhat.com>
References: <20200918204759.225810-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Checking for linker emulation is a bit tricky with meson, since it
actually tries to compile a file with a main().

I didn't bother to port the Darwin or SunOS check, as they are
quite old, and not very specific to the compiler version/issue, so they
might be outdated.

Use a subproject: this is a simple workaround to avoid the incompatible
flags (such as gprof) that are set globally for the rest of QEMU.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure                     | 16 --------
 pc-bios/meson.build           |  4 ++
 pc-bios/optionrom/Makefile    | 73 -----------------------------------
 pc-bios/optionrom/meson.build | 73 +++++++++++++++++++++++++++++++++++
 subprojects/optionrom         |  1 +
 5 files changed, 78 insertions(+), 89 deletions(-)
 delete mode 100644 pc-bios/optionrom/Makefile
 create mode 100644 pc-bios/optionrom/meson.build
 create mode 120000 subprojects/optionrom

diff --git a/configure b/configure
index 3a8733c9be..4e56edc70c 100755
--- a/configure
+++ b/configure
@@ -6441,22 +6441,7 @@ if test "$guest_agent_msi" = "yes"; then
   esac
 fi
 
-# Mac OS X ships with a broken assembler
 roms=
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
 
 # Only build s390-ccw bios if we're on s390x and the compiler has -march=z900
 if test "$cpu" = "s390x" ; then
@@ -7861,7 +7846,6 @@ DIRS="$DIRS contrib/plugins/"
 LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target"
-LINKS="$LINKS pc-bios/optionrom/Makefile"
 LINKS="$LINKS roms/seabios/Makefile"
 LINKS="$LINKS pc-bios/qemu-icon.bmp"
 LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index e5139b3ef5..d25585ca97 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -92,6 +92,10 @@ endif
 subdir('descriptors')
 subdir('keymaps')
 
+if host_machine.cpu_family() in ['x86', 'x86_64']
+  subproject('optionrom')
+endif
+
 if host_machine.cpu_family() == 's390x' and cc.has_argument('-march=z900')
   subproject('s390-ccw')
 endif
diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
deleted file mode 100644
index 084fc10f05..0000000000
--- a/pc-bios/optionrom/Makefile
+++ /dev/null
@@ -1,73 +0,0 @@
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
-CFLAGS = -O2 -g
-
-quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
-cc-option = $(if $(shell $(CC) $1 -c -o /dev/null -xc /dev/null >/dev/null 2>&1 && echo OK), $1, $2)
-
-override CFLAGS += -march=i486 -Wall
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
index 0000000000..7d5314cd80
--- /dev/null
+++ b/pc-bios/optionrom/meson.build
@@ -0,0 +1,73 @@
+project('optionrom')
+
+cc = meson.get_compiler('c')
+objcopy = find_program('objcopy')
+signrom = find_program(meson.current_source_dir() / '../../scripts/signrom.py')
+
+emu = ''
+foreach e: ['elf_i386', 'elf_i386_fbsd', 'elf_i386_obsd', 'i386pe']
+  if cc.has_multi_link_arguments('-nostdlib', '-Wl,-emain', '-m32', '-Wl,-m' + e)
+    emu = e
+    break
+  endif
+endforeach
+
+if emu == ''
+  message('No suitable compiler/linker found to build optionrom')
+  subdir_done()
+endif
+
+link_args = ['-nostdlib', '-m32', '-Wl,-m' + e]
+link_args += cc.get_supported_link_arguments('-Wl,--build-id=none')
+if cc.has_multi_link_arguments('-fno-pie', '-no-pie')
+  link_args += ['-no-pie']
+endif
+
+link_args += '-Wl,-T' + meson.current_source_dir() / 'flat.lds'
+
+c_args = ['-O2', '-ffreestanding', '-march=i486']
+c_args += cc.get_supported_arguments('-fno-pie', '-fno-stack-protector', '-Wa,-32')
+if cc.has_argument('-m16')
+  c_args += '-m16'
+else
+  # Attempt to work around compilers that lack -m16 (GCC <= 4.8, clang <= ??)
+  # On GCC we add -fno-toplevel-reorder to keep the order of asm blocks with
+  # respect to the rest of the code.  clang does not have -fno-toplevel-reorder,
+  # but it places all asm blocks at the beginning and we're relying on it for
+  # the option ROM header.  So just force clang not to use the integrated
+  # assembler, which doesn't support .code16gcc.
+  c_args += cc.get_supported_arguments('-fno-toplevel-reorder', '-no-integrated-as')
+  c_args += ['-m32', '-include', meson.current_source_dir() / 'code16gcc.h']
+endif
+
+foreach target, src: {
+  'multiboot': ['multiboot.S'],
+  'linuxboot_dma': ['linuxboot_dma.c'],
+  'linuxboot': ['linuxboot.S'],
+  'kvmvapic': ['kvmvapic.S'],
+  'pvh': ['pvh.S', 'pvh_main.c'],
+ }
+  img = executable(
+    target + '.img',
+    src,
+    c_args: c_args,
+    include_directories: include_directories('../../include'),
+    link_args: link_args,
+    override_options: ['b_coverage=false'],
+  )
+
+  raw = custom_target(
+    target + '.raw',
+    output: target + '.raw',
+    input: img,
+    command: [objcopy, '-O', 'binary', '-j', '.text', '@INPUT@', '@OUTPUT@'],
+  )
+
+  bin = custom_target(
+    target + '.bin',
+    output: target + '.bin',
+    input: raw,
+    command: [signrom, '@INPUT@', '@OUTPUT@'],
+    build_by_default: true,
+  )
+endforeach
diff --git a/subprojects/optionrom b/subprojects/optionrom
new file mode 120000
index 0000000000..0bd7ed1798
--- /dev/null
+++ b/subprojects/optionrom
@@ -0,0 +1 @@
+../pc-bios/optionrom
\ No newline at end of file
-- 
2.26.2


