Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F5AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1502074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhiOVemv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1502074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WXO-0004BI-V4
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnO-0006ye-Bm
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56941
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnL-00034n-Hf
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sg9YVJRv6wW6cfJ0v4OQv28WxAZBM0uAS+h3Qkeg40s=;
 b=DhiOVemvrbJFjUqtBpKRyVTA+pwla+NQciUhO4O4u7LjTNhbb4zNBaOjl5NEKXBLpozNkN
 AHPptHxdQw9I946ANnYEfLJPPP6BZ1sc7BDKaDmZFFTVtGkgKeS3FKQExwD3W3FWLFCrPZ
 cHw0UvTyGoTuYvlxYfeZaFZPUwBKgIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-M61JCvmIPsOmohs0VsO7iA-1; Fri, 14 Aug 2020 05:14:36 -0400
X-MC-Unique: M61JCvmIPsOmohs0VsO7iA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1125801AC5
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AED10600E4;
 Fri, 14 Aug 2020 09:14:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 098/150] meson: convert hw/ssi
Date: Fri, 14 Aug 2020 05:12:34 -0400
Message-Id: <20200814091326.16173-99-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 hw/meson.build       |  1 +
 hw/ssi/Makefile.objs | 10 ----------
 hw/ssi/meson.build   |  9 +++++++++
 4 files changed, 10 insertions(+), 11 deletions(-)
 delete mode 100644 hw/ssi/Makefile.objs
 create mode 100644 hw/ssi/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index f60fd019ac..e50eb04635 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -26,7 +26,6 @@ devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-y += pcmcia/
 devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-y += sd/
-devices-dirs-y += ssi/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 1fb1687e1e..75644266f2 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -4,6 +4,7 @@ subdir('nubus')
 subdir('rtc')
 subdir('semihosting')
 subdir('smbios')
+subdir('ssi')
 subdir('timer')
 subdir('tpm')
 subdir('usb')
diff --git a/hw/ssi/Makefile.objs b/hw/ssi/Makefile.objs
deleted file mode 100644
index 07a85f1967..0000000000
--- a/hw/ssi/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-common-obj-$(CONFIG_PL022) += pl022.o
-common-obj-$(CONFIG_SSI) += ssi.o
-common-obj-$(CONFIG_XILINX_SPI) += xilinx_spi.o
-common-obj-$(CONFIG_XILINX_SPIPS) += xilinx_spips.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_smc.o
-common-obj-$(CONFIG_STM32F2XX_SPI) += stm32f2xx_spi.o
-common-obj-$(CONFIG_MSF2) += mss-spi.o
-
-common-obj-$(CONFIG_OMAP) += omap_spi.o
-common-obj-$(CONFIG_IMX) += imx_spi.o
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
new file mode 100644
index 0000000000..f1f5c287d0
--- /dev/null
+++ b/hw/ssi/meson.build
@@ -0,0 +1,9 @@
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_smc.c'))
+softmmu_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-spi.c'))
+softmmu_ss.add(when: 'CONFIG_PL022', if_true: files('pl022.c'))
+softmmu_ss.add(when: 'CONFIG_SSI', if_true: files('ssi.c'))
+softmmu_ss.add(when: 'CONFIG_STM32F2XX_SPI', if_true: files('stm32f2xx_spi.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX_SPI', if_true: files('xilinx_spi.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX_SPIPS', if_true: files('xilinx_spips.c'))
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
+softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_spi.c'))
-- 
2.26.2



