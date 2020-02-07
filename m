Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45506C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D1A20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycliQmCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D1A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04rm-00049n-5U
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i1-0000lF-Se
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i0-0003Cg-Qk
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:35484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04i0-00039o-KO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id b17so3065380wmb.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=REszxidtLf31ZbQ7yJRQpRtjcKipd3XRTKwyqhC+ipM=;
 b=ycliQmCS21lwnPms2YB0p/Axc52dEFSGWXmJ9HKecfdoZU+1qbcXHq5XU+ic7JBx2l
 E1VDiQLbb++5lZk3NstuTKCNiG3Tq5cFQUvPycA0OjGHF3dL/cbk2snxY+OxKYMaeZ54
 4CJCLPZdbgAS1glwQEFLAH1oMc+25AMRnEZXYM0PYVkRy21I/JJaQivfieC7s6Or/sfY
 cuVW/kG0lxb7yBbtTvbnqUqqHORFIGbq52RXCwInS7UanuwAFiQR29mA+HbpVu3ymyku
 tkG7WvEHXCyqfkBRoD33AurPIVyHqCtb98UVsmi8tjan4TZ9TGmrNo+97hRQLbHlJWpx
 /VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=REszxidtLf31ZbQ7yJRQpRtjcKipd3XRTKwyqhC+ipM=;
 b=cbsad3Zqz/Eiub4F445SKtTrE+3HFyX1ANlot8jgm7nr9OSz3cM3bmEnR/HeTPhRVC
 lu6fNIL49RitXAiV7Oc86OSsTtyDjh6jf87z2v0cdwhyMpwjNZuEgBqS79sN1JZo0tzk
 kE79bc5Mme6sFk9q+bW3PfKgb117o8CUkO00+pTRKdPQdq7XI/Tm18BfEjX9R5jtFFAi
 5njBgjVyhAz3BE6w8zco4W6rmkmGUO6hw+KE2RsX2hO8tPppkZ5MlYRMneDImvxSykyJ
 sn/lscBieZvVXWrLUrW/7yhSZApOWXMddcnG3yrPd042qQA/+CAWDgwC2a7J8GIVkO7R
 bSOw==
X-Gm-Message-State: APjAAAXtjN53VVJQIkUlPkZcg4p3kUFmqhCZVDbU7uhWO7MeSCNGvZGL
 5xmkYryTOL2+pjvFZNdTI/CQoxeEpSM=
X-Google-Smtp-Source: APXvYqx77b5mYf2gq9917jTqiIeBSchFx4clMwCamzVzObASP/vDPCGn9YKB8KIJ9exYtSSLqbWLtQ==
X-Received: by 2002:a05:600c:2942:: with SMTP id
 n2mr4556323wmd.87.1581086055386; 
 Fri, 07 Feb 2020 06:34:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/48] target/arm: Update define_one_arm_cp_reg_with_opaque for
 VHE
Date: Fri,  7 Feb 2020 14:33:23 +0000
Message-Id: <20200207143343.30322-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

From: Richard Henderson <richard.henderson@linaro.org>

For ARMv8.1, op1 == 5 is reserved for EL2 aliases of
EL1 and EL0 registers.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-28-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 992ab2a15f1..2aa04d06131 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7586,13 +7586,10 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
             mask = PL0_RW;
             break;
         case 4:
+        case 5:
             /* min_EL EL2 */
             mask = PL2_RW;
             break;
-        case 5:
-            /* unallocated encoding, so not possible */
-            assert(false);
-            break;
         case 6:
             /* min_EL EL3 */
             mask = PL3_RW;
-- 
2.20.1


