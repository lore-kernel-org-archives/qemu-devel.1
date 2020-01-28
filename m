Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32D9C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44C42467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1s2Y7fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44C42467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWYL-0007Uu-Ut
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8f-0005L1-P4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8e-0001rQ-FG
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:01 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:50759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8e-0001oS-7u
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:59:00 -0500
Received: by mail-wm1-x329.google.com with SMTP id a5so3537141wmb.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ttwRYFAemNRv4jrg+BhgI1CmXV5jMDYq2H8cD28Br+A=;
 b=F1s2Y7fvA4zvPnHtKq5g6PALWfO40vxT8CrNO1C0EiMf+4B6V5ZJrzYFagBbo0mofW
 uho3KtQFexwFkpND4+EaIgxd8f7I6tBYUgld0p2xNlKAccGQaR4JwOSN8fsQbRVM3y6h
 9mqavpfTwegkoNCcBMWJGn3QRFfq9uR5VPdsVR9OLTvnPMkroLFSzOl2xXVcUqXlgRzm
 Zv7CKX0F1bDTXc2JwAHdRyhoX9T6/+PjjFKw3sfjH0yAdeFjMTvkrFZ3tKf2B/Y1WTYQ
 Re8OGcfblifd5WpYC24TDLdVKW5zPNBnRCICu477DSZcLZMgXEL/moI+jC2eGIW50sQD
 Kz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ttwRYFAemNRv4jrg+BhgI1CmXV5jMDYq2H8cD28Br+A=;
 b=TDjpJWaZKgt2Q6Kthoq3an0h5XvLguOkJy/LiiP+GnINpiYzxM7J6dC3P8MqtbodxR
 AKHs9aJTHTsGjOJABU5o4pWent6v3T+PnNzswbdJQxNOgJXou1n/OBm0yZV1Wf26mf95
 XJHSu1kmXFDk519TtWcLgPo80hgJma0MGRtuMJzn8mua5mNhdnce4e7Cv/ULgVhhIfmV
 +9jiG7UhM3+lgQFZU3fzgYJCjpseGNauwLit0BDP2wsS3ugJ50MpRsyPdTeMdjh1uli3
 ssNpH9POpz5tq0QdSgU9WbS3Kn99hZQ09648WWT6J9VvUr2vGj4VME5MDVs3MoU/wuIu
 uqDg==
X-Gm-Message-State: APjAAAVkc/pOVL3BT+djV25xyVpfOGvQmYs05WppsnQga9XJwlpOVxh5
 XVUDG860Ccd5TQV1q2BDxtSey5yG
X-Google-Smtp-Source: APXvYqxpN2+j+rDLsyVUmbmwbrjUY7JvO9YAmwHUXmkYtXWhXZ/ZnN+9qkJ5fa517125a/BMMC5kXw==
X-Received: by 2002:a1c:61c1:: with SMTP id v184mr6614181wmb.160.1580234338604; 
 Tue, 28 Jan 2020 09:58:58 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 131/142] meson: install icons
Date: Tue, 28 Jan 2020 18:53:31 +0100
Message-Id: <20200128175342.9066-132-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile             | 13 -------------
 ui/icons/meson.build | 13 +++++++++++++
 ui/meson.build       |  1 +
 3 files changed, 14 insertions(+), 13 deletions(-)
 create mode 100644 ui/icons/meson.build

diff --git a/Makefile b/Makefile
index 11e87a0c77..898949ded6 100644
--- a/Makefile
+++ b/Makefile
@@ -229,20 +229,7 @@ ifeq ($(CONFIG_GUEST_AGENT),y)
 endif
 endif
 
-ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
-
 install: all install-datadir install-localstatedir
-	for s in $(ICON_SIZES); do \
-		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
-		$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_$${s}.png \
-			"$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps/qemu.png"; \
-	done; \
-	mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps"; \
-	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_32x32.bmp \
-		"$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp"; \
-	mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps"; \
-	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu.svg \
-		"$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps/qemu.svg"
 	mkdir -p "$(DESTDIR)$(qemu_desktopdir)"
 	$(INSTALL_DATA) $(SRC_PATH)/ui/qemu.desktop \
 		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
diff --git a/ui/icons/meson.build b/ui/icons/meson.build
new file mode 100644
index 0000000000..b6e21f6ad7
--- /dev/null
+++ b/ui/icons/meson.build
@@ -0,0 +1,13 @@
+foreach s: [16, 24, 32, 48, 64, 128, 256, 512]
+  s = '@0@x@0@'.format(s.to_string())
+  install_data('qemu_@0@.png'.format(s),
+               rename: 'qemu.png',
+               install_dir: config_host['qemu_icondir'] / 'hicolor' / s / 'apps')
+endforeach
+
+install_data('qemu_32x32.bmp',
+             rename: 'qemu.bmp',
+             install_dir: config_host['qemu_icondir'] / 'hicolor' / '32x32' / 'apps')
+
+install_data('qemu.svg',
+             install_dir: config_host['qemu_icondir'] / 'hicolor' / 'scalable' / 'apps')
diff --git a/ui/meson.build b/ui/meson.build
index 95ffde3f9a..1d87b975e1 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -108,5 +108,6 @@ foreach e : keymaps
 endforeach
 
 subdir('shader')
+subdir('icons')
 
 modules += {'ui': ui_modules}
-- 
2.21.0



