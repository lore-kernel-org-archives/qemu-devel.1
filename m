Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13240C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEFE2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9/nCkaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEFE2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGOqI-00010U-JO
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGOpM-0000Pb-Ht
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGOpL-0006Ut-9Y
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:17:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGOpL-0006UV-16
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:17:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id 6so15066918wmi.5
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/HG/3zX/z7cZw8pN0b5jI6X9Kh6mm9bAalCe+PTT2Bg=;
 b=i9/nCkaCzjB7rmgVLWZ7DYA1ZWP3AE/gEzh4DpgZoMdzOyiG9T/uUA/37/8lQf5xYZ
 qe+pMUwawy3VS8ABXb8CSgVjpOC3Nx3OMoXhTeTCEuVTvsMKlELUQLLtFo+hhiMT/s5j
 eMbY0EyypzeQF6zf0Fu4f9x9fIrJGiF7rwqOZq6/SaynYoR1JvsxutM2/whQQ3qOW6/b
 MmFCTEqxZuzhVv2eAUvtt+1R6jn2T/VatAGyBs76aOkegBjtQ+T2nQMVvFFlPXsbpBMR
 FivsMuEh1XvR3ZKWIP1XSI/+JbYU1w2+2Y6I2hRv0KlOpnKPCi2CXDiDmInMy4auJiLh
 xAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/HG/3zX/z7cZw8pN0b5jI6X9Kh6mm9bAalCe+PTT2Bg=;
 b=XS6s2PaYr5L24CHrfYElMudFZAcVBIwBw0AfzFW0AXTq2DGhAbc+Ka40Qtg2RoUpj3
 sy5z7UYeAh+WbkbKxezB/0JoRjjQYg5vkoxVUCZLuByaYwYdBco2tOFFJTcZ1CIcCX/M
 MfsRKcRjCLLfJYiB2IATtfF162gAo7f2V2xQRfpIklapWi031tpxUEf6lhqmM85MglyG
 r2WZT3RyrO0lD/ZeOIjw8Y1L5q0MhEYFHWOLylwcx3db4Y/Di6kQSzYqNzr6yrT//4mH
 K+dSm782fyxUIvTzrGmCjIe5Gvr5nBlkrddJuGeimOGpr3JuCDGWWlZQl2EvsBSBnSbz
 l+4g==
X-Gm-Message-State: ANhLgQ1O2tmxK4hM1ZmijtjYt4MC/UFSGsv7OneqSa/EQCn1lHU7v0x0
 9iN700QeoVoPJNHjeCKD0WkCru2HB4n+kw==
X-Google-Smtp-Source: ADFU+vt3+WKpbMfvIG5k9EaN84Df3FdcIK90cvXDPjREPwV5FgDBN3aekZo8nxnfdOSSrZDzm6C7Jg==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr23159837wmz.21.1584976637394;
 Mon, 23 Mar 2020 08:17:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q8sm15710234wmj.22.2020.03.23.08.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 08:17:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/ide/sii3112: Use qdev gpio rather than qemu_allocate_irqs()
Date: Mon, 23 Mar 2020 15:17:15 +0000
Message-Id: <20200323151715.29454-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity points out (CID 1421984) that we are leaking the
memory returned by qemu_allocate_irqs(). We can avoid this
leak by switching to using qdev_init_gpio_in(); the base
class finalize will free the irqs that this allocates under
the hood.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is how the 'use qdev gpio' approach to fixing the leak looks.
Disclaimer: I have only tested this with "make check", nothing more.

 hw/ide/sii3112.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 06605d7af2b..2ae6f5d9df6 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -251,8 +251,8 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
 {
     SiI3112PCIState *d = SII3112_PCI(dev);
     PCIIDEState *s = PCI_IDE(dev);
+    DeviceState *ds = DEVICE(dev);
     MemoryRegion *mr;
-    qemu_irq *irq;
     int i;
 
     pci_config_set_interrupt_pin(dev->config, 1);
@@ -280,10 +280,10 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
     memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d->mmio, 0, 16);
     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);
 
-    irq = qemu_allocate_irqs(sii3112_set_irq, d, 2);
+    qdev_init_gpio_in(ds, sii3112_set_irq, 2);
     for (i = 0; i < 2; i++) {
         ide_bus_new(&s->bus[i], sizeof(s->bus[i]), DEVICE(dev), i, 1);
-        ide_init2(&s->bus[i], irq[i]);
+        ide_init2(&s->bus[i], qdev_get_gpio_in(ds, i));
 
         bmdma_init(&s->bus[i], &s->bmdma[i], s);
         s->bmdma[i].bus = &s->bus[i];
-- 
2.20.1


