Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEDCC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCA520757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4eFKGwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCA520757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7rK-0002uc-RJ
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jf-0003AA-1a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jb-0000PQ-1I
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7ja-0000Oi-HO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id f13so6474361wrm.13
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uf9EjZlK3PWSZbbcBZG8iV17wJ+d4IMJ5+LdrfTNYaM=;
 b=g4eFKGwKXdg6+ROOZwqokisERdUzIHLGcXlN+jRPv3Iy0hlBGih4whSamA3bAexaH2
 7rc3OU3cIfURER3RDB29k3HTf5pRF2tywlcCoW6oq2EeNDdIORjFMmN2UMv0Bg8ogdJC
 wv5aRuEh1hIt6bM+cdGQ3YYqT3YWpRgD8I/KDEzgvxLwsW96Dfvd4fSBNWQ/9u59gPLB
 x4rrJh1NQxri9koZgWzaMOksUAflc8SyWcnYOuDxlhOvB2U1c+TWW+5R1H6eFmT8GC/4
 cP6a4/8eko6EJ9wzIBoAZ/fJZfcMckk492uf6VEa5PLNpBAVxg9RU3ETKHOodekFXS9u
 msdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uf9EjZlK3PWSZbbcBZG8iV17wJ+d4IMJ5+LdrfTNYaM=;
 b=OK2jU0I25e69vvf01asuFAR5bVqW9eblM/hG3B09QsKAV+wxTW01nT1Eji9rIM7RAb
 +iX6xavdz6xZPMsaz0Gq7nQ2OX0XCuVPUTsPwxE5J1Q3HEjJnQkraJgPMbTIcwqa/fen
 acTAaHQI+1pewaLDOzMGlrbOtyIo3wVmg6E+8vBoKTmPH4ULMG/xiTmsLjDbUdqCQDnN
 ib/hGsUTaVMl7oQpAujE6JjaeThRJFYkeg7JXy9yCffmJx3vA87H7ycXw7nxQk+Abt3N
 hsTbussdoLXNNJDoj5eZi2RGvri8mIwZ9Pu2jZd0j+4Ik0V3ir+i34gDfG4/s34YyUR1
 an1A==
X-Gm-Message-State: AGi0PuZNWTrHNftUy4e+GZENGj/xr1hmPCKlbeJdeHbx8mn99mMmrzQ1
 Rlk/e9XmtHNPa8CY9JjwLT5xdRqQWZqngw==
X-Google-Smtp-Source: APiQypIP7DpDpu9KoX6vbk1eIvexpZCWundeZn90FMynVKI+cWM9YYvhi0TO0zVYofjKfDjlkmX0xw==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr3648312wrc.20.1588247524653; 
 Thu, 30 Apr 2020 04:52:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/31] hw/arm: versal: Setup the ADMA with 128bit bus-width
Date: Thu, 30 Apr 2020 12:51:29 +0100
Message-Id: <20200430115142.13430-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Setup the ADMA with 128bit bus-width. This matters when
FIXED BURST mode is used.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20200417153800.27399-2-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index cb0122a3a68..94460f2343b 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -205,6 +205,8 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
 
         dev = qdev_create(NULL, "xlnx.zdma");
         s->lpd.iou.adma[i] = SYS_BUS_DEVICE(dev);
+        object_property_set_int(OBJECT(s->lpd.iou.adma[i]), 128, "bus-width",
+                                &error_abort);
         object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
         qdev_init_nofail(dev);
 
-- 
2.20.1


