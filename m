Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C891C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CAF2396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBaA0anj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CAF2396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKftR-00023z-ET
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfrt-0008V1-KR
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:49:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kKfrm-0000Rt-UF
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600771785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q1aJG1Km4rcSQhjOJ0lnTuTVRdzX4MZUleXqSWlvaDw=;
 b=LBaA0anj2uEgiP1jqfwqTTpn1XvBJfCWvgRtaNXITrcv6bWqdQTn/MiWPpu4RfJra02QLK
 3ZLqnposKDP8TDiz/nv9jfJ6HqpxF6vWk3nzLrPZYeoxhtIIjRAlkNMc0IuTeuwEjmdVw4
 30+EpTqgTtWwf0bbkckGH6CUyIOZrT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-jXx2FdytNh6C1a-F_Gq4MA-1; Tue, 22 Sep 2020 06:49:43 -0400
X-MC-Unique: jXx2FdytNh6C1a-F_Gq4MA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 848ED1084C8A;
 Tue, 22 Sep 2020 10:49:42 +0000 (UTC)
Received: from localhost (ovpn-114-26.ams2.redhat.com [10.36.114.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44B8F5DD99;
 Tue, 22 Sep 2020 10:49:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 01/20] configure: Detect libfuse
Date: Tue, 22 Sep 2020 12:49:13 +0200
Message-Id: <20200922104932.46384-2-mreitz@redhat.com>
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 configure   | 34 ++++++++++++++++++++++++++++++++++
 meson.build |  6 ++++++
 2 files changed, 40 insertions(+)

diff --git a/configure b/configure
index ce27eafb0a..21c31e4694 100755
--- a/configure
+++ b/configure
@@ -538,6 +538,7 @@ meson=""
 ninja=""
 skip_meson=no
 gettext=""
+fuse=""
 
 bogus_os="no"
 malloc_trim=""
@@ -1621,6 +1622,10 @@ for opt do
   ;;
   --disable-libdaxctl) libdaxctl=no
   ;;
+  --enable-fuse) fuse=yes
+  ;;
+  --disable-fuse) fuse=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1945,6 +1950,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   xkbcommon       xkbcommon support
   rng-none        dummy RNG, avoid using /dev/(u)random and getrandom()
   libdaxctl       libdaxctl support
+  fuse            fuse block device export
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -6206,6 +6212,28 @@ but not implemented on your system"
     fi
 fi
 
+##########################################
+# FUSE support
+
+if test "$fuse" != "no"; then
+  cat > $TMPC <<EOF
+#define FUSE_USE_VERSION 31
+#include <fuse.h>
+#include <fuse_lowlevel.h>
+int main(void) { return 0; }
+EOF
+  fuse_cflags=$(pkg-config --cflags fuse3)
+  fuse_libs=$(pkg-config --libs fuse3)
+  if compile_prog "$fuse_cflags" "$fuse_libs"; then
+    fuse=yes
+  else
+    if test "$fuse" = "yes"; then
+      feature_not_found "fuse"
+    fi
+    fuse=no
+  fi
+fi
+
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
@@ -7393,6 +7421,12 @@ if test "$secret_keyring" = "yes" ; then
   echo "CONFIG_SECRET_KEYRING=y" >> $config_host_mak
 fi
 
+if test "$fuse" = "yes"; then
+  echo "CONFIG_FUSE=y" >> $config_host_mak
+  echo "FUSE_CFLAGS=$fuse_cflags" >> $config_host_mak
+  echo "FUSE_LIBS=$fuse_libs" >> $config_host_mak
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote ${source_path}/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
diff --git a/meson.build b/meson.build
index 86e1cca0ad..85addd8562 100644
--- a/meson.build
+++ b/meson.build
@@ -436,6 +436,11 @@ if 'CONFIG_TASN1' in config_host
 endif
 keyutils = dependency('libkeyutils', required: false,
                       method: 'pkg-config', static: enable_static)
+libfuse = not_found
+if 'CONFIG_FUSE' in config_host
+  libfuse = declare_dependency(compile_args: config_host['FUSE_CFLAGS'].split(),
+                               link_args: config_host['FUSE_LIBS'].split())
+endif
 
 has_gettid = cc.has_function('gettid')
 
@@ -1531,6 +1536,7 @@ endif
 summary_info += {'thread sanitizer':  config_host.has_key('CONFIG_TSAN')}
 summary_info += {'rng-none':          config_host.has_key('CONFIG_RNG_NONE')}
 summary_info += {'Linux keyring':     config_host.has_key('CONFIG_SECRET_KEYRING')}
+summary_info += {'fuse exports':      config_host.has_key('CONFIG_FUSE')}
 summary(summary_info, bool_yn: true)
 
 if not supported_cpus.contains(cpu)
-- 
2.26.2


