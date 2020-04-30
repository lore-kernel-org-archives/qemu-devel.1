Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2071DC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23262082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AyNAyUz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23262082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDxj-0007rE-26
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeI-0001no-0Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdn-0001CP-Kv
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdn-0001BY-7e
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id k12so2964936wmj.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gCVovwKxXypZUnAhID6Hfz/S5fE2/epvyEFf8xPlaPE=;
 b=AyNAyUz3IwmAVdTLv8WJ5f/oWKKJqbSIt6kBEbA57zG8eL9JvNOQpqYRpQ3yGlIx4+
 foIyUkXJDakIm+V7gBaM3eLQPbQjflR4rmFSF8mIcKEV841mUR5B2IAUhcmQvpx/LhJx
 DJbMkw3jtfpFC+Ikmfx8K1IOv7Ar4bsXUMnTSODCBzAZS/4sHB9lYxZpwKNp6RFLwF8/
 Ttglr6rXokYjSrlHH0GSAsKEkZkALQ0KAVs/nrmACzyuVAgGUuSp2LuMoByV7xLjBFG0
 2QAAtAeaclcsFMpBLHQrJAGL5fiSbYXZQCfQ7MqBwvUeU6HCCQmTpTDSbNhyOd0KblSk
 uQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gCVovwKxXypZUnAhID6Hfz/S5fE2/epvyEFf8xPlaPE=;
 b=FngLqpkzO4Uxri7h1S7qO/kriOjONqzaTSfPct7sV2T0ThVG09W72bZQQ86SzeG/+/
 763URVvYZAO9ik1eChcS0kFWBFt6LWhEkPolatzmcItU+VYbQp9VadVEoNmDJfIwn/OB
 PsPVsXzMXlZV01rWJgKjT4VVeel1dVbKLbopBft1RhBrVcCFjAfWg0uNLSmjO02BzDZ5
 9GtE7zZd5pLRs3lKQv+cSQzDMhH/m2oz91VaDwEAga/Ro7FLWM+/s58pg3tk6c8zX5jn
 4g3Lo6Y8kzj1cftO9+gUgOOONwfIGtJW6tHWHj5LnIKUoOMbjOvXIvoULSsAa7hXv/gE
 N35w==
X-Gm-Message-State: AGi0Pub7xKI3pYUEoI2NUdMXKtCkneNBu2iMVbkKascKZtaaNiXer8wa
 OXgQt6eADsOtsOSRrQrt5qgyrw==
X-Google-Smtp-Source: APiQypK2594IdSom8F9F4rbws9frjn2jbk0/GkOKTDBw3nCGMwnnn3yb8j98MnAN+XSefu/XxQU0TQ==
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr4418635wmc.11.1588270229454; 
 Thu, 30 Apr 2020 11:10:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 18/36] target/arm: Convert Neon 3-reg-same VQADD/VQSUB to
 decodetree
Date: Thu, 30 Apr 2020 19:09:45 +0100
Message-Id: <20200430181003.21682-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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

Convert the Neon VQADD/VQSUB insns in the 3-reg-same grouping
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 15 +++++++++++++++
 target/arm/translate.c          | 14 ++------------
 target/arm/neon-dp.decode       |  6 ++++++
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 952e4456f5e..854ab70cd79 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -653,3 +653,18 @@ static void gen_VTST_3s(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &cmtst_op[vece]);
 }
 DO_3SAME_NO_SZ_3(VTST, gen_VTST_3s)
+
+#define DO_3SAME_GVEC4(INSN, OPARRAY)                                   \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),           \
+                       rn_ofs, rm_ofs, oprsz, maxsz, &OPARRAY[vece]);   \
+    }                                                                   \
+    DO_3SAME(INSN, gen_##INSN##_3s)
+
+DO_3SAME_GVEC4(VQADD_S, sqadd_op)
+DO_3SAME_GVEC4(VQADD_U, uqadd_op)
+DO_3SAME_GVEC4(VQSUB_S, sqsub_op)
+DO_3SAME_GVEC4(VQSUB_U, uqsub_op)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7e4a57157c2..538e4be8f1b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4848,18 +4848,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             return 1;
 
-        case NEON_3R_VQADD:
-            tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
-                           rn_ofs, rm_ofs, vec_size, vec_size,
-                           (u ? uqadd_op : sqadd_op) + size);
-            return 0;
-
-        case NEON_3R_VQSUB:
-            tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
-                           rn_ofs, rm_ofs, vec_size, vec_size,
-                           (u ? uqsub_op : sqsub_op) + size);
-            return 0;
-
         case NEON_3R_VMUL: /* VMUL */
             if (u) {
                 /* Polynomial case allows only P8.  */
@@ -4892,6 +4880,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VTST_VCEQ:
         case NEON_3R_VCGT:
         case NEON_3R_VCGE:
+        case NEON_3R_VQADD:
+        case NEON_3R_VQSUB:
             /* Already handled by decodetree */
             return 1;
         }
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index b89ea6819a9..ab59b349aaa 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -42,6 +42,9 @@
 @3same           .... ... . . . size:2 .... .... .... . q:1 . . .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
 
+VQADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 1 .... @3same
+VQADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 1 .... @3same
+
 @3same_logic     .... ... . . . .. .... .... .... . q:1 .. .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp size=0
 
@@ -54,6 +57,9 @@ VBSL_3s          1111 001 1 0 . 01 .... .... 0001 ... 1 .... @3same_logic
 VBIT_3s          1111 001 1 0 . 10 .... .... 0001 ... 1 .... @3same_logic
 VBIF_3s          1111 001 1 0 . 11 .... .... 0001 ... 1 .... @3same_logic
 
+VQSUB_S_3s       1111 001 0 0 . .. .... .... 0010 . . . 1 .... @3same
+VQSUB_U_3s       1111 001 1 0 . .. .... .... 0010 . . . 1 .... @3same
+
 VCGT_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 0 .... @3same
 VCGT_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 0 .... @3same
 VCGE_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 1 .... @3same
-- 
2.20.1


