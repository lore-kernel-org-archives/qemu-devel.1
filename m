Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768B6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B212074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXaYnWet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B212074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6We3-00013A-Bt
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vnc-0007bz-AX
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vna-00038W-B7
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Avrm7+QSz2JDaUSsDG3e4jcUoGqDFFfk2VHkyPFsAEo=;
 b=EXaYnWetKRGHUgkEAN3k2ejT+r6YTLLx8HiOP15Y0gUMu36linbyNjxlpbrcw/rj22+/hu
 h+jd0XPqYIjHBHZ1p46FD272gP4ShP4bbCc0FR+WXUK48zUSAhIU5ON2FwF/LHSu6Www/8
 RLflFEddbGxhvNA0JvOxl/wnwgBhxps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-sKcGlESVMQm5O5CO18dB1A-1; Fri, 14 Aug 2020 05:14:51 -0400
X-MC-Unique: sKcGlESVMQm5O5CO18dB1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA539801AC2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86A3F600E4;
 Fri, 14 Aug 2020 09:14:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 118/150] meson: convert hw/dma
Date: Fri, 14 Aug 2020 05:12:54 -0400
Message-Id: <20200814091326.16173-119-pbonzini@redhat.com>
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
 hw/dma/Makefile.objs | 16 ----------------
 hw/dma/meson.build   | 15 +++++++++++++++
 hw/meson.build       |  1 +
 4 files changed, 16 insertions(+), 17 deletions(-)
 delete mode 100644 hw/dma/Makefile.objs
 create mode 100644 hw/dma/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index c04dfe589c..26917a4e1b 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -7,7 +7,6 @@ devices-dirs-y += block/
 devices-dirs-y += char/
 devices-dirs-y += cpu/
 devices-dirs-y += display/
-devices-dirs-y += dma/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
deleted file mode 100644
index f4b1cfe26d..0000000000
--- a/hw/dma/Makefile.objs
+++ /dev/null
@@ -1,16 +0,0 @@
-common-obj-$(CONFIG_PUV3) += puv3_dma.o
-common-obj-$(CONFIG_RC4030) += rc4030.o
-common-obj-$(CONFIG_PL080) += pl080.o
-common-obj-$(CONFIG_PL330) += pl330.o
-common-obj-$(CONFIG_I82374) += i82374.o
-common-obj-$(CONFIG_I8257) += i8257.o
-common-obj-$(CONFIG_XILINX_AXI) += xilinx_axidma.o
-common-obj-$(CONFIG_ZYNQ_DEVCFG) += xlnx-zynq-devcfg.o
-common-obj-$(CONFIG_ETRAXFS) += etraxfs_dma.o
-common-obj-$(CONFIG_STP2000) += sparc32_dma.o
-common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dpdma.o
-common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zdma.o
-
-common-obj-$(CONFIG_OMAP) += omap_dma.o soc_dma.o
-common-obj-$(CONFIG_PXA2XX) += pxa2xx_dma.o
-common-obj-$(CONFIG_RASPI) += bcm2835_dma.o
diff --git a/hw/dma/meson.build b/hw/dma/meson.build
new file mode 100644
index 0000000000..ff5bb3748f
--- /dev/null
+++ b/hw/dma/meson.build
@@ -0,0 +1,15 @@
+softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_dma.c'))
+softmmu_ss.add(when: 'CONFIG_RC4030', if_true: files('rc4030.c'))
+softmmu_ss.add(when: 'CONFIG_PL080', if_true: files('pl080.c'))
+softmmu_ss.add(when: 'CONFIG_PL330', if_true: files('pl330.c'))
+softmmu_ss.add(when: 'CONFIG_I82374', if_true: files('i82374.c'))
+softmmu_ss.add(when: 'CONFIG_I8257', if_true: files('i8257.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('xilinx_axidma.c'))
+softmmu_ss.add(when: 'CONFIG_ZYNQ_DEVCFG', if_true: files('xlnx-zynq-devcfg.c'))
+softmmu_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_dma.c'))
+softmmu_ss.add(when: 'CONFIG_STP2000', if_true: files('sparc32_dma.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx_dpdma.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zdma.c'))
+softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dma.c', 'soc_dma.c'))
+softmmu_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_dma.c'))
+softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_dma.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 52577c3205..96da0bba7e 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('dma')
 subdir('gpio')
 subdir('hyperv')
 subdir('i2c')
-- 
2.26.2



