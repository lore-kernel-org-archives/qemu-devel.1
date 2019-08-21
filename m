Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9066C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EB722CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP7ysIsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EB722CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Up1-0000dQ-GS
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URK-0001DA-FY
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URJ-0007YV-7W
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:30 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:41465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URJ-0007WI-0o
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:29 -0400
Received: by mail-yb1-xb43.google.com with SMTP id 1so900358ybj.8
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jd8mPhTXyu3w3ABGcqRNH3LYLJveHqDWxHnZ8Lape/8=;
 b=jP7ysIsN/bVRk/QyuJYmCiMyqFOY7hTv+TvYWsGKQ7EfEgP9tBgULbq3TTQnFUqbrK
 0LYTeViICcvPW/TDDX6btygmQM4NmCaGh9/oIbqOb77Xm9xFwlg1yRbwUuQs1DuDqHzo
 6BTBrgOenh5yht5j6D+tTgUpztcMY4DquEADQQwoPpfJ5evl8JXfHV92EauaN0gc87Z8
 NXnkyfjHfAz3arZqq9AlFtiIX7vCKMefwjTHWaR9N7azFynXaSuF+O49aLYaC2GjC7Ze
 PMbhqpchBryLsp60S4Vu78CxYo1lqrTmJCYQGlPvMHoYCWU8ajfVxj+ObXbg2OVvOkke
 Nr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jd8mPhTXyu3w3ABGcqRNH3LYLJveHqDWxHnZ8Lape/8=;
 b=RyqEVsFTnkDHnXrKdvZ7oWshPeK0oj+p5cYATSLV67Cm7geKJBOxU5pvEV6kNPvNwM
 /hndyQZEzLJ08NDhMrA2TrtwqBY4pd4RfAl7ynRkdaz/mbbTxsbujOAPj9QIsLP5FPKV
 +V+d5JwtQIgF1yHFG9AqQjenGMrbQJCRoZqhp4fnDqIJNjaxKmjDQW41MP8cFXZGnKH6
 LZShP/DgCU2O+wUsm7/IpqD8xOx5odCD3kSHn5LQztoSMDy184kQl7GYu+edF9v86sLZ
 DsoaQ2ZQXDzMttueuETc5DK3F10pLvaBDmoVJcGZitxNl/8dtn+BQHUg0/knUyhdE+3p
 HCDw==
X-Gm-Message-State: APjAAAU5WlBUbM4qLT/e5BtkCLY30cgcx31v31uWgvStHeRSvbej025E
 VAdO7ftFuzS2rKUbephjDhJc8p0N
X-Google-Smtp-Source: APXvYqxhpL/8P/NOnHQy5Yy1bHNxWj+oqgyOClCV6zDJ1BH0Ad9OBAu68jhsBYJR/hpYuYafn8KAqg==
X-Received: by 2002:a25:888a:: with SMTP id d10mr24839501ybl.308.1566408627731; 
 Wed, 21 Aug 2019 10:30:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:27 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:03 -0400
Message-Id: <20190821172951.15333-28-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v4 27/75] target/i386: introduce G*, R*,
 E* (general register) operands
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These address the general-purpose register file. The corresponding
32-bit or 64-bit register is passed as the operand value.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 88 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 46c41cc3be..d6d32c7f06 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4944,6 +4944,94 @@ DEF_INSNOP_ALIAS(Mq, M)
 DEF_INSNOP_ALIAS(Mdq, M)
 DEF_INSNOP_ALIAS(Mqq, M)
 
+/*
+ * 32-bit general register operands
+ */
+DEF_INSNOP_LDST(Gd, tcg_i32, modrm_reg)
+DEF_INSNOP_LDST(Rd, tcg_i32, modrm_rm_direct)
+
+INSNOP_LDST(tcg_i32, modrm_reg)
+{
+    assert(0 <= ptr && ptr < CPU_NB_REGS);
+    if (is_write) {
+        tcg_gen_extu_i32_tl(cpu_regs[ptr], arg);
+    } else {
+        tcg_gen_trunc_tl_i32(arg, cpu_regs[ptr]);
+    }
+}
+INSNOP_LDST(tcg_i32, modrm_rm_direct)
+{
+    insnop_ldst(tcg_i32, modrm_reg)(env, s, is_write, arg, ptr);
+}
+
+DEF_INSNOP_LDST(MEd, tcg_i32, Md)
+DEF_INSNOP_EITHER(Ed, Rd, MEd)
+DEF_INSNOP_LDST(MRdMw, tcg_i32, Mw)
+DEF_INSNOP_EITHER(RdMw, Rd, MRdMw)
+DEF_INSNOP_LDST(MRdMb, tcg_i32, Mb)
+DEF_INSNOP_EITHER(RdMb, Rd, MRdMb)
+
+INSNOP_LDST(tcg_i32, Md)
+{
+    if (is_write) {
+        tcg_gen_qemu_st_i32(arg, ptr, s->mem_index, MO_LEUL);
+    } else {
+        tcg_gen_qemu_ld_i32(arg, ptr, s->mem_index, MO_LEUL);
+    }
+}
+INSNOP_LDST(tcg_i32, Mw)
+{
+    if (is_write) {
+        tcg_gen_qemu_st_i32(arg, ptr, s->mem_index, MO_LEUW);
+    } else {
+        tcg_gen_qemu_ld_i32(arg, ptr, s->mem_index, MO_LEUW);
+    }
+}
+INSNOP_LDST(tcg_i32, Mb)
+{
+    if (is_write) {
+        tcg_gen_qemu_st_i32(arg, ptr, s->mem_index, MO_UB);
+    } else {
+        tcg_gen_qemu_ld_i32(arg, ptr, s->mem_index, MO_UB);
+    }
+}
+
+/*
+ * 64-bit general register operands
+ */
+DEF_INSNOP_LDST(Gq, tcg_i64, modrm_reg)
+DEF_INSNOP_LDST(Rq, tcg_i64, modrm_rm_direct)
+
+INSNOP_LDST(tcg_i64, modrm_reg)
+{
+#ifdef TARGET_X86_64
+    assert(0 <= ptr && ptr < CPU_NB_REGS);
+    if (is_write) {
+        tcg_gen_mov_i64(cpu_regs[ptr], arg);
+    } else {
+        tcg_gen_mov_i64(arg, cpu_regs[ptr]);
+    }
+#else /* !TARGET_X86_64 */
+    g_assert_not_reached();
+#endif /* !TARGET_X86_64 */
+}
+INSNOP_LDST(tcg_i64, modrm_rm_direct)
+{
+    insnop_ldst(tcg_i64, modrm_reg)(env, s, is_write, arg, ptr);
+}
+
+DEF_INSNOP_LDST(MEq, tcg_i64, Mq)
+DEF_INSNOP_EITHER(Eq, Rq, MEq)
+
+INSNOP_LDST(tcg_i64, Mq)
+{
+    if (is_write) {
+        tcg_gen_qemu_st_i64(arg, ptr, s->mem_index, MO_LEQ);
+    } else {
+        tcg_gen_qemu_ld_i64(arg, ptr, s->mem_index, MO_LEQ);
+    }
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


