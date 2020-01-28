Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C285C33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C652173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+zKvS96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C652173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWKG-00043P-VZ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7b-0003K9-VN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7Z-0007hi-RG
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:54 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7Z-0007eg-KB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:53 -0500
Received: by mail-wm1-x342.google.com with SMTP id f129so3585723wmf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8grToJgoRRt4NC7Ag9FksCa8ch64/J2GFZeD8sORChg=;
 b=B+zKvS96vxoHt3VGulshjV5AODMsEbAQSVM1RZhd/4PXqtRNZdsakixgYOJ6Sj6v3D
 nBhikgKL0dzIxGtPlAyRAgeomqs/ysERpGld7f+8JUsf627dH36xy98xbED/xE2rKr+g
 nsC9Xb6LFfvpnWEmxMtWGOYGzLARsQgxjHctOCpNn1Md06hrV6MR2rs60mvO+M25MSzz
 EbXrMKoesReIcS+ztQRTAaEx37FQ5XUX+UaOmKVAJ7MecvPzWOnhGes6/MC5UsQn7RAj
 MICXN4aRIGTeqqLcHZlMSCBfunb738503NEUeJ1gjlJME7e0WN6uDcl84pU90evBXRyW
 YHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8grToJgoRRt4NC7Ag9FksCa8ch64/J2GFZeD8sORChg=;
 b=a6xlJUq6AlPK+9b2GVjCZ/nE1ZJZQ1udJQltQxK5ihlNzKkESwnHhnEjm7uv0fsAv4
 TvR3huDsfUFBqroRuMJ8vLIEgGLxfuNv5tc1kxnEPpYK/72x7dfFarbaCGjxb8dj92tY
 i+TSz0DP3eiclhwV2tosI+Vl9wRJtCdTTN9mQGxd31i4QZfflnM9KSXkVp7hGMhi3gH2
 v2Cc3ppDRGGdS2qajY5IE5N34S4TIaQTauGeUjShzl8MsaQa4vHt1WIYReWlCtjyX6pa
 1w6aTUX96e/MrwyWrR+khmqSzLPgZ25Pa6MuUE0ud7tM75mhRyG/Zb0+tKJ4s+F2f7fr
 oOjA==
X-Gm-Message-State: APjAAAXKx8EZBhlbb+MQIDKtC7FPkA581bm/j6DnwwSFWRxKMOpYM6e/
 7nQfxFyVn7zBpGUviiWc2aTXIMAE
X-Google-Smtp-Source: APXvYqzLbq8mOfD6cgC5w7enweTsmZJsfG0+VukpCBZBXzcWVTOR4tDl+NJnAtseO1YHZ9dhvk+2Jg==
X-Received: by 2002:a1c:b4d7:: with SMTP id d206mr6336186wmf.188.1580234272468; 
 Tue, 28 Jan 2020 09:57:52 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 104/142] meson: convert hw/cpu
Date: Tue, 28 Jan 2020 18:53:04 +0100
Message-Id: <20200128175342.9066-105-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 hw/Makefile.objs     | 1 -
 hw/cpu/Makefile.objs | 5 -----
 hw/cpu/meson.build   | 6 ++++++
 hw/meson.build       | 1 +
 4 files changed, 7 insertions(+), 6 deletions(-)
 delete mode 100644 hw/cpu/Makefile.objs
 create mode 100644 hw/cpu/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 53e4c16f78..0b9879456f 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -5,7 +5,6 @@ devices-dirs-y += adc/
 devices-dirs-y += audio/
 devices-dirs-y += block/
 devices-dirs-y += char/
-devices-dirs-y += cpu/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/cpu/Makefile.objs b/hw/cpu/Makefile.objs
deleted file mode 100644
index 8db9e8a7b3..0000000000
--- a/hw/cpu/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-$(CONFIG_ARM11MPCORE) += arm11mpcore.o
-obj-$(CONFIG_REALVIEW) += realview_mpcore.o
-obj-$(CONFIG_A9MPCORE) += a9mpcore.o
-obj-$(CONFIG_A15MPCORE) += a15mpcore.o
-common-obj-y += core.o cluster.o
diff --git a/hw/cpu/meson.build b/hw/cpu/meson.build
new file mode 100644
index 0000000000..9e52fee9e7
--- /dev/null
+++ b/hw/cpu/meson.build
@@ -0,0 +1,6 @@
+softmmu_ss.add(files('core.c', 'cluster.c'))
+
+specific_ss.add(when: 'CONFIG_ARM11MPCORE', if_true: files('arm11mpcore.c'))
+specific_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview_mpcore.c'))
+specific_ss.add(when: 'CONFIG_A9MPCORE', if_true: files('a9mpcore.c'))
+specific_ss.add(when: 'CONFIG_A15MPCORE', if_true: files('a15mpcore.c'))
diff --git a/hw/meson.build b/hw/meson.build
index dacd26c561..103da4840b 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('cpu')
 subdir('display')
 subdir('dma')
 subdir('gpio')
-- 
2.21.0



