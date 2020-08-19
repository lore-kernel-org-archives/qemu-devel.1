Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA58C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE1420772
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 05:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoTFdsbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE1420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8H0A-000750-KW
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 01:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8GwM-0007aP-UU
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:47:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8GwH-0006hL-Lf
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 01:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597816012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3CLSo2EtGQlfx/ug/byoG1oK2g3CL0Ik/QO69B6dSM=;
 b=IoTFdsbs3bMYQtsozhj3dztMVhhOA4VXtRZDjVKujIiLJizRVyBTO8+Nc2xAZIlB3LY5mW
 2rHO6hV9T5IARG/+jdjb6zdIXpUnJPqZhPj7ocioFYYCUyW05tV0YVzakpMzxSMj3a5UBf
 v722qNXcjQxjJSATgr9zasgMZoIU6rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-S2YMYGqFNa-FtqSHXmq5HA-1; Wed, 19 Aug 2020 01:46:50 -0400
X-MC-Unique: S2YMYGqFNa-FtqSHXmq5HA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACA8581F02C;
 Wed, 19 Aug 2020 05:46:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58C3C1014181;
 Wed, 19 Aug 2020 05:46:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C118431E22; Wed, 19 Aug 2020 07:46:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/17] configure: Add USB U2F key device
Date: Wed, 19 Aug 2020 07:46:39 +0200
Message-Id: <20200819054644.30610-13-kraxel@redhat.com>
In-Reply-To: <20200819054644.30610-1-kraxel@redhat.com>
References: <20200819054644.30610-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:06:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: César Belley <cesar.belley@lse.epita.fr>

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
Message-id: 20200812094135.20550-9-cesar.belley@lse.epita.fr
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configure b/configure
index 2acc4d1465f8..3ea5e561ff43 100755
--- a/configure
+++ b/configure
@@ -447,6 +447,7 @@ trace_file="trace"
 spice=""
 rbd=""
 smartcard=""
+u2f=""
 libusb=""
 usb_redir=""
 opengl=""
@@ -1390,6 +1391,10 @@ for opt do
   ;;
   --enable-smartcard) smartcard="yes"
   ;;
+  --disable-u2f) u2f="no"
+  ;;
+  --enable-u2f) u2f="yes"
+  ;;
   --disable-libusb) libusb="no"
   ;;
   --enable-libusb) libusb="yes"
@@ -1899,6 +1904,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   libiscsi        iscsi support
   libnfs          nfs support
   smartcard       smartcard support (libcacard)
+  u2f             U2F support (u2f-emu)
   libusb          libusb (for usb passthrough)
   live-block-migration   Block migration in the main migration stream
   usb-redir       usb network redirection support
@@ -5250,6 +5256,20 @@ if test "$smartcard" != "no"; then
     fi
 fi
 
+# check for u2f support
+if test "$u2f" != "no"; then
+    if $pkg_config --atleast-version=0.0.0 u2f-emu; then
+        u2f_emu_cflags=$($pkg_config --cflags u2f-emu)
+        u2f_emu_libs=$($pkg_config --libs u2f-emu)
+        u2f="yes"
+    else
+        if test "$u2f" = "yes"; then
+            feature_not_found "u2f" "Install u2f-emu"
+        fi
+        u2f="no"
+    fi
+fi
+
 # check for libusb
 if test "$libusb" != "no" ; then
     if $pkg_config --atleast-version=1.0.13 libusb-1.0; then
@@ -6965,6 +6985,7 @@ echo "spice support     $spice $(echo_version $spice $spice_protocol_version/$sp
 echo "rbd support       $rbd"
 echo "xfsctl support    $xfs"
 echo "smartcard support $smartcard"
+echo "U2F support       $u2f"
 echo "libusb            $libusb"
 echo "usb net redir     $usb_redir"
 echo "OpenGL support    $opengl"
@@ -7543,6 +7564,12 @@ if test "$smartcard" = "yes" ; then
   echo "SMARTCARD_LIBS=$libcacard_libs" >> $config_host_mak
 fi
 
+if test "$u2f" = "yes" ; then
+  echo "CONFIG_U2F=y" >> $config_host_mak
+  echo "U2F_CFLAGS=$u2f_emu_cflags" >> $config_host_mak
+  echo "U2F_LIBS=$u2f_emu_libs" >> $config_host_mak
+fi
+
 if test "$libusb" = "yes" ; then
   echo "CONFIG_USB_LIBUSB=y" >> $config_host_mak
   echo "LIBUSB_CFLAGS=$libusb_cflags" >> $config_host_mak
-- 
2.18.4


