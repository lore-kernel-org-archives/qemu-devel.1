Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B39C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9949A20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohl5c7ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9949A20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWDZ-0001nD-RU
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6d-000237-0x
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6b-0005JX-7g
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:54 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6Z-0005Ep-TG
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:52 -0500
Received: by mail-wr1-x42d.google.com with SMTP id y17so17110417wrh.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B2Kr3drluyK87HV3/IspB7WASRbazRGk/3fqRIsRHd4=;
 b=ohl5c7ryk2STGk3n8U9QD8/NYQmVRLd3GIv0R1ik4urjo2tDWOOMzWLrxcBcys5VOE
 Q57zSu5iMEJ49PaXbB9YYk9/VELr7La3EJLsrKhzg1ullAd3EmIlFyxiyQ1BUaihU9i9
 p12EmJsniTsu6rDOFXhdp3s9zcKNoizFPm43mXAGsnH6VFUjcgeKTfMU/r+F9SKSVSvM
 y0QJ2obTfPexuFr3eQtrx1+y4L67mbbH1jQCS9Mk0gs9ofuagyIRCEXqCSc8/0pNcvGe
 TxVolquY47pO7bVpM8oPA/GOvNvtlvbQMBIPASafLskKRnf4IjVT+iM5zIssloP/jbgd
 8fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=B2Kr3drluyK87HV3/IspB7WASRbazRGk/3fqRIsRHd4=;
 b=dVXzQyF5N/sEIpQQAx2HDcchvxGLySwC/DYZNHMB3C6Y6Dqfc7TztszmYgfN/Mlyl9
 leYQx6nvMbVX10wXaDJM13NxYrcLO20Vg54aNFOCpLQ2f+qcqQMsFzVclUszfvK710xf
 n8Ei9GUXO6Y9M2x9pWJLYXiwt0Jli6sVbsW2e+uMJ5kcCDZ1pqCPodV7WrsbUMvaSSyh
 tgF9iTOxrDqnzT6sUly8FP4ORrQuS6/opxlRNzX+09TNTsxyYErC3w7L2oD4bNz4bKkx
 9WFgCFGQeSjrYh7hY2X72Wuwf4MfMFdrhcY4EL7km4ynKDy0U1cyopW9UzbkU7oEq2jC
 0n0w==
X-Gm-Message-State: APjAAAVMPWKBvuQHFMm1c2xioWXmKWNQGmKlvTInctrYm//1N7zNPEx7
 sdMRmJ0r7eZ5ZFfshcNyMyTpHaFb
X-Google-Smtp-Source: APXvYqxYZnqmqrTMEBA9y7aEIuLbscsymrUXmAiky0rPrv+GL5+O5XN1O6nm8VL2pI31aSV61r9q9Q==
X-Received: by 2002:adf:f244:: with SMTP id b4mr28617311wrp.88.1580234208751; 
 Tue, 28 Jan 2020 09:56:48 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 076/142] meson: convert hw/virtio
Date: Tue, 28 Jan 2020 18:52:36 +0100
Message-Id: <20200128175342.9066-77-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
 hw/Makefile.objs        |  1 -
 hw/meson.build          |  1 +
 hw/virtio/Makefile.objs | 41 --------------------------------------
 hw/virtio/meson.build   | 44 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 42 deletions(-)
 delete mode 100644 hw/virtio/Makefile.objs
 create mode 100644 hw/virtio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 9232919ac3..742b310f13 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -32,7 +32,6 @@ devices-dirs-y += timer/
 devices-dirs-$(CONFIG_TPM) += tpm/
 devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
-devices-dirs-y += virtio/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index f2209d900c..8338fc4408 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,5 +3,6 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('virtio')
 subdir('watchdog')
 subdir('xen')
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
deleted file mode 100644
index de0f5fc39b..0000000000
--- a/hw/virtio/Makefile.objs
+++ /dev/null
@@ -1,41 +0,0 @@
-ifeq ($(CONFIG_VIRTIO),y)
-common-obj-y += virtio-bus.o
-obj-y += virtio.o
-
-obj-$(CONFIG_VHOST) += vhost.o vhost-backend.o
-common-obj-$(call lnot,$(CONFIG_VHOST)) += vhost-stub.o
-obj-$(CONFIG_VHOST_USER) += vhost-user.o
-
-common-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng.o
-common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
-common-obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
-obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
-obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
-obj-$(CONFIG_VHOST_USER_FS) += vhost-user-fs.o
-obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
-obj-$(CONFIG_VIRTIO_PMEM) += virtio-pmem.o
-common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) += virtio-pmem-pci.o
-obj-$(call land,$(CONFIG_VHOST_USER_FS),$(CONFIG_VIRTIO_PCI)) += vhost-user-fs-pci.o
-obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
-
-ifeq ($(CONFIG_VIRTIO_PCI),y)
-obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
-obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
-obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input-pci.o
-obj-$(CONFIG_VHOST_USER_SCSI) += vhost-user-scsi-pci.o
-obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-pci.o
-obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
-obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
-obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
-obj-$(CONFIG_VIRTIO_SCSI) += virtio-scsi-pci.o
-obj-$(CONFIG_VIRTIO_BLK) += virtio-blk-pci.o
-obj-$(CONFIG_VIRTIO_NET) += virtio-net-pci.o
-obj-$(CONFIG_VIRTIO_SERIAL) += virtio-serial-pci.o
-endif
-else
-common-obj-y += vhost-stub.o
-endif
-
-common-obj-$(CONFIG_ALL) += vhost-stub.o
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
new file mode 100644
index 0000000000..561e5c9825
--- /dev/null
+++ b/hw/virtio/meson.build
@@ -0,0 +1,44 @@
+softmmu_virtio_ss = ss.source_set()
+softmmu_virtio_ss.add(files('virtio-bus.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VHOST', if_false: files('vhost-stub.c'))
+softmmu_virtio_ss.add(when: ['CONFIG_VIRTIO_PMEM', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-pmem-pci.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_VIRTIO', if_true: softmmu_virtio_ss)
+softmmu_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
+
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
+
+virtio_ss = ss.source_set()
+virtio_ss.add(files('virtio.c'))
+virtio_ss.add(when: 'CONFIG_VHOST', if_true: files('vhost.c', 'vhost-backend.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
+virtio_ss.add(when: ['CONFIG_VIRTIO_CRYPTO', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-crypto-pci.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
+virtio_ss.add(when: ['CONFIG_VHOST_USER_FS', 'CONFIG_VIRTIO_PCI'], if_true: files('vhost-user-fs-pci.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
+
+virtio_pci_ss = ss.source_set()
+virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio-scsi-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-serial-pci.c'))
+
+virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
+
+specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: virtio_ss)
-- 
2.21.0



