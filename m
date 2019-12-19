Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4782BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0335A24650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UV43Lyde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0335A24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvRn-0007vr-Hf
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihusR-000114-70
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihusO-0003Wc-Na
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihusO-0003UM-AR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iU9ljBKf9gxVwbpcHOGcW99UWNhyv6Vn2rEiVL5EXUs=;
 b=UV43LydeaWnccfztX//6jVKl1YQEEwpVttFzeHIlnd7Ykd+YF15AdCPIMogWXbYrfaft2l
 epeqIrYft4Q1NBv4LQK8iJMscEsi3+fp5h5+/ZgR+irtSZiJ3iLxzPgFQ92xGKTYxwrpg0
 YZ1Q7Zr790gVQ+GH5pNZ8KZ8jnU2IFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-SOusPYY-NMmQDA9U-CN5JA-1; Thu, 19 Dec 2019 07:25:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 529551005502
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:45 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B53C060C18;
 Thu, 19 Dec 2019 12:25:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 130/132] meson: convert pc-bios/s390-ccw
Date: Thu, 19 Dec 2019 13:23:50 +0100
Message-Id: <1576758232-12439-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: SOusPYY-NMmQDA9U-CN5JA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 configure                    |   8 --
 pc-bios/meson.build          |   5 ++
 pc-bios/s390-ccw/Makefile    | 103 -------------------------
 pc-bios/s390-ccw/meson.build | 175 +++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 180 insertions(+), 111 deletions(-)
 delete mode 100644 pc-bios/s390-ccw/Makefile
 create mode 100644 pc-bios/s390-ccw/meson.build

diff --git a/configure b/configure
index f6e3b0a..a1b71b9 100755
--- a/configure
+++ b/configure
@@ -6173,14 +6173,6 @@ if { test "$cpu" =3D "i386" || test "$cpu" =3D "x86_=
64"; } && \
     done
 fi
=20
-# Only build s390-ccw bios if we're on s390x and the compiler has -march=
=3Dz900
-if test "$cpu" =3D "s390x" ; then
-  write_c_skeleton
-  if compile_prog "-march=3Dz900" ""; then
-    roms=3D"$roms s390-ccw"
-  fi
-fi
-
 # Probe for the need for relocating the user-only binary.
 if ( [ "$linux_user" =3D yes ] || [ "$bsd_user" =3D yes ] ) && [ "$pie" =
=3D no ]; then
   textseg_addr=3D
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index def68a4..1697c55 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -99,3 +99,8 @@ if dtc.found()
   endforeach
   alias_target('update-dtb', t)
 endif
+
+cc =3D meson.get_compiler('c')
+if host_machine.cpu_family() =3D=3D 's390x' and cc.has_argument('-march=3D=
z900')
+  subdir('s390-ccw')
+endif
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
deleted file mode 100644
index b512074..0000000
--- a/pc-bios/s390-ccw/Makefile
+++ /dev/null
@@ -1,103 +0,0 @@
-CURRENT_MAKEFILE :=3D $(realpath $(word $(words $(MAKEFILE_LIST)),$(MAKEFI=
LE_LIST)))
-SRC_DIR :=3D $(dir $(CURRENT_MAKEFILE))
-TOPSRC_DIR :=3D $(SRC_DIR)/../..
-VPATH =3D $(SRC_DIR)
-
-all:
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
-override CFLAGS +=3D $(filter -W%, $(QEMU_CFLAGS))
-override CFLAGS +=3D -ffreestanding -fno-delete-null-pointer-checks -msoft=
-float
-override CFLAGS +=3D -march=3Dz900 -fPIE -fno-strict-aliasing
-override CFLAGS +=3D -fno-asynchronous-unwind-tables
-override CFLAGS +=3D $(call cc-option, -fno-stack-protector)
-LDFLAGS +=3D -Wl,-pie -nostdlib
-
-OBJECTS =3D start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
-=09  virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o dasd-ipl.o
-
-STRIP ?=3D strip
-
-$(OBJECTS): Makefile
-
-SLOF_DIR :=3D $(SRC_PATH)/roms/SLOF
-
-NETOBJS :=3D start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netmain=
.o \
-=09   libnet.a libc.a
-
-LIBC_INC :=3D -nostdinc -I$(SLOF_DIR)/lib/libc/include
-LIBNET_INC :=3D -I$(SLOF_DIR)/lib/libnet
-
-$(NETOBJS): QEMU_CFLAGS +=3D $(LIBC_INC) $(LIBNET_INC)
-
-# libc files:
-
-LIBC_CFLAGS :=3D  $(QEMU_CFLAGS) $(CFLAGS) $(LIBC_INC) $(LIBNET_INC)
-
-CTYPE_OBJS =3D isdigit.o isxdigit.o toupper.o
-$(CTYPE_OBJS) : %.o : $(SLOF_DIR)/lib/libc/ctype/%.c
-=09$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DI=
R)$@")
-
-STRING_OBJS =3D strcat.o strchr.o strrchr.o strcpy.o strlen.o strncpy.o \
-=09      strcmp.o strncmp.o strcasecmp.o strncasecmp.o strstr.o \
-=09      memset.o memcpy.o memmove.o memcmp.o
-$(STRING_OBJS) : %.o : $(SLOF_DIR)/lib/libc/string/%.c
-=09$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DI=
R)$@")
-
-STDLIB_OBJS =3D atoi.o atol.o strtoul.o strtol.o rand.o malloc.o free.o
-$(STDLIB_OBJS) : %.o : $(SLOF_DIR)/lib/libc/stdlib/%.c
-=09$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DI=
R)$@")
-
-STDIO_OBJS =3D sprintf.o snprintf.o vfprintf.o vsnprintf.o vsprintf.o fpri=
ntf.o \
-=09     printf.o putc.o puts.o putchar.o stdchnls.o fileno.o
-$(STDIO_OBJS) : %.o : $(SLOF_DIR)/lib/libc/stdio/%.c
-=09$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DI=
R)$@")
-
-sbrk.o: $(SLOF_DIR)/slof/sbrk.c
-=09$(call quiet-command,$(CC) $(LIBC_CFLAGS) -c -o $@ $<,"CC","$(TARGET_DI=
R)$@")
-
-LIBCOBJS :=3D $(STRING_OBJS) $(CTYPE_OBJS) $(STDLIB_OBJS) $(STDIO_OBJS) sb=
rk.o
-
-libc.a: $(LIBCOBJS)
-=09$(call quiet-command,$(AR) -rc $@ $^,"AR","$(TARGET_DIR)$@")
-
-# libnet files:
-
-LIBNETOBJS :=3D args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
-=09      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o pxelinux.o
-LIBNETCFLAGS :=3D $(CFLAGS) -DDHCPARCH=3D0x1F $(LIBC_INC) $(LIBNET_INC)
-
-$(LIBNETOBJS) : %.o : $(SLOF_DIR)/lib/libnet/%.c
-=09$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,"CC","$(TARGET_D=
IR)$@")
-
-libnet.a: $(LIBNETOBJS)
-=09$(call quiet-command,$(AR) -rc $@ $^,"AR","$(TARGET_DIR)$@")
-
-%.elf:
-=09$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $^,"BUILD","$(TARGET_DIR)$@=
")
-
-%.img: %.elf
-=09$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,"STRIP","$(TARG=
ET_DIR)$@")
-
-s390-ccw.elf: $(OBJECTS)
-s390-ccw.img: s390-ccw.elf
-all: s390-ccw.img
-
-ifneq ($(wildcard $(SLOF_DIR)/lib/libnet),)
-s390-netboot.elf: $(NETOBJS)
-s390-netboot.elf: LDFLAGS +=3D -Ttext=3D0x7800000
-
-s390-netboot.img: s390-netboot.elf
-all: s390-netboot.img
-endif
-
-clean:
-=09rm -f *.o *.d *.img *.elf *~ *.a
-
-.PHONY : all clean
diff --git a/pc-bios/s390-ccw/meson.build b/pc-bios/s390-ccw/meson.build
new file mode 100644
index 0000000..a4e0e3b
--- /dev/null
+++ b/pc-bios/s390-ccw/meson.build
@@ -0,0 +1,175 @@
+strip =3D find_program('strip')
+cc =3D meson.get_compiler('c')
+link_args =3D ['-Wl,-pie', '-nostdlib']
+
+# FIXME: find a better way to check/enable slof
+slof =3D '../../roms/SLOF'
+has_slof =3D cc.has_header('libnet/tftp.h', args: '-I' + meson.current_sou=
rce_dir() / slof / 'lib')
+
+s390_cargs =3D [
+  '-ffreestanding',
+  '-fno-delete-null-pointer-checks',
+  '-msoft-float',
+  '-march=3Dz900',
+  '-fPIE',
+  '-fno-strict-aliasing',
+  '-fno-asynchronous-unwind-tables',
+  cc.get_supported_arguments('-fno-stack-protector')
+]
+
+s390_incs =3D []
+
+s390_srcs =3D [
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
+  s390_srcs +=3D [
+    'netmain.c',
+    'virtio-net.c',
+  ]
+  s390_incs +=3D include_directories(slof / 'lib/libnet')
+  s390_incs +=3D include_directories(slof / 'lib/libc/include')
+  s390_cargs +=3D '-nostdinc'
+endif
+
+s390_lib =3D static_library(
+  's390', s390_srcs,
+  c_args: s390_cargs,
+  include_directories: s390_incs,
+)
+
+s390_ccw_elf =3D executable(
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
+  slof_ctype =3D slof / 'lib/libc/ctype'
+  slof_str =3D slof / 'lib/libc/string'
+  slof_stdlib =3D slof / 'lib/libc/stdlib'
+  slof_stdio =3D slof / 'lib/libc/stdio'
+
+  s390_libc =3D static_library(
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
+  slof_libnet =3D slof / 'lib/libnet'
+  s390_libnet =3D static_library(
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
+    c_args: [s390_cargs, '-DDHCPARCH=3D0x1F'],
+    include_directories: s390_incs,
+  )
+
+  s390_netboot_elf =3D executable(
+    's390-netboot.elf',
+    link_with: [s390_libc, s390_libnet],
+    link_args: [link_args, '-Ttext=3D0x7800000'],
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
--=20
1.8.3.1



