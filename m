Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A50FC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B6120787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvuTMQAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B6120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDzj-0003tf-KZ
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDeV-0002O1-9M
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdx-0001JR-9L
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdv-0001I1-BX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id g13so8159517wrb.8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4Ydk5Bbg9ucmSMF8TUFcEzRTltMFyrq9kyl7LYvgv0o=;
 b=qvuTMQAzrHTd1Rxab03/A8N4GOPCCBd9O35Kd4IDXR4qO/6p4bJroxbGPYv0XUn8wl
 baF7ghyewUvDoLkqRTSAniGx+bKc+Iv1xYhTuDfEkkow2G0Uy9YRX7GXdK8JHtBwfzv9
 S3M7u16z/s3t0yYyLItIaQdlAxWyKL/t6m/78UVTqHKntgwEUSicnZOJEYm6vfDwAYhc
 +bjLsLpcE6mFbGSvnJ3CspP6MpXCMCQlJ2k93U5eaAMXKQQfrEPZmhGQa+6aTtmV85bA
 IF0i0Ovn/xPoxnKZKPuKwqpFnOPhPeM0808hWZddlhf+1Dsef6ZD5NyliqDJrXwZRWJ8
 fWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4Ydk5Bbg9ucmSMF8TUFcEzRTltMFyrq9kyl7LYvgv0o=;
 b=CwFvqPZz4RcIBq4h7uvfmU32cxilZoMRdAlMHt7cp5/Bu5riDkpsy0Qs9+ORxokpPC
 UaNNmn0uaB11F1ED0s/ZnZvZH/XiFSEakK1XXL6zIFlr3KQHFHABcX05gILQER4ZNsPM
 2poMK+AHM1J5Qx09MDut60tvecraRSujc9193wak7LlIS2VpFJ6UxLR6wphCgaZp2KUx
 eJEPDELTPJc0Ectn2ij+6qLzquNN0JYEuU9CGVfivWoUV9a7HNi3LMLojvYjr9OTPFB2
 KJ6l0Dhtxb1ConZBaZhwlMWOWz6X5FFcTGTJEtzYqqIA8VDq1+xC+jhgYPfWkx0cpDr9
 IQVg==
X-Gm-Message-State: AGi0Pubb98jb+g/zMeWKpdIYMTeWdij1RY9TlX0PedeD/l9vgW1Az24j
 6eO5IZPfxvsL70Ax8SdlWxTWlg==
X-Google-Smtp-Source: APiQypJOk4iV0FwzyQNkPRPj0PpKqDfdODaO+bd++3K6psaF2yc4o6HvgTsFLVyh3fsnNmqSn1WnuA==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr5505683wre.101.1588270237967; 
 Thu, 30 Apr 2020 11:10:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 25/36] target/arm: Convert Neon VRHADD, VHSUB,
 VABD 3-reg-same insns to decodetree
Date: Thu, 30 Apr 2020 19:09:52 +0100
Message-Id: <20200430181003.21682-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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

Convert the Neon VRHADD, VHSUB and VABD 3-reg-same insns to
decodetree.  (These are all the other insns in 3-reg-same which were
using GEN_NEON_INTEGER_OP() and which are not pairwise or
reversed-operands.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c |  3 +++
 target/arm/translate.c          | 12 +++---------
 target/arm/neon-dp.decode       |  9 +++++++++
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 7a602d76566..bdd5f33214e 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1032,3 +1032,6 @@ static bool do_3same_32(DisasContext *s, arg_3same *a, NeonGenTwoOpFn *fn)
     }
 
 DO_3SAME_32(VHADD, hadd)
+DO_3SAME_32(VHSUB, hsub)
+DO_3SAME_32(VRHADD, rhadd)
+DO_3SAME_32(VABD, abd)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 67616fc218a..29301061ca5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4787,6 +4787,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VSHL:
         case NEON_3R_SHA:
         case NEON_3R_VHADD:
+        case NEON_3R_VRHADD:
+        case NEON_3R_VHSUB:
+        case NEON_3R_VABD:
             /* Already handled by decodetree */
             return 1;
         }
@@ -4867,12 +4870,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rm, pass);
         }
         switch (op) {
-        case NEON_3R_VRHADD:
-            GEN_NEON_INTEGER_OP(rhadd);
-            break;
-        case NEON_3R_VHSUB:
-            GEN_NEON_INTEGER_OP(hsub);
-            break;
         case NEON_3R_VQSHL:
             GEN_NEON_INTEGER_OP_ENV(qshl);
             break;
@@ -4882,9 +4879,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQRSHL:
             GEN_NEON_INTEGER_OP_ENV(qrshl);
             break;
-        case NEON_3R_VABD:
-            GEN_NEON_INTEGER_OP(abd);
-            break;
         case NEON_3R_VABA:
             GEN_NEON_INTEGER_OP(abd);
             tcg_temp_free_i32(tmp2);
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 055004df4e8..4b15e52221b 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -47,6 +47,9 @@ VHADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 0 .... @3same
 VQADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 1 .... @3same
 VQADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 1 .... @3same
 
+VRHADD_S_3s      1111 001 0 0 . .. .... .... 0001 . . . 0 .... @3same
+VRHADD_U_3s      1111 001 1 0 . .. .... .... 0001 . . . 0 .... @3same
+
 @3same_logic     .... ... . . . .. .... .... .... . q:1 .. .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp size=0
 
@@ -59,6 +62,9 @@ VBSL_3s          1111 001 1 0 . 01 .... .... 0001 ... 1 .... @3same_logic
 VBIT_3s          1111 001 1 0 . 10 .... .... 0001 ... 1 .... @3same_logic
 VBIF_3s          1111 001 1 0 . 11 .... .... 0001 ... 1 .... @3same_logic
 
+VHSUB_S_3s       1111 001 0 0 . .. .... .... 0010 . . . 0 .... @3same
+VHSUB_U_3s       1111 001 1 0 . .. .... .... 0010 . . . 0 .... @3same
+
 VQSUB_S_3s       1111 001 0 0 . .. .... .... 0010 . . . 1 .... @3same
 VQSUB_U_3s       1111 001 1 0 . .. .... .... 0010 . . . 1 .... @3same
 
@@ -86,6 +92,9 @@ VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
 VMIN_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 1 .... @3same
 VMIN_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 1 .... @3same
 
+VABD_S_3s        1111 001 0 0 . .. .... .... 0111 . . . 0 .... @3same
+VABD_U_3s        1111 001 1 0 . .. .... .... 0111 . . . 0 .... @3same
+
 VADD_3s          1111 001 0 0 . .. .... .... 1000 . . . 0 .... @3same
 VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
 
-- 
2.20.1


