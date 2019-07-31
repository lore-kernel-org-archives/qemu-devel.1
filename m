Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F32C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4AF62067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZjRzASgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AF62067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsva0-0001dI-1o
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN9-0005Ul-1U
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN7-0003nx-Ly
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:54 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvN7-0003lz-Ei
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:53 -0400
Received: by mail-pg1-x544.google.com with SMTP id o13so32626621pgp.12
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JBDZxP60+vIjwwzQbC3L2o1kpMj6601b/tqCyxFOHVI=;
 b=ZjRzASgXz9DHZDSakRRsbVZIa9HlbQkZ8AqjWSJkkeFevKt5uLRm331a/WkVz39op/
 CB6q2klZZaPbEc2XLGOxHnS/mh+mc5M2xOn3bcBXCXFLTcpG9+SEtLd+8N2MCeaGpuzq
 LXRpTEUhfVQ2tvE0uyUgrNugAwMgokamsNJEhQgCDKlqxbZKt1vZSG0qKYZbnFV2Eh2E
 cnRAi7Lp5ikJf2zs9BMsU5Bztq+dFR2DX2iI4YTZaVnU7RpBidquoeviL2v5//k9ng0V
 NsbU9V+eI2e5HbF5pNX1eJ6hS2eDTOFdiHyiW+VIBuo3wg/8bIL31q2nCObFvyKt+TQF
 nmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JBDZxP60+vIjwwzQbC3L2o1kpMj6601b/tqCyxFOHVI=;
 b=rhBM1111VHGdGJLTQKULvNtRIEvQVRIOq6jNEKX52MWrCftihuvI1iU0PP7HwNYTmK
 7bYv7GowbV9Ph6lzVOHNsQXe08WnvRDC1bjYqPAtmYk0hz++aXpEG4uhlr23FNjiC/PD
 W3gnYw2HjzNjmRIaybdy6UFo1Y0RxtVSnmzJOn2Q2qxwTYMHK1YAOM2pmQ00SN1sQQuv
 g/bguF7LnNiXCv7/1p/3nfXAyW9VGFsR/wdPNl2YSR5lGZ3KICn8y/1ii6oi/O4gadmN
 PNa4rLGbRKG31F9pTP41yLRJhqctMSZdsRQLme0JI+QqT+xh2nFwwjcV8eAuXdTTaP4b
 UsYA==
X-Gm-Message-State: APjAAAUigCqWtkG86t457Wma3Dks/S/9z/WmhGWMML+4lFg2QedBEh/H
 pqBFpLnvM7s79tVUc/0eONFij5LO6Eg=
X-Google-Smtp-Source: APXvYqzoTV2iYyHbnFTznIJE1DRJopw832qhH+KMSW0UM1VaT8p8NpINLgsIQ64bhh0jkTh0rzld5A==
X-Received: by 2002:a63:7a06:: with SMTP id v6mr116890815pgc.115.1564605531837; 
 Wed, 31 Jul 2019 13:38:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:38:11 -0700
Message-Id: <20190731203813.30765-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v2 30/32] target/arm: Enable ARMv8.1-VHE in
 -cpu max
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1901997a06..b1bb394c6d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -337,6 +337,7 @@ static void aarch64_max_initfn(Object *obj)
         t = cpu->isar.id_aa64mmfr1;
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
+        t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
         cpu->isar.id_aa64mmfr1 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
-- 
2.17.1


