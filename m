Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57279C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F09F214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LRRMr0DB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F09F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33Vz-0001fs-Jm
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33G3-0003PV-Go
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33G2-00005z-47
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:27 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33G1-0008Vo-Q3
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:25 -0400
Received: by mail-pg1-x542.google.com with SMTP id p3so210614pgb.9
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mEt0ovniA8TTjKeMb0D1ZbNJS4Vt4wC0E+O60CpepFo=;
 b=LRRMr0DBNj4ZvFE58LSrUeLNN0WHIqoy8J5VQw0s0wh/LoDixtLa6m8KxR7CKpBmWQ
 ijXJPH6zjqVcn720ikSxS9EAkYAE6CyHIYxDN0NaVSoEN7zFWYeK3osjR1RalNw3oE63
 mq7XUvNvk4ud9y37C7N4QrFH1cZsSEllaE14G+vwsgS9KZyAowTBIsS9e1vYWM/U4sXh
 envNwGqCVVgPnVqDV0ly+MUb4lMB6Y/vhVEDiamq5wxr4KEyGQj9zQ1nFa909LeGlNLs
 KoLdEtMXUcKv+wUP8xQ1LLjrozzhYrARxuCoVJgoM9qQ1mciiK04XYCGrr7sCwSpQNgQ
 6ciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mEt0ovniA8TTjKeMb0D1ZbNJS4Vt4wC0E+O60CpepFo=;
 b=oKYjdX98MurZ9Eq2tUiLHSQi/7Hafb/QJVyQ/dw+KGD62R1t96P0Exy7HniucS3beJ
 3dPEDofVg9HrBL26m84aeiQknhYUq65e9aJtFFMq6BG2JMP7YbFQQcNxgF54dH0HwX92
 0hKG8cR6I1CA7KnUtHwQiudPW9EpO0OKYIOoCMog4TNZCz0dhv1g/q5qpzurXXB+ZLDH
 MabwW+KeOT5BEeP52oNkNru2ka2MuH7VBqiTiKJk7vnWyiH+FAv8A9kTAG2Ssbc3uhQS
 XY7ythQk3tLhFeaVCw2rcVE7W3cXb7PPTvlghgySKh7QDfHTOdhN4msbrvjLrfIFreeu
 EBAg==
X-Gm-Message-State: APjAAAVmKFUnvXO6NVwygExriPYbjcBRRC0OWuuQ9yqOctDiAPSfYv0Z
 gQzT7xoQyYRWsvdLfePzInX4zzADzTs=
X-Google-Smtp-Source: APXvYqxz+EnhGQV36A97X98pRqK0LchjqSEfu0zaOjAXytB1VDs8I+fE6LMcVGMDFxU1qWj6oaditw==
X-Received: by 2002:a63:a302:: with SMTP id s2mr4797000pge.125.1567019124364; 
 Wed, 28 Aug 2019 12:05:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:06 -0700
Message-Id: <20190828190456.30315-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v3 19/69] target/arm: Convert T32 ADDW/SUBW
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 24 +++++++++++++-----------
 target/arm/a32.decode  |  1 +
 target/arm/t32.decode  | 19 +++++++++++++++++++
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ad4b3c55c6..257ee6b5ea 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7622,6 +7622,11 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
  * Constant expanders for the decoders.
  */
 
+static int negate(DisasContext *s, int x)
+{
+    return -x;
+}
+
 static int times_2(DisasContext *s, int x)
 {
     return x * 2;
@@ -7978,6 +7983,12 @@ static bool trans_ORN_rri(DisasContext *s, arg_s_rri_rot *a)
 #undef DO_ANY2
 #undef DO_CMP2
 
+static bool trans_ADR(DisasContext *s, arg_ri *a)
+{
+    store_reg_bx(s, a->rd, add_reg_for_lit(s, 15, a->imm));
+    return true;
+}
+
 /*
  * Multiply and multiply accumulate
  */
@@ -10682,17 +10693,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         }
                         store_reg(s, rd, tmp);
                     } else {
-                        /* Add/sub 12-bit immediate.  */
-                        if (insn & (1 << 23)) {
-                            imm = -imm;
-                        }
-                        tmp = add_reg_for_lit(s, rn, imm);
-                        if (rn == 13 && rd == 13) {
-                            /* ADD SP, SP, imm or SUB SP, SP, imm */
-                            store_sp_checked(s, tmp);
-                        } else {
-                            store_reg(s, rd, tmp);
-                        }
+                        /* Add/sub 12-bit immediate, in decodetree */
+                        goto illegal_op;
                     }
                 }
             } else {
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index c7f156be6d..aac991664d 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -30,6 +30,7 @@
 &rrrr            rd rn rm ra
 &rrr             rd rn rm
 &rr              rd rm
+&ri              rd imm
 &r               rm
 &i               imm
 &msr_reg         rn r mask
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 5116c6165a..be4e5f087c 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -27,6 +27,7 @@
 &rrrr            !extern rd rn rm ra
 &rrr             !extern rd rn rm
 &rr              !extern rd rm
+&ri              !extern rd imm
 &r               !extern rm
 &i               !extern imm
 &msr_reg         !extern rn r mask
@@ -121,6 +122,24 @@ SBC_rri          1111 0.0 1011 . .... 0 ... .... ........     @s_rri_rot
 }
 RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
 
+# Data processing (plain binary immediate)
+
+%imm12_26_12_0   26:1 12:3 0:8
+%neg12_26_12_0   26:1 12:3 0:8 !function=negate
+@s0_rri_12       .... ... .... . rn:4 . ... rd:4 ........ \
+                 &s_rri_rot imm=%imm12_26_12_0 rot=0 s=0
+
+{
+  ADR            1111 0.1 0000 0 1111 0 ... rd:4 ........ \
+                 &ri imm=%imm12_26_12_0
+  ADD_rri        1111 0.1 0000 0 .... 0 ... .... ........     @s0_rri_12
+}
+{
+  ADR            1111 0.1 0101 0 1111 0 ... rd:4 ........ \
+                 &ri imm=%neg12_26_12_0
+  SUB_rri        1111 0.1 0101 0 .... 0 ... .... ........     @s0_rri_12
+}
+
 # Multiply and multiply accumulate
 
 @s0_rnadm        .... .... .... rn:4 ra:4 rd:4 .... rm:4      &s_rrrr s=0
-- 
2.17.1


