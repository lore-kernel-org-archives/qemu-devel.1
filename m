Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158CCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47FC2465B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vS7zPy8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47FC2465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwW23-0001wf-2Y
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6i-00024d-F3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6g-0005TY-BO
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:59 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6e-0005Pr-TY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:58 -0500
Received: by mail-wm1-x342.google.com with SMTP id t14so3547521wmi.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9lB6daxbeo+BLy89DCXZt/sDgNZH0UEWPjjwESelKjs=;
 b=vS7zPy8Ybtlp5my7L97ulos2Hq3nR21DYfzcdxB/n03BuZQjmZx9FqB+aXkuWGbErh
 irixj6Z7UGGrJIqFlnl/SeGLc93czbrvK206xHorKjLlJBXsGIgcwV6HPXsIJ6H7u3JH
 DJ1vFTUUcaH3uYRkm23KuDfHMYqODSzSwvc9lKZsvYKo7xDKneAg1UFs7bTVBH91G3iz
 qB4cN92hQVKZW2v2Pr04nNpd+KVtyo/SAQk3TdhJqhQHJmOUqyjqZPQGjgbvFK5ZOrJs
 hRfjcDByJi0yP09tLQNz0w2jVtFhyEcMGEnyL3veF9qZeRN3PWuTnDd/lIRKI4+abLfL
 KdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9lB6daxbeo+BLy89DCXZt/sDgNZH0UEWPjjwESelKjs=;
 b=GhCLd5cbynzKN6vHASrRPg0FlC18FVNBt2d/sRaOv04KQYNAjI0S4mTBAWDsUsN5bT
 v/tDI60oIw7yRtHfghg4u6II+MncdMfid9Hi6ebtHWHaGoezcrT0nJFtDn9u6tspbTwJ
 6NTACXonr4lHxUBOep/IqBUtPJd53qbwxS26i/5WKkOtOz7z4q7QclFzJE6fM4zb4oZp
 ReyJyyDjb1rl8+ZZUssRfXVVuk6Zo1dCJB2g9/DIOhKqmYOUE8YXUhr58fsZKSqqggX9
 NpuKH4jo+AGqzjDLNqf+q8C8gNEl9+HP/L7FaZ8jO+DM1LlWX2PfqWmXjt/2shMJP+rz
 z4aw==
X-Gm-Message-State: APjAAAUlECqXzbOn7YqkUR6uxS7ShcDohfUAFajFQ8VEYz9+aOpM9vcE
 hiLAd3CaIIrvxp1t1TaCX02ibdbW
X-Google-Smtp-Source: APXvYqyfU9DRXIncgjJasrHS34gYUv7k5p+NFRlSKuPhRiS5UXPpLrQD0Gyu4ouE2f7gRKQ1+W54XA==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr6241936wmi.70.1580234215667; 
 Tue, 28 Jan 2020 09:56:55 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 079/142] meson: convert hw/tpm
Date: Tue, 28 Jan 2020 18:52:39 +0100
Message-Id: <20200128175342.9066-80-pbonzini@redhat.com>
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
 hw/meson.build       | 1 +
 hw/tpm/Makefile.objs | 6 ------
 hw/tpm/meson.build   | 7 +++++++
 4 files changed, 8 insertions(+), 7 deletions(-)
 delete mode 100644 hw/tpm/Makefile.objs
 create mode 100644 hw/tpm/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 72f808f8ec..68328d5086 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -29,7 +29,6 @@ devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-y += sd/
 devices-dirs-y += ssi/
 devices-dirs-y += timer/
-devices-dirs-$(CONFIG_TPM) += tpm/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 89bd6adb70..2ddf6bad33 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,6 +3,7 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('tpm')
 subdir('usb')
 subdir('vfio')
 subdir('virtio')
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
deleted file mode 100644
index de0b85d02a..0000000000
--- a/hw/tpm/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-common-obj-$(CONFIG_TPM) += tpm_util.o
-obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) += tpm_ppi.o
-common-obj-$(CONFIG_TPM_TIS) += tpm_tis.o
-common-obj-$(CONFIG_TPM_CRB) += tpm_crb.o
-common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
-common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o
diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
new file mode 100644
index 0000000000..9ab7cd7299
--- /dev/null
+++ b/hw/tpm/meson.build
@@ -0,0 +1,7 @@
+softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm_util.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_tis.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_PASSTHROUGH', if_true: files('tpm_passthrough.c'))
+softmmu_ss.add(when: 'CONFIG_TPM_EMULATOR', if_true: files('tpm_emulator.c'))
+
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TPMDEV'], if_true: files('tpm_ppi.c'))
-- 
2.21.0



