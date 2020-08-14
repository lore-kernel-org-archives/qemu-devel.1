Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A01C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C862074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AymLOc5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C862074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Vpc-0002Ja-0D
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VmY-00053r-8m
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VmR-0002q1-1u
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9cnuSUY7R8bNQaayK9fc2xPxyOR/SLBtuCwfgtQfHE=;
 b=AymLOc5HvgkR2HTzw0tWLu3WyU7EC1hutC3ym71j5O1teXNoXJNmpLJnrYU6AyYG12Q9uv
 IxxaGCaKCInkyqcDHFjA9S3MCC4McDiZBZ4j4M/XyDVCMoNrhB4EAra9J4KQs0IiPS176o
 CbziMzfv5dgjHX2HAkvxz1IqYz10Uog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-xkuLA8UoM_KGtx6bbmemug-1; Fri, 14 Aug 2020 05:13:40 -0400
X-MC-Unique: xkuLA8UoM_KGtx6bbmemug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 577B4801AC4
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D21F709D9
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 014/150] configure: prepare CFLAGS/CXXFLAGS/LDFLAGS for Meson
Date: Fri, 14 Aug 2020 05:11:10 -0400
Message-Id: <20200814091326.16173-15-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Split between CFLAGS/QEMU_CFLAGS and CXXFLAGS/QEMU_CXXFLAGS so that
we will use CFLAGS and CXXFLAGS for flags that we do not want to
pass to add_project_arguments.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure             | 78 ++++++++++++++++++++-----------------------
 rules.mak             |  4 +--
 softmmu/Makefile.objs |  2 +-
 3 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/configure b/configure
index 373bb22287..42f0c1c20b 100755
--- a/configure
+++ b/configure
@@ -107,15 +107,12 @@ update_cxxflags() {
     # options which some versions of GCC's C++ compiler complain about
     # because they only make sense for C programs.
     QEMU_CXXFLAGS="$QEMU_CXXFLAGS -D__STDC_LIMIT_MACROS -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS"
-
+    CXXFLAGS=$(echo "$CFLAGS" | sed s/-std=gnu99/-std=gnu++11/)
     for arg in $QEMU_CFLAGS; do
         case $arg in
             -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
             -Wold-style-declaration|-Wold-style-definition|-Wredundant-decls)
                 ;;
-            -std=gnu99)
-                QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }"-std=gnu++98"
-                ;;
             *)
                 QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg
                 ;;
@@ -125,13 +122,13 @@ update_cxxflags() {
 
 compile_object() {
   local_cflags="$1"
-  do_cc $QEMU_CFLAGS $local_cflags -c -o $TMPO $TMPC
+  do_cc $CFLAGS $QEMU_CFLAGS $local_cflags -c -o $TMPO $TMPC
 }
 
 compile_prog() {
   local_cflags="$1"
   local_ldflags="$2"
-  do_cc $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $QEMU_LDFLAGS $local_ldflags
+  do_cc $CFLAGS $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $LDFLAGS $QEMU_LDFLAGS $local_ldflags
 }
 
 # symbolically link $1 to $2.  Portable version of "ln -sf".
@@ -597,15 +594,14 @@ ARFLAGS="${ARFLAGS-rv}"
 # left shift of signed integers is well defined and has the expected
 # 2s-complement style results. (Both clang and gcc agree that it
 # provides these semantics.)
-QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv -std=gnu99 $QEMU_CFLAGS"
-QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
+QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
+QEMU_CFLAGS="-Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
 QEMU_INCLUDES="-iquote . -iquote ${source_path} -iquote ${source_path}/accel/tcg -iquote ${source_path}/include"
 QEMU_INCLUDES="$QEMU_INCLUDES -iquote ${source_path}/disas/libvixl"
-if test "$debug_info" = "yes"; then
-    CFLAGS="-g $CFLAGS"
-fi
+CFLAGS="-std=gnu99 -Wall"
+
 
 # running configure in the source tree?
 # we know that's the case if configure is there.
@@ -886,7 +882,6 @@ SunOS)
   QEMU_CFLAGS="-D_XOPEN_SOURCE=600 $QEMU_CFLAGS"
 # needed for TIOCWIN* defines in termios.h
   QEMU_CFLAGS="-D__EXTENSIONS__ $QEMU_CFLAGS"
-  QEMU_CFLAGS="-std=gnu99 $QEMU_CFLAGS"
   solarisnetlibs="-lsocket -lnsl -lresolv"
   LIBS="$solarisnetlibs $LIBS"
   libs_qga="$solarisnetlibs $libs_qga"
@@ -2109,7 +2104,7 @@ EOF
   for flag in $gcc_flags; do
     # We need to check both a compile and a link, since some compiler
     # setups fail only on a .c->.o compile and some only at link time
-    if do_cc $QEMU_CFLAGS -Werror $flag -c -o $TMPO $TMPC &&
+    if compile_object "-Werror $flag" &&
        compile_prog "-Werror $flag" ""; then
       QEMU_CFLAGS="$QEMU_CFLAGS $flag"
       QEMU_LDFLAGS="$QEMU_LDFLAGS $flag"
@@ -2184,7 +2179,7 @@ fi
 
 if test "$static" = "yes"; then
   if test "$pie" != "no" && compile_prog "-Werror -fPIE -DPIE" "-static-pie"; then
-    QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
+    CFLAGS="-fPIE -DPIE $CFLAGS"
     QEMU_LDFLAGS="-static-pie $QEMU_LDFLAGS"
     pie="yes"
   elif test "$pie" = "yes"; then
@@ -2194,11 +2189,11 @@ if test "$static" = "yes"; then
     pie="no"
   fi
 elif test "$pie" = "no"; then
-  QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
-  QEMU_LDFLAGS="$LDFLAGS_NOPIE $QEMU_LDFLAGS"
+  CFLAGS="$CFLAGS_NOPIE $CFLAGS"
+  LDFLAGS="$LDFLAGS_NOPIE $LDFLAGS"
 elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
-  QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
-  QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
+  CFLAGS="-fPIE -DPIE $CFLAGS"
+  LDFLAGS="-pie $LDFLAGS"
   pie="yes"
 elif test "$pie" = "yes"; then
   error_exit "PIE not available due to missing toolchain support"
@@ -3981,7 +3976,7 @@ EOF
 if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
     if cc_has_warning_flag "-Wno-unknown-attributes"; then
         glib_cflags="-Wno-unknown-attributes $glib_cflags"
-        CFLAGS="-Wno-unknown-attributes $CFLAGS"
+        QEMU_CFLAGS="-Wno-unknown-attributes $CFLAGS"
     fi
 fi
 
@@ -6506,10 +6501,28 @@ if test "$gcov" = "yes" ; then
   QEMU_CFLAGS="-fprofile-arcs -ftest-coverage -g $QEMU_CFLAGS"
   QEMU_LDFLAGS="-fprofile-arcs -ftest-coverage $QEMU_LDFLAGS"
 elif test "$fortify_source" = "yes" ; then
-  CFLAGS="-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
-elif test "$debug" = "no"; then
+  QEMU_CFLAGS="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $QEMU_CFLAGS"
+  debug=no
+fi
+if test "$debug" = "no"; then
   CFLAGS="-O2 $CFLAGS"
 fi
+if test "$debug_info" = "yes"; then
+  CFLAGS="-g $CFLAGS"
+  LDFLAGS="-g $LDFLAGS"
+fi
+
+case "$ARCH" in
+alpha)
+  # Ensure there's only a single GP
+  QEMU_CFLAGS="-msmall-data $QEMU_CFLAGS"
+;;
+esac
+
+if test "$gprof" = "yes" ; then
+  QEMU_CFLAGS="-p $QEMU_CFLAGS"
+  QEMU_LDFLAGS="-p $QEMU_LDFLAGS"
+fi
 
 if test "$have_asan" = "yes"; then
   QEMU_CFLAGS="-fsanitize=address $QEMU_CFLAGS"
@@ -6782,7 +6795,7 @@ EOF
 
     update_cxxflags
 
-    if do_cxx $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $QEMU_LDFLAGS; then
+    if do_cxx $CXXFLAGS $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $QEMU_LDFLAGS; then
         # C++ compiler $cxx works ok with C compiler $cc
         :
     else
@@ -7874,7 +7887,7 @@ if test "$fuzzing" = "yes" ; then
   if test "$have_fuzzer" = "yes"; then
     FUZZ_LDFLAGS=" -fsanitize=fuzzer"
     FUZZ_CFLAGS=" -fsanitize=fuzzer"
-    CFLAGS="$CFLAGS -fsanitize=fuzzer-no-link"
+    QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer-no-link"
   else
     error_exit "Your compiler doesn't support -fsanitize=fuzzer"
     exit 1
@@ -7961,6 +7974,7 @@ echo "NM=$nm" >> $config_host_mak
 echo "PKG_CONFIG=$pkg_config_exe" >> $config_host_mak
 echo "WINDRES=$windres" >> $config_host_mak
 echo "CFLAGS=$CFLAGS" >> $config_host_mak
+echo "CXXFLAGS=$CXXFLAGS" >> $config_host_mak
 echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
@@ -8430,24 +8444,6 @@ if test "$tcg_interpreter" = "yes" ; then
   disas_config "TCI"
 fi
 
-case "$ARCH" in
-alpha)
-  # Ensure there's only a single GP
-  cflags="-msmall-data $cflags"
-;;
-esac
-
-if test "$gprof" = "yes" ; then
-  if test "$target_linux_user" = "yes" ; then
-    cflags="-p $cflags"
-    ldflags="-p $ldflags"
-  fi
-  if test "$target_softmmu" = "yes" ; then
-    ldflags="-p $ldflags"
-    echo "GPROF_CFLAGS=-p" >> $config_target_mak
-  fi
-fi
-
 # Newer kernels on s390 check for an S390_PGSTE program header and
 # enable the pgste page table extensions in that case. This makes
 # the vm.allocate_pgste sysctl unnecessary. We enable this program
diff --git a/rules.mak b/rules.mak
index 56ba540a32..e79a4005a7 100644
--- a/rules.mak
+++ b/rules.mak
@@ -88,12 +88,12 @@ LINK = $(call quiet-command, $(LINKPROG) $(CFLAGS) $(QEMU_LDFLAGS) -o $@ \
 
 %.o: %.cc
 	$(call quiet-command,$(CXX) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
-	       $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
+	       $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CXXFLAGS) $($@-cflags) \
 	       -c -o $@ $<,"CXX","$(TARGET_DIR)$@")
 
 %.o: %.cpp
 	$(call quiet-command,$(CXX) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
-	       $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
+	       $(QEMU_CXXFLAGS) $(QEMU_DGFLAGS) $(CXXFLAGS) $($@-cflags) \
 	       -c -o $@ $<,"CXX","$(TARGET_DIR)$@")
 
 %.o: %.m
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
index a414a74c50..c036887500 100644
--- a/softmmu/Makefile.objs
+++ b/softmmu/Makefile.objs
@@ -11,4 +11,4 @@ obj-y += memory_mapping.o
 obj-y += qtest.o
 
 obj-y += vl.o
-vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
+vl.o-cflags := $(SDL_CFLAGS)
-- 
2.26.2



