Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC7C43466
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 09:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D2FA20EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 09:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eU2XX0kf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2FA20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJvhL-0000Ei-5S
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 05:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJvfs-00070F-6K
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 05:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJvfq-0002kJ-Ad
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 05:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600594221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8V7m33mR/GkT/611spi62ViYrq3aOu5Qz1vILJEmu9Q=;
 b=eU2XX0kfjy0sNlNSvoUAM3URxLo0w5BMTsyP1bB1ENID5Y41IucZuyqa13j0BSETxO2EEB
 MWU5tgzbdNwOCgRjVO0wcaDW5Tb4rxYNPjv+tDlpBfgaPAPQpH5QjIDgQGHFdstyEjfJYm
 6j4Z7oVCNfbgPLIOIEYZbC+QWCSGyfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-EZpDRzCtMBmvkifmFQEZKA-1; Sun, 20 Sep 2020 05:30:19 -0400
X-MC-Unique: EZpDRzCtMBmvkifmFQEZKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46E491074644
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 09:30:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 150DF10027AA
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 09:30:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] configure: do not clobber environment
 CFLAGS/CXXFLAGS/LDFLAGS
Date: Sun, 20 Sep 2020 05:30:15 -0400
Message-Id: <20200920093016.1150346-4-pbonzini@redhat.com>
In-Reply-To: <20200920093016.1150346-1-pbonzini@redhat.com>
References: <20200920093016.1150346-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 03:58:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

If the CFLAGS, CXXFLAGS or LDFLAGS variables are present in the environment,
any modification made within the configure script is passed down to Meson.
This is particularly undesirable for the "-pie" option, since it overrides
"-shared" and thus messes up the linker flags for shared modules.

Using a separate variable therefore fixes the bug, while clarifying that
the scope of these CFLAGS is just the configure script.

Reported-by: Frederic Bezies
Analyzed-by: Toolybird
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index 5fabc77fb3..9a0bbd2a69 100755
--- a/configure
+++ b/configure
@@ -155,7 +155,7 @@ update_cxxflags() {
     # options which some versions of GCC's C++ compiler complain about
     # because they only make sense for C programs.
     QEMU_CXXFLAGS="$QEMU_CXXFLAGS -D__STDC_LIMIT_MACROS -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS"
-    CXXFLAGS=$(echo "$CFLAGS" | sed s/-std=gnu99/-std=gnu++11/)
+    CONFIGURE_CXXFLAGS=$(echo "$CONFIGURE_CFLAGS" | sed s/-std=gnu99/-std=gnu++11/)
     for arg in $QEMU_CFLAGS; do
         case $arg in
             -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
@@ -170,13 +170,14 @@ update_cxxflags() {
 
 compile_object() {
   local_cflags="$1"
-  do_cc $CFLAGS $QEMU_CFLAGS $local_cflags -c -o $TMPO $TMPC
+  do_cc $CFLAGS $CONFIGURE_CFLAGS $QEMU_CFLAGS $local_cflags -c -o $TMPO $TMPC
 }
 
 compile_prog() {
   local_cflags="$1"
   local_ldflags="$2"
-  do_cc $CFLAGS $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $LDFLAGS $QEMU_LDFLAGS $local_ldflags
+  do_cc $CFLAGS $CONFIGURE_CFLAGS $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC \
+      $LDFLAGS $CONFIGURE_LDFLAGS $QEMU_LDFLAGS $local_ldflags
 }
 
 # symbolically link $1 to $2.  Portable version of "ln -sf".
@@ -632,7 +633,10 @@ QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
 QEMU_INCLUDES="-iquote . -iquote ${source_path} -iquote ${source_path}/accel/tcg -iquote ${source_path}/include"
 QEMU_INCLUDES="$QEMU_INCLUDES -iquote ${source_path}/disas/libvixl"
-CFLAGS="-std=gnu99 -Wall"
+
+# Flags that are needed during configure but later taken care of by Meson
+CONFIGURE_CFLAGS="-std=gnu99 -Wall"
+CONFIGURE_LDFLAGS=
 
 
 check_define() {
@@ -960,7 +964,7 @@ if test "$mingw32" = "yes" ; then
   EXESUF=".exe"
   HOST_DSOSUF=".dll"
   # MinGW needs -mthreads for TLS and macro _MT.
-  CFLAGS="-mthreads $CFLAGS"
+  CONFIGURE_CFLAGS="-mthreads $CONFIGURE_CFLAGS"
   write_c_skeleton;
   prefix="/qemu"
   qemu_suffix=""
@@ -2230,7 +2234,7 @@ fi
 
 if test "$static" = "yes"; then
   if test "$pie" != "no" && compile_prog "-Werror -fPIE -DPIE" "-static-pie"; then
-    CFLAGS="-fPIE -DPIE $CFLAGS"
+    CONFIGURE_CFLAGS="-fPIE -DPIE $CONFIGURE_CFLAGS"
     QEMU_LDFLAGS="-static-pie $QEMU_LDFLAGS"
     pie="yes"
   elif test "$pie" = "yes"; then
@@ -2240,11 +2244,11 @@ if test "$static" = "yes"; then
     pie="no"
   fi
 elif test "$pie" = "no"; then
-  CFLAGS="$CFLAGS_NOPIE $CFLAGS"
-  LDFLAGS="$LDFLAGS_NOPIE $LDFLAGS"
+  CONFIGURE_CFLAGS="$CFLAGS_NOPIE $CONFIGURE_CFLAGS"
+  CONFIGURE_LDFLAGS="$LDFLAGS_NOPIE $CONFIGURE_LDFLAGS"
 elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
-  CFLAGS="-fPIE -DPIE $CFLAGS"
-  LDFLAGS="-pie $LDFLAGS"
+  CONFIGURE_CFLAGS="-fPIE -DPIE $CONFIGURE_CFLAGS"
+  CONFIGURE_LDFLAGS="-pie $CONFIGURE_LDFLAGS"
   pie="yes"
 elif test "$pie" = "yes"; then
   error_exit "PIE not available due to missing toolchain support"
@@ -3808,7 +3812,7 @@ EOF
 if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
     if cc_has_warning_flag "-Wno-unknown-attributes"; then
         glib_cflags="-Wno-unknown-attributes $glib_cflags"
-        CFLAGS="-Wno-unknown-attributes $CFLAGS"
+        CONFIGURE_CFLAGS="-Wno-unknown-attributes $CONFIGURE_CFLAGS"
     fi
 fi
 
@@ -3828,7 +3832,7 @@ EOF
 if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
     if cc_has_warning_flag "-Wno-unused-function"; then
         glib_cflags="$glib_cflags -Wno-unused-function"
-        CFLAGS="$CFLAGS -Wno-unused-function"
+        CONFIGURE_CFLAGS="$CONFIGURE_CFLAGS -Wno-unused-function"
     fi
 fi
 
@@ -6359,7 +6363,7 @@ EOF
 
     update_cxxflags
 
-    if do_cxx $CXXFLAGS $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $QEMU_LDFLAGS; then
+    if do_cxx $CONFIGURE_CXXFLAGS $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $QEMU_LDFLAGS; then
         # C++ compiler $cxx works ok with C compiler $cc
         :
     else
-- 
2.26.2



