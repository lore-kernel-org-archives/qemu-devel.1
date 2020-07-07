Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB08C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3954920738
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fc4yKq5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3954920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssgG-0005lx-Eg
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3S8MEXwsKCuILWOMRRIQSIRKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--hskinnemoen.bounces.google.com>)
 id 1jssd5-0008Qe-HP
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:47:43 -0400
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849]:38340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3S8MEXwsKCuILWOMRRIQSIRKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--hskinnemoen.bounces.google.com>)
 id 1jssd3-0007Xi-Rj
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:47:43 -0400
Received: by mail-qt1-x849.google.com with SMTP id 71so23357268qte.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=x4zl2op1cKzABpWzOJ32Kyt+vBmeWcDSoujgoCFMWWI=;
 b=Fc4yKq5s3Ui3JTvioSaq1D9ezmZeTbO+onO8ukc1LzT6CYfY3bezw1nK6ThlSx99kD
 DcJJ9ALmT0yZaEoc/ebYuHBooaBkk3d9c1CkSWOD6pkba1rnqR3E2msTmEW0CH7oi1DI
 jaBqmkNuRd9RAHYZSy4fgV9+5WFrsibBKkic+y3TmH2QYbMQzxo4vG3JV/7fey5joWOg
 kb4X877wO9vbgI7Z3JvifQcbCEqwrLol/UIu6zi/2g8xbseaPIMQt5FNykh10kF9Bvk7
 SAOXluitt8NlE/9NSbIWhts5FG+63GWwaiGn2kORxd6WyBpGvn3rWO9RnjoWc89HXs1f
 BqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=x4zl2op1cKzABpWzOJ32Kyt+vBmeWcDSoujgoCFMWWI=;
 b=sAmqErHhJ1DIFjiwt4G/Sj4DFJEe4DQk+tWLPslkm/tWtgwMRc1hjCHnrOMPDXNjvz
 SoWpRfCf5YLiZDP8hmQdKklwABgM1AJWVlU1zh7Fuuus63NUXkNXg2Vwq4A5r1w2OrP/
 quLLNlh0qyLJ/FGGKShrP3sGnDOj8cLIpkoTz0QrhZlvcyDRyDgUOBC8mtQDNuUvKBqV
 X+asLjDz2M+a7K0XoRwZELdQjXP2y7OqwWxXmBszw5MtL5jNzuDQ0hMuvGZR9kgaNxe7
 assP5ML8r4escFN9MmX5XiiAwnvTjC0I6j1fhJWdIzvwvKFYMk27YTpQIVpDvt0Ishwj
 ZDUg==
X-Gm-Message-State: AOAM530+k+2zsytksCzWpLXeqnKLE5+EkZ61x3xFUti/P6IrP5MYvbTW
 6vo+uaQe7xM5aI6O1fROIcGkdVOU0WzXzBTgxA==
X-Google-Smtp-Source: ABdhPJx913787MUpkXR+V6fHT/QFz1o2LIIitBWRILmqxq2MlY1FlXELdKXBc1pbZ/IrYQL407vNTOPW66fYI0UjPA==
X-Received: by 2002:a0c:b2d1:: with SMTP id d17mr43471302qvf.100.1594147659912; 
 Tue, 07 Jul 2020 11:47:39 -0700 (PDT)
Date: Tue,  7 Jul 2020 11:47:19 -0700
In-Reply-To: <20200707184730.3047754-1-hskinnemoen@google.com>
Message-Id: <20200707184730.3047754-2-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200707184730.3047754-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 01/12] npcm7xx: Add config symbol
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, philmd@redhat.com, 
 Havard Skinnemoen <hskinnemoen@google.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::849;
 envelope-from=3S8MEXwsKCuILWOMRRIQSIRKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--hskinnemoen.bounces.google.com;
 helo=mail-qt1-x849.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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

Add a config symbol for the NPCM7xx BMC SoC family that subsequent
patches can use in Makefiles.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Acked-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 default-configs/arm-softmmu.mak | 1 +
 hw/arm/Kconfig                  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 8fc09a4a51..9a94ebd0be 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -27,6 +27,7 @@ CONFIG_GUMSTIX=y
 CONFIG_SPITZ=y
 CONFIG_TOSA=y
 CONFIG_Z2=y
+CONFIG_NPCM7XX=y
 CONFIG_COLLIE=y
 CONFIG_ASPEED_SOC=y
 CONFIG_NETDUINO2=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4a224a6351..a31d0d282f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -354,6 +354,14 @@ config XLNX_VERSAL
     select VIRTIO_MMIO
     select UNIMP
 
+config NPCM7XX
+    bool
+    select A9MPCORE
+    select ARM_GIC
+    select PL310  # cache controller
+    select SERIAL
+    select UNIMP
+
 config FSL_IMX25
     bool
     select IMX
-- 
2.27.0.212.ge8ba1cc988-goog


