Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF22C28E83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A987214F1
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zljxk9/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A987214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAMT-0008RX-EY
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6v-00015t-MH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6r-0005IT-2G
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599219744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYope/bp7T+nDpS/OJ5elZwOWkliANZisY3l2blcxRo=;
 b=Zljxk9/KtO3+0yAHYLjAEIqzYJhV1qVCcBFNcKTydakDY2USLI8LsaL5Lwn7Bm5sIn+XzG
 54pJDLJlxFqUUbUqvjF1WGHH2hu5/1AzS+SW+o0AXutiEUkuuE0USqbrrdj+vteUssJ3B9
 B/t6WPQbJHj3xzxvqFQ8ABMN6zJ5WGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-iW1WCPkUMKyovLU-r60rDA-1; Fri, 04 Sep 2020 07:42:22 -0400
X-MC-Unique: iW1WCPkUMKyovLU-r60rDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DDBF90AD8A
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:45 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52DD76FDB6
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/46] configure: do not include dependency flags in
 QEMU_CFLAGS and LIBS
Date: Fri,  4 Sep 2020 07:41:14 -0400
Message-Id: <20200904114122.31307-39-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 06:46:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 6 files changed, 5 insertions(+), 45 deletions(-)

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
index e63b356234..0ca0eaf266 100755
--- a/configure
+++ b/configure
@@ -814,7 +814,6 @@ FreeBSD)
   audio_drv_list="oss try-sdl"
   audio_possible_drivers="oss sdl pa"
   # needed for kinfo_getvmmap(3) in libutil.h
-  LIBS="-lutil $LIBS"
   netmap=""  # enable netmap autodetect
   HOST_VARIANT_DIR="freebsd"
 ;;
@@ -872,13 +871,10 @@ SunOS)
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
@@ -948,11 +944,7 @@ if test "$mingw32" = "yes" ; then
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
@@ -2673,7 +2665,6 @@ if test "$xen" != "no" ; then
     if $pkg_config --exists xentoolcore; then
       xen_pc="$xen_pc xentoolcore"
     fi
-    QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     xen_cflags="$($pkg_config --cflags $xen_pc)"
     xen_libs="$($pkg_config --libs $xen_pc)"
   else
@@ -3058,8 +3049,6 @@ if test "$gnutls" != "no"; then
         # At least ubuntu 18.04 ships only shared libraries.
         write_c_skeleton
         if compile_prog "" "$gnutls_libs" ; then
-            LIBS="$gnutls_libs $LIBS"
-            QEMU_CFLAGS="$QEMU_CFLAGS $gnutls_cflags"
             pass="yes"
         fi
     fi
@@ -3129,8 +3118,6 @@ if test "$nettle" != "no"; then
         # Link test to make sure the given libraries work (e.g for static).
         write_c_skeleton
         if compile_prog "" "$nettle_libs" ; then
-            LIBS="$nettle_libs $LIBS"
-            QEMU_CFLAGS="$QEMU_CFLAGS $nettle_cflags"
             if test -z "$gcrypt"; then
                gcrypt="no"
             fi
@@ -3173,8 +3160,6 @@ if test "$gcrypt" != "no"; then
         # Link test to make sure the given libraries work (e.g for static).
         write_c_skeleton
         if compile_prog "" "$gcrypt_libs" ; then
-            LIBS="$gcrypt_libs $LIBS"
-            QEMU_CFLAGS="$QEMU_CFLAGS $gcrypt_cflags"
             pass="yes"
         fi
     fi
@@ -3746,7 +3731,6 @@ for i in $glib_modules; do
     if $pkg_config --atleast-version=$glib_req_ver $i; then
         glib_cflags=$($pkg_config --cflags $i)
         glib_libs=$($pkg_config --libs $i)
-        LIBS="$glib_libs $LIBS"
     else
         error_exit "glib-$glib_req_ver $i is required to compile QEMU"
     fi
@@ -4056,11 +4040,6 @@ if test "$linux_io_uring" != "no" ; then
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
@@ -4105,7 +4084,6 @@ EOF
   elif compile_prog "-DCONFIG_LIBATTR" "-lattr" ; then
     attr=yes
     libattr_libs="-lattr"
-    LIBS="$libattr_libs $LIBS"
     libattr=yes
   else
     if test "$attr" = "yes" ; then
@@ -4225,7 +4203,6 @@ if test "$opengl" != "no" ; then
     if test "$gtk" = "yes" && $pkg_config --exists "$gtkpackage >= 3.16"; then
         gtk_gl="yes"
     fi
-    QEMU_CFLAGS="$QEMU_CFLAGS $opengl_cflags"
   else
     if test "$opengl" = "yes" ; then
       feature_not_found "opengl" "Please install opengl (mesa) devel pkgs: $opengl_pkgs"
@@ -4974,7 +4951,6 @@ EOF
      $pkg_config --atleast-version=0.12.3 spice-protocol && \
      compile_prog "$spice_cflags" "$spice_libs" ; then
     spice="yes"
-    QEMU_CFLAGS="$QEMU_CFLAGS $spice_cflags"
   else
     if test "$spice" = "yes" ; then
       feature_not_found "spice" \
@@ -5157,7 +5133,6 @@ case "$capstone" in
       git_submodules="${git_submodules} capstone"
     fi
     mkdir -p capstone
-    QEMU_CFLAGS="$QEMU_CFLAGS -I${source_path}/capstone/include"
     if test "$mingw32" = "yes"; then
       LIBCAPSTONE=capstone.lib
     else
@@ -5170,7 +5145,6 @@ case "$capstone" in
   system)
     capstone_libs="$($pkg_config --libs capstone)"
     capstone_cflags="$($pkg_config --cflags capstone)"
-    QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags capstone)"
     ;;
 
   no)
@@ -5319,8 +5293,6 @@ EOF
     else
       urcu_bp_libs="-lurcu-bp"
     fi
-
-    LIBS="$lttng_ust_libs $urcu_bp_libs $LIBS"
   else
     error_exit "Trace backend 'ust' missing lttng-ust header files"
   fi
@@ -6101,7 +6073,6 @@ if test "$libpmem" != "no"; then
 		libpmem="yes"
 		libpmem_libs=$($pkg_config --libs libpmem)
 		libpmem_cflags=$($pkg_config --cflags libpmem)
-		QEMU_CFLAGS="$QEMU_CFLAGS $libpmem_cflags"
 	else
 		if test "$libpmem" = "yes" ; then
 			feature_not_found "libpmem" "Install nvml or pmdk"
@@ -6118,7 +6089,6 @@ if test "$libdaxctl" != "no"; then
 		libdaxctl="yes"
 		libdaxctl_libs=$($pkg_config --libs libdaxctl)
 		libdaxctl_cflags=$($pkg_config --cflags libdaxctl)
-		QEMU_CFLAGS="$QEMU_CFLAGS $libdaxctl_cflags"
 	else
 		if test "$libdaxctl" = "yes" ; then
 			feature_not_found "libdaxctl" "Install libdaxctl"
@@ -6301,11 +6271,6 @@ if test "$libudev" != "no" ; then
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
@@ -6490,10 +6455,6 @@ echo_version() {
     fi
 }
 
-# prepend ftd flags after all config tests are done
-QEMU_CFLAGS="$fdt_cflags $QEMU_CFLAGS"
-QEMU_LDFLAGS="$fdt_ldflags $QEMU_LDFLAGS"
-
 config_host_mak="config-host.mak"
 
 echo "# Automatically generated by configure - do not modify" > $config_host_mak
@@ -7421,7 +7382,6 @@ echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
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
-- 
2.26.2



