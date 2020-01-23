Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17FAC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6C824125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwyyANqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6C824125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQ7E-0002cS-8f
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzC-00028F-40
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPz3-0001z5-NO
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPz3-0001yW-G5
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id q10so609914pfs.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zXV8kwpB1YEq5Vdk+d1pQVUnmUxRqGDEumGQUOCIABQ=;
 b=ZwyyANqxab3Ig7fd+aXEpgsoqOO6vQyoXSJ53+wjZePe5xamaZjTnG9C1B4HsVBHEy
 uDKb7gnr8bK+lCATgoSY3DycNUY+TS3TS/pbap7Q3DvKJflZB0ZTcQ+iT+aCPpNiksaf
 FTnf6Z30V7QHtuRVm5KQdKST5cmWFqBE173wlom3CXt0HtDGXW7LfhIygK+INMUPME3O
 aqxXM5hl+gaODdBBs0Z1/6SfFjCe4LjqcUzTvk32N6IuA9OndDID9vrd2IFwfWCyUWo2
 XdotgdwcX0YuJ5oRVQrJBesyyEGtQPdZ8sT56Kll+y0mHGV55HQrGOPiVFtBSj8eWf/S
 1bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zXV8kwpB1YEq5Vdk+d1pQVUnmUxRqGDEumGQUOCIABQ=;
 b=ZUxDb/DJ7c4heAxN/C49eFTv4JFiiJHBbs0Odi5DJKhMiQMIyIGh1wPolcOmSV7xA1
 fkbu9vZtdtPAT5DT/l2PKdCWNVOFxDPE7vZjmNRvvrk6Pf+dI+YlhJlDGPFnRFqb1oDX
 5mPqUZebLdphxkIiVZPb+7HMI6gefjNhf3eEKYIN42faTeadHOOrMl9peO32nfKGqxkW
 6pOU3XCJ42mUstZCMewMcj70wX1wSHRsmyubOQ2FrgCqm3qx/dmfDZ5i2b+RoshLLOp6
 2VqBMGEhsxXay/uvEQPeQuee2KslHX0jbVufo2eVB2M+xcmPtWMH6p442rIJLOd+6EXh
 MYjQ==
X-Gm-Message-State: APjAAAWBSH0Is89fIG0Ew1nzD9MeJuUtfN/4pWJ9xYkxfsbi8C0Zhg/c
 GLSp4eoQyiGv/ZzLngJ98Fsmf+VtHu0=
X-Google-Smtp-Source: APXvYqyeuAGIFhB7SdYsEVtUellqNUqnRzkz0ZfA6N7IYdewFEUt6LFI/zno2eZRVtwUmZHHCa5jsA==
X-Received: by 2002:aa7:86c3:: with SMTP id h3mr5086580pfo.225.1579737808080; 
 Wed, 22 Jan 2020 16:03:28 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:03:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 07/24] target/avr: Add instruction translation - Bit and
 Bit-test Instructions
Date: Wed, 22 Jan 2020 14:02:50 -1000
Message-Id: <20200123000307.11541-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, S.E.Harris@kent.ac.uk,
 dovgaluk@ispras.ru, imammedo@redhat.com, mrolnik@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This includes:
    - LSR, ROR
    - ASR
    - SWAP
    - SBI, CBI
    - BST, BLD
    - BSET, BCLR

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200118191416.19934-8-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/translate.c | 241 +++++++++++++++++++++++++++++++++++++++++
 target/avr/insn.decode |  14 +++
 2 files changed, 255 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 4a62d9312a..58775af17c 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2440,3 +2440,244 @@ static bool trans_LAT(DisasContext *ctx, arg_LAT *a)
 
     return true;
 }
+
+/*
+ * Bit and Bit-test Instructions
+ */
+static void gen_rshift_ZNVSf(TCGv R)
+{
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+    tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf = R(7) */
+    tcg_gen_xor_tl(cpu_Vf, cpu_Nf, cpu_Cf);
+    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
+}
+
+/*
+ *  Shifts all bits in Rd one place to the right. Bit 7 is cleared. Bit 0 is
+ *  loaded into the C Flag of the SREG. This operation effectively divides an
+ *  unsigned value by two. The C Flag can be used to round the result.
+ */
+static bool trans_LSR(DisasContext *ctx, arg_LSR *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+
+    tcg_gen_andi_tl(cpu_Cf, Rd, 1);
+    tcg_gen_shri_tl(Rd, Rd, 1);
+    /* update status register */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, Rd, 0); /* Zf = Rd == 0 */
+    tcg_gen_movi_tl(cpu_Nf, 0);
+    tcg_gen_mov_tl(cpu_Vf, cpu_Cf);
+    tcg_gen_mov_tl(cpu_Sf, cpu_Vf);
+
+    return true;
+}
+
+/*
+ *  Shifts all bits in Rd one place to the right. The C Flag is shifted into
+ *  bit 7 of Rd. Bit 0 is shifted into the C Flag.  This operation, combined
+ *  with ASR, effectively divides multi-byte signed values by two. Combined with
+ *  LSR it effectively divides multi-byte unsigned values by two. The Carry Flag
+ *  can be used to round the result.
+ */
+static bool trans_ROR(DisasContext *ctx, arg_ROR *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv t0 = tcg_temp_new_i32();
+
+    tcg_gen_shli_tl(t0, cpu_Cf, 7);
+    /* update status register */
+    tcg_gen_andi_tl(cpu_Cf, Rd, 1);
+    /* update output register */
+    tcg_gen_shri_tl(Rd, Rd, 1);
+    tcg_gen_or_tl(Rd, Rd, t0);
+    /* update status register */
+    gen_rshift_ZNVSf(Rd);
+
+    tcg_temp_free_i32(t0);
+
+    return true;
+}
+
+/*
+ *  Shifts all bits in Rd one place to the right. Bit 7 is held constant. Bit 0
+ *  is loaded into the C Flag of the SREG. This operation effectively divides a
+ *  signed value by two without changing its sign. The Carry Flag can be used to
+ *  round the result.
+ */
+static bool trans_ASR(DisasContext *ctx, arg_ASR *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv t0 = tcg_temp_new_i32();
+
+    /* update status register */
+    tcg_gen_andi_tl(cpu_Cf, Rd, 1); /* Cf = Rd(0) */
+    /* update output register */
+    tcg_gen_andi_tl(t0, Rd, 0x80); /* Rd = (Rd & 0x80) | (Rd >> 1) */
+    tcg_gen_shri_tl(Rd, Rd, 1);
+    tcg_gen_or_tl(Rd, Rd, t0);
+    /* update status register */
+    gen_rshift_ZNVSf(Rd);
+
+    tcg_temp_free_i32(t0);
+
+    return true;
+}
+
+/*
+ *  Swaps high and low nibbles in a register.
+ */
+static bool trans_SWAP(DisasContext *ctx, arg_SWAP *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv t0 = tcg_temp_new_i32();
+    TCGv t1 = tcg_temp_new_i32();
+
+    tcg_gen_andi_tl(t0, Rd, 0x0f);
+    tcg_gen_shli_tl(t0, t0, 4);
+    tcg_gen_andi_tl(t1, Rd, 0xf0);
+    tcg_gen_shri_tl(t1, t1, 4);
+    tcg_gen_or_tl(Rd, t0, t1);
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+
+    return true;
+}
+
+/*
+ *  Sets a specified bit in an I/O Register. This instruction operates on
+ *  the lower 32 I/O Registers -- addresses 0-31.
+ */
+static bool trans_SBI(DisasContext *ctx, arg_SBI *a)
+{
+    TCGv data = tcg_temp_new_i32();
+    TCGv port = tcg_const_i32(a->reg);
+
+    gen_helper_inb(data, cpu_env, port);
+    tcg_gen_ori_tl(data, data, 1 << a->bit);
+    gen_helper_outb(cpu_env, port, data);
+
+    tcg_temp_free_i32(port);
+    tcg_temp_free_i32(data);
+
+    return true;
+}
+
+/*
+ *  Clears a specified bit in an I/O Register. This instruction operates on
+ *  the lower 32 I/O Registers -- addresses 0-31.
+ */
+static bool trans_CBI(DisasContext *ctx, arg_CBI *a)
+{
+    TCGv data = tcg_temp_new_i32();
+    TCGv port = tcg_const_i32(a->reg);
+
+    gen_helper_inb(data, cpu_env, port);
+    tcg_gen_andi_tl(data, data, ~(1 << a->bit));
+    gen_helper_outb(cpu_env, port, data);
+
+    tcg_temp_free_i32(data);
+    tcg_temp_free_i32(port);
+
+    return true;
+}
+
+/*
+ *  Stores bit b from Rd to the T Flag in SREG (Status Register).
+ */
+static bool trans_BST(DisasContext *ctx, arg_BST *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+
+    tcg_gen_andi_tl(cpu_Tf, Rd, 1 << a->bit);
+    tcg_gen_shri_tl(cpu_Tf, cpu_Tf, a->bit);
+
+    return true;
+}
+
+/*
+ *  Copies the T Flag in the SREG (Status Register) to bit b in register Rd.
+ */
+static bool trans_BLD(DisasContext *ctx, arg_BLD *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv t1 = tcg_temp_new_i32();
+
+    tcg_gen_andi_tl(Rd, Rd, ~(1u << a->bit)); /* clear bit */
+    tcg_gen_shli_tl(t1, cpu_Tf, a->bit); /* create mask */
+    tcg_gen_or_tl(Rd, Rd, t1);
+
+    tcg_temp_free_i32(t1);
+
+    return true;
+}
+
+/*
+ *  Sets a single Flag or bit in SREG.
+ */
+static bool trans_BSET(DisasContext *ctx, arg_BSET *a)
+{
+    switch (a->bit) {
+    case 0x00:
+        tcg_gen_movi_tl(cpu_Cf, 0x01);
+        break;
+    case 0x01:
+        tcg_gen_movi_tl(cpu_Zf, 0x01);
+        break;
+    case 0x02:
+        tcg_gen_movi_tl(cpu_Nf, 0x01);
+        break;
+    case 0x03:
+        tcg_gen_movi_tl(cpu_Vf, 0x01);
+        break;
+    case 0x04:
+        tcg_gen_movi_tl(cpu_Sf, 0x01);
+        break;
+    case 0x05:
+        tcg_gen_movi_tl(cpu_Hf, 0x01);
+        break;
+    case 0x06:
+        tcg_gen_movi_tl(cpu_Tf, 0x01);
+        break;
+    case 0x07:
+        tcg_gen_movi_tl(cpu_If, 0x01);
+        break;
+    }
+
+    return true;
+}
+
+/*
+ *  Clears a single Flag in SREG.
+ */
+static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)
+{
+    switch (a->bit) {
+    case 0x00:
+        tcg_gen_movi_tl(cpu_Cf, 0x00);
+        break;
+    case 0x01:
+        tcg_gen_movi_tl(cpu_Zf, 0x00);
+        break;
+    case 0x02:
+        tcg_gen_movi_tl(cpu_Nf, 0x00);
+        break;
+    case 0x03:
+        tcg_gen_movi_tl(cpu_Vf, 0x00);
+        break;
+    case 0x04:
+        tcg_gen_movi_tl(cpu_Sf, 0x00);
+        break;
+    case 0x05:
+        tcg_gen_movi_tl(cpu_Hf, 0x00);
+        break;
+    case 0x06:
+        tcg_gen_movi_tl(cpu_Tf, 0x00);
+        break;
+    case 0x07:
+        tcg_gen_movi_tl(cpu_If, 0x00);
+        break;
+    }
+
+    return true;
+}
diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 3f9304f8b0..4ee55862b2 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -158,3 +158,17 @@ XCH             1001 001 rd:5 0100
 LAC             1001 001 rd:5 0110
 LAS             1001 001 rd:5 0101
 LAT             1001 001 rd:5 0111
+
+#
+# Bit and Bit-test Instructions
+#
+LSR             1001 010 rd:5 0110
+ROR             1001 010 rd:5 0111
+ASR             1001 010 rd:5 0101
+SWAP            1001 010 rd:5 0010
+SBI             1001 1010 reg:5 bit:3
+CBI             1001 1000 reg:5 bit:3
+BST             1111 101 rd:5 0 bit:3
+BLD             1111 100 rd:5 0 bit:3
+BSET            1001 0100 0 bit:3 1000
+BCLR            1001 0100 1 bit:3 1000
-- 
2.20.1


