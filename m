Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647AAECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34988214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlaPsAfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34988214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxQn-0005Lc-08
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGq-0002Rp-Mf
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGp-0007gc-FR
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:00 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:46738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGp-0007gL-Br
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:55:59 -0400
Received: by mail-yb1-xb43.google.com with SMTP id h202so3235760ybg.13
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iqTlbqaEumCeViAxHmy3brKEyzF/IL5OcylNHq80qOA=;
 b=LlaPsAfSZ9ajH0n/1v6zbHEnrz97OeHhwUUtJCeQvP+1xHOkAd54BXlZbLPsSV+yx1
 /4LxMyYD4sdNS/WBhp9O5MF4v6kKMCPTXuPeGojNocanhka7xK2/mJ8pI0vLbNXW24+/
 rhW50d+qU/ZqSheeixunH7PNW5rOB0VFa18L4MHo8ySH/w+9rf52cQ+FM1i8pLSQRrEs
 TnnO+QjWfwAQu7/p4KLZqV7Lx0NFq3X1bSeAmGVTRLO9o4IxYPfO9ucRzfJvOF2wgVPP
 4nmPDDdluOdjw9qINF8rQVt9jrVCPztH27iROZYVKpwUIlvDKo+evX0qjO3t4NjYheDk
 yFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=iqTlbqaEumCeViAxHmy3brKEyzF/IL5OcylNHq80qOA=;
 b=pQ3aTMBYsv7fNGzjSQHZWo5gkL/Q3kd891KmN6VwjWp3o8HnEyGnrRwKrfomKngi6s
 9oG3Ii7duRgHbRWvxGKyg6tVJldVPTb8RDDNFh0uKO1lZpvdwAeyNweCl3JmWu+yEDDX
 m6frnTqofHoB5fhviC0oGWGRF5NkmmipcQKqz6gqZNY3waQF+R2tKc4PFCgmmmRnKIvx
 CJNC56N6oaM3qkpvMiXoRCZrCjc3YLw7Rqf2G72u8Xy+yD5bn9zE/Pk4lN74zBhzp4/f
 oOpNirEfhgmRLZ7Mzlis6FiYv/zFC3R6Yj45epqjCQYnBriqjbrHbgBDZk5G0CRlj7fG
 CY7w==
X-Gm-Message-State: APjAAAUEB+bZxcTx65NMoUZNL7Fs/xaebJaP31H2JnRH23IRYiWvBren
 Duh+M6tsqCowltv1vjogSut1cXYOOn8=
X-Google-Smtp-Source: APXvYqzkgzbQsosCljGQX5pZq8qop0g4nkjJ5XqAgss7IkZlRKxJBOQFr7OHf3pAeph9meStsCExIw==
X-Received: by 2002:a25:4b04:: with SMTP id y4mr10225057yba.480.1570809358429; 
 Fri, 11 Oct 2019 08:55:58 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:55:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/20] target/arm: Hoist XSCALE_CPAR, VECLEN,
 VECSTRIDE in cpu_get_tb_cpu_state
Date: Fri, 11 Oct 2019 11:55:35 -0400
Message-Id: <20191011155546.14342-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do not need to compute any of these values for M-profile.
Further, XSCALE_CPAR overlaps VECSTRIDE so obviously the two
sets must be mutually exclusive.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ddd21edfcf..e2a62cf19a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11235,21 +11235,28 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             }
         } else {
             flags = rebuild_hflags_a32(env, fp_el, mmu_idx);
+
+            /*
+             * Note that XSCALE_CPAR shares bits with VECSTRIDE.
+             * Note that VECLEN+VECSTRIDE are RES0 for M-profile.
+             */
+            if (arm_feature(env, ARM_FEATURE_XSCALE)) {
+                flags = FIELD_DP32(flags, TBFLAG_A32,
+                                   XSCALE_CPAR, env->cp15.c15_cpar);
+            } else {
+                flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN,
+                                   env->vfp.vec_len);
+                flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE,
+                                   env->vfp.vec_stride);
+            }
         }
 
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
-        flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
-        flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
         if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
             || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
         }
-        /* Note that XSCALE_CPAR shares bits with VECSTRIDE */
-        if (arm_feature(env, ARM_FEATURE_XSCALE)) {
-            flags = FIELD_DP32(flags, TBFLAG_A32,
-                               XSCALE_CPAR, env->cp15.c15_cpar);
-        }
     }
 
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
-- 
2.17.1


