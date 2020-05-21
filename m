Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7839C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8310720748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BagUEr/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8310720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrzM-00087T-NH
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <31tTGXgsKCpc8JB9EE5DF5E7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--hskinnemoen.bounces.google.com>)
 id 1jbqlV-0005Xh-Eu
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:22:01 -0400
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849]:53578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <31tTGXgsKCpc8JB9EE5DF5E7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--hskinnemoen.bounces.google.com>)
 id 1jbqlU-0001jB-FQ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:22:01 -0400
Received: by mail-qt1-x849.google.com with SMTP id r9so8801216qtn.20
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=oFHRlojcNpFQuMJIo95dy5CUFH50eFtN335sC34/7o8=;
 b=BagUEr/EDaw1e84DTo31bTqCniDwb596evDbsKtUIlQxIhYftDSTi/fZKojKp1Keyw
 7ssnrmYxiNVqi4iBEpklgNEcYmkxvw5iQcGLemufByU7BAnl4Pbo7BT42i3hsxkHF0m1
 9jZPmI0ZlZIlvKM0X0307uBWI9AlhrmKF8oPCkiA5EsCP+GPdZRSRqV+5JOloUxTHqKi
 Kq079b2sxYmfohASiHw6y89nLkoa6zqMyiZFCEzgY+7+KcagCWbfOWnQInppeT20r8Sl
 XGNrkeCBOPC32juPDjyxT69yZu8XG5TFXyaqhygptb+MjjUrYA+cuWGa9nqwTMr4UByi
 0zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=oFHRlojcNpFQuMJIo95dy5CUFH50eFtN335sC34/7o8=;
 b=guCKtT0LL4toR82/US9DgV+c908wec8GPpLXT7JnoIe8YJEknLwT1/lzlaIZUl0F/c
 AZ5rsQPZLqbnAV/w4fj7ge7JvWj2oeLqZvxDZuFwVOVcuVXfmD1W1FVAaKEFK2b8+X4y
 d16HFTfKmCHa+nqEKPrZ3fygcUebWrfKrRJSguqYLxrBak13vz8aWGaU4wFpo2512LGS
 jpQgnxUhkLiRTuCHG450Gt9LPspegMUu1tNckrqoGOGRr+dpgK+2sYNuya4p4UP4Kc4f
 TjTOYbygOpychzq59I/0/Egv3puSsgU24x58awYwLsXA117THjGMwMcqif4EimSI89Ut
 MDXQ==
X-Gm-Message-State: AOAM533m91LhfVc96UXsKcO6yMec737GuNkuJUHGQ5LcRc6G+sbhOPDo
 6QlRkXCTFGZhIB8u8O6+ApZ1UO+BA5NI72l0Cw==
X-Google-Smtp-Source: ABdhPJy4VFu4hThIfCDrRHQeeqrfh57TCwkQkmkxIgU5KWXD2bWR5fp7W8afsK6D9HTJMrotrhDN2jZpGLp+pY7JIA==
X-Received: by 2002:a05:6214:370:: with SMTP id
 t16mr231743qvu.197.1590088918969; 
 Thu, 21 May 2020 12:21:58 -0700 (PDT)
Date: Thu, 21 May 2020 12:21:28 -0700
In-Reply-To: <20200521192133.127559-1-hskinnemoen@google.com>
Message-Id: <20200521192133.127559-2-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 1/6] npcm7xx: Add config symbol
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::849;
 envelope-from=31tTGXgsKCpc8JB9EE5DF5E7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--hskinnemoen.bounces.google.com;
 helo=mail-qt1-x849.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 May 2020 16:37:39 -0400
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
index 5364172537..47d0a3ca43 100644
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
2.27.0.rc0.183.gde8f92d652-goog


