Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F284AC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C91208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+HEd8Za"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C91208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33c0-0000d0-E1
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33G9-0003YE-Kg
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33G5-00009u-2H
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:33 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43301)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33G4-000093-Fb
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id k3so208632pgb.10
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kNBzQqD3B3o9SigDT6/pOwcq0pjl71BBo/Z7OB5fHLw=;
 b=L+HEd8Za5HBL2aQXB04r4C6y2WqX15WdSkUFLkn0Ree+Ds2syj1ydeZFd9Ti/2Ik84
 XpUonOw6d9uEc3mccH8XnrVmVeDVV36t+IrdRZGKonwSY4ySbxQur0ywoEdtEgnjuP3p
 L75KybpQNHD5Vb1GPqQ3wT+6ixLURDgmJS1KuLv18C1jduF9mQfF7uOqbAv1P2GNfFJC
 PYxxPjWCvNpTkXYIFBensVg7ziVSNbBK62N1NIClbsQuiB1sBJFBYNAMIptAOgQZhAMm
 C1DEE45iWo0Iw6ds+9B3gZ/YjNXIQ4J+w7uZ6c0LTgxg3HO9WETaQ6dVWePnBNvUODPM
 HeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kNBzQqD3B3o9SigDT6/pOwcq0pjl71BBo/Z7OB5fHLw=;
 b=lJ3V8NIl7I89RE/LZ0JwfO7UPRYMuuE7COQ09kOcByjr3QLTsT31vZ3prqzGSUWowX
 4Pacxd4nPzWnTG8F5Bp5XCj9jALJ+1m9vJ/9MyqYIx214EHKardUzn20rAXoSqe7a2Tw
 hS1iHquZVW6l1lu4Ab+l0kUbA3cmqGdReN/aR51dpLD3AZTWvAfW9oDaCdKpxVm/UlBr
 90EoC72gNWuzFMRgmXdeh+1nmnals0jDHvTkXgwNUJA5EGs7OVAtIucI5OIVWYXwgPeV
 kgX4aNk2IvKNm6ShpsXqe4GTj7hTqlCb5OD/bZOfXNr0ksmHM/8POamXA7lIPJ1Iyebt
 L8ug==
X-Gm-Message-State: APjAAAXkCBMCObGiRxtgHKz+uZHQ9G94YH87P4iYGSFvPiVG7NPgSdJv
 Uws5UbqHaSfL6gkLdbZlpayLQHHSo1E=
X-Google-Smtp-Source: APXvYqxLpA7lQZm1ctG6dvENSscIc/86NWUUcm7YpERnvCBNclOdm1uE86OxdN25H8vF6yGufl0qpw==
X-Received: by 2002:aa7:9591:: with SMTP id z17mr6528146pfj.215.1567019126781; 
 Wed, 28 Aug 2019 12:05:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:08 -0700
Message-Id: <20190828190456.30315-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 21/69] target/arm: Convert Synchronization
 primitives
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Fix arch test for {ld,st}rex[bh]
    Use unallocated_encoding for odd reg checks
---
 target/arm/translate.c | 576 +++++++++++++++++++++++------------------
 target/arm/a32.decode  |  48 ++++
 target/arm/t32.decode  |  46 ++++
 3 files changed, 412 insertions(+), 258 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a92b90a4e3..10ec976bd9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8846,6 +8846,318 @@ DO_LDST(STRH, store, MO_UW)
 
 #undef DO_LDST
 
+/*
+ * Synchronization primitives
+ */
+
+static bool op_swp(DisasContext *s, arg_SWP *a, TCGMemOp opc)
+{
+    TCGv_i32 addr, tmp;
+    TCGv taddr;
+
+    opc |= s->be_data;
+    addr = load_reg(s, a->rn);
+    taddr = gen_aa32_addr(s, addr, opc);
+    tcg_temp_free_i32(addr);
+
+    tmp = load_reg(s, a->rt2);
+    tcg_gen_atomic_xchg_i32(tmp, taddr, tmp, get_mem_index(s), opc);
+    tcg_temp_free(taddr);
+
+    store_reg(s, a->rt, tmp);
+    return true;
+}
+
+static bool trans_SWP(DisasContext *s, arg_SWP *a)
+{
+    return op_swp(s, a, MO_UL | MO_ALIGN);
+}
+
+static bool trans_SWPB(DisasContext *s, arg_SWP *a)
+{
+    return op_swp(s, a, MO_UB);
+}
+
+/*
+ * Load/Store Exclusive and Load-Acquire/Store-Release
+ */
+
+static bool op_strex(DisasContext *s, arg_STREX *a, TCGMemOp mop, bool rel)
+{
+    TCGv_i32 addr;
+
+    if (rel) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    }
+
+    addr = tcg_temp_local_new_i32();
+    load_reg_var(s, addr, a->rn);
+    tcg_gen_addi_i32(addr, addr, a->imm);
+
+    gen_store_exclusive(s, a->rd, a->rt, a->rt2, addr, mop);
+    tcg_temp_free_i32(addr);
+    return true;
+}
+
+static bool trans_STREX(DisasContext *s, arg_STREX *a)
+{
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+    return op_strex(s, a, MO_32, false);
+}
+
+static bool trans_STREXD_a32(DisasContext *s, arg_STREX *a)
+{
+    if (!ENABLE_ARCH_6K) {
+        return false;
+    }
+    if (a->rt & 1) {
+        unallocated_encoding(s);
+        return true;
+    }
+    a->rt2 = a->rt + 1;
+    return op_strex(s, a, MO_64, false);
+}
+
+static bool trans_STREXD_t32(DisasContext *s, arg_STREX *a)
+{
+    return op_strex(s, a, MO_64, false);
+}
+
+static bool trans_STREXB(DisasContext *s, arg_STREX *a)
+{
+    if (s->thumb ? !ENABLE_ARCH_7 : !ENABLE_ARCH_6K) {
+        return false;
+    }
+    return op_strex(s, a, MO_8, false);
+}
+
+static bool trans_STREXH(DisasContext *s, arg_STREX *a)
+{
+    if (s->thumb ? !ENABLE_ARCH_7 : !ENABLE_ARCH_6K) {
+        return false;
+    }
+    return op_strex(s, a, MO_16, false);
+}
+
+static bool trans_STLEX(DisasContext *s, arg_STREX *a)
+{
+    if (!ENABLE_ARCH_8) {
+        return false;
+    }
+    return op_strex(s, a, MO_32, true);
+}
+
+static bool trans_STLEXD_a32(DisasContext *s, arg_STREX *a)
+{
+    if (!ENABLE_ARCH_8) {
+        return false;
+    }
+    if (a->rt & 1) {
+        unallocated_encoding(s);
+        return true;
+    }
+    a->rt2 = a->rt + 1;
+    return op_strex(s, a, MO_64, true);
+}
+
+static bool trans_STLEXD_t32(DisasContext *s, arg_STREX *a)
+{
+    if (!ENABLE_ARCH_8) {
+        return false;
+    }
+    return op_strex(s, a, MO_64, true);
+}
+
+static bool trans_STLEXB(DisasContext *s, arg_STREX *a)
+{
+    if (!ENABLE_ARCH_8) {
+        return false;
+    }
+    return op_strex(s, a, MO_8, true);
+}
+
+static bool trans_STLEXH(DisasContext *s, arg_STREX *a)
+{
+    if (!ENABLE_ARCH_8) {
+        return false;
+    }
+    return op_strex(s, a, MO_16, true);
+}
+
+static bool op_stl(DisasContext *s, arg_STL *a, TCGMemOp mop)
+{
+    TCGv_i32 addr, tmp;
+
+    if (!ENABLE_ARCH_8) {
+        return false;
+    }
+    addr = load_reg(s, a->rn);
+
+    tmp = load_reg(s, a->rt);
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    gen_aa32_st_i32(s, tmp, addr, get_mem_index(s), mop | s->be_data);
+    disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel | ISSIsWrite);
+
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(addr);
+    return true;
+}
+
+static bool trans_STL(DisasContext *s, arg_STL *a)
+{
+    return op_stl(s, a, MO_UL);
+}
+
+static bool trans_STLB(DisasContext *s, arg_STL *a)
+{
+    return op_stl(s, a, MO_UB);
+}
+
+static bool trans_STLH(DisasContext *s, arg_STL *a)
+{
+    return op_stl(s, a, MO_UW);
+}
+
+static bool op_ldrex(DisasContext *s, arg_LDREX *a, TCGMemOp mop, bool acq)
+{
+    TCGv_i32 addr;
+
+    addr = tcg_temp_local_new_i32();
+    load_reg_var(s, addr, a->rn);
+    tcg_gen_addi_i32(addr, addr, a->imm);
+
+    gen_load_exclusive(s, a->rt, a->rt2, addr, mop);
+    tcg_temp_free_i32(addr);
+
+    if (acq) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    }
+    return true;
+}
+
+static bool trans_LDREX(DisasContext *s, arg_LDREX *a)
+{
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+    return op_ldrex(s, a, MO_32, false);
+}
+
+static bool trans_LDREXD_a32(DisasContext *s, arg_LDREX *a)
+{
+    if (!ENABLE_ARCH_6K) {
+        return false;
+    }
+    if (a->rt & 1) {
+        unallocated_encoding(s);
+        return true;
+    }
+    a->rt2 = a->rt + 1;
+    return op_ldrex(s, a, MO_64, false);
+}
+
+static bool trans_LDREXD_t32(DisasContext *s, arg_LDREX *a)
+{
+    return op_ldrex(s, a, MO_64, false);
+}
+
+static bool trans_LDREXB(DisasContext *s, arg_LDREX *a)
+{
+    if (s->thumb ? !ENABLE_ARCH_7 : !ENABLE_ARCH_6K) {
+        return false;
+    }
+    return op_ldrex(s, a, MO_8, false);
+}
+
+static bool trans_LDREXH(DisasContext *s, arg_LDREX *a)
+{
+    if (s->thumb ? !ENABLE_ARCH_7 : !ENABLE_ARCH_6K) {
+        return false;
+    }
+    return op_ldrex(s, a, MO_16, false);
+}
+
+static bool trans_LDAEX(DisasContext *s, arg_LDREX *a)
+{
+    if (!ENABLE_ARCH_8) {
+        return false;
+    }
+    return op_ldrex(s, a, MO_32, true);
+}
+
+static bool trans_LDAEXD_a32(DisasContext *s, arg_LDREX *a)
+{
+    if (!ENABLE_ARCH_8) {
+        return false;
+    }
+    if (a->rt & 1) {
+        unallocated_encoding(s);
+        return true;
+    }
+    a->rt2 = a->rt + 1;
+    return op_ldrex(s, a, MO_64, true);
+}
+
+static bool trans_LDAEXD_t32(DisasContext *s, arg_LDREX *a)
+{
+    if (!ENABLE_ARCH_8) {
+        return false;
+    }
+    return op_ldrex(s, a, MO_64, true);
+}
+
+static bool trans_LDAEXB(DisasContext *s, arg_LDREX *a)
+{
+    if (!ENABLE_ARCH_8) {
+        return false;
+    }
+    return op_ldrex(s, a, MO_8, true);
+}
+
+static bool trans_LDAEXH(DisasContext *s, arg_LDREX *a)
+{
+    if (!ENABLE_ARCH_8) {
+        return false;
+    }
+    return op_ldrex(s, a, MO_16, true);
+}
+
+static bool op_lda(DisasContext *s, arg_LDA *a, TCGMemOp mop)
+{
+    TCGv_i32 addr, tmp;
+
+    if (!ENABLE_ARCH_8) {
+        return false;
+    }
+    addr = load_reg(s, a->rn);
+
+    tmp = tcg_temp_new_i32();
+    gen_aa32_ld_i32(s, tmp, addr, get_mem_index(s), mop | s->be_data);
+    disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel);
+    tcg_temp_free_i32(addr);
+
+    store_reg(s, a->rt, tmp);
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    return true;
+}
+
+static bool trans_LDA(DisasContext *s, arg_LDA *a)
+{
+    return op_lda(s, a, MO_UL);
+}
+
+static bool trans_LDAB(DisasContext *s, arg_LDA *a)
+{
+    return op_lda(s, a, MO_UB);
+}
+
+static bool trans_LDAH(DisasContext *s, arg_LDA *a)
+{
+    return op_lda(s, a, MO_UW);
+}
+
 /*
  * Legacy decoder.
  */
@@ -9141,172 +9453,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         case 0x0:
         case 0x1:
             /* multiplies, extra load/stores */
-            sh = (insn >> 5) & 3;
-            if (sh == 0) {
-                if (op1 == 0x0) {
-                    /* Multiply and multiply accumulate.  */
-                    /* All done in decodetree.  Reach here for illegal ops.  */
-                    goto illegal_op;
-                } else {
-                    rn = (insn >> 16) & 0xf;
-                    rd = (insn >> 12) & 0xf;
-                    if (insn & (1 << 23)) {
-                        /* load/store exclusive */
-                        bool is_ld = extract32(insn, 20, 1);
-                        bool is_lasr = !extract32(insn, 8, 1);
-                        int op2 = (insn >> 8) & 3;
-                        op1 = (insn >> 21) & 0x3;
-
-                        switch (op2) {
-                        case 0: /* lda/stl */
-                            if (op1 == 1) {
-                                goto illegal_op;
-                            }
-                            ARCH(8);
-                            break;
-                        case 1: /* reserved */
-                            goto illegal_op;
-                        case 2: /* ldaex/stlex */
-                            ARCH(8);
-                            break;
-                        case 3: /* ldrex/strex */
-                            if (op1) {
-                                ARCH(6K);
-                            } else {
-                                ARCH(6);
-                            }
-                            break;
-                        }
-
-                        addr = tcg_temp_local_new_i32();
-                        load_reg_var(s, addr, rn);
-
-                        if (is_lasr && !is_ld) {
-                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-                        }
-
-                        if (op2 == 0) {
-                            if (is_ld) {
-                                tmp = tcg_temp_new_i32();
-                                switch (op1) {
-                                case 0: /* lda */
-                                    gen_aa32_ld32u_iss(s, tmp, addr,
-                                                       get_mem_index(s),
-                                                       rd | ISSIsAcqRel);
-                                    break;
-                                case 2: /* ldab */
-                                    gen_aa32_ld8u_iss(s, tmp, addr,
-                                                      get_mem_index(s),
-                                                      rd | ISSIsAcqRel);
-                                    break;
-                                case 3: /* ldah */
-                                    gen_aa32_ld16u_iss(s, tmp, addr,
-                                                       get_mem_index(s),
-                                                       rd | ISSIsAcqRel);
-                                    break;
-                                default:
-                                    abort();
-                                }
-                                store_reg(s, rd, tmp);
-                            } else {
-                                rm = insn & 0xf;
-                                tmp = load_reg(s, rm);
-                                switch (op1) {
-                                case 0: /* stl */
-                                    gen_aa32_st32_iss(s, tmp, addr,
-                                                      get_mem_index(s),
-                                                      rm | ISSIsAcqRel);
-                                    break;
-                                case 2: /* stlb */
-                                    gen_aa32_st8_iss(s, tmp, addr,
-                                                     get_mem_index(s),
-                                                     rm | ISSIsAcqRel);
-                                    break;
-                                case 3: /* stlh */
-                                    gen_aa32_st16_iss(s, tmp, addr,
-                                                      get_mem_index(s),
-                                                      rm | ISSIsAcqRel);
-                                    break;
-                                default:
-                                    abort();
-                                }
-                                tcg_temp_free_i32(tmp);
-                            }
-                        } else if (is_ld) {
-                            switch (op1) {
-                            case 0: /* ldrex */
-                                gen_load_exclusive(s, rd, 15, addr, 2);
-                                break;
-                            case 1: /* ldrexd */
-                                gen_load_exclusive(s, rd, rd + 1, addr, 3);
-                                break;
-                            case 2: /* ldrexb */
-                                gen_load_exclusive(s, rd, 15, addr, 0);
-                                break;
-                            case 3: /* ldrexh */
-                                gen_load_exclusive(s, rd, 15, addr, 1);
-                                break;
-                            default:
-                                abort();
-                            }
-                        } else {
-                            rm = insn & 0xf;
-                            switch (op1) {
-                            case 0:  /*  strex */
-                                gen_store_exclusive(s, rd, rm, 15, addr, 2);
-                                break;
-                            case 1: /*  strexd */
-                                gen_store_exclusive(s, rd, rm, rm + 1, addr, 3);
-                                break;
-                            case 2: /*  strexb */
-                                gen_store_exclusive(s, rd, rm, 15, addr, 0);
-                                break;
-                            case 3: /* strexh */
-                                gen_store_exclusive(s, rd, rm, 15, addr, 1);
-                                break;
-                            default:
-                                abort();
-                            }
-                        }
-                        tcg_temp_free_i32(addr);
-
-                        if (is_lasr && is_ld) {
-                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
-                        }
-                    } else if ((insn & 0x00300f00) == 0) {
-                        /* 0bcccc_0001_0x00_xxxx_xxxx_0000_1001_xxxx
-                        *  - SWP, SWPB
-                        */
-
-                        TCGv taddr;
-                        TCGMemOp opc = s->be_data;
-
-                        rm = (insn) & 0xf;
-
-                        if (insn & (1 << 22)) {
-                            opc |= MO_UB;
-                        } else {
-                            opc |= MO_UL | MO_ALIGN;
-                        }
-
-                        addr = load_reg(s, rn);
-                        taddr = gen_aa32_addr(s, addr, opc);
-                        tcg_temp_free_i32(addr);
-
-                        tmp = load_reg(s, rm);
-                        tcg_gen_atomic_xchg_i32(tmp, taddr, tmp,
-                                                get_mem_index(s), opc);
-                        tcg_temp_free(taddr);
-                        store_reg(s, rd, tmp);
-                    } else {
-                        goto illegal_op;
-                    }
-                }
-            } else {
-                /* Extra load/store (register) instructions */
-                /* All done in decodetree.  Reach here for illegal ops.  */
-                goto illegal_op;
-            }
+            /* All done in decodetree.  Reach here for illegal ops.  */
+            goto illegal_op;
             break;
         case 0x4:
         case 0x5:
@@ -9952,15 +10100,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     }
                     goto illegal_op;
                 }
-                addr = tcg_temp_local_new_i32();
-                load_reg_var(s, addr, rn);
-                tcg_gen_addi_i32(addr, addr, (insn & 0xff) << 2);
-                if (insn & (1 << 20)) {
-                    gen_load_exclusive(s, rs, 15, addr, 2);
-                } else {
-                    gen_store_exclusive(s, rd, rs, 15, addr, 2);
-                }
-                tcg_temp_free_i32(addr);
+                /* Load/store exclusive, in decodetree */
+                goto illegal_op;
             } else if ((insn & (7 << 5)) == 0) {
                 /* Table Branch.  */
                 addr = load_reg(s, rn);
@@ -9982,89 +10123,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 tcg_gen_addi_i32(tmp, tmp, read_pc(s));
                 store_reg(s, 15, tmp);
             } else {
-                bool is_lasr = false;
-                bool is_ld = extract32(insn, 20, 1);
-                int op2 = (insn >> 6) & 0x3;
-                op = (insn >> 4) & 0x3;
-                switch (op2) {
-                case 0:
-                    goto illegal_op;
-                case 1:
-                    /* Load/store exclusive byte/halfword/doubleword */
-                    if (op == 2) {
-                        goto illegal_op;
-                    }
-                    ARCH(7);
-                    break;
-                case 2:
-                    /* Load-acquire/store-release */
-                    if (op == 3) {
-                        goto illegal_op;
-                    }
-                    /* Fall through */
-                case 3:
-                    /* Load-acquire/store-release exclusive */
-                    ARCH(8);
-                    is_lasr = true;
-                    break;
-                }
-
-                if (is_lasr && !is_ld) {
-                    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-                }
-
-                addr = tcg_temp_local_new_i32();
-                load_reg_var(s, addr, rn);
-                if (!(op2 & 1)) {
-                    if (is_ld) {
-                        tmp = tcg_temp_new_i32();
-                        switch (op) {
-                        case 0: /* ldab */
-                            gen_aa32_ld8u_iss(s, tmp, addr, get_mem_index(s),
-                                              rs | ISSIsAcqRel);
-                            break;
-                        case 1: /* ldah */
-                            gen_aa32_ld16u_iss(s, tmp, addr, get_mem_index(s),
-                                               rs | ISSIsAcqRel);
-                            break;
-                        case 2: /* lda */
-                            gen_aa32_ld32u_iss(s, tmp, addr, get_mem_index(s),
-                                               rs | ISSIsAcqRel);
-                            break;
-                        default:
-                            abort();
-                        }
-                        store_reg(s, rs, tmp);
-                    } else {
-                        tmp = load_reg(s, rs);
-                        switch (op) {
-                        case 0: /* stlb */
-                            gen_aa32_st8_iss(s, tmp, addr, get_mem_index(s),
-                                             rs | ISSIsAcqRel);
-                            break;
-                        case 1: /* stlh */
-                            gen_aa32_st16_iss(s, tmp, addr, get_mem_index(s),
-                                              rs | ISSIsAcqRel);
-                            break;
-                        case 2: /* stl */
-                            gen_aa32_st32_iss(s, tmp, addr, get_mem_index(s),
-                                              rs | ISSIsAcqRel);
-                            break;
-                        default:
-                            abort();
-                        }
-                        tcg_temp_free_i32(tmp);
-                    }
-                } else if (is_ld) {
-                    gen_load_exclusive(s, rs, rd, addr, op);
-                } else {
-                    gen_store_exclusive(s, rm, rs, rd, addr, op);
-                }
-                tcg_temp_free_i32(addr);
-
-                if (is_lasr && is_ld) {
-                    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
-                }
+                /* Load/store exclusive, load-acq/store-rel, in decodetree */
+                goto illegal_op;
             }
         } else {
             /* Load/store multiple, RFE, SRS.  */
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index f7742deaee..c76cbad569 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -39,6 +39,8 @@
 &mrs_bank        rd r sysm
 &ldst_rr         p w u rn rt rm shimm shtype
 &ldst_ri         p w u rn rt imm
+&strex           rn rd rt rt2 imm
+&ldrex           rn rt rt2 imm
 
 # Data-processing (register)
 
@@ -342,3 +344,49 @@ STRT_ri          .... 010. .0.0 .... .... ............        @ldst_ri12_p0w1
 STRBT_ri         .... 010. .1.0 .... .... ............        @ldst_ri12_p0w1
 LDRT_ri          .... 010. .0.1 .... .... ............        @ldst_ri12_p0w1
 LDRBT_ri         .... 010. .1.1 .... .... ............        @ldst_ri12_p0w1
+
+# Synchronization primitives
+
+@swp             ---- .... .... rn:4 rt:4 .... .... rt2:4
+
+SWP              .... 0001 0000 .... .... 0000 1001 ....      @swp
+SWPB             .... 0001 0100 .... .... 0000 1001 ....      @swp
+
+# Load/Store Exclusive and Load-Acquire/Store-Release
+#
+# Note rt2 for STREXD/LDREXD is set by the helper after checking rt is even.
+
+@strex           ---- .... .... rn:4 rd:4 .... .... rt:4 \
+                 &strex imm=0 rt2=15
+@ldrex           ---- .... .... rn:4 rt:4 .... .... .... \
+                 &ldrex imm=0 rt2=15
+@stl             ---- .... .... rn:4 .... .... .... rt:4 \
+                 &ldrex imm=0 rt2=15
+
+STREX            .... 0001 1000 .... .... 1111 1001 ....      @strex
+STREXD_a32       .... 0001 1010 .... .... 1111 1001 ....      @strex
+STREXB           .... 0001 1100 .... .... 1111 1001 ....      @strex
+STREXH           .... 0001 1110 .... .... 1111 1001 ....      @strex
+
+STLEX            .... 0001 1000 .... .... 1110 1001 ....      @strex
+STLEXD_a32       .... 0001 1010 .... .... 1110 1001 ....      @strex
+STLEXB           .... 0001 1100 .... .... 1110 1001 ....      @strex
+STLEXH           .... 0001 1110 .... .... 1110 1001 ....      @strex
+
+STL              .... 0001 1000 .... 1111 1100 1001 ....      @stl
+STLB             .... 0001 1100 .... 1111 1100 1001 ....      @stl
+STLH             .... 0001 1110 .... 1111 1100 1001 ....      @stl
+
+LDREX            .... 0001 1001 .... .... 1111 1001 1111      @ldrex
+LDREXD_a32       .... 0001 1011 .... .... 1111 1001 1111      @ldrex
+LDREXB           .... 0001 1101 .... .... 1111 1001 1111      @ldrex
+LDREXH           .... 0001 1111 .... .... 1111 1001 1111      @ldrex
+
+LDAEX            .... 0001 1001 .... .... 1110 1001 1111      @ldrex
+LDAEXD_a32       .... 0001 1011 .... .... 1110 1001 1111      @ldrex
+LDAEXB           .... 0001 1101 .... .... 1110 1001 1111      @ldrex
+LDAEXH           .... 0001 1111 .... .... 1110 1001 1111      @ldrex
+
+LDA              .... 0001 1001 .... .... 1100 1001 1111      @ldrex
+LDAB             .... 0001 1101 .... .... 1100 1001 1111      @ldrex
+LDAH             .... 0001 1111 .... .... 1100 1001 1111      @ldrex
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index a86597562b..70cf8039d7 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -36,6 +36,8 @@
 &mrs_bank        !extern rd r sysm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
+&strex           !extern rn rd rt rt2 imm
+&ldrex           !extern rn rt rt2 imm
 
 # Data-processing (register)
 
@@ -392,3 +394,47 @@ LDRD_ri_t32      1110 1001 .101 .... .... .... ........    @ldstd_ri8 w=0 p=1
 
 STRD_ri_t32      1110 1001 .110 .... .... .... ........    @ldstd_ri8 w=1 p=1
 LDRD_ri_t32      1110 1001 .111 .... .... .... ........    @ldstd_ri8 w=1 p=1
+
+# Load/Store Exclusive and Load-Acquire/Store-Release
+
+@strex_i         .... .... .... rn:4 rt:4 rd:4 .... .... \
+                 &strex rt2=15 imm=%imm8x4
+@strex_0         .... .... .... rn:4 rt:4 .... .... rd:4 \
+                 &strex rt2=15 imm=0
+@strex_d         .... .... .... rn:4 rt:4 rt2:4 .... rd:4 \
+                 &strex imm=0
+
+@ldrex_i         .... .... .... rn:4 rt:4 .... .... .... \
+                 &ldrex rt2=15 imm=%imm8x4
+@ldrex_0         .... .... .... rn:4 rt:4 .... .... .... \
+                 &ldrex rt2=15 imm=0
+@ldrex_d         .... .... .... rn:4 rt:4 rt2:4 .... .... \
+                 &ldrex imm=0
+
+STREX            1110 1000 0100 .... .... .... .... ....      @strex_i
+STREXB           1110 1000 1100 .... .... 1111 0100 ....      @strex_0
+STREXH           1110 1000 1100 .... .... 1111 0101 ....      @strex_0
+STREXD_t32       1110 1000 1100 .... .... .... 0111 ....      @strex_d
+
+STLEX            1110 1000 1100 .... .... 1111 1110 ....      @strex_0
+STLEXB           1110 1000 1100 .... .... 1111 1100 ....      @strex_0
+STLEXH           1110 1000 1100 .... .... 1111 1101 ....      @strex_0
+STLEXD_t32       1110 1000 1100 .... .... .... 1111 ....      @strex_d
+
+STL              1110 1000 1100 .... .... 1111 1010 1111      @ldrex_0
+STLB             1110 1000 1100 .... .... 1111 1000 1111      @ldrex_0
+STLH             1110 1000 1100 .... .... 1111 1001 1111      @ldrex_0
+
+LDREX            1110 1000 0101 .... .... 1111 .... ....      @ldrex_i
+LDREXB           1110 1000 1101 .... .... 1111 0100 1111      @ldrex_0
+LDREXH           1110 1000 1101 .... .... 1111 0101 1111      @ldrex_0
+LDREXD_t32       1110 1000 1101 .... .... .... 0111 1111      @ldrex_d
+
+LDAEX            1110 1000 1101 .... .... 1111 1110 1111      @ldrex_0
+LDAEXB           1110 1000 1101 .... .... 1111 1100 1111      @ldrex_0
+LDAEXH           1110 1000 1101 .... .... 1111 1101 1111      @ldrex_0
+LDAEXD_t32       1110 1000 1101 .... .... .... 1111 1111      @ldrex_d
+
+LDA              1110 1000 1101 .... .... 1111 1010 1111      @ldrex_0
+LDAB             1110 1000 1101 .... .... 1111 1000 1111      @ldrex_0
+LDAH             1110 1000 1101 .... .... 1111 1001 1111      @ldrex_0
-- 
2.17.1


