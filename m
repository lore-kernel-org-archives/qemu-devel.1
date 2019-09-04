Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03290C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0EC20674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBFteteN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0EC20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cQh-00078p-QS
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvJ-0008CK-T9
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bv9-0006dq-Ej
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bv7-0006b0-Ib
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id n10so224762wmj.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DowzcpHFxYQS1l03Cm9hViM/2yroo56W0ONqHBhViLQ=;
 b=eBFteteNCsfTclxGSLUdxQb4usyz3xnxpoDXDWeH/Ilp1g+IkAYwEqeOf85xfCtkwx
 0ljULBATtzBF5Qw1bkItogglmwpWQUkFs1Bv5xl0iwlGNIIZTUqMRhbA8X8f7aGn6Wep
 /oGbYqfe5sSN8fs/+2aepoaMEk/1RGnpPKX9xMJfrFgiBnnvHW3LgzlvZVTXL3+dtgx8
 gRHYIRA30BW60ihlw0RlnRBr5z53c0yZUUmTTwMXe5D6zYyBc9b2JJ1FQQqoywXxS77y
 sa+NtBWSHQZoNnL/2YkpS0KK26GZTI7ONV1nERf4Obm3mo/QWHdQc90opypym4J604gj
 SoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DowzcpHFxYQS1l03Cm9hViM/2yroo56W0ONqHBhViLQ=;
 b=ul7WWgnCxN6VcAll7xbI+sLDBR3RXkdZvEBw5FSf+HY6VBHMYz4DrPo3sND4GrFAY1
 U8DUaXiFihDzhrcqwp5uCbkDuNge/GJn3NHmELL4ZoIK+S3Fe63h4D3hse8MnQ3VAuYq
 ighFkkjzLhGXz1EDfmaqxrDTqom9Yvdg7J30H0cmm1zBSNwo+aYBUp1wz3TsDc24riXX
 +wTvhyOWV+3Y76sm6YtUvAuLcuFfpjb1vbOh3nf4OLh+321ZYVNYJf7EGhIo867qCkMx
 LXyianrczk/uDiQX9qp54NIhPTLbNwY84EMSpLzPghbgFTM/fX3Obyg6dYEHHHtOxnp5
 bZXA==
X-Gm-Message-State: APjAAAXsz37n+JnRtsAsyUiUB2JgSQ8lDcCP+Fe1l5HrEBT/ECCDEeau
 xpCR7yIBkay8TP2NTH4gHMkO6Q==
X-Google-Smtp-Source: APXvYqyG71WNMlRqMy10wesz17QPjpg2/uhBcyXCP4zmQc2RRJWGruI8lsMPmYgRFi+Fma5ts8EQpQ==
X-Received: by 2002:a7b:ce99:: with SMTP id q25mr67009wmj.163.1567629023659;
 Wed, 04 Sep 2019 13:30:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h17sm334093wme.6.2019.09.04.13.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 09E901FF93;
 Wed,  4 Sep 2019 21:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:37 +0100
Message-Id: <20190904203013.9028-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v1 06/42] tests/tcg: move configuration to a
 sub-shell script
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Avoid the repeated inclusions of config-target.mak, which have
risks of namespace pollution, and instead build minimal configuration
files in a configuration script.  The same configuration files can
also be included in Makefile and Makefile.qemu

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20190807143523.15917-4-pbonzini@redhat.com>
[AJB: s/docker/container/, rm last bits from configure]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile                           |   1 +
 configure                          | 157 ++-----------------
 tests/Makefile.include             |   8 +-
 tests/tcg/Makefile.prereqs         |  18 +--
 tests/tcg/Makefile.qemu            |  51 +++----
 tests/tcg/Makefile.target          |   8 +-
 tests/tcg/aarch64/Makefile.include |   8 -
 tests/tcg/alpha/Makefile.include   |   2 -
 tests/tcg/arm/Makefile.include     |   8 -
 tests/tcg/configure.sh             | 234 +++++++++++++++++++++++++++++
 tests/tcg/cris/Makefile.include    |   6 -
 tests/tcg/hppa/Makefile.include    |   2 -
 tests/tcg/i386/Makefile.include    |   9 --
 tests/tcg/m68k/Makefile.include    |   2 -
 tests/tcg/mips/Makefile.include    |  20 ---
 tests/tcg/ppc/Makefile.include     |  10 --
 tests/tcg/riscv/Makefile.include   |  10 --
 tests/tcg/s390x/Makefile.include   |   2 -
 tests/tcg/sh4/Makefile.include     |   4 -
 tests/tcg/sparc64/Makefile.include |   2 -
 tests/tcg/xtensa/Makefile.include  |  11 --
 21 files changed, 282 insertions(+), 291 deletions(-)
 delete mode 100644 tests/tcg/aarch64/Makefile.include
 delete mode 100644 tests/tcg/alpha/Makefile.include
 delete mode 100644 tests/tcg/arm/Makefile.include
 create mode 100755 tests/tcg/configure.sh
 delete mode 100644 tests/tcg/cris/Makefile.include
 delete mode 100644 tests/tcg/hppa/Makefile.include
 delete mode 100644 tests/tcg/i386/Makefile.include
 delete mode 100644 tests/tcg/m68k/Makefile.include
 delete mode 100644 tests/tcg/mips/Makefile.include
 delete mode 100644 tests/tcg/ppc/Makefile.include
 delete mode 100644 tests/tcg/riscv/Makefile.include
 delete mode 100644 tests/tcg/s390x/Makefile.include
 delete mode 100644 tests/tcg/sh4/Makefile.include
 delete mode 100644 tests/tcg/sparc64/Makefile.include
 delete mode 100644 tests/tcg/xtensa/Makefile.include

diff --git a/Makefile b/Makefile
index ae17a830678..b3528617e48 100644
--- a/Makefile
+++ b/Makefile
@@ -717,6 +717,7 @@ endef
 
 distclean: clean
 	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-options.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
+	rm -f tests/tcg/config-*.mak
 	rm -f config-all-devices.mak config-all-disas.mak config.status
 	rm -f $(SUBDIR_DEVICES_MAK)
 	rm -f po/*.mo tests/qemu-iotests/common.env
diff --git a/configure b/configure
index 94845fc5101..7860bbc3121 100755
--- a/configure
+++ b/configure
@@ -495,27 +495,10 @@ qed="yes"
 parallels="yes"
 sheepdog="yes"
 libxml2=""
-container="no"
 debug_mutex="no"
 libpmem=""
 default_devices="yes"
 
-# cross compilers defaults, can be overridden with --cross-cc-ARCH
-cross_cc_aarch64="aarch64-linux-gnu-gcc"
-cross_cc_aarch64_be="$cross_cc_aarch64"
-cross_cc_cflags_aarch64_be="-mbig-endian"
-cross_cc_arm="arm-linux-gnueabihf-gcc"
-cross_cc_cflags_armeb="-mbig-endian"
-cross_cc_i386="i386-pc-linux-gnu-gcc"
-cross_cc_cflags_i386=""
-cross_cc_ppc="powerpc-linux-gnu-gcc"
-cross_cc_cflags_ppc="-m32"
-cross_cc_ppc64="powerpc-linux-gnu-gcc"
-cross_cc_cflags_ppc64="-m64"
-cross_cc_ppc64le="powerpc64le-linux-gnu-gcc"
-
-enabled_cross_compilers=""
-
 supported_cpu="no"
 supported_os="no"
 bogus_os="no"
@@ -548,9 +531,12 @@ for opt do
   ;;
   --cross-cc-cflags-*) cc_arch=${opt#--cross-cc-flags-}; cc_arch=${cc_arch%%=*}
                       eval "cross_cc_cflags_${cc_arch}=\$optarg"
+                      cross_cc_vars="$cross_cc_vars cross_cc_cflags_${cc_arch}"
   ;;
   --cross-cc-*) cc_arch=${opt#--cross-cc-}; cc_arch=${cc_arch%%=*}
+                cc_archs="$cc_archs $cc_arch"
                 eval "cross_cc_${cc_arch}=\$optarg"
+                cross_cc_vars="$cross_cc_vars cross_cc_${cc_arch}"
   ;;
   esac
 done
@@ -745,42 +731,34 @@ ARCH=
 case "$cpu" in
   ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
     supported_cpu="yes"
-    eval "cross_cc_${cpu}=\$host_cc"
   ;;
   ppc64le)
     ARCH="ppc64"
     supported_cpu="yes"
-    cross_cc_ppc64le=$host_cc
   ;;
   i386|i486|i586|i686|i86pc|BePC)
     cpu="i386"
     supported_cpu="yes"
-    cross_cc_i386=$host_cc
   ;;
   x86_64|amd64)
     cpu="x86_64"
     supported_cpu="yes"
-    cross_cc_x86_64=$host_cc
   ;;
   armv*b|armv*l|arm)
     cpu="arm"
     supported_cpu="yes"
-    cross_cc_arm=$host_cc
   ;;
   aarch64)
     cpu="aarch64"
     supported_cpu="yes"
-    cross_cc_aarch64=$host_cc
   ;;
   mips*)
     cpu="mips"
     supported_cpu="yes"
-    cross_cc_mips=$host_cc
   ;;
   sparc|sun4[cdmuv])
     cpu="sparc"
     supported_cpu="yes"
-    cross_cc_sparc=$host_cc
   ;;
   *)
     # This will result in either an error or falling back to TCI later
@@ -1555,44 +1533,30 @@ case "$cpu" in
     ppc)
            CPU_CFLAGS="-m32"
            LDFLAGS="-m32 $LDFLAGS"
-           cross_cc_ppc=$cc
-           cross_cc_cflags_ppc="$CPU_CFLAGS"
            ;;
     ppc64)
            CPU_CFLAGS="-m64"
            LDFLAGS="-m64 $LDFLAGS"
-           cross_cc_ppc64=$cc
-           cross_cc_cflags_ppc64="$CPU_CFLAGS"
            ;;
     sparc)
            CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
            LDFLAGS="-m32 -mv8plus $LDFLAGS"
-           cross_cc_sparc=$cc
-           cross_cc_cflags_sparc="$CPU_CFLAGS"
            ;;
     sparc64)
            CPU_CFLAGS="-m64 -mcpu=ultrasparc"
            LDFLAGS="-m64 $LDFLAGS"
-           cross_cc_sparc64=$cc
-           cross_cc_cflags_sparc64="$CPU_CFLAGS"
            ;;
     s390)
            CPU_CFLAGS="-m31"
            LDFLAGS="-m31 $LDFLAGS"
-           cross_cc_s390=$cc
-           cross_cc_cflags_s390="$CPU_CFLAGS"
            ;;
     s390x)
            CPU_CFLAGS="-m64"
            LDFLAGS="-m64 $LDFLAGS"
-           cross_cc_s390x=$cc
-           cross_cc_cflags_s390x="$CPU_CFLAGS"
            ;;
     i386)
            CPU_CFLAGS="-m32"
            LDFLAGS="-m32 $LDFLAGS"
-           cross_cc_i386=$cc
-           cross_cc_cflags_i386="$CPU_CFLAGS"
            ;;
     x86_64)
            # ??? Only extremely old AMD cpus do not have cmpxchg16b.
@@ -1600,18 +1564,16 @@ case "$cpu" in
            # runtime and generate the fallback to serial emulation.
            CPU_CFLAGS="-m64 -mcx16"
            LDFLAGS="-m64 $LDFLAGS"
-           cross_cc_x86_64=$cc
-           cross_cc_cflags_x86_64="$CPU_CFLAGS"
            ;;
     x32)
            CPU_CFLAGS="-mx32"
            LDFLAGS="-mx32 $LDFLAGS"
-           cross_cc_i386=$cc
-           cross_cc_cflags_i386="$CPU_CFLAGS"
            ;;
     # No special flags required for other host CPUs
 esac
 
+eval "cross_cc_${cpu}=\$host_cc"
+cross_cc_vars="$cross_cc_vars cross_cc_${cpu}"
 QEMU_CFLAGS="$CPU_CFLAGS $QEMU_CFLAGS"
 
 # For user-mode emulation the host arch has to be one we explicitly
@@ -5893,17 +5855,6 @@ EOF
   fi
 fi
 
-##########################################
-# Container based cross-compiler support
-#
-# This is specifically for building test
-# cases for foreign architectures, not
-# cross-compiling QEMU itself.
-
-if has "docker" || has "podman"; then
-    container=$($python $source_path/tests/docker/docker.py probe)
-fi
-
 ##########################################
 # check for libpmem
 
@@ -6474,7 +6425,6 @@ echo "qed support       $qed"
 echo "parallels support $parallels"
 echo "sheepdog support  $sheepdog"
 echo "capstone          $capstone"
-echo "container support $container"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
@@ -7384,10 +7334,6 @@ if test "$gcov" = "yes" ; then
   echo "GCOV=$gcov_tool" >> $config_host_mak
 fi
 
-if test "$docker" != "no"; then
-    echo "HAVE_USER_DOCKER=y" >> $config_host_mak
-fi
-
 if test "$libudev" != "no"; then
     echo "CONFIG_LIBUDEV=y" >> $config_host_mak
     echo "LIBUDEV_LIBS=$libudev_libs" >> $config_host_mak
@@ -7461,10 +7407,6 @@ case "$target" in
     ;;
 esac
 
-target_compiler=""
-target_compiler_static=""
-target_compiler_cflags=""
-
 mkdir -p $target_dir
 echo "# Automatically generated by configure - do not modify" > $config_target_mak
 
@@ -7481,26 +7423,20 @@ case "$target_name" in
   i386)
     mttcg="yes"
 	gdb_xml_files="i386-32bit.xml"
-    target_compiler=$cross_cc_i386
-    target_compiler_cflags=$cross_cc_ccflags_i386
   ;;
   x86_64)
     TARGET_BASE_ARCH=i386
     mttcg="yes"
 	gdb_xml_files="i386-64bit.xml"
-    target_compiler=$cross_cc_x86_64
   ;;
   alpha)
     mttcg="yes"
-    target_compiler=$cross_cc_alpha
   ;;
   arm|armeb)
     TARGET_ARCH=arm
     bflt="yes"
     mttcg="yes"
     gdb_xml_files="arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
-    target_compiler=$cross_cc_arm
-    eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
   ;;
   aarch64|aarch64_be)
     TARGET_ARCH=aarch64
@@ -7508,41 +7444,32 @@ case "$target_name" in
     bflt="yes"
     mttcg="yes"
     gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
-    target_compiler=$cross_cc_aarch64
-    eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
   ;;
   cris)
-    target_compiler=$cross_cc_cris
   ;;
   hppa)
     mttcg="yes"
-    target_compiler=$cross_cc_hppa
   ;;
   lm32)
-    target_compiler=$cross_cc_lm32
   ;;
   m68k)
     bflt="yes"
     gdb_xml_files="cf-core.xml cf-fp.xml m68k-fp.xml"
-    target_compiler=$cross_cc_m68k
   ;;
   microblaze|microblazeel)
     TARGET_ARCH=microblaze
     bflt="yes"
     echo "TARGET_ABI32=y" >> $config_target_mak
-    target_compiler=$cross_cc_microblaze
   ;;
   mips|mipsel)
     mttcg="yes"
     TARGET_ARCH=mips
-    target_compiler=$cross_cc_mips
     echo "TARGET_ABI_MIPSO32=y" >> $config_target_mak
   ;;
   mipsn32|mipsn32el)
     mttcg="yes"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
-    target_compiler=$cross_cc_mipsn32
     echo "TARGET_ABI_MIPSN32=y" >> $config_target_mak
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
@@ -7550,32 +7477,24 @@ case "$target_name" in
     mttcg="yes"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
-    target_compiler=$cross_cc_mips64
     echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
   ;;
   moxie)
-    target_compiler=$cross_cc_moxie
   ;;
   nios2)
-    target_compiler=$cross_cc_nios2
   ;;
   or1k)
-    target_compiler=$cross_cc_or1k
     TARGET_ARCH=openrisc
     TARGET_BASE_ARCH=openrisc
   ;;
   ppc)
     gdb_xml_files="power-core.xml power-fpu.xml power-altivec.xml power-spe.xml"
-    target_compiler=$cross_cc_ppc
-    target_compiler_cflags="$cross_cc_cflags_ppc"
   ;;
   ppc64)
     TARGET_BASE_ARCH=ppc
     TARGET_ABI_DIR=ppc
     mttcg=yes
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
-    target_compiler=$cross_cc_ppc64
-    target_compiler_cflags="$cross_cc_cflags_ppc64"
   ;;
   ppc64le)
     TARGET_ARCH=ppc64
@@ -7583,7 +7502,6 @@ case "$target_name" in
     TARGET_ABI_DIR=ppc
     mttcg=yes
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
-    target_compiler=$cross_cc_ppc64le
   ;;
   ppc64abi32)
     TARGET_ARCH=ppc64
@@ -7591,60 +7509,48 @@ case "$target_name" in
     TARGET_ABI_DIR=ppc
     echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
-    target_compiler=$cross_cc_ppc64abi32
   ;;
   riscv32)
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
     gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml"
-    target_compiler=$cross_cc_riscv32
   ;;
   riscv64)
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
     gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
-    target_compiler=$cross_cc_riscv64
   ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
     bflt="yes"
-    target_compiler=$cross_cc_sh4
   ;;
   sparc)
-    target_compiler=$cross_cc_sparc
   ;;
   sparc64)
     TARGET_BASE_ARCH=sparc
-    target_compiler=$cross_cc_sparc64
   ;;
   sparc32plus)
     TARGET_ARCH=sparc64
     TARGET_BASE_ARCH=sparc
     TARGET_ABI_DIR=sparc
-    target_compiler=$cross_cc_sparc32plus
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   s390x)
     mttcg=yes
     gdb_xml_files="s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-gs.xml"
-    target_compiler=$cross_cc_s390x
   ;;
   tilegx)
-    target_compiler=$cross_cc_tilegx
   ;;
   tricore)
-    target_compiler=$cross_cc_tricore
   ;;
   unicore32)
-    target_compiler=$cross_cc_unicore32
   ;;
   xtensa|xtensaeb)
     TARGET_ARCH=xtensa
     bflt="yes"
     mttcg="yes"
-    target_compiler=$cross_cc_xtensa
   ;;
   *)
     error_exit "Unsupported target CPU"
@@ -7655,27 +7561,6 @@ if [ "$TARGET_BASE_ARCH" = "" ]; then
   TARGET_BASE_ARCH=$TARGET_ARCH
 fi
 
-# Do we have a cross compiler for this target?
-if has $target_compiler; then
-
-    write_c_skeleton
-
-    if ! do_compiler "$target_compiler" $target_compiler_cflags -o $TMPE $TMPC -static ; then
-        # For host systems we might get away with building without -static
-        if ! do_compiler "$target_compiler" $target_compiler_cflags -o $TMPE $TMPC ; then
-            target_compiler=""
-        else
-            enabled_cross_compilers="${enabled_cross_compilers} '${target_compiler}'"
-            target_compiler_static="n"
-        fi
-    else
-        enabled_cross_compilers="${enabled_cross_compilers} '${target_compiler}'"
-        target_compiler_static="y"
-    fi
-else
-    target_compiler=""
-fi
-
 symlink "$source_path/Makefile.target" "$target_dir/Makefile"
 
 upper() {
@@ -7752,18 +7637,6 @@ if test "$target_bsd_user" = "yes" ; then
   echo "CONFIG_BSD_USER=y" >> $config_target_mak
 fi
 
-if test -n "$target_compiler"; then
-  echo "CROSS_CC_GUEST=\"$target_compiler\"" >> $config_target_mak
-
-  if test -n "$target_compiler_static"; then
-      echo "CROSS_CC_GUEST_STATIC=$target_compiler_static" >> $config_target_mak
-  fi
-
-  if test -n "$target_compiler_cflags"; then
-      echo "CROSS_CC_GUEST_CFLAGS=$target_compiler_cflags" >> $config_target_mak
-  fi
-fi
-
 
 # generate QEMU_CFLAGS/LDFLAGS for targets
 
@@ -7894,11 +7767,6 @@ done # for target in $targets
 echo "PIXMAN_CFLAGS=$pixman_cflags" >> $config_host_mak
 echo "PIXMAN_LIBS=$pixman_libs" >> $config_host_mak
 
-if test -n "$enabled_cross_compilers"; then
-    echo
-    echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
-fi
-
 if [ "$fdt" = "git" ]; then
   echo "config-host.h: dtc/all" >> $config_host_mak
 fi
@@ -7927,15 +7795,14 @@ fi
 # so the build tree will be missing the link back to the new file, and
 # tests might fail. Prefer to keep the relevant files in their own
 # directory and symlink the directory instead.
-DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
+DIRS="tests tests/tcg tests/tcg/lm32 tests/libqos tests/qapi-schema tests/qemu-iotests tests/vm"
 DIRS="$DIRS tests/fp tests/qgraph"
 DIRS="$DIRS docs docs/interop fsdev scsi"
 DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios roms/vgabios"
-LINKS="Makefile tests/tcg/Makefile"
-LINKS="$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
-LINKS="$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
-LINKS="$LINKS tests/fp/Makefile"
+LINKS="Makefile"
+LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
+LINKS="$LINKS tests/tcg/Makefile.target tests/fp/Makefile"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/spapr-rtas/Makefile"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
@@ -7965,6 +7832,12 @@ for f in $LINKS ; do
     fi
 done
 
+(for i in $cross_cc_vars; do
+  export $i
+done
+export target_list source_path
+$source_path/tests/tcg/configure.sh)
+
 # temporary config to build submodules
 for rom in seabios vgabios ; do
     config_mak=roms/$rom/config.mak
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8400656b9d3..9380b9eb666 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1059,30 +1059,28 @@ BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
 CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(TARGET_DIRS))
 RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))
 
-ifeq ($(HAVE_USER_DOCKER),y)
 # Probe for the Docker Builds needed for each build
 $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
 	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))
-endif
 
 build-tcg-tests-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
 		SRC_PATH=$(SRC_PATH) \
-	       	V="$(V)" TARGET_DIR="$*/" guest-tests, \
+	       	V="$(V)" TARGET="$*" guest-tests, \
 		"BUILD", "TCG tests for $*")
 
 run-tcg-tests-%: build-tcg-tests-% %/all
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
 		SRC_PATH=$(SRC_PATH) SPEED="$(SPEED)" \
-		V="$(V)" TARGET_DIR="$*/" run-guest-tests, \
+		V="$(V)" TARGET="$*" run-guest-tests, \
 		"RUN", "TCG tests for $*")
 
 clean-tcg-tests-%:
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
 		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
-		SRC_PATH=$(SRC_PATH) TARGET_DIR="$*/" clean-guest-tests, \
+		SRC_PATH=$(SRC_PATH) TARGET="$*" clean-guest-tests, \
 		"RUN", "TCG tests for $*")
 
 .PHONY: build-tcg
diff --git a/tests/tcg/Makefile.prereqs b/tests/tcg/Makefile.prereqs
index 53b01962e1d..7494b31b952 100644
--- a/tests/tcg/Makefile.prereqs
+++ b/tests/tcg/Makefile.prereqs
@@ -7,24 +7,12 @@
 # selection of required docker targets before we invoke a sub-make for
 # each target.
 
-# First we need the target makefile which tells us the target architecture
-CROSS_CC_GUEST:=
--include $(BUILD_DIR)/$(PROBE_TARGET)/config-target.mak
-
-# Then we load up the target architecture makefiles which tell us
-# about the compilers
 DOCKER_IMAGE:=
 
--include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
--include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
+-include $(BUILD_DIR)/tests/tcg/config-$(PROBE_TARGET).mak
 
-ifndef CROSS_CC_GUEST
 ifneq ($(DOCKER_IMAGE),)
 build-tcg-tests-$(PROBE_TARGET): docker-image-$(DOCKER_IMAGE)
+$(BUILD_DIR)/tests/tcg/config_$(PROBE_TARGET).mak: config-host.mak
+config-host.mak: $(SRC_PATH)/tests/tcg/configure.sh
 endif
-endif
-
-# Clean-up
-# undefine TARGET_NAME
-# undefine TARGET_BASE_ARCH
-# undefine TARGET_ABI_DIR
diff --git a/tests/tcg/Makefile.qemu b/tests/tcg/Makefile.qemu
index 7eff11d434e..9c23aeaa2a6 100644
--- a/tests/tcg/Makefile.qemu
+++ b/tests/tcg/Makefile.qemu
@@ -8,17 +8,22 @@
 # to do it for us.
 #
 
-# The per ARCH makefile, if it exists, holds extra information about
+include $(SRC_PATH)/rules.mak
+
+# The configure script fills in extra information about
 # useful docker images or alternative compiler flags.
 
-include $(TARGET_DIR)config-target.mak
-include $(SRC_PATH)/rules.mak
-include $(wildcard \
-	$(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include \
-	$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include)
+CROSS_CC_GUEST:=
+DOCKER_IMAGE:=
+-include $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak
 
 GUEST_BUILD=
 TCG_MAKE=../Makefile.target
+
+# We also need the Docker make rules to depend on
+SKIP_DOCKER_BUILD=1
+include $(SRC_PATH)/tests/docker/Makefile.include
+
 # Support installed Cross Compilers
 
 ifdef CROSS_CC_GUEST
@@ -26,11 +31,11 @@ ifdef CROSS_CC_GUEST
 .PHONY: cross-build-guest-tests
 cross-build-guest-tests:
 	$(call quiet-command, \
-	   (mkdir -p tests/tcg/$(TARGET_DIR) && cd tests/tcg/$(TARGET_DIR) && \
-	    $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" CC="$(CROSS_CC_GUEST)" \
+	   (mkdir -p tests/tcg/$(TARGET) && cd tests/tcg/$(TARGET) && \
+	    $(MAKE) -f $(TCG_MAKE) TARGET="$(TARGET)" CC="$(CROSS_CC_GUEST)" \
 			SRC_PATH="$(SRC_PATH)" BUILD_STATIC=$(CROSS_CC_GUEST_STATIC) \
-			EXTRA_CFLAGS=$(CROSS_CC_GUEST_CFLAGS)), \
-	"BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
+			EXTRA_CFLAGS="$(CROSS_CC_GUEST_CFLAGS)"), \
+	"BUILD","$(TARGET) guest-tests with $(CROSS_CC_GUEST)")
 
 GUEST_BUILD=cross-build-guest-tests
 
@@ -38,30 +43,24 @@ endif
 
 # Support building with Docker
 
-ifeq ($(HAVE_USER_DOCKER)$(GUEST_BUILD),y)
 ifneq ($(DOCKER_IMAGE),)
 
-# We also need the Docker make rules to depend on
-SKIP_DOCKER_BUILD=1
-include $(SRC_PATH)/tests/docker/Makefile.include
-
 DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc \
-		--cc $(DOCKER_CROSS_COMPILER) \
+		--cc $(DOCKER_CROSS_CC_GUEST) \
 		-i qemu:$(DOCKER_IMAGE) \
 		-s $(SRC_PATH) -- "
 
 .PHONY: docker-build-guest-tests
 docker-build-guest-tests: docker-image-$(DOCKER_IMAGE)
 	$(call quiet-command, \
-	  (mkdir -p tests/tcg/$(TARGET_DIR) && cd tests/tcg/$(TARGET_DIR) && \
-	   $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" CC=$(DOCKER_COMPILE_CMD) \
+	  (mkdir -p tests/tcg/$(TARGET) && cd tests/tcg/$(TARGET) && \
+	   $(MAKE) -f $(TCG_MAKE) TARGET="$(TARGET)" CC=$(DOCKER_COMPILE_CMD) \
 			SRC_PATH="$(SRC_PATH)" BUILD_STATIC=y \
-			EXTRA_CFLAGS=$(DOCKER_CROSS_COMPILER_CFLAGS)), \
-	"BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
+			EXTRA_CFLAGS="$(CROSS_CC_GUEST_CFLAGS)"), \
+	"BUILD","$(TARGET) guest-tests with docker qemu:$(DOCKER_IMAGE)")
 
 GUEST_BUILD=docker-build-guest-tests
 
-endif
 endif
 
 # Final targets
@@ -75,22 +74,22 @@ guest-tests: $(GUEST_BUILD)
 
 run-guest-tests: guest-tests
 	$(call quiet-command, \
-	(cd tests/tcg/$(TARGET_DIR) && \
-	 $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" \
+	(cd tests/tcg/$(TARGET) && \
+	 $(MAKE) -f $(TCG_MAKE) TARGET="$(TARGET)" \
 	 		SRC_PATH="$(SRC_PATH)" SPEED=$(SPEED) run), \
 	"RUN", "tests for $(TARGET_NAME)")
 
 else
 guest-tests:
 	$(call quiet-command, /bin/true, "BUILD", \
-		"$(TARGET_DIR) guest-tests SKIPPED")
+		"$(TARGET) guest-tests SKIPPED")
 
 run-guest-tests:
 	$(call quiet-command, /bin/true, "RUN", \
-		"tests for $(TARGET_DIR) SKIPPED")
+		"tests for $(TARGET) SKIPPED")
 endif
 
 # It doesn't matter if these don't exits
 .PHONY: clean-guest-tests
 clean-guest-tests:
-	rm -rf tests/tcg/$(TARGET_DIR)
+	rm -rf tests/tcg/$(TARGET)
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 8dbcba4474f..8808beaf74b 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -31,7 +31,7 @@
 
 all:
 -include ../../config-host.mak
--include ../../../$(TARGET_DIR)/config-target.mak
+-include ../config-$(TARGET).mak
 
 # for including , in command strings
 COMMA := ,
@@ -63,12 +63,6 @@ CFLAGS=
 QEMU_CFLAGS=
 LDFLAGS=
 
-# The QEMU for this TARGET
-ifdef CONFIG_USER_ONLY
-QEMU=../../../$(TARGET_DIR)/qemu-$(TARGET_NAME)
-else
-QEMU=../../../$(TARGET_DIR)/qemu-system-$(TARGET_NAME)
-endif
 QEMU_OPTS=
 
 
diff --git a/tests/tcg/aarch64/Makefile.include b/tests/tcg/aarch64/Makefile.include
deleted file mode 100644
index 5d4e4c6f99b..00000000000
--- a/tests/tcg/aarch64/Makefile.include
+++ /dev/null
@@ -1,8 +0,0 @@
-# Makefile.include for AArch64 targets
-#
-# We don't have any bigendian build tools so we only use this for AArch64
-
-ifeq ($(TARGET_NAME),aarch64)
-DOCKER_IMAGE=debian-buster-arm64-cross
-DOCKER_CROSS_COMPILER=aarch64-linux-gnu-gcc
-endif
diff --git a/tests/tcg/alpha/Makefile.include b/tests/tcg/alpha/Makefile.include
deleted file mode 100644
index c7dc48eadb0..00000000000
--- a/tests/tcg/alpha/Makefile.include
+++ /dev/null
@@ -1,2 +0,0 @@
-DOCKER_IMAGE=debian-alpha-cross
-DOCKER_CROSS_COMPILER=alpha-linux-gnu-gcc
diff --git a/tests/tcg/arm/Makefile.include b/tests/tcg/arm/Makefile.include
deleted file mode 100644
index 8e7eac008f9..00000000000
--- a/tests/tcg/arm/Makefile.include
+++ /dev/null
@@ -1,8 +0,0 @@
-# Makefile.include for all ARM targets
-#
-# We don't have any bigendian build tools so we only use this for armhf
-
-ifeq ($(TARGET_NAME),arm)
-DOCKER_IMAGE=debian-armhf-cross
-DOCKER_CROSS_COMPILER=arm-linux-gnueabihf-gcc
-endif
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
new file mode 100755
index 00000000000..5f794b664b8
--- /dev/null
+++ b/tests/tcg/configure.sh
@@ -0,0 +1,234 @@
+#! /bin/sh
+
+if test -z "$source_path"; then
+  echo Do not invoke this script directly.  It is called
+  echo automatically by configure.
+  exit 1
+fi
+
+write_c_skeleton() {
+    cat > $TMPC <<EOF
+int main(void) { return 0; }
+EOF
+}
+
+has() {
+  command -v "$1" >/dev/null 2>&1
+}
+
+do_compiler() {
+  # Run the compiler, capturing its output to the log. First argument
+  # is compiler binary to execute.
+  local compiler="$1"
+  shift
+  if test -n "$BASH_VERSION"; then eval '
+      echo >>config.log "
+funcs: ${FUNCNAME[*]}
+lines: ${BASH_LINENO[*]}"
+  '; fi
+  echo $compiler "$@" >> config.log
+  $compiler "$@" >> config.log 2>&1 || return $?
+}
+
+
+TMPDIR1="config-temp"
+TMPC="${TMPDIR1}/qemu-conf.c"
+TMPE="${TMPDIR1}/qemu-conf.exe"
+
+container="no"
+if has "docker" || has "podman"; then
+  container=$($python $source_path/tests/docker/docker.py probe)
+fi
+
+# cross compilers defaults, can be overridden with --cross-cc-ARCH
+: ${cross_cc_aarch64="aarch64-linux-gnu-gcc"}
+: ${cross_cc_aarch64_be="$cross_cc_aarch64"}
+: ${cross_cc_cflags_aarch64_be="-mbig-endian"}
+: ${cross_cc_arm="arm-linux-gnueabihf-gcc"}
+: ${cross_cc_cflags_armeb="-mbig-endian"}
+: ${cross_cc_i386="i386-pc-linux-gnu-gcc"}
+: ${cross_cc_cflags_i386="-m32"}
+: ${cross_cc_x86_64="x86_64-pc-linux-gnu-gcc"}
+: ${cross_cc_cflags_x86_64="-m64"}
+: ${cross_cc_ppc="powerpc-linux-gnu-gcc"}
+: ${cross_cc_cflags_ppc="-m32"}
+: ${cross_cc_ppc64="powerpc-linux-gnu-gcc"}
+: ${cross_cc_cflags_ppc64="-m64"}
+: ${cross_cc_ppc64le="powerpc64le-linux-gnu-gcc"}
+: ${cross_cc_cflags_s390x="-m64"}
+: ${cross_cc_cflags_sparc="-m32 -mv8plus -mcpu=ultrasparc"}
+: ${cross_cc_cflags_sparc64="-m64 -mcpu=ultrasparc"}
+
+for target in $target_list; do
+  arch=${target%%-*}
+  case $arch in
+    arm|armeb)
+      arches=arm
+      ;;
+    aarch64|aarch64_be)
+      arches="aarch64 arm"
+      ;;
+    mips*)
+      arches=mips
+      ;;
+    ppc*)
+      arches=ppc
+      ;;
+    sh4|sh4eb)
+      arches=sh4
+      ;;
+    x86_64)
+      arches="x86_64 i386"
+      ;;
+    xtensa|xtensaeb)
+      arches=xtensa
+      ;;
+    alpha|cris|hppa|i386|lm32|m68k|openrisc|riscv64|s390x|sh4|sparc64)
+      arches=$target
+      ;;
+    *)
+      continue
+      ;;
+  esac
+
+  container_image=
+  case $target in
+    aarch64-*)
+      # We don't have any bigendian build tools so we only use this for AArch64
+      container_image=debian-buster-arm64-cross
+      container_cross_cc=aarch64-linux-gnu-gcc
+      ;;
+    alpha-*)
+      container_image=debian-alpha-cross
+      container_cross_cc=alpha-linux-gnu-gcc
+      ;;
+    arm-*)
+      # We don't have any bigendian build tools so we only use this for AArch64
+      container_image=debian-armhf-cross
+      container_cross_cc=arm-linux-gnueabihf-gcc
+      ;;
+    cris-*)
+      container_image=fedora-cris-cross
+      container_cross_cc=cris-linux-gnu-gcc
+      ;;
+    hppa-*)
+      container_image=debian-hppa-cross
+      container_cross_cc=hppa-linux-gnu-gcc
+      ;;
+    i386-*)
+      container_image=fedora-i386-cross
+      container_cross_cc=gcc
+      ;;
+    m68k-*)
+      container_image=debian-m68k-cross
+      container_cross_cc=m68k-linux-gnu-gcc
+      ;;
+    mips64el-*)
+      container_image=debian-mips64el-cross
+      container_cross_cc=mips64el-linux-gnuabi64-gcc
+      ;;
+    mips64-*)
+      container_image=debian-mips64-cross
+      container_cross_cc=mips64-linux-gnuabi64-gcc
+      ;;
+    mipsel-*)
+      container_image=debian-mipsel-cross
+      container_cross_cc=mipsel-linux-gnu-gcc
+      ;;
+    mips-*)
+      container_image=debian-mips-cross
+      container_cross_cc=mips-linux-gnu-gcc
+      ;;
+    ppc-*)
+      container_image=debian-powerpc-cross
+      container_cross_cc=powerpc-linux-gnu-gcc
+      ;;
+    ppc64-*)
+      container_image=debian-ppc64-cross
+      container_cross_cc=powerpc64-linux-gnu-gcc
+      ;;
+    ppc64le-*)
+      container_image=debian-ppc64el-cross
+      container_cross_cc=powerpc64le-linux-gnu-gcc
+      ;;
+    riscv64-*)
+      container_image=debian-riscv64-cross
+      container_cross_cc=riscv64-linux-gnu-gcc
+      ;;
+    s390x-*)
+      container_image=debian-s390x-cross
+      container_cross_cc=s390x-linux-gnu-gcc
+      ;;
+    sh4-*)
+      container_image=debian-sh4-cross
+      container_cross_cc=sh4-linux-gnu-gcc
+      ;;
+    sparc64-*)
+      container_image=debian-sparc64-cross
+      container_cross_cc=sparc64-linux-gnu-gcc
+      ;;
+    xtensa*-softmmu)
+      container_image=debian-xtensa-cross
+
+      # default to the dc232b cpu
+      container_cross_cc=/opt/2018.02/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-gcc
+      ;;
+  esac
+
+  config_target_mak=tests/tcg/config-$target.mak
+
+  echo "# Automatically generated by configure - do not modify" > $config_target_mak
+  echo "TARGET_NAME=$arch" >> $config_target_mak
+  case $target in
+    *-linux-user | *-bsd-user)
+      echo "CONFIG_USER_ONLY=y" >> $config_target_mak
+      echo "QEMU=\$(BUILD_DIR)/$target/qemu-$arch" >> $config_target_mak
+      ;;
+    *-softmmu)
+      echo "CONFIG_SOFTMMU=y" >> $config_target_mak
+      echo "QEMU=\$(BUILD_DIR)/$target/qemu-system-$arch" >> $config_target_mak
+      ;;
+  esac
+
+  eval "target_compiler_cflags=\${cross_cc_cflags_$arch}"
+  echo "CROSS_CC_GUEST_CFLAGS=$target_compiler_cflags" >> $config_target_mak
+
+  got_cross_cc=no
+  for i in $arch $arches; do
+    if eval test "x\${cross_cc_$i+yes}" != xyes; then
+      continue
+    fi
+
+    eval "target_compiler=\${cross_cc_$i}"
+    if ! has $target_compiler; then
+      continue
+    fi
+    write_c_skeleton
+    if ! do_compiler "$target_compiler" $target_compiler_cflags -o $TMPE $TMPC -static ; then
+      # For host systems we might get away with building without -static
+      if ! do_compiler "$target_compiler" $target_compiler_cflags -o $TMPE $TMPC ; then
+        continue
+      fi
+      echo "CROSS_CC_GUEST_STATIC=y" >> $config_target_mak
+    else
+      echo "CROSS_CC_GUEST_STATIC=y" >> $config_target_mak
+    fi
+    echo "CROSS_CC_GUEST=$target_compiler" >> $config_target_mak
+    enabled_cross_compilers="$enabled_cross_compilers $target_compiler"
+    got_cross_cc=yes
+    break
+  done
+
+  if test $got_cross_cc = no && test "$docker" != no && test -n "$container_image"; then
+    echo "DOCKER_IMAGE=$container_image" >> $config_target_mak
+    echo "DOCKER_CROSS_CC_GUEST=$container_cross_cc" >> $config_target_mak
+  fi
+done
+
+# report container support state
+echo "cross containers  $container"
+
+if test -n "$enabled_cross_compilers"; then
+    echo
+    echo "NOTE: guest cross-compilers enabled:$enabled_cross_compilers"
+fi
diff --git a/tests/tcg/cris/Makefile.include b/tests/tcg/cris/Makefile.include
deleted file mode 100644
index 1c037824bff..00000000000
--- a/tests/tcg/cris/Makefile.include
+++ /dev/null
@@ -1,6 +0,0 @@
-#
-# Makefile.include for all CRIS targets
-#
-
-DOCKER_IMAGE=fedora-cris-cross
-DOCKER_CROSS_COMPILER=cris-linux-gnu-gcc
diff --git a/tests/tcg/hppa/Makefile.include b/tests/tcg/hppa/Makefile.include
deleted file mode 100644
index da2353430e2..00000000000
--- a/tests/tcg/hppa/Makefile.include
+++ /dev/null
@@ -1,2 +0,0 @@
-DOCKER_IMAGE=debian-hppa-cross
-DOCKER_CROSS_COMPILER=hppa-linux-gnu-gcc
diff --git a/tests/tcg/i386/Makefile.include b/tests/tcg/i386/Makefile.include
deleted file mode 100644
index be1c3008dd7..00000000000
--- a/tests/tcg/i386/Makefile.include
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# Makefile.include for all i386
-#
-# There is enough brokeness in x86_64 compilers that we don't default
-# to using the x86_64 system compiler for i386 binaries.
-#
-
-DOCKER_IMAGE=fedora-i386-cross
-DOCKER_CROSS_COMPILER=gcc
diff --git a/tests/tcg/m68k/Makefile.include b/tests/tcg/m68k/Makefile.include
deleted file mode 100644
index cd7c6bf50d7..00000000000
--- a/tests/tcg/m68k/Makefile.include
+++ /dev/null
@@ -1,2 +0,0 @@
-DOCKER_IMAGE=debian-m68k-cross
-DOCKER_CROSS_COMPILER=m68k-linux-gnu-gcc
diff --git a/tests/tcg/mips/Makefile.include b/tests/tcg/mips/Makefile.include
deleted file mode 100644
index 4a14fc078d2..00000000000
--- a/tests/tcg/mips/Makefile.include
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# Makefile.include for all MIPs targets
-#
-# As Debian doesn't support mip64 in big endian mode the only way to
-# build BE is to pass a working cross compiler to ./configure
-#
-
-ifeq ($(TARGET_NAME),mips64el)
-DOCKER_IMAGE=debian-mips64el-cross
-DOCKER_CROSS_COMPILER=mips64el-linux-gnuabi64-gcc
-else ifeq ($(TARGET_NAME),mips64)
-DOCKER_IMAGE=debian-mips64-cross
-DOCKER_CROSS_COMPILER=mips64-linux-gnuabi64-gcc
-else ifeq ($(TARGET_NAME),mipsel)
-DOCKER_IMAGE=debian-mipsel-cross
-DOCKER_CROSS_COMPILER=mipsel-linux-gnu-gcc
-else ifeq ($(TARGET_NAME),mips)
-DOCKER_IMAGE=debian-mips-cross
-DOCKER_CROSS_COMPILER=mips-linux-gnu-gcc
-endif
diff --git a/tests/tcg/ppc/Makefile.include b/tests/tcg/ppc/Makefile.include
deleted file mode 100644
index ae01fb8fadd..00000000000
--- a/tests/tcg/ppc/Makefile.include
+++ /dev/null
@@ -1,10 +0,0 @@
-ifeq ($(TARGET_NAME),ppc)
-DOCKER_IMAGE=debian-powerpc-cross
-DOCKER_CROSS_COMPILER=powerpc-linux-gnu-gcc
-else ifeq ($(TARGET_NAME),ppc64)
-DOCKER_IMAGE=debian-ppc64-cross
-DOCKER_CROSS_COMPILER=powerpc64-linux-gnu-gcc
-else ifeq ($(TARGET_NAME),ppc64le)
-DOCKER_IMAGE=debian-ppc64el-cross
-DOCKER_CROSS_COMPILER=powerpc64le-linux-gnu-gcc
-endif
diff --git a/tests/tcg/riscv/Makefile.include b/tests/tcg/riscv/Makefile.include
deleted file mode 100644
index d92ac6c89f0..00000000000
--- a/tests/tcg/riscv/Makefile.include
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# Makefile.include for all RISCV targets
-#
-# Debian only really cares about 64 bit going forward
-#
-
-ifeq ($(TARGET_NAME),riscv64)
-DOCKER_IMAGE=debian-riscv64-cross
-DOCKER_CROSS_COMPILER=riscv64-linux-gnu-gcc
-endif
diff --git a/tests/tcg/s390x/Makefile.include b/tests/tcg/s390x/Makefile.include
deleted file mode 100644
index 1f58115d961..00000000000
--- a/tests/tcg/s390x/Makefile.include
+++ /dev/null
@@ -1,2 +0,0 @@
-DOCKER_IMAGE=debian-s390x-cross
-DOCKER_CROSS_COMPILER=s390x-linux-gnu-gcc
diff --git a/tests/tcg/sh4/Makefile.include b/tests/tcg/sh4/Makefile.include
deleted file mode 100644
index ad21594d9d8..00000000000
--- a/tests/tcg/sh4/Makefile.include
+++ /dev/null
@@ -1,4 +0,0 @@
-ifneq ($(TARGET_NAME), sh4eb)
-DOCKER_IMAGE=debian-sh4-cross
-DOCKER_CROSS_COMPILER=sh4-linux-gnu-gcc
-endif
diff --git a/tests/tcg/sparc64/Makefile.include b/tests/tcg/sparc64/Makefile.include
deleted file mode 100644
index 95fc8dee9f4..00000000000
--- a/tests/tcg/sparc64/Makefile.include
+++ /dev/null
@@ -1,2 +0,0 @@
-DOCKER_IMAGE=debian-sparc64-cross
-DOCKER_CROSS_COMPILER=sparc64-linux-gnu-gcc
diff --git a/tests/tcg/xtensa/Makefile.include b/tests/tcg/xtensa/Makefile.include
deleted file mode 100644
index 423c00a5d31..00000000000
--- a/tests/tcg/xtensa/Makefile.include
+++ /dev/null
@@ -1,11 +0,0 @@
-# Makefile.include for xtensa targets
-#
-# The compilers can only be used for building system tests
-
-ifeq ($(CONFIG_SOFTMMU),y)
-DOCKER_IMAGE=debian-xtensa-cross
-
-# default to the dc232b cpu
-DOCKER_CROSS_COMPILER=/opt/2018.02/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-gcc
-DOCKER_CROSS_LINKER=/opt/2018.02/xtensa-dc232b-elf/bin/xtensa-dc232b-elf-ld
-endif
-- 
2.20.1


