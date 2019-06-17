Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B44C31E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58383208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ai/YtYns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58383208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctLZ-0006GL-IM
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46656)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiJ-0003YN-IK
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiH-00084O-TR
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:33228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiH-00083e-K0
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id h19so118092wme.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DirqTV/zCPX2KcEnjTOe/sMakcabEsqAkkHQvfbYZ04=;
 b=Ai/YtYnsHVQtY/wpR51uTKfFLM7ybf/YPj3D7LXStVlzxUOGCcoCaVJ2Q3bq2ecAbX
 /rn0Z0AogCO606htw3UR6WA9v6AN2fAKhkee0Ng5CLEhm3z6/D2NmUfMG6gOMkFg+K0U
 5e54JL9y6Qtpcu51Q6hJ3cYxromdmd3B6XKvssxxGkf8lMvFhJuUvIv8yjYTVgfW24ss
 sAGp4nsAwjPg8g4kvMvennnygwwg/t4hwhXnKU8+FCBlQaQT7Zc07yzDI+DPgSqy5iaL
 cX2LUPnJODgD2gIHl5bULEdNADHRHu9TKUIf3GyWXwXex1YXU48NfROgLoThslH3eVXb
 ndyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DirqTV/zCPX2KcEnjTOe/sMakcabEsqAkkHQvfbYZ04=;
 b=RaRNi7SopJX6JU6TGBiBUgcQIvcbJ6ZFo7DeZDAlg3KL7QCSHe62PDeNgdxGMLA+sS
 MnHXB6dmiSIrfIgHbTFPDXyNAVzgYwOgqAS1ovv3Dtg5QikX9cjQV3O5RPqZFdVPylsI
 b8VWBTuNi3pDo53t5GOzvs3BW6DMsKQ8GJ24DgW3sletGuvwuSx4c2TbAK/+V+fude4i
 iddk9odQx0od/zxGptWvs301qmp0PXNM0WuFZg/vFE4HApbmfDjzucfdiRKHFDbexoFB
 8TGnAHUA5UKKhyrwOfsez9LGft/mS+sYL5A5RsAzS3UU7xuMUxXwJXyKxmh10vVDCa7E
 4qFA==
X-Gm-Message-State: APjAAAUW9xwflIa/qlLt0+I9b2pwMo749QHX8eJrXsN2HWDHzTtmC7At
 C8l14wt4HL9ze1o4S76MKqoSdYEwbY2Efw==
X-Google-Smtp-Source: APXvYqwFsXchUc8xv1WSZUYjwXatyp9q/DuucrIAcLMfysUf/i8HvgeYwYNAoIYI2iwsPfLbq5HMWA==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr19679453wmb.19.1560782064289; 
 Mon, 17 Jun 2019 07:34:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:33:57 +0100
Message-Id: <20190617143412.5734-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 09/24] hw/intc/arm_gicv3: Fix decoding of ID
 register range
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

The GIC ID registers cover an area 0x30 bytes in size
(12 registers, 4 bytes each). We were incorrectly decoding
only the first 0x20 bytes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190524124248.28394-2-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_dist.c   | 4 ++--
 hw/intc/arm_gicv3_redist.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 53c55c57291..e6fe4905fd3 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -533,7 +533,7 @@ static MemTxResult gicd_readl(GICv3State *s, hwaddr offset,
         }
         return MEMTX_OK;
     }
-    case GICD_IDREGS ... GICD_IDREGS + 0x1f:
+    case GICD_IDREGS ... GICD_IDREGS + 0x2f:
         /* ID registers */
         *data = gicv3_idreg(offset - GICD_IDREGS);
         return MEMTX_OK;
@@ -744,7 +744,7 @@ static MemTxResult gicd_writel(GICv3State *s, hwaddr offset,
         gicd_write_irouter(s, attrs, irq, r);
         return MEMTX_OK;
     }
-    case GICD_IDREGS ... GICD_IDREGS + 0x1f:
+    case GICD_IDREGS ... GICD_IDREGS + 0x2f:
     case GICD_TYPER:
     case GICD_IIDR:
         /* RO registers, ignore the write */
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 3b0ba6de1ab..8645220d618 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -233,7 +233,7 @@ static MemTxResult gicr_readl(GICv3CPUState *cs, hwaddr offset,
         }
         *data = cs->gicr_nsacr;
         return MEMTX_OK;
-    case GICR_IDREGS ... GICR_IDREGS + 0x1f:
+    case GICR_IDREGS ... GICR_IDREGS + 0x2f:
         *data = gicv3_idreg(offset - GICR_IDREGS);
         return MEMTX_OK;
     default:
@@ -363,7 +363,7 @@ static MemTxResult gicr_writel(GICv3CPUState *cs, hwaddr offset,
         return MEMTX_OK;
     case GICR_IIDR:
     case GICR_TYPER:
-    case GICR_IDREGS ... GICR_IDREGS + 0x1f:
+    case GICR_IDREGS ... GICR_IDREGS + 0x2f:
         /* RO registers, ignore the write */
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: invalid guest write to RO register at offset "
-- 
2.20.1


