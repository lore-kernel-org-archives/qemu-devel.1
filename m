Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2350FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD83B2078B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 09:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="NDeLpgV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD83B2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nJw-0006rP-Vs
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 05:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHV-00027p-Qj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:42:49 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:40906
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1k5nHU-0006kk-3P
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 05:42:49 -0400
Received: from MattGorko-Laptop.localdomain (unknown [78.194.154.81])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id CDDBA415D1;
 Wed, 12 Aug 2020 11:42:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1597225366; bh=iKIh0pVXn2xcd5xyw+MbSBYuutfq5VrL5AOyRI9zABo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NDeLpgV64JD0+biihEOHvtimcV+M2KW1v4dSKw01hqlitzCFi5kwj2MHX4n2+cT/H
 TlqXVDDcrl0T+1IRcw0dIZ7bRbQagFiHiAyMajpGE3eztqjUP5tVhoZDc2tnmAJPH8
 9LlrHbkA81W+MpGl2fb/3q5U49EKwB/F3SBsbR4s=
From: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/13] configure: Add USB U2F key device
Date: Wed, 12 Aug 2020 11:41:30 +0200
Message-Id: <20200812094135.20550-9-cesar.belley@lse.epita.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
References: <20200812094135.20550-1-cesar.belley@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=nna4=bw=lse.epita.fr=cesar.belley@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 05:42:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
---
 configure | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configure b/configure
index 2acc4d1465..3ea5e561ff 100755
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
2.28.0


