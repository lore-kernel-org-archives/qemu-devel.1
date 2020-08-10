Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D54C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDD420885
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVwqbZQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDD420885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BmL-0001ZE-Cj
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKp-0001gK-Ft
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKn-0003CA-9o
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAdpJ6uFzac1e0yweaVtIrh6BZyTsNYsf8fXcvTvDxc=;
 b=IVwqbZQjiy6FaNNaBlFdqw0JHBqAVn4TxFaQHPZiTLeUYbC2qVivh95X9TSWck1+/0JiYI
 qmxnmtwS48Fuk3uA/YSFKL1nDdBIGuAKXqFtYxoPLb9MQUZSXjXaB2B7Le3wZWFlIqYNkx
 vFwasJKAZrcXlCiInHI1wqqVjybIrDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-n5GYCBZQMVmLL5wvkOYk9g-1; Mon, 10 Aug 2020 13:11:38 -0400
X-MC-Unique: n5GYCBZQMVmLL5wvkOYk9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 172378014D7
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:11:37 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 237815F1E9;
 Mon, 10 Aug 2020 17:11:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 089/147] meson: convert hw/virtio
Date: Mon, 10 Aug 2020 19:08:07 +0200
Message-Id: <1597079345-42801-90-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs        |  1 -
 hw/meson.build          |  1 +
 hw/virtio/Makefile.objs | 48 ----------------------------------------------
 hw/virtio/meson.build   | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 49 deletions(-)
 delete mode 100644 hw/virtio/Makefile.objs
 create mode 100644 hw/virtio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 9ebd13d..a1cfb99 100644
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
index f2209d9..8338fc4 100644
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
index fc91719..0000000
--- a/hw/virtio/Makefile.objs
+++ /dev/null
@@ -1,48 +0,0 @@
-ifeq ($(CONFIG_VIRTIO),y)
-common-obj-y += virtio-bus.o
-obj-y += virtio.o
-
-obj-$(CONFIG_VHOST) += vhost.o vhost-backend.o
-common-obj-$(call lnot,$(CONFIG_VHOST)) += vhost-stub.o
-obj-$(CONFIG_VHOST_USER) += vhost-user.o
-obj-$(CONFIG_VHOST_VDPA) += vhost-vdpa.o
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
-obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
-obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-common.o vhost-vsock.o
-obj-$(CONFIG_VHOST_USER_VSOCK) += vhost-vsock-common.o vhost-user-vsock.o
-obj-$(CONFIG_VIRTIO_MEM) += virtio-mem.o
-common-obj-$(call land,$(CONFIG_VIRTIO_MEM),$(CONFIG_VIRTIO_PCI)) += virtio-mem-pci.o
-
-ifeq ($(CONFIG_VIRTIO_PCI),y)
-obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
-obj-$(CONFIG_VHOST_USER_VSOCK) += vhost-user-vsock-pci.o
-obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
-obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input-pci.o
-obj-$(CONFIG_VHOST_USER_SCSI) += vhost-user-scsi-pci.o
-obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-pci.o
-obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
-obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
-obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu-pci.o
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
index 0000000..fbff9bc
--- /dev/null
+++ b/hw/virtio/meson.build
@@ -0,0 +1,51 @@
+softmmu_virtio_ss = ss.source_set()
+softmmu_virtio_ss.add(files('virtio-bus.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
+softmmu_virtio_ss.add(when: 'CONFIG_VHOST', if_false: files('vhost-stub.c'))
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
+virtio_ss.add(when: 'CONFIG_VHOST_VDPA', if_true: files('vhost-vdpa.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
+virtio_ss.add(when: ['CONFIG_VIRTIO_CRYPTO', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-crypto-pci.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
+virtio_ss.add(when: ['CONFIG_VHOST_USER_FS', 'CONFIG_VIRTIO_PCI'], if_true: files('vhost-user-fs-pci.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c', 'vhost-vsock-common.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c', 'vhost-vsock-common.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
+
+virtio_pci_ss = ss.source_set()
+virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock-pci.c'))
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
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
+
+virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
+
+specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: virtio_ss)
-- 
1.8.3.1



