Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042DCC4727E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7092100A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="h9aGC3kA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7092100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPX74-0007x6-IF
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWaK-00054p-Li; Mon, 05 Oct 2020 15:55:48 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:35988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kPWaI-0007ac-7t; Mon, 05 Oct 2020 15:55:48 -0400
Received: from sekoia-pc.home.lmichel.fr (sekoia-pc.home.lmichel.fr
 [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 7ECA6C61424;
 Mon,  5 Oct 2020 19:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601927720;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJCQg7TqYgZEgOW9ZJzmTeBBjLyp1G/Jv/jrDNA36Uc=;
 b=h9aGC3kANfW2g4162mufle2EBPG5P42z8RwRT6eC5t8HWwN7qC5V0jvbfA//71Coy7lb/1
 cg+WepCi5zL+1hocdMqL9VwpgW/bSpoXOEy1RV0PQhUsJSfSia4S7RFF6VcvXPDaK4Ba4x
 Gpk2Y3yaO2jAefQJMjMpW6BXHjQfchWK8t1OuUCIkviUJZRThUFbnfHGLQHrRDZ+kYexgl
 fUvbtlq/mgcn0V/zcoeOuNDY5aQ/SNNLvwpg9FImyX4GrNj66BHNm4JG0EnZ7yJQThavf2
 vnvAxYrCcd/IX6gFTELkacaZTN90R340nVOnWGnHlq/jN3Ka/eaqJqRo8TdidQ==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/15] hw/arm/bcm2835_peripherals: connect the UART clock
Date: Mon,  5 Oct 2020 21:56:12 +0200
Message-Id: <20201005195612.1999165-16-luc@lmichel.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005195612.1999165-1-luc@lmichel.fr>
References: <20201005195612.1999165-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601927720;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJCQg7TqYgZEgOW9ZJzmTeBBjLyp1G/Jv/jrDNA36Uc=;
 b=Zi1OX6Kfs5k5684WparQTUFo1t7/kDhjGLeWyBwrS20ROznQhFMGB4akFru1MJRmB/DLxL
 tI5zgKIkKGPa/PND+YYkBeoCBshIPF8nAz3TfYEsQ5vMq+8++jdhimKmlvbGlc2dKQ3eO2
 3ZECTUcquuRkhrtsAchHAvGVGMVsbd0NxTA5XF99BCUXL5ObV4aODHPVYnwKAL4MORI7bg
 a6NIoyv7XUD/jfKAlMOF1l+8xfuar5+SlRxr+bBRfEhUCl+5q2Ro0JciDV2XYooGWGhslj
 GhSkCigeSHpSeOHjWlhBlZN1Yx+iY0gLByImSKUglXn5pV7VJO+iYNTGzVUT2w==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601927720; a=rsa-sha256; cv=none;
 b=VO/LzXlcnkhx9x4lxgp2viKcrswcP1P4tNEDU+heNNpi+KowSnruNeftJ3b9xEDHvEmiepqO4QQ19Kl5o36aOYV5WlZfiZKvSEkLeOJtwsU/jDuQ3/j+ESAP5SRhbu5ftvTkyxNWRqlOss9+CtkP/N/ykQZKHHMubQAsLRDMZotff8YkRR7jm+EVeKzvQKyJoNHGzYEEBjX0Xw50TTLP4g/GzywO+LLNSxiOOzV0m0O54IGiuuDiQP0QUDii6AQgXa/GjcVIis8Ca6zyOKBFLtUONBb0YQZV7/T0a7YiQcm3pclYDyYu+K5xscX+yib+drTh+PCSWpyHGCPX73Oovg==
ARC-Authentication-Results: i=1;
	pharaoh.lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 15:49:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Connect the 'uart-out' clock from the CPRMAN to the PL011 instance.

Signed-off-by: Luc Michel <luc@lmichel.fr>
---
 hw/arm/bcm2835_peripherals.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 9d6190042d..d8f28b1ae2 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -167,10 +167,12 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->cprman), errp)) {
         return;
     }
     memory_region_add_subregion(&s->peri_mr, CPRMAN_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cprman), 0));
+    qdev_connect_clock_in(DEVICE(&s->uart0), "clk",
+                          qdev_get_clock_out(DEVICE(&s->cprman), "uart-out"));
 
     memory_region_add_subregion(&s->peri_mr, ARMCTRL_IC_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ic), 0));
     sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
 
-- 
2.28.0


