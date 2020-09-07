Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E689C2BB84
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD202080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXgrufAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD202080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFKHl-0007UU-0q
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kFKFm-0004xx-8T
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:44:26 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:41906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kFKFk-0000ZP-6u
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 12:44:25 -0400
Received: by mail-ej1-x633.google.com with SMTP id lo4so18965727ejb.8
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NJCG291sP5k6rqzSSOSg1NyDHQEnkAmTSor1WlXw0DU=;
 b=nXgrufAJbvLCPRmvq13zIrV8mDHSnNAdQR5SDsq0PjCjzEvuU2t+ZmBtOWJTZBYIR0
 AqAYD+rWu3w82zLQoH3G80VgVgR0/ZPvefmOBnokyzzVcAjt9+mJxOmsgRtL4pKNXFKm
 rEmb3XNqxVC5eyGYuILuQm6BYjtRbjYjVOhNVCcHcIjNIZNeFDGZI3X0dTi7cxYsO2bJ
 xIOAsc78F4NRo2vGK4msVZZi8TaPXd6r/U7Z/0Yc27zKCkdDE6qSSvcjXQutxHn/g8hl
 vBxzqu3kMIGV/3MTkI0xTh4e2Y4V3qGVbF6Z5aZNVFtnkPo7pQXbiFG1/gT4AEXoZjR6
 cOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NJCG291sP5k6rqzSSOSg1NyDHQEnkAmTSor1WlXw0DU=;
 b=fSLhK4kc5EGUUd69t3BVqE+JOhG6ChnNLTgbv4TgOtr3nyOjwm/H4z66GFxflavq2g
 v8sNxrzhIhDrbOlfJk5J6E+QoGLSX5OUYPbGltJcgibsLHsgBTO4MW1mYdvYLLqt68/0
 iYrTVKlIvw004MX1RrgwH2UUrp8Aiv5sfianJUMmAIGdlPbyFFJnhL/zex0pXulKsVDo
 Ts/5Ag8Iu9TlTDc95z5tDKUkw/3SIf7PIm0avgt4HJqVNaOcDGJvhjWhFaz3k3u+ZC9m
 5UupD8HOXJpxII2jooJnZag6soKQcb2JUU4ZRnzSzF3qwQOqzG6E1CbFVzpIY7HjAqIL
 nyug==
X-Gm-Message-State: AOAM5324/13JdSqGkLEOxEtRg+L37yUZXpG4MHt/vi2iJnGDOIWdE8g3
 siSyl9zIWrYg9oRi+tupqb5RUOVk3X8=
X-Google-Smtp-Source: ABdhPJxqSI1Kafahr+mYf258sK1ApX4ulrplmXfj3oNj/THNKN84wSQnEIB/f0f0M2vt8gbIPiSwng==
X-Received: by 2002:a17:906:715b:: with SMTP id
 z27mr23224920ejj.166.1599497062347; 
 Mon, 07 Sep 2020 09:44:22 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:6891:d6db:f6ec:d1df])
 by smtp.gmail.com with ESMTPSA id n20sm15760391ejg.65.2020.09.07.09.44.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:44:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/46] configure: do not include dependency flags in
 QEMU_CFLAGS and LIBS
Date: Mon,  7 Sep 2020 18:44:21 +0200
Message-Id: <20200907164421.19886-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907164421.19886-1-pbonzini@redhat.com>
References: <20200907164421.19886-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ej1-x633.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All Meson executables should specify their dependencies explicitly, either
directly or indirectly via declare_dependency.  Makefiles instead did
not propagate dependencies correctly from static libraries, for example.
Therefore, flags for dependencies need not be included in QEMU_CFLAGS.
LIBS is not used at all, so drop that one as well.

In a few cases the dependencies were not yet specified, so add them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile             |  2 +-
 configure            | 40 ----------------------------------------
 hw/arm/meson.build   |  2 +-
 hw/mips/meson.build  |  2 +-
 hw/riscv/meson.build |  2 +-
 monitor/meson.build  |  2 +-
 ui/meson.build       |  3 ++-
 7 files changed, 7 insertions(+), 46 deletions(-)

diff --git a/Makefile b/Makefile
index 678e76d6f2..d6c5c9fdef 100644
--- a/Makefile
+++ b/Makefile
@@ -155,7 +155,7 @@ dtc/%: .git-submodule-status
 # Therefore we replicate some of the logic in the sub-makefile.
 # Remove all the extra -Warning flags that QEMU uses that Capstone doesn't;
 # no need to annoy QEMU developers with such things.
-CAP_CFLAGS = $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS))
+CAP_CFLAGS = $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS)) $(CAPSTONE_CFLAGS)
 CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM
 CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
diff --git a/configure b/configure
index e18f3e2156..b94ba9b239 100755
--- a/configure
+++ b/configure
@@ -832,7 +832,6 @@ FreeBSD)
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl pa"
   # needed for kinfo_getvmmap(3) in libutil.h
-  LIBS="-lutil $LIBS"
   netmap=""  # enable netmap autodetect
   HOST_VARIANT_DIR="freebsd"
 ;;
@@ -890,13 +889,10 @@ SunOS)
   QEMU_CFLAGS="-D_XOPEN_SOURCE=600 $QEMU_CFLAGS"
 # needed for TIOCWIN* defines in termios.h
   QEMU_CFLAGS="-D__EXTENSIONS__ $QEMU_CFLAGS"
-  solarisnetlibs="-lsocket -lnsl -lresolv"
-  LIBS="$solarisnetlibs $LIBS"
 ;;
 Haiku)
   haiku="yes"
   QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS -DBSD_SOURCE $QEMU_CFLAGS"
-  LIBS="-lposix_error_mapper -lnetwork -lbsd $LIBS"
 ;;
 Linux)
   audio_drv_list="try-pa oss"
@@ -966,11 +962,7 @@ if test "$mingw32" = "yes" ; then
   HOST_DSOSUF=".dll"
   # MinGW needs -mthreads for TLS and macro _MT.
   CFLAGS="-mthreads $CFLAGS"
-  LIBS="-lwinmm -lws2_32 $LIBS"
   write_c_skeleton;
-  if compile_prog "" "-liberty" ; then
-    LIBS="-liberty $LIBS"
-  fi
   prefix="c:/Program Files/QEMU"
   qemu_suffix=""
   libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi -lnetapi32 $libs_qga"
@@ -2691,7 +2683,6 @@ if test "$xen" != "no" ; then
     if $pkg_config --exists xentoolcore; then
       xen_pc="$xen_pc xentoolcore"
     fi
-    QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     xen_cflags="$($pkg_config --cflags $xen_pc)"
     xen_libs="$($pkg_config --libs $xen_pc)"
   else
@@ -3076,8 +3067,6 @@ if test "$gnutls" != "no"; then
         # At least ubuntu 18.04 ships only shared libraries.
         write_c_skeleton
         if compile_prog "" "$gnutls_libs" ; then
-            LIBS="$gnutls_libs $LIBS"
-            QEMU_CFLAGS="$QEMU_CFLAGS $gnutls_cflags"
             pass="yes"
         fi
     fi
@@ -3147,8 +3136,6 @@ if test "$nettle" != "no"; then
         # Link test to make sure the given libraries work (e.g for static).
         write_c_skeleton
         if compile_prog "" "$nettle_libs" ; then
-            LIBS="$nettle_libs $LIBS"
-            QEMU_CFLAGS="$QEMU_CFLAGS $nettle_cflags"
             if test -z "$gcrypt"; then
                gcrypt="no"
             fi
@@ -3191,8 +3178,6 @@ if test "$gcrypt" != "no"; then
         # Link test to make sure the given libraries work (e.g for static).
         write_c_skeleton
         if compile_prog "" "$gcrypt_libs" ; then
-            LIBS="$gcrypt_libs $LIBS"
-            QEMU_CFLAGS="$QEMU_CFLAGS $gcrypt_cflags"
             pass="yes"
         fi
     fi
@@ -3764,7 +3749,6 @@ for i in $glib_modules; do
     if $pkg_config --atleast-version=$glib_req_ver $i; then
         glib_cflags=$($pkg_config --cflags $i)
         glib_libs=$($pkg_config --libs $i)
-        LIBS="$glib_libs $LIBS"
     else
         error_exit "glib-$glib_req_ver $i is required to compile QEMU"
     fi
@@ -4074,11 +4058,6 @@ if test "$linux_io_uring" != "no" ; then
     linux_io_uring_cflags=$($pkg_config --cflags liburing)
     linux_io_uring_libs=$($pkg_config --libs liburing)
     linux_io_uring=yes
-
-    # io_uring is used in libqemuutil.a where per-file -libs variables are not
-    # seen by programs linking the archive.  It's not ideal, but just add the
-    # library dependency globally.
-    LIBS="$linux_io_uring_libs $LIBS"
   else
     if test "$linux_io_uring" = "yes" ; then
       feature_not_found "linux io_uring" "Install liburing devel"
@@ -4123,7 +4102,6 @@ EOF
   elif compile_prog "-DCONFIG_LIBATTR" "-lattr" ; then
     attr=yes
     libattr_libs="-lattr"
-    LIBS="$libattr_libs $LIBS"
     libattr=yes
   else
     if test "$attr" = "yes" ; then
@@ -4243,7 +4221,6 @@ if test "$opengl" != "no" ; then
     if test "$gtk" = "yes" && $pkg_config --exists "$gtkpackage >= 3.16"; then
         gtk_gl="yes"
     fi
-    QEMU_CFLAGS="$QEMU_CFLAGS $opengl_cflags"
   else
     if test "$opengl" = "yes" ; then
       feature_not_found "opengl" "Please install opengl (mesa) devel pkgs: $opengl_pkgs"
@@ -4998,7 +4975,6 @@ EOF
      $pkg_config --atleast-version=0.12.3 spice-protocol && \
      compile_prog "$spice_cflags" "$spice_libs" ; then
     spice="yes"
-    QEMU_CFLAGS="$QEMU_CFLAGS $spice_cflags"
   else
     if test "$spice" = "yes" ; then
       feature_not_found "spice" \
@@ -5181,7 +5157,6 @@ case "$capstone" in
       git_submodules="${git_submodules} capstone"
     fi
     mkdir -p capstone
-    QEMU_CFLAGS="$QEMU_CFLAGS -I${source_path}/capstone/include"
     if test "$mingw32" = "yes"; then
       LIBCAPSTONE=capstone.lib
     else
@@ -5194,7 +5169,6 @@ case "$capstone" in
   system)
     capstone_libs="$($pkg_config --libs capstone)"
     capstone_cflags="$($pkg_config --cflags capstone)"
-    QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
     ;;
 
   no)
@@ -5343,8 +5317,6 @@ EOF
     else
       urcu_bp_libs="-lurcu-bp"
     fi
-
-    LIBS="$lttng_ust_libs $urcu_bp_libs $LIBS"
   else
     error_exit "Trace backend 'ust' missing lttng-ust header files"
   fi
@@ -6125,7 +6097,6 @@ if test "$libpmem" != "no"; then
 		libpmem="yes"
 		libpmem_libs=$($pkg_config --libs libpmem)
 		libpmem_cflags=$($pkg_config --cflags libpmem)
-		QEMU_CFLAGS="$QEMU_CFLAGS $libpmem_cflags"
 	else
 		if test "$libpmem" = "yes" ; then
 			feature_not_found "libpmem" "Install nvml or pmdk"
@@ -6142,7 +6113,6 @@ if test "$libdaxctl" != "no"; then
 		libdaxctl="yes"
 		libdaxctl_libs=$($pkg_config --libs libdaxctl)
 		libdaxctl_cflags=$($pkg_config --cflags libdaxctl)
-		QEMU_CFLAGS="$QEMU_CFLAGS $libdaxctl_cflags"
 	else
 		if test "$libdaxctl" = "yes" ; then
 			feature_not_found "libdaxctl" "Install libdaxctl"
@@ -6325,11 +6295,6 @@ if test "$libudev" != "no" ; then
   fi
 fi
 
-# Now we've finished running tests it's OK to add -Werror to the compiler flags
-if test "$werror" = "yes"; then
-    QEMU_CFLAGS="-Werror $QEMU_CFLAGS"
-fi
-
 # Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
 if test "$solaris" = "no" && test "$tsan" = "no"; then
     if $ld --version 2>/dev/null | grep "GNU ld" >/dev/null 2>/dev/null ; then
@@ -6546,10 +6511,6 @@ echo_version() {
     fi
 }
 
-# prepend ftd flags after all config tests are done
-QEMU_CFLAGS="$fdt_cflags $QEMU_CFLAGS"
-QEMU_LDFLAGS="$fdt_ldflags $QEMU_LDFLAGS"
-
 config_host_mak="config-host.mak"
 
 echo "# Automatically generated by configure - do not modify" > $config_host_mak
@@ -7482,7 +7443,6 @@ echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
 echo "LDFLAGS_NOPIE=$LDFLAGS_NOPIE" >> $config_host_mak
 echo "LD_REL_FLAGS=$LD_REL_FLAGS" >> $config_host_mak
 echo "LD_I386_EMULATION=$ld_i386_emulation" >> $config_host_mak
-echo "LIBS+=$LIBS" >> $config_host_mak
 echo "LIBS_TOOLS+=$libs_tools" >> $config_host_mak
 echo "PTHREAD_LIB=$PTHREAD_LIB" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 1ae5e17eeb..8480b7f37d 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,5 +1,5 @@
 arm_ss = ss.source_set()
-arm_ss.add(files('boot.c'))
+arm_ss.add(files('boot.c'), fdt)
 arm_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
 arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index 6ac9dc4cff..46294b7382 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -4,7 +4,7 @@ mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
 mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
 mips_ss.add(when: 'CONFIG_MALTA', if_true: files('gt64xxx_pci.c', 'malta.c'))
 mips_ss.add(when: 'CONFIG_MIPSSIM', if_true: files('mipssim.c'))
-mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: files('boston.c'))
+mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: [files('boston.c'), fdt])
 mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
 mips_ss.add(when: 'CONFIG_R4K', if_true: files('r4k.c'))
 
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 25af9db75e..fe2ea75f65 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,5 +1,5 @@
 riscv_ss = ss.source_set()
-riscv_ss.add(files('boot.c'))
+riscv_ss.add(files('boot.c'), fdt)
 riscv_ss.add(files('numa.c'))
 riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
diff --git a/monitor/meson.build b/monitor/meson.build
index 0484a64341..eb2a534fdc 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -6,4 +6,4 @@ softmmu_ss.add(files(
   'qmp-cmds.c',
 ))
 
-specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('misc.c'))
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files('misc.c'), spice])
diff --git a/ui/meson.build b/ui/meson.build
index 82f60756d9..dd6c110136 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -1,5 +1,5 @@
 softmmu_ss.add(pixman)
-specific_ss.add(pixman)   # for the include path
+specific_ss.add(when: ['CONFIG_SOFTMMU'], if_true: pixman)   # for the include path
 
 softmmu_ss.add(files(
   'console.c',
@@ -35,6 +35,7 @@ softmmu_ss.add_all(when: vnc, if_true: vnc_ss)
 softmmu_ss.add(when: vnc, if_false: files('vnc-stubs.c'))
 softmmu_ss.add(when: [opengl, 'CONFIG_OPENGL'], if_true: files('shader.c', 'console-gl.c', 'egl-helpers.c', 'egl-context.c'))
 softmmu_ss.add(when: [opengl, 'CONFIG_OPENGL_DMABUF'], if_true: files('egl-headless.c'))
+specific_ss.add(when: ['CONFIG_SOFTMMU'], if_true: opengl)
 
 ui_modules = {}
 
-- 
2.26.2

