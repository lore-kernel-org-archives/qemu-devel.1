Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD425C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 11:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B027120828
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 11:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B027120828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3ICJ-0003Y3-Hx
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 07:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Zhe.He@windriver.com>) id 1i3IAC-0001a5-KR
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Zhe.He@windriver.com>) id 1i3IAA-0004XZ-Qd
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:00:24 -0400
Received: from mail1.windriver.com ([147.11.146.13]:62681)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Zhe.He@windriver.com>)
 id 1i3IA8-0004Uq-M3
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:00:22 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
 by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x7T8q3l8015075
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
 Thu, 29 Aug 2019 01:52:03 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Thu, 29 Aug 2019 01:52:02 -0700
From: <zhe.he@windriver.com>
To: <berrange@redhat.com>, <philmd@redhat.com>, <thuth@redhat.com>,
 <pbonzini@redhat.com>, <laurent@vivier.eu>, <qemu-devel@nongnu.org>,
 <zhe.he@windriver.com>
Date: Thu, 29 Aug 2019 16:51:59 +0800
Message-ID: <1567068719-359846-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Solaris 10
X-Received-From: 147.11.146.13
Subject: [Qemu-devel] [PATCH] configure: Add pkg-config handling for
 libgcrypt
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

From: He Zhe <zhe.he@windriver.com>

libgcrypt may also be controlled by pkg-config, this patch adds pkg-config
handling for libgcrypt.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 configure | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index e44e454..0f362a7 100755
--- a/configure
+++ b/configure
@@ -2875,6 +2875,30 @@ has_libgcrypt() {
     return 0
 }
 
+has_libgcrypt_pkgconfig() {
+    if ! has $pkg_config ; then
+        return 1
+    fi
+
+    if ! $pkg_config --list-all | grep libgcrypt > /dev/null 2>&1 ; then
+        return 1
+    fi
+
+    if test -n "$cross_prefix" ; then
+        host=$($pkg_config --variable=host libgcrypt)
+        if test "${host%-gnu}-" != "${cross_prefix%-gnu}" ; then
+            print_error "host($host) does not match cross_prefix($cross_prefix)"
+            return 1
+        fi
+    fi
+
+    if ! $pkg_config --atleast-version=1.5.0 libgcrypt ; then
+        print_error "libgcrypt version is $($pkg_config --modversion libgcrypt)"
+        return 1
+    fi
+
+    return 0
+}
 
 if test "$nettle" != "no"; then
     pass="no"
@@ -2902,7 +2926,14 @@ fi
 
 if test "$gcrypt" != "no"; then
     pass="no"
-    if has_libgcrypt; then
+    if has_libgcrypt_pkgconfig; then
+        gcrypt_cflags=$($pkg_config --cflags libgcrypt)
+        if test "$static" = "yes" ; then
+            gcrypt_libs=$($pkg_config --libs --static libgcrypt)
+        else
+            gcrypt_libs=$($pkg_config --libs libgcrypt)
+        fi
+    elif has_libgcrypt; then
         gcrypt_cflags=$(libgcrypt-config --cflags)
         gcrypt_libs=$(libgcrypt-config --libs)
         # Debian has removed -lgpg-error from libgcrypt-config
@@ -2912,15 +2943,16 @@ if test "$gcrypt" != "no"; then
         then
             gcrypt_libs="$gcrypt_libs -lgpg-error"
         fi
+    fi
 
-        # Link test to make sure the given libraries work (e.g for static).
-        write_c_skeleton
-        if compile_prog "" "$gcrypt_libs" ; then
-            LIBS="$gcrypt_libs $LIBS"
-            QEMU_CFLAGS="$QEMU_CFLAGS $gcrypt_cflags"
-            pass="yes"
-        fi
+    # Link test to make sure the given libraries work (e.g for static).
+    write_c_skeleton
+    if compile_prog "" "$gcrypt_libs" ; then
+	    LIBS="$gcrypt_libs $LIBS"
+	    QEMU_CFLAGS="$QEMU_CFLAGS $gcrypt_cflags"
+	    pass="yes"
     fi
+
     if test "$pass" = "yes"; then
         gcrypt="yes"
         cat > $TMPC << EOF
-- 
2.7.4


