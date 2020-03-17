Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7ADC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA5520735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGczjF6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA5520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGhJ-00052B-41
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUb-0005pJ-87
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUa-00012P-4v
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGUZ-0000xO-Tf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id g62so284791wme.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M48cU5ZUp7kKc2JaWuC8XHAXXhtPfcdV39imYH+qaek=;
 b=VGczjF6fWuU01syDM+MwafszV7e942MfzTNFFU+dND1iId9lkr7VUSDsJNYet3eOIU
 0u76opveYLEtiKZEwAHUpWCOFfvuCxPBQHXgm0ucA2WF7Mrwb2hBmoqZTsLoto/JBU6f
 n/o+VAdRREoC+nguDZ3IKch6eZ9n8iP1BSq3BF5R3yE+BebltDh1IwCbSH6H+vGccEZH
 mB93aqe5YG/Gp9r17KEY3BXEROTq5TQIu9F2D2BBdo/5vM6SmuNiD6GMRMDHzg5y4m4j
 gWAlhevT3a9YddQ1LZND2qR/AIoZ5sDXYtClrW5bYiuHlL7W83hw7kInblpU8Me/vNBw
 2fDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M48cU5ZUp7kKc2JaWuC8XHAXXhtPfcdV39imYH+qaek=;
 b=pYaBKITRE63TP0pnqrcWCu9H11193tETHRWQRlG3KH66wAyYKEKDyoDdLtrfYkfsnE
 nr5PZpr3qW9+O4Ct4Ua3sYGsUehunNlbLwXjhTWlx4t0dQ2vUBIFy6BJPXOHLAamk2oQ
 QCz1iNq+HL+iEhO5pDOy06tjeTt4R1XH83G3UeNuNQ5ypHHAwRL5igwS2HX1q6mRpqfv
 ytsP+tj6Q4DZYm1s5mImSidLwTACT+jVC8knzxortc8iAi4m1jC8wuBub6+1zZUMZhxJ
 Uwabmge0pmrpU2iAyHs0lBY6ZtBc+fhL1caGqkodsRQLub+7Be5wwvoz1IKFQhcIy5b4
 sf9Q==
X-Gm-Message-State: ANhLgQ23YdsYvjnPc8gvxW1OXdx7OdkE4vJyTYbB8yw/PFLaDjJ9bG9S
 ez7siuKyTN3Xn+25j8vv/NqykQ==
X-Google-Smtp-Source: ADFU+vsXVvQRLvwsekGHyIIYcbHkL/OK7Vx+MllUjD6f1jd45CL98EkPJdshqGPljLzBR5VZpkaMNg==
X-Received: by 2002:a1c:de41:: with SMTP id v62mr236590wmg.60.1584467942841;
 Tue, 17 Mar 2020 10:59:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q8sm251177wmg.6.2020.03.17.10.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:58:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2112D1FFA5;
 Tue, 17 Mar 2020 17:50:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 17/28] target/arm: default SVE length to 64 bytes for linux-user
Date: Tue, 17 Mar 2020 17:50:42 +0000
Message-Id: <20200317175053.5278-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel chooses the default of 64 bytes for SVE registers on
the basis that it is the largest size on known hardware that won't
grow the signal frame. We still honour the sve-max-vq property and
userspace can expand the number of lanes by calling PR_SVE_SET_VL.

This should not make any difference to SVE enabled software as the SVE
is of course vector length agnostic.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Message-Id: <20200316172155.971-18-alex.bennee@linaro.org>

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3623ecefbd9..0909ce86a12 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -195,9 +195,10 @@ static void arm_cpu_reset(CPUState *s)
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 20, 2, 3);
         /* and to the SVE instructions */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
-        /* with maximum vector length */
-        env->vfp.zcr_el[1] = cpu_isar_feature(aa64_sve, cpu) ?
-                             cpu->sve_max_vq - 1 : 0;
+        /* with reasonable vector length */
+        if (cpu_isar_feature(aa64_sve, cpu)) {
+            env->vfp.zcr_el[1] = MIN(cpu->sve_max_vq - 1, 3);
+        }
         /*
          * Enable TBI0 and TBI1.  While the real kernel only enables TBI0,
          * turning on both here will produce smaller code and otherwise
-- 
2.20.1


