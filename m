Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93CAC35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3423208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsS9t5eS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3423208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58bQ-0006sD-Rf
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j58Jm-00032H-BM
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j58Jj-0007Ra-6d
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j58Jj-0007Og-2Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582291560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=knm7izTn3QMDeqGkdlsTr7WEWsDthOUVCNGPYSj8q90=;
 b=NsS9t5eStfytKrs/RU3KxSl9FKLEAtVvNpG4QHATDbDQ3EVM/wO2wqKPApyta+4oeO06Or
 nFfbOFlzyWMu4etxSfxu+7yskexLYrPqD3yP0r3c5hyRzuzDKdbXvIy1bfS7HF7AT6xjs0
 vJWU476KRhLXNS+dcz+m/M5KuO8yXNs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-YqpKcDUDPIW-g4P1ZVooCQ-1; Fri, 21 Feb 2020 08:25:56 -0500
X-MC-Unique: YqpKcDUDPIW-g4P1ZVooCQ-1
Received: by mail-wm1-f70.google.com with SMTP id p26so607904wmg.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i4tc3X06KlldR4fgJ2DnHVlEIqgio/XYk4CRiPLhiQE=;
 b=gR5CdJGedQ4sPtC6OWhRBNDYAoL/qMtNUtjZzmzDJsshX258PoINMqg1axsSB9RpY7
 QHBuJVGTizkmLEAWY41NwVdeZ3UlI777JmoVqBcn2Z5K+KbkO3BWSh4gHq2f263fNMzr
 gwHLvTfxK+Se9lUakLtfB1MLSoHPhuI4pBW9QF1udbAa5kw3fb/t2J3ui48jt/xj05q7
 2Gjy7FD8XNBqGu0fePwY3m5fntrpOBa8LUTv3blOLxGXhmNeZnYR8J1DOYUEg+95eec0
 rvUkCJPNwjAdBkHhbMF68gDYa7O8T28pXWl/eCWvJPS7tCjBoZuxcY+Vr30RzmtuK6Qa
 d1Hg==
X-Gm-Message-State: APjAAAWSwUeVnR0t91x5EYqkPp2q45fCO7NLKm1/j8b520PM4j84Y6es
 pMSa+rmFN2EBzYbE9A9zmYY6RMJLLJerq0T5QIsX8qho+d8DZjtaT8gQfjN+RgnmQfkyW84DX+v
 heg3jIS0Vsj+ygV8=
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr47793227wrv.316.1582291555172; 
 Fri, 21 Feb 2020 05:25:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBkWPDof7tB9gbioJ+go7V27Hj14HlPsHFiHSeDJLh2zDSwQS68e2jbTp1o8eVzNT4n3wk7w==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr47793197wrv.316.1582291554961; 
 Fri, 21 Feb 2020 05:25:54 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t13sm3947679wrw.19.2020.02.21.05.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:25:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/scsi/esp: Let ESPDMAMemoryReadWriteFunc take void
 pointer and size_t
Date: Fri, 21 Feb 2020 14:25:49 +0100
Message-Id: <20200221132550.22156-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221132550.22156-1-philmd@redhat.com>
References: <20200221132550.22156-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ESPDMAMemoryReadWriteFunc handlers end calling
dma_memory_read/write, which both take void pointers (since
introduced in commit d86a77f8). The ESPDMAMemoryReadWriteFunc
handlers can take a void pointer too.

All calls to these handlers in hw/scsi/esp.c use an unsigned
length. Use size_t type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/scsi/esp.h | 2 +-
 hw/dma/sparc32_dma.c  | 4 ++--
 hw/scsi/esp-pci.c     | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 6ba47dac41..fff0ebc4d4 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -6,7 +6,7 @@
=20
 /* esp.c */
 #define ESP_MAX_DEVS 7
-typedef void (*ESPDMAMemoryReadWriteFunc)(void *opaque, uint8_t *buf, int =
len);
+typedef void (*ESPDMAMemoryReadWriteFunc)(void *opaque, void *buf, size_t =
len);
=20
 #define ESP_REGS 16
 #define TI_BUFSZ 16
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index c9e313938c..fbe58b8fea 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -142,7 +142,7 @@ static void dma_set_irq(void *opaque, int irq, int leve=
l)
     }
 }
=20
-static void espdma_memory_read(void *opaque, uint8_t *buf, int len)
+static void espdma_memory_read(void *opaque, void *buf, size_t len)
 {
     DMADeviceState *s =3D opaque;
     IOMMUState *is =3D (IOMMUState *)s->iommu;
@@ -152,7 +152,7 @@ static void espdma_memory_read(void *opaque, uint8_t *b=
uf, int len)
     s->dmaregs[1] +=3D len;
 }
=20
-static void espdma_memory_write(void *opaque, uint8_t *buf, int len)
+static void espdma_memory_write(void *opaque, void *buf, size_t len)
 {
     DMADeviceState *s =3D opaque;
     IOMMUState *is =3D (IOMMUState *)s->iommu;
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index d5a1f9e017..8f11c4a2d2 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -242,7 +242,7 @@ static uint64_t esp_pci_io_read(void *opaque, hwaddr ad=
dr,
     return ret;
 }
=20
-static void esp_pci_dma_memory_rw(PCIESPState *pci, uint8_t *buf, int len,
+static void esp_pci_dma_memory_rw(PCIESPState *pci, void *buf, size_t len,
                                   DMADirection dir)
 {
     dma_addr_t addr;
@@ -278,13 +278,13 @@ static void esp_pci_dma_memory_rw(PCIESPState *pci, u=
int8_t *buf, int len,
     }
 }
=20
-static void esp_pci_dma_memory_read(void *opaque, uint8_t *buf, int len)
+static void esp_pci_dma_memory_read(void *opaque, void *buf, size_t len)
 {
     PCIESPState *pci =3D opaque;
     esp_pci_dma_memory_rw(pci, buf, len, DMA_DIRECTION_TO_DEVICE);
 }
=20
-static void esp_pci_dma_memory_write(void *opaque, uint8_t *buf, int len)
+static void esp_pci_dma_memory_write(void *opaque, void *buf, size_t len)
 {
     PCIESPState *pci =3D opaque;
     esp_pci_dma_memory_rw(pci, buf, len, DMA_DIRECTION_FROM_DEVICE);
--=20
2.21.1


