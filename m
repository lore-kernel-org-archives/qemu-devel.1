Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217DBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65E4206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="Yaj+1N//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65E4206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAB0o-0007YB-4D
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 07:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=45nv=cc=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1kAAyV-0002Yt-7H
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:49:19 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:54822
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=45nv=cc=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1kAAyS-0003cy-LF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:49:18 -0400
Received: from MattGorko-Laptop.home
 (lfbn-idf1-1-1395-83.w90-79.abo.wanadoo.fr [90.79.87.83])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 73685412C9;
 Mon, 24 Aug 2020 13:49:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1598269755; bh=a+7ZXrsEm2NyNn+Qyc4H4Tfiz70E7/Z+HkEpxeMxp5s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Yaj+1N//azg7lXjhBL0DIrEmvGAnCGQL/99nKvAJNjv3qGzkte2P3Y88PjQDSkhPg
 HR9FYj0InPiHybQ+Z3t8cjHDRpv6SJTxER2NJVn+8/5xI4Nd8SREEK46+QZ/igG3EE
 dwOKBfYLnOJ9/hT0jBOVV10qZ23JQSOcp7mZhKSw=
From: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/13] hw/usb: Add U2F key build recipe
Date: Mon, 24 Aug 2020 13:48:21 +0200
Message-Id: <20200824114827.81623-8-cesar.belley@lse.epita.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824114827.81623-1-cesar.belley@lse.epita.fr>
References: <20200824114827.81623-1-cesar.belley@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=45nv=cc=lse.epita.fr=cesar.belley@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 07:49:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 hw/usb/Kconfig     | 5 +++++
 hw/usb/meson.build | 5 +++++
 meson.build        | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 5e63dc75f8..3fc8fbe3c7 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -96,6 +96,11 @@ config USB_STORAGE_MTP
     default y
     depends on USB
 
+config USB_U2F
+    bool
+    default y
+    depends on USB
+
 config IMX_USBPHY
     bool
     default y
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 3c44a1b069..cac7639924 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -50,6 +50,11 @@ if config_host.has_key('CONFIG_SMARTCARD')
   hw_usb_modules += {'smartcard': usbsmartcard_ss}
 endif
 
+# U2F
+softmmu_ss.add(when: 'CONFIG_USB_U2F', if_true: files('u2f.c'))
+softmmu_ss.add(when: ['CONFIG_LINUX', 'CONFIG_USB_U2F'], if_true: files('u2f-passthru.c'))
+softmmu_ss.add(when: ['CONFIG_U2F', 'CONFIG_USB_U2F'], if_true: [u2f, files('u2f-emulated.c')])
+
 # usb redirect
 if config_host.has_key('CONFIG_USB_REDIR')
   usbredir_ss = ss.source_set()
diff --git a/meson.build b/meson.build
index df5bf728b5..1e6c9c598f 100644
--- a/meson.build
+++ b/meson.build
@@ -360,6 +360,11 @@ if 'CONFIG_SMARTCARD' in config_host
   cacard = declare_dependency(compile_args: config_host['SMARTCARD_CFLAGS'].split(),
                               link_args: config_host['SMARTCARD_LIBS'].split())
 endif
+u2f = not_found
+if 'CONFIG_U2F' in config_host
+  u2f = declare_dependency(compile_args: config_host['U2F_CFLAGS'].split(),
+                           link_args: config_host['U2F_LIBS'].split())
+endif
 usbredir = not_found
 if 'CONFIG_USB_REDIR' in config_host
   usbredir = declare_dependency(compile_args: config_host['USB_REDIR_CFLAGS'].split(),
@@ -1359,6 +1364,7 @@ summary_info += {'spice support':     config_host.has_key('CONFIG_SPICE')}
 summary_info += {'rbd support':       config_host.has_key('CONFIG_RBD')}
 summary_info += {'xfsctl support':    config_host.has_key('CONFIG_XFS')}
 summary_info += {'smartcard support': config_host.has_key('CONFIG_SMARTCARD')}
+summary_info += {'U2F support':       config_host.has_key('CONFIG_U2F')}
 summary_info += {'libusb':            config_host.has_key('CONFIG_USB_LIBUSB')}
 summary_info += {'usb net redir':     config_host.has_key('CONFIG_USB_REDIR')}
 summary_info += {'OpenGL support':    config_host.has_key('CONFIG_OPENGL')}
-- 
2.28.0


