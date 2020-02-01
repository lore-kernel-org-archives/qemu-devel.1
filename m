Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF01C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFD1205F4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIMVNOAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFD1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyeW-0001IO-Gu
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySy-0007yv-9G
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySx-00079F-5f
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:04 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySw-00075n-Vn
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:30:03 -0500
Received: by mail-pf1-x444.google.com with SMTP id i6so5291093pfc.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lOpt+tnic+DBm+8Ls3O8L5tH0MsUO+4UoXmIfqQorxk=;
 b=gIMVNOAMZvAeLm/G/EOxYs7gMFHuN1Gw+JwbNNFAmEQj3/p4zX8CHxgNnxT3jc982g
 BPTp9zeYkqloNH65FimNCBHCEXfwDQu/YJ/CvZWqlBb9QY++Wv3VXt0xOsuq1yAVj6lH
 VX+xPHRlpbgMa3o776H/h5hNkmtccpj5ovIPQ2i8S4/glwRrwYJqm3xVkHXr+tKeb4va
 MiF5uln82JS9hjF3nnOgfu0CIwB72n633qBobqzwz+W40JcRpaWbuwo+PuVokfotYkJG
 /C8YKhxzhBHcHY1oNpT5tGbaI95ZjPJWpW3cXk7wp5Z5ugBGPVgrS4TFtpcz9nlpLdHZ
 Pybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lOpt+tnic+DBm+8Ls3O8L5tH0MsUO+4UoXmIfqQorxk=;
 b=kpmOal8Pf6/aeXahirdGG6ZHpzOXogBf5p0c4SY7sdZJ0d0f6HPv1jrmGDqsPCDsJz
 XAaQ3ZMsw7dUoaKPdbt3QmiOdkIuZMl6Mdmoc2Z5OAJqDsYbVKVfSqQqWQbJVUqbbfXW
 wYDeG88aUPrCEwEVAG98mwb91z6yhgi90qlyzUk8/gMJXXga+d9N0vOUZJ+EZHY7QlFK
 j2BSV4a81/fy/MiNN6H/GfNQDIWXGyq/rc5WzwGaqaCcnkS7adjGmeC+qHSXNcxYxSCl
 7u7r/HUoIvUju8qJO2PRwWMV0DQhuf7oVWnljhi5si5CXO2IcbzKOvVD26RAQuDvuXgo
 q0AA==
X-Gm-Message-State: APjAAAVOKQbb26F2SWKtTg4XE2LWlYvATv8F7O3UvkBgmGkJ3Z3AlotV
 rFlxVSO5Pzz28iR+sId5CyeAkkjhsf0=
X-Google-Smtp-Source: APXvYqyFUSPZJ5IbI4cU0lt1AVIzys/mQGVk9m5nB44woO3pmQyMEoiuWIxK0UowSvv0MiIbyuiSDg==
X-Received: by 2002:aa7:820d:: with SMTP id k13mr17393692pfi.10.1580585400429; 
 Sat, 01 Feb 2020 11:30:00 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 36/41] target/arm: Update arm_cpu_do_interrupt_aarch64 for
 VHE
Date: Sat,  1 Feb 2020 11:29:11 -0800
Message-Id: <20200201192916.31796-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When VHE is enabled, the exception level below EL2 is not EL1,
but EL0, and so to identify the entry vector offset for exceptions
targeting EL2 we need to look at the width of EL0, not of EL1.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 576afd9c9e..70b10428c5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9026,14 +9026,19 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * immediately lower than the target level is using AArch32 or AArch64
          */
         bool is_aa64;
+        uint64_t hcr;
 
         switch (new_el) {
         case 3:
             is_aa64 = (env->cp15.scr_el3 & SCR_RW) != 0;
             break;
         case 2:
-            is_aa64 = (env->cp15.hcr_el2 & HCR_RW) != 0;
-            break;
+            hcr = arm_hcr_el2_eff(env);
+            if ((hcr & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
+                is_aa64 = (hcr & HCR_RW) != 0;
+                break;
+            }
+            /* fall through */
         case 1:
             is_aa64 = is_a64(env);
             break;
-- 
2.20.1


