Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE160C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BB322DD6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMDWHWGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BB322DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0BY7-00038l-DR
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLz-0000JH-UP
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLy-00008u-Sn
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:43 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BLx-0008U9-0f
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:42 -0400
Received: by mail-pg1-x542.google.com with SMTP id u17so13592pgi.6
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cAE3egBYYhx3Un5p/9eiXe7aY/AvfKY8XXQvwdeHeks=;
 b=IMDWHWGkACnr3xshcVwyGWECtPIROaDZSeLtMBPd/2joZErI37Z+YX+nJzN2E6BnW2
 8KKu39ETpX71aPkEAbCpD33AS0UkhGSzmr3wJh+lIyRSDdvWnWWzvFdQF0+eqKSI02WV
 OqG/rjEUVbJP3Dd/C4E4l/931bmvxsZed7SHtwqWVTTLCz0OYz3AN0kUn7TSq57jFsH8
 zaK/ij2cq91GNzsAu5jKi5c0JTpYHRE7YI9iHbTAjgfsOHYeeZW4jmw6daIpk5BjkoK8
 IwuN9BcvL6wS7gUJCdWt7f/DZg0eTeMOpKnuJgZDOguBqLvkgHYh1/rruenfHExEuYEe
 N8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cAE3egBYYhx3Un5p/9eiXe7aY/AvfKY8XXQvwdeHeks=;
 b=UN51y8+5wHFHVtIrZ7RchjXDjFb1QD73LLkGRgEl49zZ6eycJqGR2N9lAr3/GOtZtZ
 XS1r2BIJCBaqLqOKGDtD6Yv6oeoETWrFIfQkIt/eWTqB4sSxKbrCdkdnXZ4qaVaX8uxl
 /6jgww8VihsuzdCJPBT9GEHVYL7fngZ7QJEKvJL6iYYVMnEQLNwjwlt/lSNArbWM+B0F
 1LE0OIgqMgoFoAGZ1r/lFm71x++Ri0Re7EVuFAFlqsKVodA3usrKswp7MkAS+n33i8+x
 PiRlgQ5qU0/alZ12k8q3UR96X39Yknkk48Ab4otLdxT/wljldExKAJgFRDiDDpP2OXtO
 UIWg==
X-Gm-Message-State: APjAAAV9bnN0isnkGZ+qq/M9KHTyy+OtrzSIuAJG321jO2j4LHTmlx/s
 cK/XGzgs6JrJw9Sb1oIXs0nzINu39VE=
X-Google-Smtp-Source: APXvYqxfFlEn3je754t/GK13fsQitEIxdJfRj/FFoq4fzZwKb4FmoAp/32JcgJesdfeyNzjtkIbT/w==
X-Received: by 2002:a62:be04:: with SMTP id l4mr30995464pff.77.1566335255019; 
 Tue, 20 Aug 2019 14:07:35 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:12 -0700
Message-Id: <20190820210720.18976-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v5 09/17] target/arm: Hoist XSCALE_CPAR, VECLEN,
 VECSTRIDE in cpu_get_tb_cpu_state
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fc071f95db..3889b9295a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11197,21 +11197,28 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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


