Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A35EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235D82071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSJ0AGbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235D82071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuf9b-0004dX-MC
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuj-0001vF-CM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucuh-0001T4-CI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46146
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucuh-0001Sl-70
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3R7VMZI2FdMTPYoKDcrZxqTkzH07EEWxInSe9BWbR6U=;
 b=RSJ0AGbYi3jAO2JNTRR5obQHCrTepibGpIb1bmx3kRHPzfnCYrxkuPf6UVvk9TQWUCGStp
 Iil3StFBk9oE1Jb9dmn1aFezC/k6hVDdj/XE7En0eogFdbhwOFtPvogM/m6fkIbqZfjyhA
 doxJ1Sg0TBDRSWX7UTPIc7vvM3UZI6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-NGyHtsiRPNOXVKjNDEa4PQ-1; Thu, 23 Jan 2020 08:52:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28B8110110C5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:48 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2544C1CB;
 Thu, 23 Jan 2020 13:52:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 58/59] build-sys: clean up flags included in the linker command
 line
Date: Thu, 23 Jan 2020 14:50:48 +0100
Message-Id: <1579787449-27599-59-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: NGyHtsiRPNOXVKjNDEa4PQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Some of the CFLAGS that are discovered during configure, for example
compiler warnings, are being included on the linker command line because
QEMU_CFLAGS is added to it.  Other flags, such as the -m32, appear twice
because they are included in both QEMU_CFLAGS and LDFLAGS.  All this
leads to confusion with respect to what goes in which Makefile variables
(and we have plenty).

So, introduce QEMU_LDFLAGS for flags discovered by configure, following
the lead of QEMU_CFLAGS, and stop adding to it:

1) options that are already in CFLAGS, for example "-g"

2) duplicate options

At the same time, options that _are_ needed by both compiler and linker
must now be added to both QEMU_CFLAGS and QEMU_LDFLAGS, which is clearer.
This is mostly -fsanitize options.

Meson will not include CFLAGS on the linker command line, do the same in ou=
r
build system as well.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml                 |  4 +--
 Makefile                    |  4 +--
 configure                   | 60 ++++++++++++++++++++++-------------------=
----
 qga/vss-win32/Makefile.objs |  4 +--
 rules.mak                   |  4 +--
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 6c1038a..142d28f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -179,7 +179,7 @@ matrix:
       compiler: clang
       before_script:
         - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags=3D"-fsanitize=3Dun=
defined -Werror" || { cat config.log && exit 1; }
+        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags=3D"-fsanitize=3Dun=
defined -Werror" --extra-ldflags=3D"-fsanitize=3Dundefined" || { cat config=
.log && exit 1; }
=20
=20
     - env:
@@ -327,7 +327,7 @@ matrix:
         - TEST_CMD=3D""
       before_script:
         - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -Wno-er=
ror=3Dstringop-truncation -fsanitize=3Dthread -fuse-ld=3Dgold" || { cat con=
fig.log && exit 1; }
+        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -Wno-er=
ror=3Dstringop-truncation -fsanitize=3Dthread" --extra-ldflags=3D"-fsanitiz=
e=3Dthread -fuse-ld=3Dgold" || { cat config.log && exit 1; }
=20
=20
     # Run check-tcg against linux-user
diff --git a/Makefile b/Makefile
index 6562b0d..c20c6fe 100644
--- a/Makefile
+++ b/Makefile
@@ -490,7 +490,7 @@ DTC_CPPFLAGS=3D-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$=
(SRC_PATH)/dtc/libfdt
=20
 .PHONY: dtc/all
 dtc/all: .git-submodule-status dtc/libfdt dtc/tests
-=09$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS=3D"$(DTC_CPPFLAG=
S)" CFLAGS=3D"$(DTC_CFLAGS)" LDFLAGS=3D"$(LDFLAGS)" ARFLAGS=3D"$(ARFLAGS)" =
CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,=
)
+=09$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS=3D"$(DTC_CPPFLAG=
S)" CFLAGS=3D"$(DTC_CFLAGS)" LDFLAGS=3D"$(QEMU_LDFLAGS)" ARFLAGS=3D"$(ARFLA=
GS)" CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libf=
dt.a,)
=20
 dtc/%: .git-submodule-status
 =09@mkdir -p $@
@@ -517,7 +517,7 @@ slirp/all: .git-submodule-status
 =09=09BUILD_DIR=3D"$(BUILD_DIR)/slirp" =09=09=09\
 =09=09PKG_CONFIG=3D"$(PKG_CONFIG)" =09=09=09=09\
 =09=09CC=3D"$(CC)" AR=3D"$(AR)" =09LD=3D"$(LD)" RANLIB=3D"$(RANLIB)"=09\
-=09=09CFLAGS=3D"$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS=3D"$(LDFLAGS)")
+=09=09CFLAGS=3D"$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS=3D"$(QEMU_LDFLAGS)")
=20
 # Compatibility gunk to keep make working across the rename of targets
 # for recursion, to be removed some time after 4.1.
diff --git a/configure b/configure
index c67a7e7..b308150 100755
--- a/configure
+++ b/configure
@@ -126,7 +126,7 @@ compile_object() {
 compile_prog() {
   local_cflags=3D"$1"
   local_ldflags=3D"$2"
-  do_cc $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $LDFLAGS $local_ldflags
+  do_cc $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $QEMU_LDFLAGS $local_ldf=
lags
 }
=20
 # symbolically link $1 to $2.  Portable version of "ln -sf".
@@ -526,7 +526,7 @@ for opt do
   ;;
   --extra-cxxflags=3D*) QEMU_CXXFLAGS=3D"$QEMU_CXXFLAGS $optarg"
   ;;
-  --extra-ldflags=3D*) LDFLAGS=3D"$LDFLAGS $optarg"
+  --extra-ldflags=3D*) QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $optarg"
                      EXTRA_LDFLAGS=3D"$optarg"
   ;;
   --enable-debug-info) debug_info=3D"yes"
@@ -599,7 +599,6 @@ QEMU_INCLUDES=3D"-iquote . -iquote \$(SRC_PATH) -iquote=
 \$(SRC_PATH)/accel/tcg -iq
 QEMU_INCLUDES=3D"$QEMU_INCLUDES -iquote \$(SRC_PATH)/disas/libvixl"
 if test "$debug_info" =3D "yes"; then
     CFLAGS=3D"-g $CFLAGS"
-    LDFLAGS=3D"-g $LDFLAGS"
 fi
=20
 # running configure in the source tree?
@@ -845,12 +844,12 @@ Darwin)
   LDFLAGS_SHARED=3D"-bundle -undefined dynamic_lookup"
   if [ "$cpu" =3D "x86_64" ] ; then
     QEMU_CFLAGS=3D"-arch x86_64 $QEMU_CFLAGS"
-    LDFLAGS=3D"-arch x86_64 $LDFLAGS"
+    QEMU_LDFLAGS=3D"-arch x86_64 $QEMU_LDFLAGS"
   fi
   cocoa=3D"yes"
   audio_drv_list=3D"coreaudio try-sdl"
   audio_possible_drivers=3D"coreaudio sdl"
-  LDFLAGS=3D"-framework CoreFoundation -framework IOKit $LDFLAGS"
+  QEMU_LDFLAGS=3D"-framework CoreFoundation -framework IOKit $QEMU_LDFLAGS=
"
   libs_softmmu=3D"-F/System/Library/Frameworks -framework Cocoa -framework=
 IOKit $libs_softmmu"
   # Disable attempts to use ObjectiveC features in os/object.h since they
   # won't work when we're compiling with gcc as a C compiler.
@@ -1025,7 +1024,7 @@ for opt do
   ;;
   --static)
     static=3D"yes"
-    LDFLAGS=3D"-static $LDFLAGS"
+    QEMU_LDFLAGS=3D"-static $QEMU_LDFLAGS"
     QEMU_PKG_CONFIG_FLAGS=3D"--static $QEMU_PKG_CONFIG_FLAGS"
   ;;
   --mandir=3D*) mandir=3D"$optarg"
@@ -1551,42 +1550,42 @@ done
 case "$cpu" in
     ppc)
            CPU_CFLAGS=3D"-m32"
-           LDFLAGS=3D"-m32 $LDFLAGS"
+           QEMU_LDFLAGS=3D"-m32 $QEMU_LDFLAGS"
            ;;
     ppc64)
            CPU_CFLAGS=3D"-m64"
-           LDFLAGS=3D"-m64 $LDFLAGS"
+           QEMU_LDFLAGS=3D"-m64 $QEMU_LDFLAGS"
            ;;
     sparc)
            CPU_CFLAGS=3D"-m32 -mv8plus -mcpu=3Dultrasparc"
-           LDFLAGS=3D"-m32 -mv8plus $LDFLAGS"
+           QEMU_LDFLAGS=3D"-m32 -mv8plus $QEMU_LDFLAGS"
            ;;
     sparc64)
            CPU_CFLAGS=3D"-m64 -mcpu=3Dultrasparc"
-           LDFLAGS=3D"-m64 $LDFLAGS"
+           QEMU_LDFLAGS=3D"-m64 $QEMU_LDFLAGS"
            ;;
     s390)
            CPU_CFLAGS=3D"-m31"
-           LDFLAGS=3D"-m31 $LDFLAGS"
+           QEMU_LDFLAGS=3D"-m31 $QEMU_LDFLAGS"
            ;;
     s390x)
            CPU_CFLAGS=3D"-m64"
-           LDFLAGS=3D"-m64 $LDFLAGS"
+           QEMU_LDFLAGS=3D"-m64 $QEMU_LDFLAGS"
            ;;
     i386)
            CPU_CFLAGS=3D"-m32"
-           LDFLAGS=3D"-m32 $LDFLAGS"
+           QEMU_LDFLAGS=3D"-m32 $QEMU_LDFLAGS"
            ;;
     x86_64)
            # ??? Only extremely old AMD cpus do not have cmpxchg16b.
            # If we truly care, we should simply detect this case at
            # runtime and generate the fallback to serial emulation.
            CPU_CFLAGS=3D"-m64 -mcx16"
-           LDFLAGS=3D"-m64 $LDFLAGS"
+           QEMU_LDFLAGS=3D"-m64 $QEMU_LDFLAGS"
            ;;
     x32)
            CPU_CFLAGS=3D"-mx32"
-           LDFLAGS=3D"-mx32 $LDFLAGS"
+           QEMU_LDFLAGS=3D"-mx32 $QEMU_LDFLAGS"
            ;;
     # No special flags required for other host CPUs
 esac
@@ -1967,6 +1966,7 @@ EOF
     if do_cc $QEMU_CFLAGS -Werror $flag -c -o $TMPO $TMPC &&
        compile_prog "-Werror $flag" ""; then
       QEMU_CFLAGS=3D"$QEMU_CFLAGS $flag"
+      QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $flag"
       sp_on=3D1
       break
     fi
@@ -2051,10 +2051,10 @@ EOF
=20
   if compile_prog "-fPIE -DPIE" "-pie"; then
     QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
-    LDFLAGS=3D"-pie $LDFLAGS"
+    QEMU_LDFLAGS=3D"-pie $QEMU_LDFLAGS"
     pie=3D"yes"
     if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
-      LDFLAGS=3D"-Wl,-z,relro -Wl,-z,now $LDFLAGS"
+      QEMU_LDFLAGS=3D"-Wl,-z,relro -Wl,-z,now $QEMU_LDFLAGS"
     fi
   else
     if test "$pie" =3D "yes"; then
@@ -5837,7 +5837,7 @@ EOF
     hvf=3D'no'
   else
     hvf=3D'yes'
-    LDFLAGS=3D"-framework Hypervisor $LDFLAGS"
+    QEMU_LDFLAGS=3D"-framework Hypervisor $QEMU_LDFLAGS"
   fi
 fi
=20
@@ -6071,8 +6071,8 @@ esac
 write_c_skeleton
=20
 if test "$gcov" =3D "yes" ; then
-  CFLAGS=3D"-fprofile-arcs -ftest-coverage -g $CFLAGS"
-  LDFLAGS=3D"-fprofile-arcs -ftest-coverage $LDFLAGS"
+  QEMU_CFLAGS=3D"-fprofile-arcs -ftest-coverage -g $QEMU_CFLAGS"
+  QEMU_LDFLAGS=3D"-fprofile-arcs -ftest-coverage $QEMU_LDFLAGS"
 elif test "$fortify_source" =3D "yes" ; then
   CFLAGS=3D"-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 $CFLAGS"
 elif test "$debug" =3D "no"; then
@@ -6080,7 +6080,8 @@ elif test "$debug" =3D "no"; then
 fi
=20
 if test "$have_asan" =3D "yes"; then
-  CFLAGS=3D"-fsanitize=3Daddress $CFLAGS"
+  QEMU_CFLAGS=3D"-fsanitize=3Daddress $QEMU_CFLAGS"
+  QEMU_LDFLAGS=3D"-fsanitize=3Daddress $QEMU_LDFLAGS"
   if test "$have_asan_iface_h" =3D "no" ; then
       echo "ASAN build enabled, but ASAN header missing." \
            "Without code annotation, the report may be inferior."
@@ -6090,7 +6091,8 @@ if test "$have_asan" =3D "yes"; then
   fi
 fi
 if test "$have_ubsan" =3D "yes"; then
-  CFLAGS=3D"-fsanitize=3Dundefined $CFLAGS"
+  QEMU_CFLAGS=3D"-fsanitize=3Dundefined $QEMU_CFLAGS"
+  QEMU_LDFLAGS=3D"-fsanitize=3Dundefined $QEMU_LDFLAGS"
 fi
=20
 ##########################################
@@ -6125,7 +6127,7 @@ fi
=20
 if test "$solaris" =3D "no" ; then
     if $ld --version 2>/dev/null | grep "GNU ld" >/dev/null 2>/dev/null ; =
then
-        LDFLAGS=3D"-Wl,--warn-common $LDFLAGS"
+        QEMU_LDFLAGS=3D"-Wl,--warn-common $QEMU_LDFLAGS"
     fi
 fi
=20
@@ -6140,7 +6142,7 @@ fi
 if test "$mingw32" =3D "yes" ; then
     for flag in --dynamicbase --no-seh --nxcompat; do
         if ld_has $flag ; then
-            LDFLAGS=3D"-Wl,$flag $LDFLAGS"
+            QEMU_LDFLAGS=3D"-Wl,$flag $QEMU_LDFLAGS"
         fi
     done
 fi
@@ -6375,7 +6377,7 @@ EOF
=20
     update_cxxflags
=20
-    if do_cxx $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $LDFLAGS; then
+    if do_cxx $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $QEMU_LDFLAGS; then
         # C++ compiler $cxx works ok with C compiler $cc
         :
     else
@@ -6427,7 +6429,6 @@ echo "Objective-C compiler $objcc"
 echo "ARFLAGS           $ARFLAGS"
 echo "CFLAGS            $CFLAGS"
 echo "QEMU_CFLAGS       $QEMU_CFLAGS"
-echo "LDFLAGS           $LDFLAGS"
 echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
 echo "make              $make"
 echo "install           $install"
@@ -7479,9 +7480,8 @@ if test "$sparse" =3D "yes" ; then
   echo "HOST_CC      :=3D REAL_CC=3D\"\$(HOST_CC)\" cgcc"  >> $config_host=
_mak
   echo "QEMU_CFLAGS  +=3D -Wbitwise -Wno-transparent-union -Wno-old-initia=
lizer -Wno-non-pointer-null" >> $config_host_mak
 fi
-echo "LDFLAGS=3D$LDFLAGS" >> $config_host_mak
-echo "LDFLAGS_NOPIE=3D$LDFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_LDFLAGS=3D$QEMU_LDFLAGS" >> $config_host_mak
+echo "LDFLAGS_NOPIE=3D$LDFLAGS_NOPIE" >> $config_host_mak
 echo "LD_REL_FLAGS=3D$LD_REL_FLAGS" >> $config_host_mak
 echo "LD_I386_EMULATION=3D$ld_i386_emulation" >> $config_host_mak
 echo "LIBS+=3D$LIBS" >> $config_host_mak
@@ -7807,7 +7807,7 @@ if test "$target_bsd_user" =3D "yes" ; then
 fi
=20
=20
-# generate QEMU_CFLAGS/LDFLAGS for targets
+# generate QEMU_CFLAGS/QEMU_LDFLAGS for targets
=20
 cflags=3D""
 ldflags=3D""
@@ -7928,7 +7928,7 @@ if test "$TARGET_ARCH" =3D "s390x" && test "$target_s=
oftmmu" =3D "yes" && \
     fi
 fi
=20
-echo "LDFLAGS+=3D$ldflags" >> $config_target_mak
+echo "QEMU_LDFLAGS+=3D$ldflags" >> $config_target_mak
 echo "QEMU_CFLAGS+=3D$cflags" >> $config_target_mak
=20
 done # for target in $targets
diff --git a/qga/vss-win32/Makefile.objs b/qga/vss-win32/Makefile.objs
index fd3ba18..c82676a 100644
--- a/qga/vss-win32/Makefile.objs
+++ b/qga/vss-win32/Makefile.objs
@@ -5,9 +5,9 @@ qga-vss-dll-obj-y +=3D requester.o provider.o install.o
 obj-qga-vss-dll-obj-y =3D $(addprefix $(obj)/, $(qga-vss-dll-obj-y))
 $(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS :=3D $(filter-out -fstack-protecto=
r-all -fstack-protector-strong, $(QEMU_CXXFLAGS)) -Wno-unknown-pragmas -Wno=
-delete-non-virtual-dtor
=20
-$(obj)/qga-vss.dll: LDFLAGS =3D -shared -Wl,--add-stdcall-alias,--enable-s=
tdcall-fixup -lglib-2.0 -lole32 -loleaut32 -lshlwapi -luuid -lintl -lws2_32=
 -static
+QGA_VSS_LDFLAGS =3D -shared -Wl,--add-stdcall-alias,--enable-stdcall-fixup=
 -lglib-2.0 -lole32 -loleaut32 -lshlwapi -luuid -lintl -lws2_32 -static
 $(obj)/qga-vss.dll: $(obj-qga-vss-dll-obj-y) $(SRC_PATH)/$(obj)/qga-vss.de=
f
-=09$(call quiet-command,$(CXX) -o $@ $(qga-vss-dll-obj-y) $(SRC_PATH)/qga/=
vss-win32/qga-vss.def $(CXXFLAGS) $(LDFLAGS),"LINK","$(TARGET_DIR)$@")
+=09$(call quiet-command,$(CXX) -o $@ $(qga-vss-dll-obj-y) $(SRC_PATH)/qga/=
vss-win32/qga-vss.def $(CXXFLAGS) $(QGA_VSS_LDFLAGS),"LINK","$(TARGET_DIR)$=
@")
=20
=20
 # rules to build qga-provider.tlb
diff --git a/rules.mak b/rules.mak
index 967295d..c855887 100644
--- a/rules.mak
+++ b/rules.mak
@@ -76,7 +76,7 @@ expand-objs =3D $(strip $(sort $(filter %.o,$1)) \
 # must link with the C++ compiler, not the plain C compiler.
 LINKPROG =3D $(or $(CXX),$(CC))
=20
-LINK =3D $(call quiet-command, $(LINKPROG) $(QEMU_LDFLAGS) $(QEMU_CFLAGS) =
$(CFLAGS) $(LDFLAGS) -o $@ \
+LINK =3D $(call quiet-command, $(LINKPROG) $(CFLAGS) $(QEMU_LDFLAGS) -o $@=
 \
        $(call process-archive-undefs, $1) \
        $(version-obj-y) $(call extract-libs,$1) $(LIBS),"LINK","$(TARGET_D=
IR)$@")
=20
@@ -105,7 +105,7 @@ LINK =3D $(call quiet-command, $(LINKPROG) $(QEMU_LDFLA=
GS) $(QEMU_CFLAGS) $(CFLAGS
=20
 DSO_OBJ_CFLAGS :=3D -fPIC -DBUILD_DSO
 module-common.o: CFLAGS +=3D $(DSO_OBJ_CFLAGS)
-%$(DSOSUF): LDFLAGS +=3D $(LDFLAGS_SHARED)
+%$(DSOSUF): QEMU_LDFLAGS +=3D $(LDFLAGS_SHARED)
 %$(DSOSUF): %.mo
 =09$(call LINK,$^)
 =09@# Copy to build root so modules can be loaded when program started wit=
hout install
--=20
1.8.3.1



