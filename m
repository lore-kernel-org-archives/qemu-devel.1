Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF4C55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B76D223BF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eABs6x0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B76D223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIB1-00044n-1z
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1D-0003MS-J2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:54822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1C-0006Cq-5P
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id c77so2989239wmd.4
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NoDwWHinBIKIuPIX7ZFYNJrNUHL9vQFLXTimhcq4kjQ=;
 b=eABs6x0ckYBmbr2/3W50NFaxR//eZ8uRR1aTJoOcp4sbfqePoMQVs5vxzTxpKjAA+A
 4ZpYwm0o9ggJLVZAOmYjIlGYc0c8Z8cKl3FyuV4PE6XgvVbsYZlZ8UgUJtOdGpiso2TS
 62VxDPlgduVHVEPO7g8N1GDGcuVzWah+4xOfwVNXuUhHMLehfk5tTOnBvGjfSshnGDBi
 pTq16nUI8YU5DoZRTNRa6JoxxkFndcyWTzoz8GJ6Bqp7NudLKqb62TO/sACbC7ZjYDUr
 WbnOc/9/gjzuYXPhmWbEAluCLUmWceLY2R+i+xBaVfkm8JKfit4tnaEu8TLn1jyw0tz5
 pidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NoDwWHinBIKIuPIX7ZFYNJrNUHL9vQFLXTimhcq4kjQ=;
 b=Rj7qtqicP19+zdoMfbWqjxZ1ASIIVZaO1kfJzDVT9RqOecLBPegXaVxnXUXtIbh4ht
 eA2D5dKGwx3i96LzK0gYYq2CF7ZTFOwAiA43yHVrKgHN0PZuM7TtDIbXkA6+RTjK5f48
 6Fc581uTyIMBOWp9FVSDz12kYqTLlyzHhXPg34o9qlbJEfCLqL9Ll9/KdHDTwbR7SdwJ
 G4aFuW+/xk+F6kwJDUYX9poEhKd6v7WUMT49RoW641jCtEHLjhjg4EfARrEEPo7zYmoH
 gKhTc+Vy1+UOa85Pqw/aRst1/Df3vWta1FMSm9ar/jUolbxlIuxVZSlyJtGZ1z1Q2yNe
 RSzw==
X-Gm-Message-State: AOAM530iRxI2deCdO8Fm1wBGK8QYZGgaLPDKljV+DiT7vKPAcGIHc6LL
 mqJJSuG0kYXRfrIX1Z/Ne/YhH/64QXQ=
X-Google-Smtp-Source: ABdhPJwLQIJqc+ZE4gBsTy/pCChmQBUWALD1zNHXGavM6wG4C/6wgeCukFTprryZmUyK1sRUsxCKyQ==
X-Received: by 2002:a1c:2803:: with SMTP id o3mr4162007wmo.97.1603301720651;
 Wed, 21 Oct 2020 10:35:20 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id b7sm5101971wrp.16.2020.10.21.10.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:35:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/13] hw/sd/sdhci: Let sdhci_update_irq() return if IRQ was
 delivered
Date: Wed, 21 Oct 2020 19:34:43 +0200
Message-Id: <20201021173450.2616910-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200903172806.489710-4-f4bug@amsat.org>
---
 hw/sd/sdhci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 4db77decf87..b93ecefd20c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -218,9 +218,14 @@ static uint8_t sdhci_slotint(SDHCIState *s)
          ((s->norintsts & SDHC_NIS_REMOVE) && (s->wakcon & SDHC_WKUP_ON_RMV));
 }
 
-static inline void sdhci_update_irq(SDHCIState *s)
+/* Return true if IRQ was pending and delivered */
+static bool sdhci_update_irq(SDHCIState *s)
 {
-    qemu_set_irq(s->irq, sdhci_slotint(s));
+    bool pending = sdhci_slotint(s);
+
+    qemu_set_irq(s->irq, pending);
+
+    return pending;
 }
 
 static void sdhci_raise_insertion_irq(void *opaque)
-- 
2.26.2


