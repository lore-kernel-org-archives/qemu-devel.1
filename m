Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF31ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B473F21D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 18:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCrfpAhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B473F21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLAx9-0007P8-GG
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 14:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAs6-0001Eb-3C
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLArw-0000u0-NO
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:31 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLAru-0000tJ-C0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:26 -0400
Received: by mail-pl1-x641.google.com with SMTP id g9so242391plj.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+w+DpqTaqyThsFD3h0g6qTaqlae+kRMVgywC4mwAkDA=;
 b=eCrfpAhpKEKn8gSuCuueNB4Q4eWZE05CJ5ll8P2HV4HypqZJX2rKWZpvxLeUfgP+0+
 7LQe4TkF4rzIkMIQL/DYskdS2iOZAE2as4DVZIkjT61LYVpdc4nayzFZWKP/YtDlQUXl
 xUvu7XIP/4Af7WXpMyV6E823SARcVOLypKXDt3sFQYly0AOrS4l+6sOEEekosMN+ZWzG
 GBstJOpbBhed4ksN7fBU8X6F8wuolGdFsjb48YwoejYhVrf5Ga43TWYyKFbZUjW5Iwnw
 dkGoNXW0nDRP1drWdsOo1TKzgyCCDG5xDJ/0lOXuee+ue3thN+6CLZjoYu6wioxA3eff
 BbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+w+DpqTaqyThsFD3h0g6qTaqlae+kRMVgywC4mwAkDA=;
 b=qeUqOFs0SoOP8u85m+NMhwhZqFl9om51mswFMZBGwYsGYfhrv8u62FzSzXTmbq526j
 0aISSWryHGkbSjOImsXKcwjyOqbyZwAQzlC7pdOeW8yy3CgEnXBEO0eulFMZjLKKF3Bw
 q5SsjVU8kuTXCEbumLzA7i/AbX2UtmTXjpniuW3Ryv/kc3GmjxKvzPQLpLLL+76oM6mw
 p2cW5/9LIS57tIIrtzj0yHwJRdBmiTr9vlq8Nn2KAfy0C/uWfH2iYJSALG9fuDRRmY4O
 qcYacFMna5CKrGrc3Gp5g8fgQUhD5nhTHmdxolo4qrOMU8QNlJe6njOIP3ttU3M4q0P3
 fyDw==
X-Gm-Message-State: APjAAAXo2tWUFJxG+8pSLlyVbbukAHIsmh+gkyg+YbtVU/cVppmThjAs
 JsxjyFjnuom2igo6zKNSyN/1ejBHcqM=
X-Google-Smtp-Source: APXvYqz9bzYdA9HKh79CDGvpBkgov/ycdRv8UTgizUvfQThP64IcafW7NcNKxKz1gP67N5y34BbnWA==
X-Received: by 2002:a17:902:9005:: with SMTP id
 a5mr5426314plp.204.1571338284222; 
 Thu, 17 Oct 2019 11:51:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 09/20] target/arm: Hoist XSCALE_CPAR, VECLEN,
 VECSTRIDE in cpu_get_tb_cpu_state
Date: Thu, 17 Oct 2019 11:50:59 -0700
Message-Id: <20191017185110.539-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do not need to compute any of these values for M-profile.
Further, XSCALE_CPAR overlaps VECSTRIDE so obviously the two
sets must be mutually exclusive.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


