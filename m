Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FE0C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A184220787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VsRAUXUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A184220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDz5-0002kB-Oa
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDea-0002bc-1a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDe1-0001L6-5r
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDe0-0001KT-Mp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:44 -0400
Received: by mail-wm1-x344.google.com with SMTP id r26so3082485wmh.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GFlmtmtGwB0Z1c1xqmmNwpuF0kF4/GSmZyxkEc1uP1E=;
 b=VsRAUXUxsObvdX4ev6dvcPVS0LM7W22Vq1kV8pRgJXo5L2JpmsH7JAt1gQ9rH69Diq
 jYCnzt/y2jtICUDLEMWc1U8MYq704j8BSLw2+bi6dSKcKfWMuc5HG0lAKi6huqDJLVXq
 2aiRdpB/D4mKOdrjiQjwDYa2xSUS1wuZr6TsNy3DA7CAk5upTf2xpeLYwcOzmLBtCaxv
 FtsFttKDInOjZjRD8MfU4QpKLAyBZ8XhlR6cvsDNCRqsNklgWYStfQBekoArfzHT3mPv
 w0BxyxxhwlGi/f+vegKCaJbgpQ+6G79Cbra8HrIaA7K9f5d1aAyH47Ij54Q2MfRfOb/2
 lONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GFlmtmtGwB0Z1c1xqmmNwpuF0kF4/GSmZyxkEc1uP1E=;
 b=nFzWQDMJmwIcAziKZRTnxLcFQMJ1XZSCta1phqJD3hKoFzAZxWYtKPOTiHyH5e0y+B
 44CBQx8v7zfSKAs8RC5TbtrE548YZ0pnq3KP58bquuKM+4ViIOzkgczGOwJ1jfr6a3mu
 guBAKE04xFdVTg5XqtZyjO6/wIdPV9Hvv5BCP/XLkyX6Jn0Q2DN/GA660+lzWE91JoJf
 /4JBARRy0KLsSOUsriMU0NdxR/GR67nr+7RwmmrGRMQSjfLi9+0d1qZYMdUrNlxnwNoC
 hoUxjWXmQuZf12ieBuFfDWtUvf6P8jVJdJfKKnTWk8Ab693Crew8V0QSYgeCQwcpe9RV
 BVpw==
X-Gm-Message-State: AGi0PubdftUDoKm0cdjX24z3T7oZzjV+8ojY4AEIkfj/cRm97WsiVdv2
 IvoIzOMbEQJXyzXd0hOHKADJaA==
X-Google-Smtp-Source: APiQypJNkwvRlSDhlOdPT1hgSeObXCJijhNSjMO5phxQOnn+eYlWeqM/d93eZ6gWHv9+Epau/BExdA==
X-Received: by 2002:a1c:1f8e:: with SMTP id f136mr4189750wmf.166.1588270242753; 
 Thu, 30 Apr 2020 11:10:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 29/36] target/arm: Convert Neon VPADD 3-reg-same insns to
 decodetree
Date: Thu, 30 Apr 2020 19:09:56 +0100
Message-Id: <20200430181003.21682-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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

Convert the Neon integer VPADD 3-reg-same insns to decodetree.  These
are 'pairwise' operations.  (Note that VQRDMLAH, which shares the
same primary opcode but has U=1, has already been converted.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c |  2 ++
 target/arm/translate.c          | 19 +------------------
 target/arm/neon-dp.decode       |  2 ++
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index cd4c9dd6f28..31a8e4ef486 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1270,8 +1270,10 @@ static bool do_3same_pair(DisasContext *s, arg_3same *a, NeonGenTwoOpFn *fn)
 #define gen_helper_neon_pmax_u32  tcg_gen_umax_i32
 #define gen_helper_neon_pmin_s32  tcg_gen_smin_i32
 #define gen_helper_neon_pmin_u32  tcg_gen_umin_i32
+#define gen_helper_neon_padd_u32  tcg_gen_add_i32
 
 DO_3SAME_PAIR(VPMAX_S, pmax_s)
 DO_3SAME_PAIR(VPMIN_S, pmin_s)
 DO_3SAME_PAIR(VPMAX_U, pmax_u)
 DO_3SAME_PAIR(VPMIN_U, pmin_u)
+DO_3SAME_PAIR(VPADD, padd_u)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4bbdddaa30c..f583cc900e1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4749,13 +4749,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 1;
         }
         switch (op) {
-        case NEON_3R_VPADD_VQRDMLAH:
-            if (!u) {
-                break;  /* VPADD */
-            }
-            /* VQRDMLAH : handled by decodetree */
-            return 1;
-
         case NEON_3R_VFM_VQRDMLSH:
             if (!u) {
                 /* VFM, VFMS */
@@ -4790,6 +4783,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VABA:
         case NEON_3R_VPMAX:
         case NEON_3R_VPMIN:
+        case NEON_3R_VPADD_VQRDMLAH:
             /* Already handled by decodetree */
             return 1;
         }
@@ -4800,9 +4794,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         }
         pairwise = 0;
         switch (op) {
-        case NEON_3R_VPADD_VQRDMLAH:
-            pairwise = 1;
-            break;
         case NEON_3R_FLOAT_ARITH:
             pairwise = (u && size < 2); /* if VPADD (float) */
             break;
@@ -4880,14 +4871,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
             }
             break;
-        case NEON_3R_VPADD_VQRDMLAH:
-            switch (size) {
-            case 0: gen_helper_neon_padd_u8(tmp, tmp, tmp2); break;
-            case 1: gen_helper_neon_padd_u16(tmp, tmp, tmp2); break;
-            case 2: tcg_gen_add_i32(tmp, tmp, tmp2); break;
-            default: abort();
-            }
-            break;
         case NEON_3R_FLOAT_ARITH: /* Floating point arithmetic. */
         {
             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index e47998899ce..acaf278cc8d 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -137,6 +137,8 @@ VPMAX_U_3s       1111 001 1 0 . .. .... .... 1010 . . . 0 .... @3same_q0
 VPMIN_S_3s       1111 001 0 0 . .. .... .... 1010 . . . 1 .... @3same_q0
 VPMIN_U_3s       1111 001 1 0 . .. .... .... 1010 . . . 1 .... @3same_q0
 
+VPADD_3s         1111 001 0 0 . .. .... .... 1011 . . . 1 .... @3same_q0
+
 VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
 
 SHA1_3s          1111 001 0 0 . optype:2 .... .... 1100 . 1 . 0 .... \
-- 
2.20.1


