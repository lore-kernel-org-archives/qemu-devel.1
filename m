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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A29C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D135122D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQQ1ZVTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D135122D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0V4l-0004y1-GU
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URL-0001E1-3V
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URJ-0007b1-PD
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:30 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:39258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URJ-0007ZQ-L2
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:29 -0400
Received: by mail-yb1-xb41.google.com with SMTP id s142so1341277ybc.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hFsqTxXX8rsrnf3xHudaOJA2J0Kvvq2y/vZUzrj1f20=;
 b=cQQ1ZVTcTBv8Uj6li4mk6ryBIR5zQQgliyaoqbyowP5pn9LBxc3agOclMK7x9C6PeD
 yCdPEbCZmkery0Zhv+zSj3rTWxgInPchZOyMpZjFwACidgLpcoWmV5zA4vnEzgIMDJ/h
 axg9HwbOwS9AO1QsFXxtbFo16+G8rbWXv1eVxjsxe1VeI2DpXUs6pO2mzChwgYjpU026
 gS/0K8K9mhsle0voO+e1DaK/KrvDbPw3LUxVYXTcCoYByddbidA8S7K2Rny7DcM2/6AJ
 HtkYba53xXI19W9RwcSluppljL1pzIHpzeQXdy5MdYBJZHeSPq4mUxQJTR7/HZxPCAz9
 f1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hFsqTxXX8rsrnf3xHudaOJA2J0Kvvq2y/vZUzrj1f20=;
 b=lAQukZTKuVJpwkPCnVEtDWJ0LWGTS5AkKJp5AaUqaZX4YAcFkSxdBhFP2QL9WVBSdb
 7r6P3jxQRzOw/CLsPwqH1Q7BSPIamRlEeixlD9PDoSoiBUighKNVle/dIZd6yc7QxJ29
 nAozX9wbL65KUdmbWxobu86KpN48A/ybfV6oCFNmWlMkQ1HOUmhsSZ8cMqJCuWEZbP6g
 ZDsaDIEWpeeTK0Y6cZGIPtz/imunx/lfg0C6xms8nAoXifb+rmTUblAkEhsuu3zOpzYi
 ulKUDghLSibsI/uhcAyxf9ribpo1iU821cWUbzlXKJLpGwr4l8yFiMrgzM+bI+3vXxHl
 diZw==
X-Gm-Message-State: APjAAAVQQhenk62j6uiFpMMfoN7i90Y1ydu/RJQqalGfGJfzc+nzOvV+
 /OekY8PuDiRpU0WMESFCJIm1dQiJ
X-Google-Smtp-Source: APXvYqxmjOtU0//ZaXx+NhkHAhUPbeWbu2XjIlc1QD4mkVt6rUh5ZjYZkDKh2Po4fxjLxcuGZpkmmg==
X-Received: by 2002:a25:76ca:: with SMTP id r193mr26498443ybc.33.1566408628987; 
 Wed, 21 Aug 2019 10:30:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:28 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:04 -0400
Message-Id: <20190821172951.15333-29-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v4 28/75] target/i386: introduce P*, N*,
 Q* (MMX) operands
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

These address the MMX-technology register file; the corresponding
cpu_env offset is passed as the operand value. Notably, offset of the
entire register is pased at all times, regardless of the operand-size
suffix.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 80 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index d6d32c7f06..815354f12b 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5032,6 +5032,86 @@ INSNOP_LDST(tcg_i64, Mq)
     }
 }
 
+/*
+ * MMX-technology register operands
+ */
+typedef unsigned int insnop_arg_t(mm);
+typedef struct {} insnop_ctxt_t(mm);
+
+INSNOP_INIT(mm)
+{
+    return true;
+}
+INSNOP_PREPARE(mm)
+{
+    return offsetof(CPUX86State, mmx_t0);
+}
+INSNOP_FINALIZE(mm)
+{
+}
+
+#define DEF_INSNOP_MM(opT, opTmmid)                                     \
+    typedef insnop_arg_t(mm) insnop_arg_t(opT);                         \
+    typedef struct {                                                    \
+        insnop_ctxt_t(opTmmid) mmid;                                    \
+    } insnop_ctxt_t(opT);                                               \
+                                                                        \
+    INSNOP_INIT(opT)                                                    \
+    {                                                                   \
+        return insnop_init(opTmmid)(&ctxt->mmid, env, s, modrm, is_write); \
+    }                                                                   \
+    INSNOP_PREPARE(opT)                                                 \
+    {                                                                   \
+        const insnop_arg_t(opTmmid) mmid =                              \
+            insnop_prepare(opTmmid)(&ctxt->mmid, env, s, modrm, is_write); \
+        const insnop_arg_t(opT) arg =                                   \
+            offsetof(CPUX86State, fpregs[mmid & 7].mmx);                \
+        insnop_finalize(opTmmid)(&ctxt->mmid, env, s, modrm, is_write, mmid); \
+        return arg;                                                     \
+    }                                                                   \
+    INSNOP_FINALIZE(opT)                                                \
+    {                                                                   \
+    }
+
+DEF_INSNOP_MM(P, modrm_reg)
+DEF_INSNOP_ALIAS(Pq, P)
+
+DEF_INSNOP_MM(N, modrm_rm_direct)
+DEF_INSNOP_ALIAS(Nd, N)
+DEF_INSNOP_ALIAS(Nq, N)
+
+DEF_INSNOP_LDST(MQd, mm, Md)
+DEF_INSNOP_LDST(MQq, mm, Mq)
+DEF_INSNOP_EITHER(Qd, Nd, MQd)
+DEF_INSNOP_EITHER(Qq, Nq, MQq)
+
+INSNOP_LDST(mm, Md)
+{
+    const insnop_arg_t(mm) ofs = offsetof(MMXReg, MMX_L(0));
+    const TCGv_i32 r32 = tcg_temp_new_i32();
+    if (is_write) {
+        tcg_gen_ld_i32(r32, cpu_env, arg + ofs);
+        tcg_gen_qemu_st_i32(r32, ptr, s->mem_index, MO_LEUL);
+    } else {
+        tcg_gen_qemu_ld_i32(r32, ptr, s->mem_index, MO_LEUL);
+        tcg_gen_st_i32(r32, cpu_env, arg + ofs);
+    }
+    tcg_temp_free_i32(r32);
+}
+INSNOP_LDST(mm, Mq)
+{
+    const insnop_arg_t(mm) ofs = offsetof(MMXReg, MMX_Q(0));
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+    if (is_write) {
+        tcg_gen_ld_i64(r64, cpu_env, arg + ofs);
+        tcg_gen_qemu_st_i64(r64, ptr, s->mem_index, MO_LEQ);
+    } else {
+        tcg_gen_qemu_ld_i64(r64, ptr, s->mem_index, MO_LEQ);
+        tcg_gen_st_i64(r64, cpu_env, arg + ofs);
+    }
+    tcg_temp_free_i64(r64);
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


