Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D6AC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC0322363
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hNmizyZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC0322363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUX2v-0005go-9w
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqe-0006xa-G3
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWqa-0002m8-Pl
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:13:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id e23so186660wme.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=60CXa9EVUwZSuD/TaM/4vLu3CrMpUPxjQs1jlsMOoMs=;
 b=hNmizyZDP2pel4ajJU+5apBtwUYjPPBUb09FuMN+454ruGVlIT/Lv7mFjkf5k3y3Gw
 MlnrqIVe3OkfhcDaKts6K3XWI647o00iY+UytB93+UwAy7fKfxvlYmLDCKK3bws2H/CF
 r9KTMuGelHm/QgqbJgj9qY5muEHuoYBuKhV5heBi6wU5Gmo2Mq+wVdmbm2hhTud0x+Zu
 lX/TydvOT7RyhzFtV6WdTaI6ONSnV1i2dNy6LEU8+QqFFbCuAJGWtH0vSys1kUlDlLbX
 1SPrjDpmrGJxyJWzRLF2rRXu7p9+XLluMVwd3cBpxvsHjoG4YewStN/jQXtqL9t534du
 F2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=60CXa9EVUwZSuD/TaM/4vLu3CrMpUPxjQs1jlsMOoMs=;
 b=dLpANoKvbiz8Twa/qaYdvdx2usSlvWfWqp5tqdHgkaOoy75FsvobUk4S5S0n6GvNrU
 cqCxk1d4JLUrrZCms3WxXdUSD0i91wKghV38WHCBjAGqUOMSltmsmeE5uQjGGG7vl+0S
 iRWhyjVOrmgyj6KrCufF82AhyswTR05JXGXiJu5nqWLNbnpBrZrIYK/PMyUkYAR/3GCn
 yX8jFxdzxT7yXxNhP7Nra6Lywwz2lmuHWuYteOb1YQRmXobWyYDwN8BZb9fLu0bOARgz
 DI7Dkx9ztlcQ/zGwws4MJkx5y8c/u1CmCe1BDu+ywqivduab34ZoKLxYPBWsBLcOMbQj
 hfag==
X-Gm-Message-State: AOAM532jwThkeWikyF5mf5HYbrZWKkFV+WiD5TGCq/q1b4Cw+2Zyh4Jx
 tjxdF46NUoOMsguonargX223Lw==
X-Google-Smtp-Source: ABdhPJzH6su9dHghAQc0/Hx2azguF8lQWioUtOU6jGIGgJVm2Y4UUJS4bK/cpzZ71Rti1niuIURkfA==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr46877wmb.32.1603120395484;
 Mon, 19 Oct 2020 08:13:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y14sm309918wma.48.2020.10.19.08.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:13:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 10/10] target/arm: Implement FPSCR.LTPSIZE for M-profile
 LOB extension
Date: Mon, 19 Oct 2020 16:13:01 +0100
Message-Id: <20201019151301.2046-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201019151301.2046-1-peter.maydell@linaro.org>
References: <20201019151301.2046-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the M-profile low-overhead-branch extension is implemented, FPSCR
bits [18:16] are a new field LTPSIZE.  If MVE is not implemented
(currently always true for us) then this field always reads as 4 and
ignores writes.

These bits used to be the vector-length field for the old
short-vector extension, so we need to take care that they are not
misinterpreted as setting vec_len. We do this with a rearrangement
of the vfp_set_fpscr() code that deals with vec_len, vec_stride
and also the QC bit; this obviates the need for the M-profile
only masking step that we used to have at the start of the function.

We provide a new field in CPUState for LTPSIZE, even though this
will always be 4, in preparation for MVE, so we don't have to
come back later and split it out of the vfp.xregs[FPSCR] value.
(This state struct field will be saved and restored as part of
the FPSCR value via the vmstate_fpscr in machine.c.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        | 1 +
 target/arm/cpu.c        | 9 +++++++++
 target/arm/vfp_helper.c | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a432f301f11..49cd5cabcf2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -549,6 +549,7 @@ typedef struct CPUARMState {
         uint32_t fpdscr[M_REG_NUM_BANKS];
         uint32_t cpacr[M_REG_NUM_BANKS];
         uint32_t nsacr;
+        int ltpsize;
     } v7m;
 
     /* Information associated with an exception about to be taken:
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 186ee621a65..07492e9f9a4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -255,6 +255,15 @@ static void arm_cpu_reset(DeviceState *dev)
         uint8_t *rom;
         uint32_t vecbase;
 
+        if (cpu_isar_feature(aa32_lob, cpu)) {
+            /*
+             * LTPSIZE is constant 4 if MVE not implemented, and resets
+             * to an UNKNOWN value if MVE is implemented. We choose to
+             * always reset to 4.
+             */
+            env->v7m.ltpsize = 4;
+        }
+
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
             env->v7m.secure = true;
         } else {
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index c3d01d781b6..bf608d7aef3 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -174,6 +174,12 @@ uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
             | (env->vfp.vec_len << 16)
             | (env->vfp.vec_stride << 20);
 
+    /*
+     * M-profile LTPSIZE overlaps A-profile Stride; whichever of the
+     * two is not applicable to this CPU will always be zero.
+     */
+    fpscr |= env->v7m.ltpsize << 16;
+
     fpscr |= vfp_get_fpscr_from_host(env);
 
     i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
-- 
2.20.1


