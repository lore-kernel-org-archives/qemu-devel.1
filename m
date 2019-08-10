Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170C7C32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22B32166E
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg6/+3s2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22B32166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34901 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIsu-0008QH-3t
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34892)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl4-0006GS-Fk
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl3-0004Sq-EA
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:34 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIl3-0004Sh-9f
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:33 -0400
Received: by mail-ot1-x341.google.com with SMTP id b7so90234805otl.11
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZzNqi122k+7Jd9BKz3dezcAE/xj5VfNz4Zoq5N5DAcM=;
 b=Vg6/+3s2vhIMRi5WeVr7xkzHVwLxNkBt25TILLQwR23tsVixPRxuLv14k3OX+OOkR9
 cHGj/2ugNC/vfOglccb1JWwNDLU23BQncctmN1hPIjoggZWB1lOTIJ6qjhvK98l6ouAV
 0x7fLA5geECuCizVWZYwer1ImTnk7sy660tG0FLzaABmDPtOfcjdkz2GNFwPS+NtoLTX
 8moJR9g9DE689/nMiV61mQiF1KsyckKojxYcvtmY/iK3uU1h8gBRR7I5gYD5kLkIHbvb
 L0/4W1u3FvjeQO+OttzVrqeW6Ikysyy8yp6q0jm6DsL7XiTcjMeU34JYDGrO2QvTjlZ9
 F7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZzNqi122k+7Jd9BKz3dezcAE/xj5VfNz4Zoq5N5DAcM=;
 b=To0VcdO7l7RU4Ar0jd2fUO0xaioQW4ffwV9LvNvI7gcJ+ueYlPk4ipDONgcYVug6sA
 WpSI1FNWkqtDShgYzzEUyckgHgZ85CL9b8HomjIIO2keQvFyy1n1KQ8kEEzeTvmlc7Q4
 sEc31b9s+bsmQMsRUYWaEGH7OZzx+17U6vogfW5JazUDehJqp/KtgkqzlDyR3aWBXiKU
 iRfiWqgan3U1V+WfTuGOrhHpd3Hf0bRKeYMWb589e6YAqURXjqajpsrz4luSd4Z8uo0K
 lW1ozsdxB1+MbTEbJV6nKnhP0ahSRcTzOmJmu8tVkvrXV5iMR1GhGcpiGB0YHQQCojg/
 KRsw==
X-Gm-Message-State: APjAAAV7yRmNl5K5ghdsBuCHKGky2qUk4eFdjFIRxayZk/YbikL55oYB
 povihtJzuhqtKWzCVPWWvOjYxsiE
X-Google-Smtp-Source: APXvYqzEESjl+Oxl6Rr2UqB7fjwlTJr1AQcQQJ76CX5Tqcle5suHxuuU3LO5wMYNfljmnOKTIFMx1w==
X-Received: by 2002:aca:4256:: with SMTP id p83mr8914903oia.125.1565410412505; 
 Fri, 09 Aug 2019 21:13:32 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:32 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:42 -0400
Message-Id: <20190810041255.6820-27-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [RFC PATCH v2 26/39] target/i386: introduce G*, R*,
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
 target/i386/translate.c | 65 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 301dc4eddf..0e57d5f049 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4730,6 +4730,71 @@ INSNOP_ALIAS(Md, M)
 INSNOP_ALIAS(Mdq, M)
 INSNOP_ALIAS(Mqq, M)
 
+/*
+ * General registers
+ */
+#define INSNOP_R32(opT, regid_fp, init_stmt)                    \
+    INSNOP(                                                     \
+        opT, TCGv_i32, init_stmt,                               \
+        do {                                                    \
+            const int regid = regid_fp(env, s, modrm);          \
+            tcg_gen_trunc_tl_i32(*op, cpu_regs[regid]);         \
+        } while (0),                                            \
+        do {                                                    \
+            const int regid = regid_fp(env, s, modrm);          \
+            tcg_gen_extu_i32_tl(cpu_regs[regid], *op);          \
+        } while (0))
+
+#define INSNOP_R64(opT, regid_fp, init_stmt)                    \
+    INSNOP(                                                     \
+        opT, TCGv_i64, init_stmt,                               \
+        do {                                                    \
+            const int regid = regid_fp(env, s, modrm);          \
+            tcg_gen_mov_i64(*op, cpu_regs[regid]);              \
+        } while (0),                                            \
+        do {                                                    \
+            const int regid = regid_fp(env, s, modrm);          \
+            tcg_gen_mov_i64(cpu_regs[regid], *op);              \
+        } while (0))
+
+#ifdef TARGET_X86_64
+INSNOP_R32(Gd, decode_modrm_reg_rexr, INSNOP_INIT_OK(s->tmp2_i32))
+INSNOP_R64(Gq, decode_modrm_reg_rexr, INSNOP_INIT_OK(s->T1))
+
+INSNOP_R32(Rd, decode_modrm_rm_rexb,
+           INSNOP_INIT_DIRECT_ONLY(INSNOP_INIT_OK(s->tmp3_i32)))
+INSNOP_R64(Rq, decode_modrm_rm_rexb,
+           INSNOP_INIT_DIRECT_ONLY(INSNOP_INIT_OK(s->T0)))
+#else /* !TARGET_X86_64 */
+INSNOP_R32(Gd, decode_modrm_reg_rexr, INSNOP_INIT_OK(s->T1))
+INSNOP(Gq, TCGv_i64, INSNOP_INIT_FAIL,
+       INSNOP_PREPARE_INVALID, INSNOP_FINALIZE_INVALID)
+
+INSNOP_R32(Rd, decode_modrm_rm_rexb,
+           INSNOP_INIT_DIRECT_ONLY(INSNOP_INIT_OK(s->T0)))
+INSNOP(Rq, TCGv_i64, INSNOP_INIT_FAIL,
+       INSNOP_PREPARE_INVALID, INSNOP_FINALIZE_INVALID)
+#endif /* !TARGET_X86_64 */
+
+#ifdef TARGET_X86_64
+INSNOP_LDST(RdMd, Rd, Md, s->tmp3_i32,
+            tcg_gen_qemu_ld_i32(reg, ptr, s->mem_index, MO_LEUL),
+            tcg_gen_qemu_st_i32(reg, ptr, s->mem_index, MO_LEUL))
+INSNOP_LDST(RqMq, Rq, Mq, s->T0,
+            tcg_gen_qemu_ld_i64(reg, ptr, s->mem_index, MO_LEQ),
+            tcg_gen_qemu_st_i64(reg, ptr, s->mem_index, MO_LEQ))
+#else /* !TARGET_X86_64 */
+INSNOP_LDST(RdMd, Rd, Md, s->T0,
+            tcg_gen_qemu_ld_i32(reg, ptr, s->mem_index, MO_LEUL),
+            tcg_gen_qemu_st_i32(reg, ptr, s->mem_index, MO_LEUL))
+INSNOP_LDST(RqMq, Rq, Mq, NULL,
+            INSNOP_PREPARE_INVALID,
+            INSNOP_FINALIZE_INVALID)
+#endif /* !TARGET_X86_64 */
+
+INSNOP_LDST_UNIFY(Ed, Rd, RdMd)
+INSNOP_LDST_UNIFY(Eq, Rq, RqMq)
+
 /*
  * Code generators
  */
-- 
2.20.1


