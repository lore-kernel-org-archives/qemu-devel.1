Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF660CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5762173B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnqnVCH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5762173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIT1-00089M-0N
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8u-000897-15
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8r-0001FO-BG
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:43 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:44401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8r-00014g-3T
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:41 -0400
Received: by mail-qt1-x842.google.com with SMTP id z22so12215931qtq.11
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+w+DpqTaqyThsFD3h0g6qTaqlae+kRMVgywC4mwAkDA=;
 b=tnqnVCH/71/mrfaS0bcMDWr06WHHWLbRbkKUHXp/nAueUslzhqQ0NwfEE0F1M56+kq
 gYX1meHPZKyM23Qo/XT0jI+I14W7cfHxL7sK6cIkR8vY/fMIy+1xQicWP+AG+UwgValm
 NrbTS6WOHNZZIiBykpTj3IN1bb7m14dy9k1nMaX9mw8uBNIDEywxHS8JQw5CTeliZ+2d
 Etl6kQdEGr935xJIkYvaM4GZiDQX4m1rB/bZWEE/kH2Ws0fI31oXsdQOM1sSFiybAiW3
 vhOSQ5424NdLolQlmBlVUfTtMDTLwZQ3uuZJ8To8BlchaBkcyxJvlF0+UKI5qqoze6HK
 +MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+w+DpqTaqyThsFD3h0g6qTaqlae+kRMVgywC4mwAkDA=;
 b=lqhExIn/7FhCuAOrqRfUOv6CbE8hUHSGws+u5AZcgazv6mtR/UND6nH0yp8iGMoxeC
 j4ocCnCgUzqTEFucf5BtYOX2P8Ic9fs1VLfxNurllnCKh4ySHsP40VonR0in5wiUNF4j
 cBvCYbrUl/zF8gKQcrNa2gFKFYpKPqK9kCDN/6Oc7Liylz/vCTmNtwCvRXgrz5nPfe1y
 9oVkJ1sPM9YLeXJyNYAycffrZF1iXDDkpRUq50TTn5QEu6y2BDpeieACamZlA9BV5u1R
 OuvmDnjnqUF4jxcNM2cAPF15zb5RhLULdNOOBVZm/fYzU1j7Zk0tWU+7hyd+e96/glC4
 tlNA==
X-Gm-Message-State: APjAAAUDyJqyHv1d9x1aIm7kMGxKc1YDF+F3xyMPmWJs6wj7no317pfm
 pQHwnOV3iA0IzBe7qpIIVn2c+EqU+6E=
X-Google-Smtp-Source: APXvYqymAu2qq90HIwOCAccVR1AIkmMJs2/5U2AtYyn3ZAxtMUjB1fvD0dPKPKJlWgjeaXxopss7RQ==
X-Received: by 2002:ac8:664b:: with SMTP id j11mr9706105qtp.137.1571842874422; 
 Wed, 23 Oct 2019 08:01:14 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 09/24] target/arm: Hoist XSCALE_CPAR, VECLEN,
 VECSTRIDE in cpu_get_tb_cpu_state
Date: Wed, 23 Oct 2019 11:00:42 -0400
Message-Id: <20191023150057.25731-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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


