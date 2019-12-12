Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40BFC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841C52077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKzKwUW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841C52077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOil-00050e-9X
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyr-0004I1-Vz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyq-0007k6-JL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:09 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:41629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyq-0007il-B4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:08 -0500
Received: by mail-wr1-x42b.google.com with SMTP id c9so2604405wrw.8
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j12SgvFUEMlLTMG0dlw8JQNUMvzFA/y97s9nwnCqE4I=;
 b=BKzKwUW+igYVlfNZTSixnxrNjnDnnkVF9/0E/sd9cSUKKSnPFuaT94QBEerIzJlUme
 MKaGDeZOQrm1vSHBWwCeIBF9OYnFAuig50SsZWJ9k6EhOspRr6RhxvdcSL2+3rupOYkh
 GqNivcF+fbpOuYDe752wEkpd4289wr5IWtDFnoujG3VLoCFuyJDYHrCsiwB8Uo6dMa3i
 /NZiGCiM189V6tb01QtBpMWpocvPlApG0IDZPnaNJwBTjwcRg+eJp0ZDzm3cbKmRwyU7
 8xEF+xMQdXnixib5fXygQzvNMxrfjnoFtPeqUlxf7Z+fTVYrSGKNByjOB6PGFZRF273y
 ontA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=j12SgvFUEMlLTMG0dlw8JQNUMvzFA/y97s9nwnCqE4I=;
 b=dyZoBEDVLf8o/u+duTsR1jc0WgTlwO+leuZmSJmsAg2vRCkXhA/9E7c9G55qna94W5
 bZb7qOmcnTjPVc7ZxHRs5LaoPAmh29drZu9Ei2PhpaMxyVTIMsq4I37g5/dVhRrAoALV
 0lnFRI5b9P/O4R4u4WVAou38aN6mR3+A0u9B3cVZsRupL6bXsRAQlQU8uKvZFLWK9CLx
 wHCXTKI0uShTzmKroWgU+T8KTKvcI7xUOcmgzK1aESpCNJ+6DkdFcogzC8VfaGaVJhqX
 icbdaHgI2adXVc3WEr4SeCORqkUqr/IF9nCXk/LL21qkfQKOUkVFpxRnxVoF/qs5P40L
 FY4g==
X-Gm-Message-State: APjAAAVpBK/J8htMlsUBIROXgG+B/Lj35POBaUPYX88ZWMJ0pFUI7IO4
 v8PxrVp3u8mA5MsMm4drmD9760kM
X-Google-Smtp-Source: APXvYqyAnips2NxZhNeO61iScFJfWPcMLo0eNTGZdCmbd0DavSOoBbKPEYavcdI6uCyNBZyh4gl+4Q==
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr6168159wrn.152.1576155247095; 
 Thu, 12 Dec 2019 04:54:07 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 069/132] meson: convert hw/virtio
Date: Thu, 12 Dec 2019 13:51:53 +0100
Message-Id: <1576155176-2464-70-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 hw/Makefile.objs        |  1 -
 hw/meson.build          |  1 +
 hw/virtio/Makefile.objs | 39 ---------------------------------------
 hw/virtio/meson.build   | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 40 deletions(-)
 delete mode 100644 hw/virtio/Makefile.objs
 create mode 100644 hw/virtio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a1d3f07..3f528b5 100644
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
index 376dbef..a8e9acd 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -2,5 +2,6 @@ subdir('core')
 subdir('mem')
 subdir('semihosting')
 subdir('smbios')
+subdir('virtio')
 subdir('watchdog')
 subdir('xen')
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
deleted file mode 100644
index e0d7cd3..0000000
--- a/hw/virtio/Makefile.objs
+++ /dev/null
@@ -1,39 +0,0 @@
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
-obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
-obj-$(CONFIG_VIRTIO_PMEM) += virtio-pmem.o
-common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) += virtio-pmem-pci.o
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
index 0000000..1a75a87
--- /dev/null
+++ b/hw/virtio/meson.build
@@ -0,0 +1,42 @@
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
1.8.3.1



