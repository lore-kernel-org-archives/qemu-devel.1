Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C19C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CC22072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHuiDqeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CC22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k953g-0008Vd-F9
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Ed-0003WQ-4K
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94EO-0001pD-Au
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ynfbcLl6Zdt9MTtUOILAaaGn/q/GyrPKPhNf79w27O0=;
 b=JHuiDqeXEMeK6GWwHFnKy8QmTHVWjT5yAo37TjZI9fUvi8t5QOsetr0DZ5ppHxClO0AyRc
 oybO2uf+bFuOGz6fO7kJkvwajBwHfCiB7KnLTkgAJlBiAooCRTBXgc7cwralddJqFuaVpM
 JJz8RPuRxLPratwATcxiDL510kbP3WI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-1Ruod0LoPSOvlHk-uNQzoQ-1; Fri, 21 Aug 2020 06:25:02 -0400
X-MC-Unique: 1Ruod0LoPSOvlHk-uNQzoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 910181009444
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:25:01 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C3A8756D8;
 Fri, 21 Aug 2020 10:25:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 115/152] meson: convert hw/ide
Date: Fri, 21 Aug 2020 06:22:52 -0400
Message-Id: <20200821102329.29777-116-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 hw/Makefile.objs     |  1 -
 hw/ide/Makefile.objs | 14 --------------
 hw/ide/meson.build   | 14 ++++++++++++++
 hw/meson.build       |  1 +
 4 files changed, 15 insertions(+), 15 deletions(-)
 delete mode 100644 hw/ide/Makefile.objs
 create mode 100644 hw/ide/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 3feccd83d7..02c5c0d94e 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -11,7 +11,6 @@ devices-dirs-y += dma/
 devices-dirs-y += gpio/
 devices-dirs-$(CONFIG_HYPERV) += hyperv/
 devices-dirs-$(CONFIG_I2C) += i2c/
-devices-dirs-y += ide/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
deleted file mode 100644
index faf04e0209..0000000000
--- a/hw/ide/Makefile.objs
+++ /dev/null
@@ -1,14 +0,0 @@
-common-obj-$(CONFIG_IDE_CORE) += core.o atapi.o
-common-obj-$(CONFIG_IDE_QDEV) += qdev.o
-common-obj-$(CONFIG_IDE_PCI) += pci.o
-common-obj-$(CONFIG_IDE_ISA) += isa.o ioport.o
-common-obj-$(CONFIG_IDE_PIIX) += piix.o ioport.o
-common-obj-$(CONFIG_IDE_CMD646) += cmd646.o
-common-obj-$(CONFIG_IDE_MACIO) += macio.o
-common-obj-$(CONFIG_IDE_MMIO) += mmio.o
-common-obj-$(CONFIG_IDE_VIA) += via.o
-common-obj-$(CONFIG_MICRODRIVE) += microdrive.o
-common-obj-$(CONFIG_AHCI) += ahci.o
-common-obj-$(CONFIG_AHCI_ICH9) += ich.o
-common-obj-$(CONFIG_ALLWINNER_A10) += ahci-allwinner.o
-common-obj-$(CONFIG_IDE_SII3112) += sii3112.o
diff --git a/hw/ide/meson.build b/hw/ide/meson.build
new file mode 100644
index 0000000000..ddcb3b28d2
--- /dev/null
+++ b/hw/ide/meson.build
@@ -0,0 +1,14 @@
+softmmu_ss.add(when: 'CONFIG_AHCI', if_true: files('ahci.c'))
+softmmu_ss.add(when: 'CONFIG_AHCI_ICH9', if_true: files('ich.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('ahci-allwinner.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_CMD646', if_true: files('cmd646.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_CORE', if_true: files('core.c', 'atapi.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_ISA', if_true: files('isa.c', 'ioport.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_MACIO', if_true: files('macio.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_MMIO', if_true: files('mmio.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_PCI', if_true: files('pci.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_PIIX', if_true: files('piix.c', 'ioport.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_QDEV', if_true: files('qdev.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_SII3112', if_true: files('sii3112.c'))
+softmmu_ss.add(when: 'CONFIG_IDE_VIA', if_true: files('via.c'))
+softmmu_ss.add(when: 'CONFIG_MICRODRIVE', if_true: files('microdrive.c'))
diff --git a/hw/meson.build b/hw/meson.build
index b15c8d0970..4d7c31c652 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('ide')
 subdir('input')
 subdir('intc')
 subdir('ipack')
-- 
2.26.2



