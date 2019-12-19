Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977CDC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52921227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SH6X7FpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52921227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvBq-0002NX-TB
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihusX-00013B-1f
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihusT-0003dF-Hq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:26:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihusS-0003bG-T5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4VG0A2LeMVyZ2tnEceHhryyGS+Rkr3VA6D1UZnTY4Q=;
 b=SH6X7FpIRt6y9Uq7F3oZqrgQfdjmhqGq/9+/IOMURPt7stIdKvZkAWF8t9Yf8S2PLqomep
 9g4sctPRMLlBqQHjL+YyBFL3I4WC2gqrqN7JUd3vb+c4/oqD6ljgYaaopoY7ujNd2uRsbk
 6VRZdgaV/86f/qOy6PNw8BGx4cMKkFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-uH7uqXlPOtqb1jvAzGBApQ-1; Thu, 19 Dec 2019 07:25:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C61F477
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:49 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD3BD60C18;
 Thu, 19 Dec 2019 12:25:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 131/132] meson: convert pc-bios/optionrom
Date: Thu, 19 Dec 2019 13:23:51 +0100
Message-Id: <1576758232-12439-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uH7uqXlPOtqb1jvAzGBApQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile                      | 12 -------
 configure                     | 20 +----------
 pc-bios/meson.build           |  4 +++
 pc-bios/optionrom/Makefile    | 77 ---------------------------------------=
----
 pc-bios/optionrom/meson.build | 72 +++++++++++++++++++++++++++++++++++++++=
+
 scripts/signrom.py            |  2 ++
 6 files changed, 79 insertions(+), 108 deletions(-)
 delete mode 100644 pc-bios/optionrom/Makefile
 create mode 100644 pc-bios/optionrom/meson.build

diff --git a/Makefile b/Makefile
index 0493a3b..1bc219a 100644
--- a/Makefile
+++ b/Makefile
@@ -158,18 +158,6 @@ subdir-dtc: dtc/all
 subdir-capstone: capstone/all
 subdir-slirp: slirp/all
=20
-ROM_DIRS =3D $(addprefix pc-bios/, $(ROMS))
-ROM_DIRS_RULES=3D$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
-# Only keep -O and -g cflags
-.PHONY: $(ROM_DIRS_RULES)
-$(ROM_DIRS_RULES):
-=09$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$(V)=
" TARGET_DIR=3D"$(dir $@)" CFLAGS=3D"$(filter -O% -g%,$(CFLAGS))" $(notdir =
$@),)
-
-.PHONY: recurse-all recurse-clean recurse-install
-recurse-all: $(ROM_DIRS)
-recurse-clean: $(addsuffix /clean, $(ROM_DIRS))
-recurse-install:
-
 ######################################################################
=20
 COMMON_LDADDS =3D libqemuutil.a
diff --git a/configure b/configure
index a1b71b9..9d4974e 100755
--- a/configure
+++ b/configure
@@ -6156,23 +6156,6 @@ if test "$guest_agent_msi" =3D "yes"; then
   esac
 fi
=20
-# Mac OS X ships with a broken assembler
-roms=3D
-if { test "$cpu" =3D "i386" || test "$cpu" =3D "x86_64"; } && \
-        test "$targetos" !=3D "Darwin" && test "$targetos" !=3D "SunOS" &&=
 \
-        test "$softmmu" =3D yes ; then
-    # Different host OS linkers have different ideas about the name of the=
 ELF
-    # emulation. Linux and OpenBSD/amd64 use 'elf_i386'; FreeBSD uses the =
_fbsd
-    # variant; OpenBSD/i386 uses the _obsd variant; and Windows uses i386p=
e.
-    for emu in elf_i386 elf_i386_fbsd elf_i386_obsd i386pe; do
-        if "$ld" -verbose 2>&1 | grep -q "^[[:space:]]*$emu[[:space:]]*$";=
 then
-            ld_i386_emulation=3D"$emu"
-            roms=3D"optionrom"
-            break
-        fi
-    done
-fi
-
 # Probe for the need for relocating the user-only binary.
 if ( [ "$linux_user" =3D yes ] || [ "$bsd_user" =3D yes ] ) && [ "$pie" =
=3D no ]; then
   textseg_addr=3D
@@ -7302,7 +7285,6 @@ else
 fi
 QEMU_INCLUDES=3D"-iquote ${source_path}/tcg $QEMU_INCLUDES"
=20
-echo "ROMS=3D$roms" >> $config_host_mak
 echo "MAKE=3D$make" >> $config_host_mak
 echo "INSTALL=3D$install" >> $config_host_mak
 echo "INSTALL_DIR=3D$install -d -m 0755" >> $config_host_mak
@@ -7824,7 +7806,7 @@ DIRS=3D"$DIRS roms/seabios roms/vgabios"
 LINKS=3D"Makefile"
 LINKS=3D"$LINKS tests/tcg/lm32/Makefile po/Makefile"
 LINKS=3D"$LINKS tests/tcg/Makefile.target tests/fp/Makefile"
-LINKS=3D"$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
+LINKS=3D"$LINKS pc-bios/keymaps"
 LINKS=3D"$LINKS pc-bios/s390-ccw/Makefile"
 LINKS=3D"$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
 LINKS=3D"$LINKS pc-bios/qemu-icon.bmp"
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 1697c55..ff1eebf 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -100,6 +100,10 @@ if dtc.found()
   alias_target('update-dtb', t)
 endif
=20
+if host_machine.cpu_family() in ['x86', 'x86_64']
+  subdir('optionrom')
+endif
+
 cc =3D meson.get_compiler('c')
 if host_machine.cpu_family() =3D=3D 's390x' and cc.has_argument('-march=3D=
z900')
   subdir('s390-ccw')
diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
deleted file mode 100644
index 51cb6ca..0000000
--- a/pc-bios/optionrom/Makefile
+++ /dev/null
@@ -1,77 +0,0 @@
-CURRENT_MAKEFILE :=3D $(realpath $(word $(words $(MAKEFILE_LIST)),$(MAKEFI=
LE_LIST)))
-SRC_DIR :=3D $(dir $(CURRENT_MAKEFILE))
-TOPSRC_DIR :=3D $(SRC_DIR)/../..
-VPATH =3D $(SRC_DIR)
-
-all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
-# Dummy command so that make thinks it has done something
-=09@true
-
-include ../../config-host.mak
-
-quiet-command =3D $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1=
, @$1))
-cc-option =3D $(if $(shell $(CC) $1 -S -o /dev/null -xc /dev/null >/dev/nu=
ll 2>&1 && echo OK), $1, $2)
-
-# Compiling with no optimization creates ROMs that are too large
-ifeq ($(lastword $(filter -O%, -O0 $(CFLAGS))),-O0)
-override CFLAGS +=3D -O2
-endif
-override CFLAGS +=3D -march=3Di486
-
-# Flags for dependency generation
-override CPPFLAGS +=3D -MMD -MP -MT $@ -MF $(@D)/$(*F).d
-
-override CFLAGS +=3D $(filter -W%, $(QEMU_CFLAGS))
-override CFLAGS +=3D $(CFLAGS_NOPIE) -ffreestanding -I$(TOPSRC_DIR)/includ=
e
-override CFLAGS +=3D $(call cc-option, -fno-stack-protector)
-override CFLAGS +=3D $(call cc-option, -m16)
-
-ifeq ($(filter -m16, $(CFLAGS)),)
-# Attempt to work around compilers that lack -m16 (GCC <=3D 4.8, clang <=
=3D ??)
-# On GCC we add -fno-toplevel-reorder to keep the order of asm blocks with
-# respect to the rest of the code.  clang does not have -fno-toplevel-reor=
der,
-# but it places all asm blocks at the beginning and we're relying on it fo=
r
-# the option ROM header.  So just force clang not to use the integrated
-# assembler, which doesn't support .code16gcc.
-override CFLAGS +=3D $(call cc-option, -fno-toplevel-reorder)
-override CFLAGS +=3D $(call cc-option, -no-integrated-as)
-override CFLAGS +=3D -m32 -include $(SRC_DIR)/code16gcc.h
-endif
-
-Wa =3D -Wa,
-override ASFLAGS +=3D -32
-override CFLAGS +=3D $(call cc-option, $(Wa)-32)
-
-
-LD_I386_EMULATION ?=3D elf_i386
-override LDFLAGS =3D -m $(LD_I386_EMULATION) -T $(SRC_DIR)/flat.lds
-override LDFLAGS +=3D $(LDFLAGS_NOPIE)
-
-all: multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
-
-pvh.img: pvh.o pvh_main.o
-
-%.o: %.S
-=09$(call quiet-command,$(CPP) $(CPPFLAGS) -c -o - $< | $(AS) $(ASFLAGS) -=
o $@,"AS","$@")
-
-%.o: %.c
-=09$(call quiet-command,$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@,"CC","$@")
-
-%.img: %.o
-=09$(call quiet-command,$(LD) $(LDFLAGS) -s -o $@ $^,"BUILD","$@")
-
-%.raw: %.img
-=09$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,"BUILD","$@")
-
-%.bin: %.raw
-=09$(call quiet-command,$(PYTHON) $(TOPSRC_DIR)/scripts/signrom.py $< $@,"=
SIGN","$@")
-
-include $(wildcard *.d)
-
-clean:
-=09rm -f *.o *.d *.raw *.img *.bin *~
-
-# suppress auto-removal of intermediate files
-.SECONDARY:
-
-.PHONY: all clean
diff --git a/pc-bios/optionrom/meson.build b/pc-bios/optionrom/meson.build
new file mode 100644
index 0000000..5761736
--- /dev/null
+++ b/pc-bios/optionrom/meson.build
@@ -0,0 +1,72 @@
+cc =3D meson.get_compiler('c')
+objcopy =3D find_program('objcopy')
+signrom =3D find_program(meson.current_source_dir() / '../../scripts/signr=
om.py')
+
+emu =3D ''
+foreach e: ['elf_i386', 'elf_i386_fbsd', 'elf_i386_obsd', 'i386pe']
+  if cc.has_multi_link_arguments('-m32', '-Wl,-m' + e)
+    emu =3D e
+    break
+  endif
+endforeach
+
+if emu =3D=3D ''
+  message('No suitable compiler/linker found to build optionrom')
+else
+  link_args =3D ['-nostdlib', '-m32', '-Wl,-m' + e]
+  link_args +=3D cc.get_supported_link_arguments('-Wl,--build-id=3Dnone')
+  if cc.has_multi_link_arguments('-fno-pie', '-no-pie')
+    link_args +=3D ['-no-pie']
+  endif
+
+  link_args +=3D '-Wl,-T' + meson.current_source_dir() / 'flat.lds'
+
+  c_args =3D ['-ffreestanding', '-march=3Di486']
+  c_args +=3D cc.get_supported_arguments('-fno-pie', '-fno-stack-protector=
', '-m32')
+
+  # Compiling with no optimization creates ROMs that are too large
+  code16_c_args =3D ['-O2']
+  if cc.has_argument('-m16')
+    code16_c_args +=3D '-m16'
+  else
+    # Attempt to work around compilers that lack -m16 (GCC <=3D 4.8, clang=
 <=3D ??)
+    # On GCC we add -fno-toplevel-reorder to keep the order of asm blocks =
with
+    # respect to the rest of the code.  clang does not have -fno-toplevel-=
reorder,
+    # but it places all asm blocks at the beginning and we're relying on i=
t for
+    # the option ROM header.  So just force clang not to use the integrate=
d
+    # assembler, which doesn't support .code16gcc.
+    code16_c_args +=3D cc.get_supported_arguments('-fno-toplevel-reorder',=
 '-no-integrated-as')
+    code16_c_args +=3D ['-m32', '-include', meson.current_source_dir() / '=
code16gcc.h']
+  endif
+
+  foreach target, opt: {
+    'multiboot': {'src': ['multiboot.S'], 'cargs': ['-m32', '-g0']},
+    'linuxboot_dma': {'src': ['linuxboot_dma.c'], 'cargs': code16_c_args},
+    'linuxboot': {'src': ['linuxboot.S']},
+    'kvmvapic': {'src': ['kvmvapic.S']},
+    'pvh': {'src': ['pvh.S', 'pvh_main.c']},
+   }
+    img =3D executable(
+      target + '.img',
+      opt['src'],
+      c_args: [c_args, opt.get('cargs', [])],
+      include_directories: include_directories('../../include'),
+      link_args: link_args,
+    )
+
+    raw =3D custom_target(
+      target + '.raw',
+      output: target + '.raw',
+      input: img,
+      command: [objcopy, '-O', 'binary', '-j', '.text', '@INPUT@', '@OUTPU=
T@'],
+    )
+
+    bin =3D custom_target(
+      target + '.bin',
+      output: target + '.bin',
+      input: raw,
+      command: [signrom, '@INPUT@', '@OUTPUT@'],
+      build_by_default: true,
+    )
+  endforeach
+endif
diff --git a/scripts/signrom.py b/scripts/signrom.py
index 313ee28..ba9ac03 100644
--- a/scripts/signrom.py
+++ b/scripts/signrom.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python
+
 from __future__ import print_function
 #
 # Option ROM signing utility
--=20
1.8.3.1



