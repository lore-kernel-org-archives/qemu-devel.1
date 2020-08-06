Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA69C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3132177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpVLblx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3132177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lSD-0004S5-TO
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNi-0003dd-KB
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNg-0006NQ-8G
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=9T8BV3Ch8O5NN7zcQ2QHgAj52r6qq14nCSvLvm+VZWA=;
 b=fpVLblx1dBy63mnk+S9NBvoBmognuFm0xlw2M/mAtrv6bqiCPAr85DnnodoyhTplYEnDCa
 5tx4kpyT05tSNoxveIbXCxEefMvWZ0arSi0cPvBr+b6JDs54+vFTBUSr35l73V/tHHptrG
 kRFv88foOQsafR8WoUwH8A898o7Y5ZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-St1_YbjYPEmt2W2fjr5e6Q-1; Thu, 06 Aug 2020 15:16:45 -0400
X-MC-Unique: St1_YbjYPEmt2W2fjr5e6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FE3619200C2
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:16:44 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98D5E5FC3B
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:16:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 011/143] configure: prepare CFLAGS/CXXFLAGS/LDFLAGS for Meson
Date: Thu,  6 Aug 2020 21:14:07 +0200
Message-Id: <1596741379-12902-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 12:59:11
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
 configure | 42 ++++++++++++++++++++++--------------------
 rules.mak |  4 ++--
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/configure b/configure
index 29cde6a..c65cf77 100755
--- a/configure
+++ b/configure
@@ -107,15 +107,12 @@ update_cxxflags() {
     # options which some versions of GCC's C++ compiler complain about
     # because they only make sense for C programs.
     QEMU_CXXFLAGS="$QEMU_CXXFLAGS -D__STDC_LIMIT_MACROS -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS"
-
+    CXXFLAGS=$(echo "$CFLAGS" | sed s/-std=gnu99/-std=gnu++03/)
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
@@ -131,7 +128,7 @@ compile_object() {
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
+QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
 QEMU_INCLUDES="-iquote . -iquote ${source_path} -iquote ${source_path}/accel/tcg -iquote ${source_path}/include"
 QEMU_INCLUDES="$QEMU_INCLUDES -iquote ${source_path}/disas/libvixl"
-if test "$debug_info" = "yes"; then
-    CFLAGS="-g $CFLAGS"
-fi
+CFLAGS=-std=gnu99
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
@@ -2184,21 +2179,21 @@ fi
 
 if test "$static" = "yes"; then
   if test "$pie" != "no" && compile_prog "-Werror -fPIE -DPIE" "-static-pie"; then
-    QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
-    QEMU_LDFLAGS="-static-pie $QEMU_LDFLAGS"
+    CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
+    LDFLAGS="-static-pie $QEMU_LDFLAGS"
     pie="yes"
   elif test "$pie" = "yes"; then
     error_exit "-static-pie not available due to missing toolchain support"
   else
-    QEMU_LDFLAGS="-static $QEMU_LDFLAGS"
+    LDFLAGS="-static $QEMU_LDFLAGS"
     pie="no"
   fi
 elif test "$pie" = "no"; then
-  QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
-  QEMU_LDFLAGS="$LDFLAGS_NOPIE $QEMU_LDFLAGS"
+  CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
+  LDFLAGS="$LDFLAGS_NOPIE $QEMU_LDFLAGS"
 elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
-  QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
-  QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
+  CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
+  LDFLAGS="-pie $QEMU_LDFLAGS"
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
 
@@ -6506,10 +6501,16 @@ if test "$gcov" = "yes" ; then
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
 
 if test "$have_asan" = "yes"; then
   QEMU_CFLAGS="-fsanitize=address $QEMU_CFLAGS"
@@ -7961,6 +7962,7 @@ echo "NM=$nm" >> $config_host_mak
 echo "PKG_CONFIG=$pkg_config_exe" >> $config_host_mak
 echo "WINDRES=$windres" >> $config_host_mak
 echo "CFLAGS=$CFLAGS" >> $config_host_mak
+echo "CXXFLAGS=$CXXFLAGS" >> $config_host_mak
 echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
diff --git a/rules.mak b/rules.mak
index 56ba540..e79a400 100644
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
-- 
1.8.3.1



