Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5188C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822CC2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ua3pUkWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822CC2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvE0B-0007IA-Rj
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 00:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40664)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxQ-0001E9-Ke
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxP-0004pe-LV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:52 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvDxP-0004p0-GP
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:51 -0400
Received: by mail-pf1-x443.google.com with SMTP id r1so42756480pfq.12
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 21:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4bDE+Hq+chnI8wPbuqNYe22C+ZJ9SH+TnuzWZSpaQbg=;
 b=Ua3pUkWXv2z/gC4cHUT+sHLFhoLP+71LGQbIIarkscRJMXHvRTz/AQqr1V8CKLbY/9
 ND6tXeih6OeGhS3myNqIEKDNKXKR+7R2EuBKQrVgzdClouFQ2i1OpDd4G/oeAI7ffcsY
 /l0JGZT/W8H6f1Pybp0itHvEUbpUVgUBzaW/tiFETrbU4SXjEwAfcb+U4wWQvpyFTdgq
 0J7wH6t0Co+Sgy3+iWkr6OQjbOHrmBZynzKSgrVa92L/B/tVPp0sPTv8Y+fb2Gz/3bQz
 +GihBac0ibkdWi2zOi6VQjp13rDC6BjjOs562PAxEuMf/RP5f9Kr2bAkKBtZlJf7k+jm
 zGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4bDE+Hq+chnI8wPbuqNYe22C+ZJ9SH+TnuzWZSpaQbg=;
 b=fCx163GIqaM3KQDEv2T+8mcDaP5ZapsFNLsWRYqYcxIK5WNU37K1i9fJYeHKM6m/wL
 NeZG8tcSoPYZ0YDT9IdE7k01QqODdrb4SF+yReqJ0+4X5dmJPOI7TraQn6QYKAGNRNQl
 Vk6dOQ0XclBCQOzdu4uVKbUvjVH9KxwHIOfKHxB+sfcCFjQ3ZYV4N+K6nCu5fi0xIHD+
 dg14+OIkfAP16tLHyOo8rV1XAvNaTih38EhgGhCQ8I6oU53WBQx+ckW0TBNLuy7odk0q
 IABEbfzUBireeFvFc6fB4Cu/IMN32vyP82JkTAuu9MtnS8qXkpLiBLGyceLzLRKnYNWF
 vITw==
X-Gm-Message-State: APjAAAU5cIh6PEgW19cv+FUvjIgo510s5AZshRU0y/MbVVoz1L37Qp9g
 ppSN8ms2djkjUw4G6mkX3KwW/nzE914=
X-Google-Smtp-Source: APXvYqxtDorDAw1cc/C8KP4PPNnV9ED16LJE5zcsML7JThdKJEsyqtusG5uWp+LB8uNhsAMp8S4b7w==
X-Received: by 2002:a62:1444:: with SMTP id 65mr7297001pfu.145.1565153630212; 
 Tue, 06 Aug 2019 21:53:50 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t9sm24347921pji.18.2019.08.06.21.53.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 21:53:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 21:53:29 -0700
Message-Id: <20190807045335.1361-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807045335.1361-1-richard.henderson@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 05/11] target/arm: Remove redundant s->pc & ~1
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

The thumb bit has already been removed from s->pc, and is always even.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 71d94c053b..100f958e33 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1288,7 +1288,7 @@ static void gen_exception_bkpt_insn(DisasContext *s, int offset, uint32_t syn)
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 static inline void gen_lookup_tb(DisasContext *s)
 {
-    tcg_gen_movi_i32(cpu_R[15], s->pc & ~1);
+    tcg_gen_movi_i32(cpu_R[15], s->pc);
     s->base.is_jmp = DISAS_EXIT;
 }
 
@@ -7819,7 +7819,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                  * self-modifying code correctly and also to take
                  * any pending interrupts immediately.
                  */
-                gen_goto_tb(s, 0, s->pc & ~1);
+                gen_goto_tb(s, 0, s->pc);
                 return;
             case 7: /* sb */
                 if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
@@ -7830,7 +7830,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                  * for TCG; MB and end the TB instead.
                  */
                 tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                gen_goto_tb(s, 0, s->pc & ~1);
+                gen_goto_tb(s, 0, s->pc);
                 return;
             default:
                 goto illegal_op;
@@ -10464,7 +10464,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                              * and also to take any pending interrupts
                              * immediately.
                              */
-                            gen_goto_tb(s, 0, s->pc & ~1);
+                            gen_goto_tb(s, 0, s->pc);
                             break;
                         case 7: /* sb */
                             if ((insn & 0xf) || !dc_isar_feature(aa32_sb, s)) {
@@ -10475,7 +10475,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                              * for TCG; MB and end the TB instead.
                              */
                             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-                            gen_goto_tb(s, 0, s->pc & ~1);
+                            gen_goto_tb(s, 0, s->pc);
                             break;
                         default:
                             goto illegal_op;
-- 
2.17.1


