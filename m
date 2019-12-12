Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A9C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CCD2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBqnNhiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CCD2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOfm-0001Tx-Sr
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyp-0004Ec-N2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyo-0007gd-KB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:07 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyo-0007fD-DY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:06 -0500
Received: by mail-wm1-x342.google.com with SMTP id n9so2246555wmd.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+voKtS/tCPLOrQL4iyH8p1hj5TaZ5R0ylnlgcmlNHwg=;
 b=hBqnNhizDVBrsZF/W11KNoMR8YBa83G1bA40OsApcxiXcWCNvmP6rmdfdJaDxFxFpw
 YoxcKA9TNoAPdQyPiZEm10JFwEFwuBAOFaxCsna1K+PunIelQKhn69loZUMF2MpvDb9E
 lWMaVIvx/691rwOSGDk4bMULdcf4E3yXuuBFxtPSlqUOZwhx3g9dsh9qrPNO35BTdcOi
 xRq0jZ4nPMYlHRY0ZXxGDfBaCSAa0UdxQAMymYPj4UOqjRUJEYeJ5b0/QncSj4voEt3V
 Jlw5tyc+3j7pgRoqb8QdgevthEshR7lMLwitiuL638W97HUeSQQqAbRo8xE2gOR7tPk7
 tFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+voKtS/tCPLOrQL4iyH8p1hj5TaZ5R0ylnlgcmlNHwg=;
 b=FKDgkm4W68B9dt95C1OZvH+VNjR09kNu0mkS9o7qa9m32vc06A+4/yidAEEXH1FSn1
 mwwr688Zeuk6rUHFGU1amkjwPJmrK+WwkXciJQDM3hnbDEkhF5oElW61LBkXDNXvrciz
 96fBXx/X+D929DFTuXWstFZjGMOeL77g6KZlXfsokQ6cgPV4q5z5akWZS8PZtALr4mlJ
 LvbCngdfmgqPKtW6LMLjfWenQn0t1euWVT9a8dBNf+IZYFkw4fM6nLpSoRN8VEHN8QcY
 bfnuCFIOX8KlOz9S0PIWHRnkCXxwtqSWbSV0B1i8Rom03pHu2qn5BzCsMBiQxSuVm6gr
 vSPg==
X-Gm-Message-State: APjAAAW+KVRIq/+vNutWgQyu+OgdfLoUKqckX71SxNkDTj3oGxrkm3wD
 dmODlZjNWG6RQCJfvD1osHnNGrzF
X-Google-Smtp-Source: APXvYqxROOcs3sQ1SXv14rfi0wZ/uMNuiX1CJjAh8z7a5HICSkvsEk8nGztWNlrponSXAPiRhlKWKg==
X-Received: by 2002:a1c:9903:: with SMTP id b3mr6259272wme.139.1576155245229; 
 Thu, 12 Dec 2019 04:54:05 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 067/132] meson: convert hw/mem
Date: Thu, 12 Dec 2019 13:51:51 +0100
Message-Id: <1576155176-2464-68-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs     | 1 -
 hw/mem/Kconfig       | 1 +
 hw/mem/Makefile.objs | 3 ---
 hw/mem/meson.build   | 3 +++
 hw/meson.build       | 1 +
 5 files changed, 5 insertions(+), 4 deletions(-)
 delete mode 100644 hw/mem/Makefile.objs
 create mode 100644 hw/mem/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index f5c2ab4..b91472b 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -34,7 +34,6 @@ devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
-devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 620fd4c..9e6c6b8 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -9,3 +9,4 @@ config NVDIMM
     bool
     default y
     depends on PC
+    select MEM_DEVICE
diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
deleted file mode 100644
index 3e2f7c5..0000000
--- a/hw/mem/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-common-obj-$(CONFIG_DIMM) += pc-dimm.o
-common-obj-$(CONFIG_MEM_DEVICE) += memory-device.o
-common-obj-$(CONFIG_NVDIMM) += nvdimm.o
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
new file mode 100644
index 0000000..f9adc45
--- /dev/null
+++ b/hw/mem/meson.build
@@ -0,0 +1,3 @@
+common_ss.add(when: 'CONFIG_MEM_DEVICE', if_true: files('memory-device.c'))
+common_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
+common_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 80da62d..d788be4 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('mem')
 subdir('semihosting')
 subdir('smbios')
 subdir('xen')
-- 
1.8.3.1



