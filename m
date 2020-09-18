Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC499C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDA022208
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwkCACPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDA022208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNr6-0005YB-HH
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kJNIv-00034b-19
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kJNIs-0006RY-Ne
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600462102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fg4TsMMjf7HRn66+a8X8Q8KFOO8EknVqk/C/btKAjw=;
 b=RwkCACPdvTduOiz4kgNXl+cK6ZDqvaKzX1Q2rkLn8P6qOhBScURhv/QcSq/K7nj+wmeeYZ
 +rceAN/4ScD4rtmh8I89MU06t1bL0/ZPc3o3Er0dq4Va2zLe5UbkB//xVD0NIEfBasXT+5
 yqphJLVx2y7rNfguEfzDcvn5b/V7/RU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-QykwkBsFNUmYTrRFby1aFA-1; Fri, 18 Sep 2020 16:48:13 -0400
X-MC-Unique: QykwkBsFNUmYTrRFby1aFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E761510A7AE2;
 Fri, 18 Sep 2020 20:48:12 +0000 (UTC)
Received: from localhost (unknown [10.36.110.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6276E61177;
 Fri, 18 Sep 2020 20:48:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] meson: convert pc-bios/s390-ccw
Date: Sat, 19 Sep 2020 00:47:54 +0400
Message-Id: <20200918204759.225810-2-marcandre.lureau@redhat.com>
In-Reply-To: <20200918204759.225810-1-marcandre.lureau@redhat.com>
References: <20200918204759.225810-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Use a fake subproject: this is a simple workaround to avoid the
incompatible flags (such as gprof) that are set globally for the rest of
QEMU.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure                    |   2 -
 pc-bios/meson.build          |   4 +
 pc-bios/s390-ccw/Makefile    |  62 ------------
 pc-bios/s390-ccw/meson.build | 177 +++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/netboot.mak |  62 ------------
 subprojects/s390-ccw         |   1 +
 6 files changed, 182 insertions(+), 126 deletions(-)
 delete mode 100644 pc-bios/s390-ccw/Makefile
 create mode 100644 pc-bios/s390-ccw/meson.build
 delete mode 100644 pc-bios/s390-ccw/netboot.mak
 create mode 120000 subprojects/s390-ccw

diff --git a/configure b/configure
index 7564479008..3a8733c9be 100755
--- a/configure
+++ b/configure
@@ -6462,7 +6462,6 @@ fi
 if test "$cpu" = "s390x" ; then
   write_c_skeleton
   if compile_prog "-march=z900" ""; then
-    roms="$roms s390-ccw"
     # SLOF is required for building the s390-ccw firmware on s390x,
     # since it is using the libnet code from SLOF for network booting.
     if test -e "${source_path}/.git" ; then
@@ -7863,7 +7862,6 @@ LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target"
 LINKS="$LINKS pc-bios/optionrom/Makefile"
-LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS roms/seabios/Makefile"
 LINKS="$LINKS pc-bios/qemu-icon.bmp"
 LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index a0d21be432..e5139b3ef5 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -91,3 +91,7 @@ endif
 
 subdir('descriptors')
 subdir('keymaps')
+
+if host_machine.cpu_family() == 's390x' and cc.has_argument('-march=z900')
+  subproject('s390-ccw')
+endif
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
deleted file mode 100644
index 3eb785048a..0000000000
--- a/pc-bios/s390-ccw/Makefile
+++ /dev/null
@@ -1,62 +0,0 @@
-all: build-all
-# Dummy command so that make thinks it has done something
-	@true
-
-include ../../config-host.mak
-CFLAGS = -O2 -g
-
-quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
-cc-option = $(if $(shell $(CC) $1 -S -o /dev/null -xc /dev/null > /dev/null \
-	      2>&1 && echo OK), $1, $2)
-
-VPATH_SUFFIXES = %.c %.h %.S %.m %.mak %.sh %.rc Kconfig% %.json.in
-set-vpath = $(if $1,$(foreach PATTERN,$(VPATH_SUFFIXES),$(eval vpath $(PATTERN) $1)))
-$(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
-
-# Flags for dependency generation
-QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
-
-%.o: %.c
-	$(call quiet-command,$(CC) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
-	       -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-%.o: %.S
-	$(call quiet-command,$(CCAS) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
-	       -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
-
-.PHONY : all clean build-all
-
-OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
-	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o dasd-ipl.o
-
-QEMU_CFLAGS := -Wall $(filter -W%, $(QEMU_CFLAGS))
-QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
-QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
-QEMU_CFLAGS += -fno-asynchronous-unwind-tables
-QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
-LDFLAGS += -Wl,-pie -nostdlib
-
-build-all: s390-ccw.img s390-netboot.img
-
-s390-ccw.elf: $(OBJECTS)
-	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $(OBJECTS),"BUILD","$(TARGET_DIR)$@")
-
-STRIP ?= strip
-
-s390-ccw.img: s390-ccw.elf
-	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
-
-$(OBJECTS): Makefile
-
-ifneq ($(wildcard $(SRC_PATH)/roms/SLOF/lib/libnet),)
-include $(SRC_PATH)/pc-bios/s390-ccw/netboot.mak
-else
-s390-netboot.img:
-	@echo "s390-netboot.img not built since roms/SLOF/ is not available."
-endif
-
-ALL_OBJS = $(sort $(OBJECTS) $(NETOBJS) $(LIBCOBJS) $(LIBNETOBJS))
--include $(ALL_OBJS:%.o=%.d)
-
-clean:
-	rm -f *.o *.d *.img *.elf *~ *.a
diff --git a/pc-bios/s390-ccw/meson.build b/pc-bios/s390-ccw/meson.build
new file mode 100644
index 0000000000..0de5400287
--- /dev/null
+++ b/pc-bios/s390-ccw/meson.build
@@ -0,0 +1,177 @@
+project('s390-ccw')
+
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
diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
deleted file mode 100644
index 577c023afe..0000000000
--- a/pc-bios/s390-ccw/netboot.mak
+++ /dev/null
@@ -1,62 +0,0 @@
-
-SLOF_DIR := $(SRC_PATH)/roms/SLOF
-
-NETOBJS := start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netmain.o
-
-LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
-LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
-
-NETLDFLAGS := $(LDFLAGS) -Ttext=0x7800000
-
-$(NETOBJS): QEMU_CFLAGS += $(LIBC_INC) $(LIBNET_INC)
-
-s390-netboot.elf: $(NETOBJS) libnet.a libc.a
-	$(call quiet-command,$(CC) $(NETLDFLAGS) -o $@ $^,"BUILD","$(TARGET_DIR)$@")
-
-s390-netboot.img: s390-netboot.elf
-	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARGET_DIR)$@")
-
-# libc files:
-
-LIBC_CFLAGS = $(QEMU_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC) \
-	      -MMD -MP -MT $@ -MF $(@:%.o=%.d)
-
-CTYPE_OBJS = isdigit.o isxdigit.o toupper.o
-%.o : $(SLOF_DIR)/lib/libc/ctype/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-STRING_OBJS = strcat.o strchr.o strrchr.o strcpy.o strlen.o strncpy.o \
-	      strcmp.o strncmp.o strcasecmp.o strncasecmp.o strstr.o \
-	      memset.o memcpy.o memmove.o memcmp.o
-%.o : $(SLOF_DIR)/lib/libc/string/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-STDLIB_OBJS = atoi.o atol.o strtoul.o strtol.o rand.o malloc.o free.o
-%.o : $(SLOF_DIR)/lib/libc/stdlib/%.c
-	$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-STDIO_OBJS = sprintf.o snprintf.o vfprintf.o vsnprintf.o vsprintf.o fprintf.o \
-	     printf.o putc.o puts.o putchar.o stdchnls.o fileno.o
-%.o : $(SLOF_DIR)/lib/libc/stdio/%.c
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
-LIBNETCFLAGS = $(QEMU_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC) \
-	       -DDHCPARCH=0x1F -MMD -MP -MT $@ -MF $(@:%.o=%.d)
-
-%.o : $(SLOF_DIR)/lib/libnet/%.c
-	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-
-libnet.a: $(LIBNETOBJS)
-	$(call quiet-command,$(AR) -rc $@ $^,"AR","$(TARGET_DIR)$@")
diff --git a/subprojects/s390-ccw b/subprojects/s390-ccw
new file mode 120000
index 0000000000..8a3120224b
--- /dev/null
+++ b/subprojects/s390-ccw
@@ -0,0 +1 @@
+../pc-bios/s390-ccw
\ No newline at end of file
-- 
2.26.2


