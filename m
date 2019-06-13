Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157BBC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31A321721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrF6EXLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31A321721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPfQ-0004EY-3v
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59371)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOda-0008HD-0f
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdU-0004aI-Kc
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:25 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:35887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdU-0004Ta-5q
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id u8so9889522wmm.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RdrTqHHHmaF6iJZ3JzcpCUEEhs68e3HO51ReGF+FJxk=;
 b=FrF6EXLBlhmi/P/C603R3jpIcAxrN0lBj9lMba00Au+xRY8Ju/9A9PV2aamyblfIMK
 8AG4Z34icAHqpHFeh+AvtmMWoTb8N4P14bbmfemeaTP2PXRgtI1ACWVQaZFyMA8TATCP
 GaQO2ZUG79U4gEhwjJHDWBtVmt0HIS3FQnIHvPwHlb9/KT6ahQG7VKQH8bO4QFRBJHDF
 ZrkDkuR7GdDeFGvmUIpAIYdXWM0qU7eTxvA2pMGJ6Ql8JlbCC8jTWb7Ke3gAVcyQ+AKt
 MELQ5uecAZ1LWWpOYJb2Ix0FRuFxS0kZAgs+fZSgkSiJnHH+CplIK9Ofq4aT9UGVAKJT
 ZP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RdrTqHHHmaF6iJZ3JzcpCUEEhs68e3HO51ReGF+FJxk=;
 b=fNvxnB8CtGcdA9Xj9OI1bYhWLrGEUqRPpnFthxsDG34C6kUrmylb019c6hIROQWWfe
 1JscZtKsIktTXAD1T4fzidAbXcE7cKXhFUlMi8mnmV1lAahHOqht53Iv87+ZXwcH7Plq
 DsBZP77tOOvILbEGmkJoGKkJLsdTvYZj/KxuBAUypXMIL7RBC4GFqnZt2lmpRuJmt2zW
 K4nx/57PZr930Wa9fkAnVKgmCFL5LVkFQlF2m13EgWY1t16OdnO+rOy5rB259uRbjJGh
 4Sy7nG5U+pT16uVbjj7eAH/LcKAt2TK9ZC3qAMPuchz6AKG7e/lZLiXSRIDfthRy22Mp
 5tww==
X-Gm-Message-State: APjAAAXKCkdJ7AR9/rNiF02iE7Gu8a6ym4yGvgXeH/Tm+YgH+aa3hTtp
 8r/Rzxrb6cEvsbbc+I66zSpSEeD1sI3dbA==
X-Google-Smtp-Source: APXvYqxYg2221qN2NH2uSZdj0x5gQYBQ/o/AFWeI40nrj/U2laK17XshMQJQj8M8tD8dHc57XDRdrQ==
X-Received: by 2002:a1c:452:: with SMTP id 79mr3640062wme.149.1560428116130;
 Thu, 13 Jun 2019 05:15:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:23 +0100
Message-Id: <20190613121433.5246-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PULL 38/48] target/arm: Convert VMOV (register) to
 decodetree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         |  8 +-------
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index ae2f77a873b..a7e4ae31985 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1889,6 +1889,16 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
     return true;
 }
 
+static bool trans_VMOV_reg_sp(DisasContext *s, arg_VMOV_reg_sp *a)
+{
+    return do_vfp_2op_sp(s, tcg_gen_mov_i32, a->vd, a->vm);
+}
+
+static bool trans_VMOV_reg_dp(DisasContext *s, arg_VMOV_reg_dp *a)
+{
+    return do_vfp_2op_dp(s, tcg_gen_mov_i64, a->vd, a->vm);
+}
+
 static bool trans_VABS_sp(DisasContext *s, arg_VABS_sp *a)
 {
     return do_vfp_2op_sp(s, gen_helper_vfp_abss, a->vd, a->vm);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b0fd4051f1f..b26242d3498 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3090,7 +3090,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 1 ... 3:
+                case 0 ... 3:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3103,9 +3103,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             if (op == 15) {
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
-                case 0x00: /* vmov */
-                    break;
-
                 case 0x04: /* vcvtb.f64.f16, vcvtb.f32.f16 */
                 case 0x05: /* vcvtt.f64.f16, vcvtt.f32.f16 */
                     /*
@@ -3278,9 +3275,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 0: /* cpy */
-                        /* no-op */
-                        break;
                     case 4: /* vcvtb.f32.f16, vcvtb.f64.f16 */
                     {
                         TCGv_ptr fpst = get_fpstatus_ptr(false);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 2780e1ed9ea..b72ab8b8067 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -157,6 +157,11 @@ VMOV_imm_sp  ---- 1110 1.11 imm4h:4 .... 1010 0000 imm4l:4 \
 VMOV_imm_dp  ---- 1110 1.11 imm4h:4 .... 1011 0000 imm4l:4 \
              vd=%vd_dp
 
+VMOV_reg_sp  ---- 1110 1.11 0000 .... 1010 01.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VMOV_reg_dp  ---- 1110 1.11 0000 .... 1011 01.0 .... \
+             vd=%vd_dp vm=%vm_dp
+
 VABS_sp      ---- 1110 1.11 0000 .... 1010 11.0 .... \
              vd=%vd_sp vm=%vm_sp
 VABS_dp      ---- 1110 1.11 0000 .... 1011 11.0 .... \
-- 
2.20.1


