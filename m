Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90B6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663FC2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHZ2MrnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663FC2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWRY-0001bX-Ca
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8z-0005TV-0R
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8u-0002Fd-Ki
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:20 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:38625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8t-00029W-Tb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:16 -0500
Received: by mail-wm1-x32f.google.com with SMTP id a9so3579023wmj.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RcQrNFggeNmlSs35dyilD6GwcAP8H/A33YAOTncSaG8=;
 b=aHZ2MrnGj0VATVtHQaNncfCddzIc1sN2obewnbBhTjN+PDBY1/hgOhDZTDFqbVKfWV
 aJFBgxZUDTtNFf9g4N01N8ynBcx8NR7UdjmHNxb5J971YAk8UQKNFwxqyePrGdpbbslf
 s/H0R1vsoL8JrdPVumvW1O+yA2HlFX9n0HHwlvm3Qm8vdSJ8Oe94mYm4SsjjNcVmKIGz
 jzTRUeFvC+e0lVzW2wqQipyXACWnXIzQKjCtGLUqZTQlEeLZAmRO0IKYTOZe7NUZrY4O
 rI6GlzxAvFWpLk5lj2DPtFfChBmd582HPjSIA7x4RmV9MFPqHF7h3GHXC1Iasg1S9Mkv
 fpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RcQrNFggeNmlSs35dyilD6GwcAP8H/A33YAOTncSaG8=;
 b=fiNJv5M5wRjJ+FVEN0JabedtMKSu4mjsINNn2/7gVXFyjJVltHsT6Wp7ndWZWSzqbg
 FVAtfWUs//nfiGc6ZPBV8xqRxlj310H4LMUZG9AjU45xjvaOcEgHxpewQNN9fXKOhgnC
 V1nY+xUuU34S2kQYlAE9p4DtFaWxl1Xfa2/oPR+H4FMtXwib6JHG5uiXyKmzJdOgRSxG
 86JnYPuJCInBOs2aFVljEuyqBIpn8daaItWmQeL/aV79KMA6oldq5qlf75p/QyqrgprG
 yKlTcaApdegSOv7eN01hEFWofQVJ50SjoAHrYEDxlWILYmIczpHN5mfR2UA4kVb87Nd9
 /Ztw==
X-Gm-Message-State: APjAAAVKsSS8JpP5vkmKVjm2P3Xfh2+i6wT9a4kLUi2YLMMTO2aPkRkM
 U7gQ7mSrJUyLUTCTYSxpckQ2s69U
X-Google-Smtp-Source: APXvYqwTAUJydZBeLZtxUNs+wgvFvMhu03FNMlPcXt61W/UF+zBMlg86vINin6awhBTfthuxjnAxqQ==
X-Received: by 2002:a1c:4e05:: with SMTP id g5mr6141221wmh.138.1580234349956; 
 Tue, 28 Jan 2020 09:59:09 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:59:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 136/142] meson: convert pc-bios/s390-ccw
Date: Tue, 28 Jan 2020 18:53:36 +0100
Message-Id: <20200128175342.9066-137-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
 configure                    |   8 --
 pc-bios/meson.build          |   5 +
 pc-bios/s390-ccw/Makefile    | 103 ---------------------
 pc-bios/s390-ccw/meson.build | 175 +++++++++++++++++++++++++++++++++++
 4 files changed, 180 insertions(+), 111 deletions(-)
 delete mode 100644 pc-bios/s390-ccw/Makefile
 create mode 100644 pc-bios/s390-ccw/meson.build

diff --git a/configure b/configure
index 089bff7c37..64d52fa589 100755
--- a/configure
+++ b/configure
@@ -6331,14 +6331,6 @@ if { test "$cpu" = "i386" || test "$cpu" = "x86_64"; } && \
     done
 fi
 
-# Only build s390-ccw bios if we're on s390x and the compiler has -march=z900
-if test "$cpu" = "s390x" ; then
-  write_c_skeleton
-  if compile_prog "-march=z900" ""; then
-    roms="$roms s390-ccw"
-  fi
-fi
-
 # Probe for the need for relocating the user-only binary.
 if ( [ "$linux_user" = yes ] || [ "$bsd_user" = yes ] ) && [ "$pie" = no ]; then
   textseg_addr=
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 62183506f7..013c75ce43 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -101,3 +101,8 @@ if dtc.found()
   endforeach
   alias_target('update-dtb', t)
 endif
+
+cc = meson.get_compiler('c')
+if host_machine.cpu_family() == 's390x' and cc.has_argument('-march=z900')
+  subdir('s390-ccw')
+endif
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
deleted file mode 100644
index b512074e3a..0000000000
--- a/pc-bios/s390-ccw/Makefile
+++ /dev/null
@@ -1,103 +0,0 @@
-CURRENT_MAKEFILE := $(realpath $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
-SRC_DIR := $(dir $(CURRENT_MAKEFILE))
-TOPSRC_DIR := $(SRC_DIR)/../..
-VPATH = $(SRC_DIR)
-
-all:
-# Dummy command so that make thinks it has done something
-	@true
-
-include ../../config-host.mak
-
-quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
-cc-option = $(if $(shell $(CC) $1 -S -o /dev/null -xc /dev/null >/dev/null 2>&1 && echo OK), $1, $2)
-
-override CFLAGS += $(filter -W%, $(QEMU_CFLAGS))
-override CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
-override CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
-override CFLAGS += -fno-asynchronous-unwind-tables
-override CFLAGS += $(call cc-option, -fno-stack-protector)
-LDFLAGS += -Wl,-pie -nostdlib
-
-OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
-	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o dasd-ipl.o
-
-STRIP ?= strip
-
-$(OBJECTS): Makefile
-
-SLOF_DIR := $(SRC_PATH)/roms/SLOF
-
-NETOBJS := start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netmain.o \
-	   libnet.a libc.a
-
-LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
-LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
-
-$(NETOBJS): QEMU_CFLAGS += $(LIBC_INC) $(LIBNET_INC)
-
-# libc files:
-
-LIBC_CFLAGS :=  $(QEMU_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC)
-
-CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
-$(CTYPE_OBJS) : %.o : $(SLOF_DIR)/lib/libc/ctype/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-STRING_OBJS = strcat.o strchr.o strrchr.o strcpy.o strlen.o strncpy.o \
-	      strcmp.o strncmp.o strcasecmp.o strncasecmp.o strstr.o \
-	      memset.o memcpy.o memmove.o memcmp.o
-$(STRING_OBJS) : %.o : $(SLOF_DIR)/lib/libc/string/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-STDLIB_OBJS = atoi.o atol.o strtoul.o strtol.o rand.o malloc.o free.o
-$(STDLIB_OBJS) : %.o : $(SLOF_DIR)/lib/libc/stdlib/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-STDIO_OBJS = sprintf.o snprintf.o vfprintf.o vsnprintf.o vsprintf.o fprintf.o \
-	     printf.o putc.o puts.o putchar.o stdchnls.o fileno.o
-$(STDIO_OBJS) : %.o : $(SLOF_DIR)/lib/libc/stdio/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-sbrk.o: $(SLOF_DIR)/slof/sbrk.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-LIBCOBJS := $(STRING_OBJS) $(CTYPE_OBJS) $(STDLIB_OBJS) $(STDIO_OBJS) sbrk.o
-
-libc.a: $(LIBCOBJS)
-	$(call quiet-command,$(AR) -rc $@ $^,"AR","$(TARGET_DIR)$@")
-
-# libnet files:
-
-LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
-	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o pxelinux.o
-LIBNETCFLAGS := $(CFLAGS) -DDHCPARCH=0x1F $(LIBC_INC) $(LIBNET_INC)
-
-$(LIBNETOBJS) : %.o : $(SLOF_DIR)/lib/libnet/%.c
-	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-libnet.a: $(LIBNETOBJS)
-	$(call quiet-command,$(AR) -rc $@ $^,"AR","$(TARGET_DIR)$@")
-
-%.elf:
-	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $^,"BUILD","$(TARGET_DIR)$@")
-
-%.img: %.elf
-	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
-
-s390-ccw.elf: $(OBJECTS)
-s390-ccw.img: s390-ccw.elf
-all: s390-ccw.img
-
-ifneq ($(wildcard $(SLOF_DIR)/lib/libnet),)
-s390-netboot.elf: $(NETOBJS)
-s390-netboot.elf: LDFLAGS += -Ttext=0x7800000
-
-s390-netboot.img: s390-netboot.elf
-all: s390-netboot.img
-endif
-
-clean:
-	rm -f *.o *.d *.img *.elf *~ *.a
-
-.PHONY : all clean
diff --git a/pc-bios/s390-ccw/meson.build b/pc-bios/s390-ccw/meson.build
new file mode 100644
index 0000000000..a4e0e3b7dd
--- /dev/null
+++ b/pc-bios/s390-ccw/meson.build
@@ -0,0 +1,175 @@
+strip = find_program('strip')
+cc = meson.get_compiler('c')
+link_args = ['-Wl,-pie', '-nostdlib']
+
+# FIXME: find a better way to check/enable slof
+slof = '../../roms/SLOF'
+has_slof = cc.has_header('libnet/tftp.h', args: '-I' + meson.current_source_dir() / slof / 'lib')
+
+s390_cargs = [
+  '-ffreestanding',
+  '-fno-delete-null-pointer-checks',
+  '-msoft-float',
+  '-march=z900',
+  '-fPIE',
+  '-fno-strict-aliasing',
+  '-fno-asynchronous-unwind-tables',
+  cc.get_supported_arguments('-fno-stack-protector')
+]
+
+s390_incs = []
+
+s390_srcs = [
+  'bootmap.c',
+  'cio.c',
+  'dasd-ipl.c',
+  'jump2ipl.c',
+  'libc.c',
+  'main.c',
+  'menu.c',
+  'sclp.c',
+  'start.S',
+  'virtio-blkdev.c',
+  'virtio-scsi.c',
+  'virtio.c',
+]
+
+if has_slof
+  s390_srcs += [
+    'netmain.c',
+    'virtio-net.c',
+  ]
+  s390_incs += include_directories(slof / 'lib/libnet')
+  s390_incs += include_directories(slof / 'lib/libc/include')
+  s390_cargs += '-nostdinc'
+endif
+
+s390_lib = static_library(
+  's390', s390_srcs,
+  c_args: s390_cargs,
+  include_directories: s390_incs,
+)
+
+s390_ccw_elf = executable(
+  's390-ccw.elf',
+  link_args: link_args,
+  objects: s390_lib.extract_objects([
+    'bootmap.c',
+    'cio.c',
+    'dasd-ipl.c',
+    'jump2ipl.c',
+    'libc.c',
+    'main.c',
+    'menu.c',
+    'sclp.c',
+    'start.S',
+    'virtio-blkdev.c',
+    'virtio-scsi.c',
+    'virtio.c',
+  ]),
+)
+
+custom_target(
+  's390-ccw.img',
+  output: 's390-ccw.img',
+  input: s390_ccw_elf,
+  command: [strip, '--strip-unneeded', '@INPUT@', '-o', '@OUTPUT@'],
+  build_by_default: true,
+)
+
+if has_slof
+  slof_ctype = slof / 'lib/libc/ctype'
+  slof_str = slof / 'lib/libc/string'
+  slof_stdlib = slof / 'lib/libc/stdlib'
+  slof_stdio = slof / 'lib/libc/stdio'
+
+  s390_libc = static_library(
+    's390-libc', files(
+      slof_ctype / 'isdigit.c',
+      slof_ctype / 'isxdigit.c',
+      slof_ctype / 'toupper.c',
+      slof_str / 'strcat.c',
+      slof_str / 'strchr.c',
+      slof_str / 'strrchr.c',
+      slof_str / 'strcpy.c',
+      slof_str / 'strlen.c',
+      slof_str / 'strncpy.c',
+      slof_str / 'strcmp.c',
+      slof_str / 'strncmp.c',
+      slof_str / 'strcasecmp.c',
+      slof_str / 'strncasecmp.c',
+      slof_str / 'strstr.c',
+      slof_str / 'memset.c',
+      slof_str / 'memcpy.c',
+      slof_str / 'memmove.c',
+      slof_str / 'memcmp.c',
+      slof_stdlib / 'atoi.c',
+      slof_stdlib / 'atol.c',
+      slof_stdlib / 'strtoul.c',
+      slof_stdlib / 'strtol.c',
+      slof_stdlib / 'rand.c',
+      slof_stdlib / 'malloc.c',
+      slof_stdlib / 'free.c',
+      slof_stdio / 'sprintf.c',
+      slof_stdio / 'snprintf.c',
+      slof_stdio / 'vfprintf.c',
+      slof_stdio / 'vsnprintf.c',
+      slof_stdio / 'vsprintf.c',
+      slof_stdio / 'fprintf.c',
+      slof_stdio / 'printf.c',
+      slof_stdio / 'putc.c',
+      slof_stdio / 'puts.c',
+      slof_stdio / 'putchar.c',
+      slof_stdio / 'stdchnls.c',
+      slof_stdio / 'fileno.c',
+      slof / 'slof/sbrk.c',
+    ),
+    c_args: s390_cargs,
+    include_directories: s390_incs,
+  )
+
+  slof_libnet = slof / 'lib/libnet'
+  s390_libnet = static_library(
+    's390-libnet', files(
+      slof_libnet / 'args.c',
+      slof_libnet / 'dhcp.c',
+      slof_libnet / 'dns.c',
+      slof_libnet / 'icmpv6.c',
+      slof_libnet / 'ipv6.c',
+      slof_libnet / 'tcp.c',
+      slof_libnet / 'udp.c',
+      slof_libnet / 'bootp.c',
+      slof_libnet / 'dhcpv6.c',
+      slof_libnet / 'ethernet.c',
+      slof_libnet / 'ipv4.c',
+      slof_libnet / 'ndp.c',
+      slof_libnet / 'tftp.c',
+      slof_libnet / 'pxelinux.c',
+    ),
+    c_args: [s390_cargs, '-DDHCPARCH=0x1F'],
+    include_directories: s390_incs,
+  )
+
+  s390_netboot_elf = executable(
+    's390-netboot.elf',
+    link_with: [s390_libc, s390_libnet],
+    link_args: [link_args, '-Ttext=0x7800000'],
+    objects: s390_lib.extract_objects([
+      'cio.c',
+      'jump2ipl.c',
+      'netmain.c',
+      'sclp.c',
+      'start.S',
+      'virtio-net.c',
+      'virtio.c',
+    ]),
+  )
+
+  custom_target(
+    's390-netboot.img',
+    output: 's390-netboot.img',
+    input: s390_netboot_elf,
+    command: [strip, '--strip-unneeded', '@INPUT@', '-o', '@OUTPUT@'],
+    build_by_default: true,
+  )
+endif
-- 
2.21.0



