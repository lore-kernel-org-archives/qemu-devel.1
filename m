Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E8EC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC87206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n43rhKr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC87206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5cK-0003Bd-Qn
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dd-0006HU-3Z
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Db-0000C4-2N
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:24 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:46377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DZ-00008f-4l
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:21 -0400
Received: by mail-yw1-xc41.google.com with SMTP id w10so281790ywa.13
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N7ct2S1EUw6i0gNejU7gxLZfhyQRJ8jeuhEiYT8J/DA=;
 b=n43rhKr3GD9IGgRwIIUR5lTOHc6YjNkYr3sKl1jdA0KovphV0j/6nSXaolP2WHGe9z
 tfOSmm9p4q/Rf+SUcluTrHLM6ZOru4itrglgOMpNeIGX70JPCIxGDcFXuseVfjoGldZq
 H+8+WYTtOOZLWCNMsXJ3OTBeFewzhqoQUuDeeFJul6nvwYA+XnB47fb8Hx6npyjelFzV
 H7t9Y7fUa4zfYExtQ+YBpc2L0wh+RqGmJZJUoDOL3uhQ2Og6PPC8w2IV9BChSKMbkNNu
 V7HUuwcCanXXumNQA3dID5jk2vSo09tYg+P8NzbfDwzkn/hMmaEbUIgmrUwVy2XX+xGf
 iEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N7ct2S1EUw6i0gNejU7gxLZfhyQRJ8jeuhEiYT8J/DA=;
 b=F+MWRiABv1bFx5DE949o5oVQU0MaYvSGTvTrAT7prL9TbQsa7mKcHIe3YfRbXuYwYg
 ht/SuEjkt5d/mMQ1G1DlUojqc5jD6lYIXrv910J9hwd4RHLMtqbnJ5+wzEzPRB3WCnDF
 B7N9gNpbQiy94+7EMOTf6VoLSIKyNz5TXyWmWg8+X4ODSiFVEMK6LWNrrHLTs8NnHb3I
 HrWiCC1s+TgsA9Xmh4nkifATasV2bsJ0ENTzPztOzc391lMgewtZ4A8b2oWxshr9aB39
 5lbrPAun6kdd8En2wPZSEaISGfEEKVzqUpFyhxZSW9DytLQqPX6DSs90vjsdL5qw7NsU
 rf5A==
X-Gm-Message-State: APjAAAUFx2N/X7WY3FisKxeguxm+rDrGAeCS6+EEi36MjG5XIiF5E72h
 LwDwL978J1PSRJ9fgfIhTjaS1jf7
X-Google-Smtp-Source: APXvYqyTXnXSQyEuOghehO33gpqmQCAstMOZbKS5DesecJRC2XISaaP1oZT23deH7CyNwdxqV1ubYQ==
X-Received: by 2002:a81:4b17:: with SMTP id y23mr1568169ywa.240.1565835019577; 
 Wed, 14 Aug 2019 19:10:19 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:18 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:09 -0400
Message-Id: <20190815020928.9679-28-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RFC PATCH v3 27/46] target/i386: introduce G*, R*,
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
 target/i386/translate.c | 78 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 2374876b38..779b692942 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4933,6 +4933,84 @@ DEF_INSNOP_ALIAS(Mq, M)
 DEF_INSNOP_ALIAS(Mdq, M)
 DEF_INSNOP_ALIAS(Mqq, M)
 
+/*
+ * 32-bit general register operands
+ */
+DEF_INSNOP_LDST(Gd, tcg_temp_i32, modrm_reg)
+DEF_INSNOP_LDST(Rd, tcg_temp_i32, modrm_rm_direct)
+
+INSNOP_LDST(tcg_temp_i32, modrm_reg)
+{
+    assert(0 <= ptr && ptr < CPU_NB_REGS);
+    if (is_write) {
+        tcg_gen_extu_i32_tl(cpu_regs[ptr], arg);
+    } else {
+        tcg_gen_trunc_tl_i32(arg, cpu_regs[ptr]);
+    }
+}
+INSNOP_LDST(tcg_temp_i32, modrm_rm_direct)
+{
+    insnop_ldst(tcg_temp_i32, modrm_reg)(env, s, modrm, is_write, arg, ptr);
+}
+
+DEF_INSNOP_LDST(MEd, tcg_temp_i32, Md)
+DEF_INSNOP_EITHER(Ed, Rd, MEd)
+DEF_INSNOP_LDST(MRdMw, tcg_temp_i32, Mw)
+DEF_INSNOP_EITHER(RdMw, Rd, MRdMw)
+
+INSNOP_LDST(tcg_temp_i32, Md)
+{
+    if (is_write) {
+        tcg_gen_qemu_st_i32(arg, ptr, s->mem_index, MO_LEUL);
+    } else {
+        tcg_gen_qemu_ld_i32(arg, ptr, s->mem_index, MO_LEUL);
+    }
+}
+INSNOP_LDST(tcg_temp_i32, Mw)
+{
+    if (is_write) {
+        tcg_gen_qemu_st_i32(arg, ptr, s->mem_index, MO_LEUW);
+    } else {
+        tcg_gen_qemu_ld_i32(arg, ptr, s->mem_index, MO_LEUW);
+    }
+}
+
+/*
+ * 64-bit general register operands
+ */
+DEF_INSNOP_LDST(Gq, tcg_temp_i64, modrm_reg)
+DEF_INSNOP_LDST(Rq, tcg_temp_i64, modrm_rm_direct)
+
+INSNOP_LDST(tcg_temp_i64, modrm_reg)
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
+INSNOP_LDST(tcg_temp_i64, modrm_rm_direct)
+{
+    insnop_ldst(tcg_temp_i64, modrm_reg)(env, s, modrm, is_write, arg, ptr);
+}
+
+DEF_INSNOP_LDST(MEq, tcg_temp_i64, Mq)
+DEF_INSNOP_EITHER(Eq, Rq, MEq)
+
+INSNOP_LDST(tcg_temp_i64, Mq)
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


