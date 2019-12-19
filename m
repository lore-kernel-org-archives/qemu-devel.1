Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC36C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5660A21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QE3JoyD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5660A21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihx0c-0001TI-2W
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwwh-0004OU-Jo
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwwg-0004M7-Gb
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwwg-0004IX-BE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCVeQFCt2yi/YlY57zKMOsjAqA+h2IpIYTAyv/Ap+IQ=;
 b=QE3JoyD222gKHnPZIcYJJ8GNGWCSWScOMpiRa/jgTbRGXvcIbV8zvHR4MD9yqd9RX56rJs
 9CzwtdToyjjZkgM31FKEWabF3OymI2fZqwEBNAqzb8fpolkrXrOaJr9istoOOMS4FJiL6E
 2GJ0qtZ/mhTbsEwz4ZXf93eY7bIxQyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-UOlHbPRuOPOUzo6nVfi7yg-1; Thu, 19 Dec 2019 09:38:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CC2F911BD;
 Thu, 19 Dec 2019 14:38:26 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0E43703A0;
 Thu, 19 Dec 2019 14:38:22 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 01/18] configure: Detect libfuse
Date: Thu, 19 Dec 2019 15:38:01 +0100
Message-Id: <20191219143818.1646168-2-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: UOlHbPRuOPOUzo6nVfi7yg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 configure | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/configure b/configure
index 84b413dbfc..ff7d760a0a 100755
--- a/configure
+++ b/configure
@@ -503,6 +503,7 @@ debug_mutex=3D"no"
 libpmem=3D""
 default_devices=3D"yes"
 plugins=3D"no"
+fuse=3D""
=20
 supported_cpu=3D"no"
 supported_os=3D"no"
@@ -1534,6 +1535,10 @@ for opt do
   ;;
   --disable-plugins) plugins=3D"no"
   ;;
+  --enable-fuse) fuse=3Dyes
+  ;;
+  --disable-fuse) fuse=3Dno
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1819,6 +1824,7 @@ disabled with --disable-FEATURE, default is enabled i=
f available:
   debug-mutex     mutex debugging support
   libpmem         libpmem support
   xkbcommon       xkbcommon support
+  fuse            fuse block device export
=20
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -6042,6 +6048,28 @@ case "$slirp" in
     ;;
 esac
=20
+##########################################
+# FUSE support
+
+if test "$fuse" !=3D "no"; then
+  cat > $TMPC <<EOF
+#define FUSE_USE_VERSION 31
+#include <fuse.h>
+#include <fuse_lowlevel.h>
+int main(void) { return 0; }
+EOF
+  fuse_cflags=3D$(pkg-config --cflags fuse3)
+  fuse_libs=3D$(pkg-config --libs fuse3)
+  if compile_prog "$fuse_cflags" "$fuse_libs"; then
+    fuse=3Dyes
+  else
+    if test "$fuse" =3D "yes"; then
+      feature_not_found "fuse"
+    fi
+    fuse=3Dno
+  fi
+fi
+
=20
 ##########################################
 # End of CC checks
@@ -6556,6 +6584,7 @@ echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
 echo "plugin support    $plugins"
+echo "fuse exports      $fuse"
=20
 if test "$supported_cpu" =3D "no"; then
     echo
@@ -7410,6 +7439,12 @@ if test "$plugins" =3D "yes" ; then
     fi
 fi
=20
+if test "$fuse" =3D "yes"; then
+  echo "CONFIG_FUSE=3Dy" >> $config_host_mak
+  echo "FUSE_CFLAGS=3D$fuse_cflags" >> $config_host_mak
+  echo "FUSE_LIBS=3D$fuse_libs" >> $config_host_mak
+fi
+
 if test "$tcg_interpreter" =3D "yes"; then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" =3D "sparc64" ; then
--=20
2.23.0


