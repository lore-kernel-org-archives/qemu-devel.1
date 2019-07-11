Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C796CC71142
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967EF20863
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iae8uT6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967EF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlcmH-0006ko-KJ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60004)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlcm0-0005q7-7Z
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlcly-0003jA-So
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:22:24 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hlcly-0003hi-Mf
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:22:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id h19so7450056wme.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 10:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8jfPHYDP/Jv1ss0TndIwtapkw5U3C3otDUhZHMou5PA=;
 b=Iae8uT6jM74ZpwsABNNOFKNAaxIdsCfwjGTObwn6yc9B4VV81Qu/+05YM85Ed2X4wN
 J1bUyCxLWiYZCIeG6KzboZGaUGYdFan9ReQkfdSCdP/kZ7HXuTfLu13CgpX9MxG3ZyOj
 LYwWOwWr10j5z2Vs84o2HxPIBjcru8XI05YjbaZcAukgcFovSmgUyfO9z3HJ23y1DCuJ
 1GNsM18HIjKNl9BBNFtj6fpWMLBoZuUyLCyOO3r32C7mbtm+b6JcYxrshAVYz9ZqSapF
 KtgRB+YdazgL2EKNqN4qGZs+WkQqY2s4zqBsEl5QKy0bKzyZzvlUodPfR5PWCL6n3iDY
 pUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=8jfPHYDP/Jv1ss0TndIwtapkw5U3C3otDUhZHMou5PA=;
 b=WW/yck4sk72IK6FaTzUSHCQkwUQQJXGCRqadTYQeEgyIJ+FPrbYQyi4zAHFaQJYBPn
 O0qjBXebA0kJ3dEht8OClfqjdQOG4c8GMUsfhNzGQfO95sQemOO72bLX75H6dVE47iGi
 Oku0WYMY0wkv7YOD9t/Re9XyW5Q0Dy3uFxpMiO2FozfnZuljy5kcttoYTlz1mzEbU0nL
 f5AUDa8KGEvwBIAXEvM6cVF61AXdowOlDfpX4zsmNWxb1PV6ydqIWsangOVUuMSYAUgM
 h5SJ7S6ciRqSjZhPCf0swvu+viEqW1FgJG1/O4uIS8zxwdqykgyzAt+81PQq2wzqoAav
 tSyQ==
X-Gm-Message-State: APjAAAVTR+pkfjBe/gcguxxP5oihQChqrfw0jcsEj3CA+BlfPji2p/hx
 DtbwF36hfJUz0vJLaPEZUbdwJ+WpqIE=
X-Google-Smtp-Source: APXvYqyPXq2MH5kCz10RZUiuekuxhMzRRsCCVVZs7DQT+cDqElvkdrEheXZTPQLkoYROwY+tHh8XUw==
X-Received: by 2002:a1c:6a17:: with SMTP id f23mr5096115wmc.91.1562865739372; 
 Thu, 11 Jul 2019 10:22:19 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c11sm8654514wrq.45.2019.07.11.10.22.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 10:22:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 19:22:15 +0200
Message-Id: <1562865736-3546-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562865736-3546-1-git-send-email-pbonzini@redhat.com>
References: <1562865736-3546-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 1/2] Makefile: do not repeat $(CONFIG_SOFTMMU)
 in hw/Makefile.objs
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The device directories must be included only for softmmu builds.
Instead of repeating $(CONFIG_SOFTMMU), use an "ifeq".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs | 61 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index d770926..ece6cc3 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,42 +1,45 @@
+devices-dirs-y = core/
+ifeq ($(CONFIG_SOFTMMU), y)
 devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
-devices-dirs-$(CONFIG_SOFTMMU) += acpi/
-devices-dirs-$(CONFIG_SOFTMMU) += adc/
-devices-dirs-$(CONFIG_SOFTMMU) += audio/
-devices-dirs-$(CONFIG_SOFTMMU) += block/
-devices-dirs-$(CONFIG_SOFTMMU) += bt/
-devices-dirs-$(CONFIG_SOFTMMU) += char/
-devices-dirs-$(CONFIG_SOFTMMU) += cpu/
-devices-dirs-$(CONFIG_SOFTMMU) += display/
-devices-dirs-$(CONFIG_SOFTMMU) += dma/
-devices-dirs-$(CONFIG_SOFTMMU) += gpio/
+devices-dirs-y += acpi/
+devices-dirs-y += adc/
+devices-dirs-y += audio/
+devices-dirs-y += block/
+devices-dirs-y += bt/
+devices-dirs-y += char/
+devices-dirs-y += cpu/
+devices-dirs-y += display/
+devices-dirs-y += dma/
+devices-dirs-y += gpio/
 devices-dirs-$(CONFIG_HYPERV) += hyperv/
 devices-dirs-$(CONFIG_I2C) += i2c/
-devices-dirs-$(CONFIG_SOFTMMU) += ide/
-devices-dirs-$(CONFIG_SOFTMMU) += input/
-devices-dirs-$(CONFIG_SOFTMMU) += intc/
+devices-dirs-y += ide/
+devices-dirs-y += input/
+devices-dirs-y += intc/
 devices-dirs-$(CONFIG_IPACK) += ipack/
 devices-dirs-$(CONFIG_IPMI) += ipmi/
-devices-dirs-$(CONFIG_SOFTMMU) += isa/
-devices-dirs-$(CONFIG_SOFTMMU) += misc/
-devices-dirs-$(CONFIG_SOFTMMU) += net/
-devices-dirs-$(CONFIG_SOFTMMU) += rdma/
-devices-dirs-$(CONFIG_SOFTMMU) += nvram/
-devices-dirs-$(CONFIG_SOFTMMU) += pci/
+devices-dirs-y += isa/
+devices-dirs-y += misc/
+devices-dirs-y += net/
+devices-dirs-y += rdma/
+devices-dirs-y += nvram/
+devices-dirs-y += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
-devices-dirs-$(CONFIG_SOFTMMU) += pcmcia/
+devices-dirs-y += pcmcia/
 devices-dirs-$(CONFIG_SCSI) += scsi/
-devices-dirs-$(CONFIG_SOFTMMU) += sd/
-devices-dirs-$(CONFIG_SOFTMMU) += ssi/
-devices-dirs-$(CONFIG_SOFTMMU) += timer/
+devices-dirs-y += sd/
+devices-dirs-y += ssi/
+devices-dirs-y += timer/
 devices-dirs-$(CONFIG_TPM) += tpm/
-devices-dirs-$(CONFIG_SOFTMMU) += usb/
+devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
-devices-dirs-$(CONFIG_SOFTMMU) += virtio/
-devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
-devices-dirs-$(CONFIG_SOFTMMU) += xen/
+devices-dirs-y += virtio/
+devices-dirs-y += watchdog/
+devices-dirs-y += xen/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
-devices-dirs-$(CONFIG_SOFTMMU) += smbios/
 devices-dirs-y += semihosting/
-devices-dirs-y += core/
+devices-dirs-y += smbios/
+endif
+
 common-obj-y += $(devices-dirs-y)
 obj-y += $(devices-dirs-y)
-- 
1.8.3.1



