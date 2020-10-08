Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 23:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDB320708
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 23:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NbQRUtqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDB320708
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQfIw-0007yN-1H
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 19:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JZ9_XwsKCmQJUMKPPGOQGPIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--hskinnemoen.bounces.google.com>)
 id 1kQfF1-0003w4-GR
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 19:22:33 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649]:43753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JZ9_XwsKCmQJUMKPPGOQGPIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--hskinnemoen.bounces.google.com>)
 id 1kQfEn-0002sT-8t
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 19:22:30 -0400
Received: by mail-pl1-x649.google.com with SMTP id bd7so4707819plb.10
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 16:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=GvbNwDqppFPWenoks7xb2ZqH9HIInY1obMx9e9WOMDE=;
 b=NbQRUtqDp+8k34zRK3I5QfjS+kFEmS0Sd9rYUV51WR9ue/iFGgKzci/y/6QWwUlPew
 lULJTX3YzWgiuL1CmntJmBnKY97iTqK7s1GJmRpEMWVKrlpHzpFifmTB7kgPE+aQIINi
 irH0lNQO5jIsEkiqzyVdqsgcjV5vkzX9ra86SYspjCvkPBdfPqrDmrvMRGNHq78GsdDU
 6q6Vl1Vqe1zboDW7x46mtCISlAe8Nr4PdIMH/35mgw4t0rwPhcc0U6lr1VSNKV6QuvVP
 3y6nUMuZBaN2BO2sZzXFQuE/yKSmqkMlIa7XgQ+vP1LyIWvpeIwDJ6XD4wzwwknWscBj
 bHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=GvbNwDqppFPWenoks7xb2ZqH9HIInY1obMx9e9WOMDE=;
 b=FeJgDk+okBi/iQ+E0+EdO2CNmxl2rCUZEfgPmr3jP0NxH4QSLP6VGq3I3Q5s5Q8s4a
 rMAfv+2mkbwf6IlJMkQTD+gclPY0c6JuXkQQWR5L0MjOYOU+S3WaExWTgLHoTSKHhUIt
 ak7CdcMcdG8t4IVGTXsJ30wWLqggFnEqNqUYIe+yvgnHrGYx70wsEvAolQhxC18IT3Nh
 gCWuFKoqd0qjZxCOpVZ2gdkEhtvZJyQdbDog0jetxFy5zNPtEcJos1cvz/Yj25mLHkj1
 Dw8GNKB2QESRlFpTl3T5wSnehjChb9VFic5VEkf+Zh4ehntMqycqjGEXqRtJk43htDyY
 YuyQ==
X-Gm-Message-State: AOAM532P5BW6FMciLoddWSSVNmdeVF940Dl6rz7RJaHfAnJ6oahVA1VE
 qN35SdpT57O9Gy6OvpDZJW3wF6lZkXprIblj1E0nL3M8CNc+1J0yCcAiD+1QPee15vegTaWHyjs
 8u67Xdhe2juLCn4o+KPZzFOJFmMKFFzCX9mQo01eCJpnhCZfmXlsXlZ+hu3mgk73T6/1Xm2iORA
 ==
X-Google-Smtp-Source: ABdhPJyF0Tqgmz1TW6AanqSZFIqFH+ZIZlNfprVEALZsESKx5g2402STf45Arzr2PgN4OJ3Ky/x12bZ+hkr6yjFaIw==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by
 2002:a05:6a00:888:b029:13f:f7eb:578c with
 SMTP id q8-20020a056a000888b029013ff7eb578cmr9954809pfj.10.1602199333465;
 Thu, 08 Oct 2020 16:22:13 -0700 (PDT)
Date: Thu,  8 Oct 2020 16:21:50 -0700
In-Reply-To: <20201008232154.94221-1-hskinnemoen@google.com>
Message-Id: <20201008232154.94221-3-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20201008232154.94221-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH 2/6] Move npcm7xx_timer_reached_zero call out of
 npcm7xx_timer_pause
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, f4bug@amsat.org, clg@kaod.org, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3JZ9_XwsKCmQJUMKPPGOQGPIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--hskinnemoen.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

This allows us to reuse npcm7xx_timer_pause for the watchdog timer.

Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/timer/npcm7xx_timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index 5703e43d40..2df9e3e496 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -157,9 +157,6 @@ static void npcm7xx_timer_pause(NPCM7xxTimer *t)
     timer_del(&t->qtimer);
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     t->remaining_ns = t->expires_ns - now;
-    if (t->remaining_ns <= 0) {
-        npcm7xx_timer_reached_zero(t);
-    }
 }
 
 /*
@@ -239,6 +236,9 @@ static void npcm7xx_timer_write_tcsr(NPCM7xxTimer *t, uint32_t new_tcsr)
         } else {
             t->tcsr &= ~NPCM7XX_TCSR_CACT;
             npcm7xx_timer_pause(t);
+            if (t->remaining_ns <= 0) {
+                npcm7xx_timer_reached_zero(t);
+            }
         }
     }
 }
-- 
2.28.0.1011.ga647a8990f-goog


