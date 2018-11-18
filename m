Received: from eggs.gnu.org ([2001:4830:134:3::10]:36437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOTl2-0005Qy-Hc
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 15:33:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOTl0-0000g6-Dp
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 15:33:28 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOTl0-0000fX-4o
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 15:33:26 -0500
Received: by mail-wr1-x444.google.com with SMTP id z13-v6so29874334wrs.3
	for <qemu-devel@nongnu.org>; Sun, 18 Nov 2018 12:33:26 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 18 Nov 2018 21:33:11 +0100
Message-Id: <20181118203312.5376-2-f4bug@amsat.org>
In-Reply-To: <20181118203312.5376-1-f4bug@amsat.org>
References: <20181118203312.5376-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/2] docker: Add gentoo-mipsr5900el-cross
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Mike Frysinger <vapier@gentoo.org>

This image is based on Gentoo and the toolchain is built using crossdev.

Recipe from:
  https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03944.html

Suggested-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
TODO:
- Add Fredrik Noring S-o-b in his patches
- Check patch merged upstream

 tests/docker/Makefile.include                 |   6 +
 .../gentoo-mipsr5900el-cross.docker           |  39 ++++
 .../binutils-v2.30-ps2-llsc.patch             |  36 +++
 .../crossdev.conf                             |   5 +
 .../gcc-v7.2.0-ps2-llsc.patch                 |  23 ++
 .../gcc-v7.2.0-ps2.patch                      | 219 ++++++++++++++++++
 6 files changed, 328 insertions(+)
 create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
 create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/binutils-v2.30-ps2-llsc.patch
 create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/crossdev.conf
 create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/gcc-v7.2.0-ps2-llsc.patch
 create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/gcc-v7.2.0-ps2.patch

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 9467e9d088..6ca615206f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -119,6 +119,12 @@ docker-image-debian-sparc64-cross: docker-image-debian-sid
 docker-image-debian-mips64-cross: docker-image-debian-sid
 docker-image-debian-riscv64-cross: docker-image-debian-sid
 docker-image-debian-powerpc-cross: docker-image-debian-sid
+docker-image-gentoo-mipsr5900el-cross: EXTRA_FILES:=$(addprefix \
+			$(SRC_PATH)/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/,\
+				crossdev.conf \
+				binutils-v2.30-ps2-llsc.patch \
+				gcc-v7.2.0-ps2.patch \
+				gcc-v7.2.0-ps2-llsc.patch)
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
diff --git a/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
new file mode 100644
index 0000000000..dbc2eb007b
--- /dev/null
+++ b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
@@ -0,0 +1,39 @@
+#
+# Docker mipsel (r5900) cross-compiler target
+#
+# Using multi-stage builds, this image requires docker-17.05.0 or later.
+# (See: https://github.com/gentoo/gentoo-docker-images)
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# name the portage image
+FROM gentoo/portage:latest as portage
+
+# image is based on stage3-amd64
+FROM gentoo/stage3-amd64:latest
+
+# copy the entire portage volume in
+COPY --from=portage /usr/portage /usr/portage
+
+MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
+
+# continue with image build ...
+RUN emerge -qv sys-devel/crossdev
+
+# set CROSSDEV_OVERLAY to /usr/local/portage-crossdev
+RUN mkdir -p /usr/local/portage-crossdev/{profiles,metadata} && \
+    echo 'crossdev' > /usr/local/portage-crossdev/profiles/repo_name && \
+    echo 'masters = gentoo' > /usr/local/portage-crossdev/metadata/layout.conf && \
+    chown -R portage:portage /usr/local/portage-crossdev && \
+    mkdir -p /etc/portage/repos.conf
+ADD crossdev.conf /etc/portage/repos.conf/crossdev.conf
+
+# Fredrik's patches
+RUN mkdir -p /etc/portage/patches/cross-mipsr5900el-unknown-linux-gnu/{binutils,gcc}
+ADD binutils-v2.30-ps2-llsc.patch /etc/portage/patches/cross-mipsr5900el-unknown-linux-gnu/binutils
+ADD gcc-v7.2.0-ps2.patch /etc/portage/patches/cross-mipsr5900el-unknown-linux-gnu/gcc
+ADD gcc-v7.2.0-ps2-llsc.patch /etc/portage/patches/cross-mipsr5900el-unknown-linux-gnu/gcc
+
+RUN crossdev -s3 -t mipsr5900el-unknown-linux-gnu --binutils ">=2.30" --gcc ">=7.2.0"
+
+ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsr5900el-unknown-linux-gnu-
diff --git a/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/binutils-v2.30-ps2-llsc.patch b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/binutils-v2.30-ps2-llsc.patch
new file mode 100644
index 0000000000..62ecc3267a
--- /dev/null
+++ b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/binutils-v2.30-ps2-llsc.patch
@@ -0,0 +1,36 @@
+diff --git a/opcodes/mips-opc.c b/opcodes/mips-opc.c
+index 1cbcbc6..0986b0a 100644
+--- a/opcodes/mips-opc.c
++++ b/opcodes/mips-opc.c
+@@ -1280,11 +1280,11 @@ const struct mips_opcode mips_builtin_opcodes[] =
+ {"li.s",		"t,f",		0,    (int) M_LI_S,	INSN_MACRO,		INSN2_M_FP_S,	I1,		0,	0 },
+ {"li.s",		"T,l",		0,    (int) M_LI_SS,	INSN_MACRO,		INSN2_M_FP_S,	I1,		0,	0 },
+ {"ll",			"t,+j(b)",	0x7c000036, 0xfc00007f, WR_1|RD_3|LM,		0,		I37,		0,	0 },
+-{"ll",			"t,o(b)",	0xc0000000, 0xfc000000, WR_1|RD_3|LM,		0,		I2,		0,	EE|I37 },
+-{"ll",			"t,A(b)",	0,    (int) M_LL_AB,	INSN_MACRO,		0,		I2,		0,	EE },
++{"ll",			"t,o(b)",	0xc0000000, 0xfc000000, WR_1|RD_3|LM,		0,		I2,		0,	I37 },
++{"ll",			"t,A(b)",	0,    (int) M_LL_AB,	INSN_MACRO,		0,		I2,		0,	0 },
+ {"lld",			"t,+j(b)",	0x7c000037, 0xfc00007f, WR_1|RD_3|LM,		0,		I69,		0,	0 },
+-{"lld",			"t,o(b)",	0xd0000000, 0xfc000000, WR_1|RD_3|LM,		0,		I3,		0,	EE|I69 },
+-{"lld",			"t,A(b)",	0,    (int) M_LLD_AB,	INSN_MACRO,		0,		I3,		0,	EE },
++{"lld",			"t,o(b)",	0xd0000000, 0xfc000000, WR_1|RD_3|LM,		0,		I3,		0,	I69 },
++{"lld",			"t,A(b)",	0,    (int) M_LLD_AB,	INSN_MACRO,		0,		I3,		0,	0 },
+ {"lq",			"t,o(b)",	0x78000000, 0xfc000000, WR_1|RD_3|LM,		0,		MMI,		0,	0 },
+ {"lq",			"t,A(b)",	0,    (int) M_LQ_AB,	INSN_MACRO,		0,		MMI,		0,	0 },
+ {"lqc2",		"+7,o(b)",	0xd8000000, 0xfc000000,	RD_3|WR_C2|LM,		0,		EE,		0,	0 },
+@@ -1810,11 +1810,11 @@ const struct mips_opcode mips_builtin_opcodes[] =
+ {"sb",			"t,o(b)",	0xa0000000, 0xfc000000,	RD_1|RD_3|SM,		0,		I1,		0,	0 },
+ {"sb",			"t,A(b)",	0,    (int) M_SB_AB,	INSN_MACRO,		0,		I1,		0,	0 },
+ {"sc",			"t,+j(b)",	0x7c000026, 0xfc00007f, MOD_1|RD_3|SM,		0,		I37,		0,	0 },
+-{"sc",			"t,o(b)",	0xe0000000, 0xfc000000, MOD_1|RD_3|SM,		0,		I2,		0,	EE|I37 },
+-{"sc",			"t,A(b)",	0,    (int) M_SC_AB,	INSN_MACRO,		0,		I2,		0,	EE },
++{"sc",			"t,o(b)",	0xe0000000, 0xfc000000, MOD_1|RD_3|SM,		0,		I2,		0,	I37 },
++{"sc",			"t,A(b)",	0,    (int) M_SC_AB,	INSN_MACRO,		0,		I2,		0,	0 },
+ {"scd",			"t,+j(b)",	0x7c000027, 0xfc00007f, MOD_1|RD_3|SM,		0,		I69,		0,	0 },
+-{"scd",			"t,o(b)",	0xf0000000, 0xfc000000, MOD_1|RD_3|SM,		0,		I3,		0,	EE|I69 },
+-{"scd",			"t,A(b)",	0,    (int) M_SCD_AB,	INSN_MACRO,		0,		I3,		0,	EE },
++{"scd",			"t,o(b)",	0xf0000000, 0xfc000000, MOD_1|RD_3|SM,		0,		I3,		0,	I69 },
++{"scd",			"t,A(b)",	0,    (int) M_SCD_AB,	INSN_MACRO,		0,		I3,		0,	0 },
+ /* The macro has to be first to handle o32 correctly.  */
+ {"sd",			"t,A(b)",	0,    (int) M_SD_AB,	INSN_MACRO,		0,		I1,		0,	0 },
+ {"sd",			"t,o(b)",	0xfc000000, 0xfc000000,	RD_1|RD_3|SM,		0,		I3,		0,	0 },
diff --git a/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/crossdev.conf b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/crossdev.conf
new file mode 100644
index 0000000000..b8fa368c1c
--- /dev/null
+++ b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/crossdev.conf
@@ -0,0 +1,5 @@
+[crossdev]
+location = /usr/local/portage-crossdev
+priority = 10
+masters = gentoo
+auto-sync = no
diff --git a/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/gcc-v7.2.0-ps2-llsc.patch b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/gcc-v7.2.0-ps2-llsc.patch
new file mode 100644
index 0000000000..59bc0e6e83
--- /dev/null
+++ b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/gcc-v7.2.0-ps2-llsc.patch
@@ -0,0 +1,23 @@
+diff --git a/gcc/config.gcc b/gcc/config.gcc
+index a9196cd..5b497f6 100644
+--- a/gcc/config.gcc
++++ b/gcc/config.gcc
+@@ -3558,14 +3558,14 @@ fi
+ # Infer a default setting for --with-llsc.
+ if test x$with_llsc = x; then
+   case ${target} in
+-    mips64r5900-*-* | mips64r5900el-*-* | mipsr5900-*-* | mipsr5900el-*-*)
+-      # The R5900 doesn't support LL(D) and SC(D).
+-      with_llsc=no
+-      ;;
+     mips*-*-linux*)
+       # The kernel emulates LL and SC where necessary.
+       with_llsc=yes
+       ;;
++    mips64r5900-*-* | mips64r5900el-*-* | mipsr5900-*-* | mipsr5900el-*-*)
++      # The R5900 doesn't support LL(D) and SC(D).
++      with_llsc=no
++      ;;
+   esac
+ fi
+ 
diff --git a/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/gcc-v7.2.0-ps2.patch b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/gcc-v7.2.0-ps2.patch
new file mode 100644
index 0000000000..a3337dbf61
--- /dev/null
+++ b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker.d/gcc-v7.2.0-ps2.patch
@@ -0,0 +1,219 @@
+commit ff785b9af62d5dfe1c0e3d3cf0052e7b5cf281ad
+Author: Rick Gaiser <rgaiser@gmail.com>
+Date:   Thu Apr 26 22:30:11 2018 +0200
+
+    Apply gcc-7.2.0-libgcc.patch from uyjulian
+
+diff --git a/gcc/config/mips/mips.c b/gcc/config/mips/mips.c
+index 6bfd86a..2996ebc 100644
+--- a/gcc/config/mips/mips.c
++++ b/gcc/config/mips/mips.c
+@@ -19747,6 +19747,11 @@ mips_option_override (void)
+     error ("unsupported combination: %s",
+ 	   "-march=r5900 -mhard-float -mdouble-float");
+ 
++  /* The R5900 does not support some MIPS16 instructions.  */
++  if (TARGET_MIPS5900 && ((mips_base_compression_flags & MASK_MIPS16) != 0))
++	  error("unsupported combination: %s",
++		  "-march=r5900 -mips16");
++
+   /* If a -mlong* option was given, check that it matches the ABI,
+      otherwise infer the -mlong* setting from the other options.  */
+   if ((target_flags_explicit & MASK_LONG64) != 0)
+diff --git a/libgcc/config.host b/libgcc/config.host
+index bedcf10..4a85a15 100644
+--- a/libgcc/config.host
++++ b/libgcc/config.host
+@@ -144,7 +144,11 @@ mips*-*-*)
+ 	cpu_type=mips
+ 	tmake_file="mips/t-mips"
+ 	if test "${libgcc_cv_mips_hard_float}" = yes; then
++	    if test "${libgcc_cv_mips_single_float}" = yes; then
++                tmake_file="${tmake_file} t-hardfp-sf t-hardfp"
++	    else
+ 		tmake_file="${tmake_file} t-hardfp-sfdf t-hardfp"
++	    fi
+ 	else
+ 		tmake_file="${tmake_file} t-softfp-sfdf"
+ 	fi
+@@ -858,19 +862,16 @@ mips*-*-netbsd*)			# NetBSD/mips, either endian.
+ mips*-*-linux*)				# Linux MIPS, either endian.
+ 	extra_parts="$extra_parts crtfastmath.o"
+ 	tmake_file="${tmake_file} t-crtfm"
+-	case ${host} in
+-	  mips64r5900* | mipsr5900*)
+-	    # The MIPS16 support code uses floating point
+-	    # instructions that are not supported on r5900.
+-	    ;;
+-	  *)
++    if test "${libgcc_cv_mips16}" = yes; then
+ 	    tmake_file="${tmake_file} mips/t-mips16 t-slibgcc-libgcc"
+-	    ;;
+-	esac
++    fi
+ 	md_unwind_header=mips/linux-unwind.h
+ 	;;
+ mips*-sde-elf*)
+-	tmake_file="$tmake_file mips/t-crtstuff mips/t-mips16"
++	tmake_file="$tmake_file mips/t-crtstuff"
++    if test "${libgcc_cv_mips16}" = yes; then
++	  tmake_file="${tmake_file} mips/t-mips16"
++    fi
+ 	case "${with_newlib}" in
+ 	  yes)
+ 	    # newlib / libgloss.
+@@ -900,7 +901,10 @@ mipsisa64sb1-*-elf* | mipsisa64sb1el-*-elf*)
+ 	extra_parts="$extra_parts crti.o crtn.o"
+ 	;;
+ mips-*-elf* | mipsel-*-elf*)
+-	tmake_file="$tmake_file mips/t-elf mips/t-crtstuff mips/t-mips16"
++	tmake_file="$tmake_file mips/t-elf mips/t-crtstuff"
++    if test "${libgcc_cv_mips16}" = yes; then
++	  tmake_file="${tmake_file} mips/t-mips16"
++    fi
+ 	extra_parts="$extra_parts crti.o crtn.o"
+ 	;;
+ mipsr5900-*-elf* | mipsr5900el-*-elf*)
+@@ -908,7 +912,10 @@ mipsr5900-*-elf* | mipsr5900el-*-elf*)
+ 	extra_parts="$extra_parts crti.o crtn.o"
+ 	;;
+ mips64-*-elf* | mips64el-*-elf*)
+-	tmake_file="$tmake_file mips/t-elf mips/t-crtstuff mips/t-mips16"
++	tmake_file="$tmake_file mips/t-elf mips/t-crtstuff"
++    if test "${libgcc_cv_mips16}" = yes; then
++	  tmake_file="${tmake_file} mips/t-mips16"
++    fi
+ 	extra_parts="$extra_parts crti.o crtn.o"
+ 	;;
+ mips64r5900-*-elf* | mips64r5900el-*-elf*)
+@@ -924,7 +931,10 @@ mips64orion-*-elf* | mips64orionel-*-elf*)
+ 	extra_parts="$extra_parts crti.o crtn.o"
+ 	;;
+ mips*-*-rtems*)
+-	tmake_file="$tmake_file mips/t-elf mips/t-crtstuff mips/t-mips16"
++	tmake_file="$tmake_file mips/t-elf mips/t-crtstuff"
++    if test "${libgcc_cv_mips16}" = yes; then
++	  tmake_file="${tmake_file} mips/t-mips16"
++    fi
+ 	extra_parts="$extra_parts crti.o crtn.o"
+ 	;;
+ mips-wrs-vxworks)
+diff --git a/libgcc/config/t-hardfp-sf b/libgcc/config/t-hardfp-sf
+new file mode 100644
+index 0000000..e63ad47
+--- /dev/null
++++ b/libgcc/config/t-hardfp-sf
+@@ -0,0 +1,32 @@
++# Copyright (C) 2014-2015 Free Software Foundation, Inc.
++
++# This file is part of GCC.
++
++# GCC is free software; you can redistribute it and/or modify
++# it under the terms of the GNU General Public License as published by
++# the Free Software Foundation; either version 3, or (at your option)
++# any later version.
++
++# GCC is distributed in the hope that it will be useful,
++# but WITHOUT ANY WARRANTY; without even the implied warranty of
++# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
++# GNU General Public License for more details.
++
++# You should have received a copy of the GNU General Public License
++# along with GCC; see the file COPYING3.  If not see
++# <http://www.gnu.org/licenses/>.
++
++hardfp_float_modes := sf
++# di and ti are provided by libgcc2.c where needed.
++hardfp_int_modes := si
++hardfp_extensions :=
++hardfp_truncations :=
++
++# Emulate 64 bit float:
++FPBIT = true
++DPBIT = true
++# Don't build functions handled by 32 bit hardware:
++LIB2FUNCS_EXCLUDE = _addsub_sf _mul_sf _div_sf \
++    _fpcmp_parts_sf _compare_sf _eq_sf _ne_sf _gt_sf _ge_sf \
++    _lt_sf _le_sf _unord_sf _si_to_sf _sf_to_si _negate_sf \
++    _thenan_sf _sf_to_usi _usi_to_sf
+diff --git a/libgcc/configure b/libgcc/configure
+index 42dda7f..716bba9 100644
+--- a/libgcc/configure
++++ b/libgcc/configure
+@@ -4871,6 +4871,48 @@ rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
+ fi
+ { $as_echo "$as_me:${as_lineno-$LINENO}: result: $libgcc_cv_mips_hard_float" >&5
+ $as_echo "$libgcc_cv_mips_hard_float" >&6; }
++  { $as_echo "$as_me:${as_lineno-$LINENO}: checking whether the target is single-float" >&5
++$as_echo_n "checking whether the target is single-float... " >&6; }
++if test "${libgcc_cv_mips_single_float+set}" = set; then :
++  $as_echo_n "(cached) " >&6
++else
++  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
++/* end confdefs.h.  */
++#ifndef __mips_single_float
++     #error FOO
++     #endif
++_ACEOF
++if ac_fn_c_try_compile "$LINENO"; then :
++  libgcc_cv_mips_single_float=yes
++else
++  libgcc_cv_mips_single_float=no
++fi
++rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
++fi
++{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $libgcc_cv_mips_single_float" >&5
++$as_echo "$libgcc_cv_mips_single_float" >&6; }
++  # Some targets (i.e. R5900) don't support some MIPS16 instructions.
++  { $as_echo "$as_me:${as_lineno-$LINENO}: checking whether the target supports the MIPS16 ASE" >&5
++$as_echo_n "checking whether the target supports MIPS16 ASE... " >&6; }
++if test "${libgcc_cv_mips16+set}" = set; then :
++  $as_echo_n "(cached) " >&6
++else
++  CFLAGS_hold=$CFLAGS
++		 CFLAGS="$CFLAGS -mips16"
++		 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
++/* end confdefs.h.  */
++int i;
++_ACEOF
++if ac_fn_c_try_compile "$LINENO"; then :
++  libgcc_cv_mips16=yes
++else
++  libgcc_cv_mips16=no
++fi
++rm -f core conftest.err conftest.$ac_objext conftest.$ac_ext
++	CFLAGS=$CFLAGS_hold
++fi
++{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $libgcc_cv_mips16" >&5
++$as_echo "$libgcc_cv_mips16" >&6; }
+ esac
+ 
+ case ${host} in
+diff --git a/libgcc/configure.ac b/libgcc/configure.ac
+index 6bcaad6..5bce467 100644
+--- a/libgcc/configure.ac
++++ b/libgcc/configure.ac
+@@ -292,6 +292,23 @@ mips*-*-*)
+      #endif],
+     [libgcc_cv_mips_hard_float=yes],
+     [libgcc_cv_mips_hard_float=no])])
++  AC_CACHE_CHECK([whether the target is single-float],
++		 [libgcc_cv_mips_single_float],
++		 [AC_COMPILE_IFELSE(
++    [#ifndef __mips_single_float
++     #error FOO
++     #endif],
++    [libgcc_cv_mips_single_float=yes],
++    [libgcc_cv_mips_single_float=no])])
++  # Some targets (i.e. R5900) don't support some MIPS16 instructions.
++  AC_CACHE_CHECK([whether the target supports the MIPS16 ASE],
++		 [libgcc_cv_mips16],
++		 [CFLAGS_hold=$CFLAGS
++		 CFLAGS="$CFLAGS -mips16"
++		 AC_COMPILE_IFELSE([[int i;]],
++    [libgcc_cv_mips16=yes],
++    [libgcc_cv_mips16=no])
++	CFLAGS=$CFLAGS_hold])
+ esac
+ 
+ case ${host} in
-- 
2.17.2
