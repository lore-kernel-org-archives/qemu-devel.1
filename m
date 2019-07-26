Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25B5C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDBE21842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRKxzn4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDBE21842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Uv-00044b-2d
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58373)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NF-0004WT-Uf
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4N9-0000H1-PM
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:40196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4N6-00005e-CC
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id a93so24972511pla.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7tTsGJIDF0bTmlDGx9oqoy4yU2XiArhYoVylWwae3nM=;
 b=gRKxzn4PotW6Bf7coh2phGb7sGYj4rkpoLQYg5zKo8a62PIMbO7oAPUn2SOiiwmlSE
 k1t+dM6oahegAlf4uvCSUMkcZYVcjEvDpoKvlWoa6eXWF2elkK36bZZDI3dCXf86aqti
 BiGArORg9BQSU6K7e9ZZOyTKCYaEp8bVpbt8gLVCoq9t5/MvgtGqp0sagpVC4HN9F0fR
 dWexDkblloOfCyAQZJD3sIkJweSaibe1cZi1L+c6qI2aqh9o7FWSOz/QAQCYu0cQHr+2
 gCRXO+GUt9cdcSGP5f3mSjyg503qKQ9P2ejhYugQUPYgfi8z0pwxBRbhSE5QJzAYljNZ
 PFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7tTsGJIDF0bTmlDGx9oqoy4yU2XiArhYoVylWwae3nM=;
 b=EQEiG2RARXwzOx8Tusr8VDcvnU2iA+Mz+j65VitpjHgYHNeG2kFMwxccJwWzVM+4cE
 fcpeEHWS3tE7MMfFvOWz8soTXMZNsR2vRyHZkBmYm9xHJNomlEcFWNnn2lpwrFzFM2rX
 OTTILLCiS8svS7uMd4htUnuSDSaPRO98c8Qs5gDVf7GOMwhK789o2xWFi6FAINgz3kRs
 EdlfR2LZq15aRRi2MhvdIbzrPf+yBDvjTe/uuFuO0kiL2EcNxdGnbOB4bFZhvFdNmAhN
 I1WUdyClF2QPWHq93sN22CniW6KZV3owjOq8bCDrpH1dwvN53giCgt8Iukm8OnxESFir
 WJmg==
X-Gm-Message-State: APjAAAVb1fs4uf7Yh9h7eQJBtow5UfA4nqPSfEOxbgo8gel+xo++jMe/
 C5dCtHzxSwOKjXKSA9Kgt5DOsXlyXCw=
X-Google-Smtp-Source: APXvYqwLEc2Ky4wg0md8pC0ff3On9n6qogNhdLnr1yb88s0TU+99vz9kaGjvL+JotCESjm2OM1ntQA==
X-Received: by 2002:a17:902:7791:: with SMTP id
 o17mr98752380pll.27.1564163468781; 
 Fri, 26 Jul 2019 10:51:08 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:54 -0700
Message-Id: <20190726175032.6769-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::634
Subject: [Qemu-devel] [PATCH 29/67] target/arm: Convert LDM, STM
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While unifying all of these paths, remove the constrained unpredictable
test for "wback && registers<n> == 1" from the T2 encoding that isn't
constrained unpredictable for the A1 encoding.  The A1 behaviour is
allowed for the T2 behaviour.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 388 ++++++++++++++++++++---------------------
 target/arm/a32.decode  |   6 +
 target/arm/t32.decode  |  10 ++
 3 files changed, 206 insertions(+), 198 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ee97a0ccdd..33daf70d5d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9742,6 +9742,192 @@ static bool trans_UDIV(DisasContext *s, arg_rrr *a)
     return op_div(s, a, true);
 }
 
+/*
+ * Block data transfer
+ */
+
+static TCGv_i32 op_addr_block_pre(DisasContext *s, arg_ldst_block *a, int n)
+{
+    TCGv_i32 addr = load_reg(s, a->rn);
+
+    if (a->b) {
+        if (a->i) {
+            /* pre increment */
+            tcg_gen_addi_i32(addr, addr, 4);
+        } else {
+            /* pre decrement */
+            tcg_gen_addi_i32(addr, addr, -(n * 4));
+        }
+    } else if (!a->i && n != 1) {
+        /* post decrement */
+        tcg_gen_addi_i32(addr, addr, -((n - 1) * 4));
+    }
+
+    if (s->v8m_stackcheck && a->rn == 13 && a->w) {
+        /*
+         * If the writeback is incrementing SP rather than
+         * decrementing it, and the initial SP is below the
+         * stack limit but the final written-back SP would
+         * be above, then then we must not perform any memory
+         * accesses, but it is IMPDEF whether we generate
+         * an exception. We choose to do so in this case.
+         * At this point 'addr' is the lowest address, so
+         * either the original SP (if incrementing) or our
+         * final SP (if decrementing), so that's what we check.
+         */
+        gen_helper_v8m_stackcheck(cpu_env, addr);
+    }
+
+    return addr;
+}
+
+static void op_addr_block_post(DisasContext *s, arg_ldst_block *a,
+                               TCGv_i32 addr, int n)
+{
+    if (a->w) {
+        /* write back */
+        if (!a->b) {
+            if (a->i) {
+                /* post increment */
+                tcg_gen_addi_i32(addr, addr, 4);
+            } else {
+                /* post decrement */
+                tcg_gen_addi_i32(addr, addr, -(n * 4));
+            }
+        } else if (!a->i && n != 1) {
+            /* pre decrement */
+            tcg_gen_addi_i32(addr, addr, -((n - 1) * 4));
+        }
+        store_reg(s, a->rn, addr);
+    } else {
+        tcg_temp_free_i32(addr);
+    }
+}
+
+static bool trans_STM(DisasContext *s, arg_ldst_block *a)
+{
+    int i, j, n, list, mem_idx;
+    TCGv_i32 addr, tmp, tmp2;
+    bool user = a->u;
+
+    if (user) {
+        /* STM (user) */
+        if (IS_USER(s)) {
+            /* Only usable in supervisor mode.  */
+            return false;
+        }
+    }
+
+    /* compute total size */
+    list = a->list;
+    n = ctpop16(list);
+    mem_idx = get_mem_index(s);
+
+    addr = op_addr_block_pre(s, a, n);
+    for (i = j = 0; i < 16; i++) {
+        if (((list >> i) & 1) == 0) {
+            continue;
+        }
+        if (user && i != 15) {
+            tmp = tcg_temp_new_i32();
+            tmp2 = tcg_const_i32(i);
+            gen_helper_get_user_reg(tmp, cpu_env, tmp2);
+            tcg_temp_free_i32(tmp2);
+        } else {
+            tmp = load_reg(s, i);
+        }
+        gen_aa32_st32(s, tmp, addr, mem_idx);
+        tcg_temp_free_i32(tmp);
+        /* No need to add after the last transfer.  */
+        if (++j != n) {
+            tcg_gen_addi_i32(addr, addr, 4);
+        }
+    }
+
+    op_addr_block_post(s, a, addr, n);
+    return true;
+}
+
+static bool trans_LDM(DisasContext *s, arg_ldst_block *a)
+{
+    int i, j, n, mem_idx, loaded_base;
+    int list = a->list;
+    bool user = a->u;
+    bool exc_return = false;
+    TCGv_i32 addr, tmp, tmp2, loaded_var;
+
+    if (user) {
+        /* LDM (user), LDM (exception return) */
+        if (IS_USER(s)) {
+            /* Only usable in supervisor mode.  */
+            return false;
+        }
+        if (extract32(a->list, 15, 1)) {
+            exc_return = true;
+            user = false;
+        } else {
+            /* LDM (User) does not allow W set.  */
+            if (a->w) {
+                return false;
+            }
+        }
+    }
+
+    /* compute total size */
+    loaded_base = 0;
+    loaded_var = NULL;
+    n = ctpop16(list);
+    mem_idx = get_mem_index(s);
+
+    addr = op_addr_block_pre(s, a, n);
+    for (i = j = 0; i < 16; i++) {
+        if (((list >> i) & 1) == 0) {
+            continue;
+        }
+        tmp = tcg_temp_new_i32();
+        gen_aa32_ld32u(s, tmp, addr, mem_idx);
+        if (user) {
+            tmp2 = tcg_const_i32(i);
+            gen_helper_set_user_reg(cpu_env, tmp2, tmp);
+            tcg_temp_free_i32(tmp2);
+            tcg_temp_free_i32(tmp);
+        } else if (i == a->rn) {
+            loaded_var = tmp;
+            loaded_base = 1;
+        } else if (i == 15 && exc_return) {
+            store_pc_exc_ret(s, tmp);
+        } else {
+            store_reg_from_load(s, i, tmp);
+        }
+        /* No need to add after the last transfer.  */
+        if (++j != n) {
+            tcg_gen_addi_i32(addr, addr, 4);
+        }
+    }
+
+    op_addr_block_post(s, a, addr, n);
+
+    if (loaded_base) {
+        store_reg(s, a->rn, loaded_var);
+    }
+
+    if (exc_return) {
+        /* Restore CPSR from SPSR.  */
+        tmp = load_cpu_field(spsr);
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
+        gen_helper_cpsr_write_eret(cpu_env, tmp);
+        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+            gen_io_end();
+        }
+        tcg_temp_free_i32(tmp);
+        /* Must exit loop to check un-masked IRQs */
+        s->base.is_jmp = DISAS_EXIT;
+    }
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10017,139 +10203,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         case 0x5:
         case 0x6:
         case 0x7:
-            /* All done in decodetree.  Reach here for illegal ops.  */
-            goto illegal_op;
         case 0x08:
         case 0x09:
-            {
-                int j, n, loaded_base;
-                bool exc_return = false;
-                bool is_load = extract32(insn, 20, 1);
-                bool user = false;
-                TCGv_i32 loaded_var;
-                /* load/store multiple words */
-                /* XXX: store correct base if write back */
-                if (insn & (1 << 22)) {
-                    /* LDM (user), LDM (exception return) and STM (user) */
-                    if (IS_USER(s))
-                        goto illegal_op; /* only usable in supervisor mode */
-
-                    if (is_load && extract32(insn, 15, 1)) {
-                        exc_return = true;
-                    } else {
-                        user = true;
-                    }
-                }
-                rn = (insn >> 16) & 0xf;
-                addr = load_reg(s, rn);
-
-                /* compute total size */
-                loaded_base = 0;
-                loaded_var = NULL;
-                n = 0;
-                for (i = 0; i < 16; i++) {
-                    if (insn & (1 << i))
-                        n++;
-                }
-                /* XXX: test invalid n == 0 case ? */
-                if (insn & (1 << 23)) {
-                    if (insn & (1 << 24)) {
-                        /* pre increment */
-                        tcg_gen_addi_i32(addr, addr, 4);
-                    } else {
-                        /* post increment */
-                    }
-                } else {
-                    if (insn & (1 << 24)) {
-                        /* pre decrement */
-                        tcg_gen_addi_i32(addr, addr, -(n * 4));
-                    } else {
-                        /* post decrement */
-                        if (n != 1)
-                        tcg_gen_addi_i32(addr, addr, -((n - 1) * 4));
-                    }
-                }
-                j = 0;
-                for (i = 0; i < 16; i++) {
-                    if (insn & (1 << i)) {
-                        if (is_load) {
-                            /* load */
-                            tmp = tcg_temp_new_i32();
-                            gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                            if (user) {
-                                tmp2 = tcg_const_i32(i);
-                                gen_helper_set_user_reg(cpu_env, tmp2, tmp);
-                                tcg_temp_free_i32(tmp2);
-                                tcg_temp_free_i32(tmp);
-                            } else if (i == rn) {
-                                loaded_var = tmp;
-                                loaded_base = 1;
-                            } else if (i == 15 && exc_return) {
-                                store_pc_exc_ret(s, tmp);
-                            } else {
-                                store_reg_from_load(s, i, tmp);
-                            }
-                        } else {
-                            /* store */
-                            if (user && i != 15) {
-                                tmp = tcg_temp_new_i32();
-                                tmp2 = tcg_const_i32(i);
-                                gen_helper_get_user_reg(tmp, cpu_env, tmp2);
-                                tcg_temp_free_i32(tmp2);
-                            } else {
-                                tmp = load_reg(s, i);
-                            }
-                            gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                            tcg_temp_free_i32(tmp);
-                        }
-                        j++;
-                        /* no need to add after the last transfer */
-                        if (j != n)
-                            tcg_gen_addi_i32(addr, addr, 4);
-                    }
-                }
-                if (insn & (1 << 21)) {
-                    /* write back */
-                    if (insn & (1 << 23)) {
-                        if (insn & (1 << 24)) {
-                            /* pre increment */
-                        } else {
-                            /* post increment */
-                            tcg_gen_addi_i32(addr, addr, 4);
-                        }
-                    } else {
-                        if (insn & (1 << 24)) {
-                            /* pre decrement */
-                            if (n != 1)
-                                tcg_gen_addi_i32(addr, addr, -((n - 1) * 4));
-                        } else {
-                            /* post decrement */
-                            tcg_gen_addi_i32(addr, addr, -(n * 4));
-                        }
-                    }
-                    store_reg(s, rn, addr);
-                } else {
-                    tcg_temp_free_i32(addr);
-                }
-                if (loaded_base) {
-                    store_reg(s, rn, loaded_var);
-                }
-                if (exc_return) {
-                    /* Restore CPSR from SPSR.  */
-                    tmp = load_cpu_field(spsr);
-                    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                        gen_io_start();
-                    }
-                    gen_helper_cpsr_write_eret(cpu_env, tmp);
-                    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                        gen_io_end();
-                    }
-                    tcg_temp_free_i32(tmp);
-                    /* Must exit loop to check un-masked IRQs */
-                    s->base.is_jmp = DISAS_EXIT;
-                }
-            }
-            break;
+            /* All done in decodetree.  Reach here for illegal ops.  */
+            goto illegal_op;
         case 0xa:
         case 0xb:
             {
@@ -10422,73 +10479,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                             insn & (1 << 21));
                 }
             } else {
-                int i, loaded_base = 0;
-                TCGv_i32 loaded_var;
-                bool wback = extract32(insn, 21, 1);
-                /* Load/store multiple.  */
-                addr = load_reg(s, rn);
-                offset = 0;
-                for (i = 0; i < 16; i++) {
-                    if (insn & (1 << i))
-                        offset += 4;
-                }
-
-                if (insn & (1 << 24)) {
-                    tcg_gen_addi_i32(addr, addr, -offset);
-                }
-
-                if (s->v8m_stackcheck && rn == 13 && wback) {
-                    /*
-                     * If the writeback is incrementing SP rather than
-                     * decrementing it, and the initial SP is below the
-                     * stack limit but the final written-back SP would
-                     * be above, then then we must not perform any memory
-                     * accesses, but it is IMPDEF whether we generate
-                     * an exception. We choose to do so in this case.
-                     * At this point 'addr' is the lowest address, so
-                     * either the original SP (if incrementing) or our
-                     * final SP (if decrementing), so that's what we check.
-                     */
-                    gen_helper_v8m_stackcheck(cpu_env, addr);
-                }
-
-                loaded_var = NULL;
-                for (i = 0; i < 16; i++) {
-                    if ((insn & (1 << i)) == 0)
-                        continue;
-                    if (insn & (1 << 20)) {
-                        /* Load.  */
-                        tmp = tcg_temp_new_i32();
-                        gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                        if (i == rn) {
-                            loaded_var = tmp;
-                            loaded_base = 1;
-                        } else {
-                            store_reg_from_load(s, i, tmp);
-                        }
-                    } else {
-                        /* Store.  */
-                        tmp = load_reg(s, i);
-                        gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                        tcg_temp_free_i32(tmp);
-                    }
-                    tcg_gen_addi_i32(addr, addr, 4);
-                }
-                if (loaded_base) {
-                    store_reg(s, rn, loaded_var);
-                }
-                if (wback) {
-                    /* Base register writeback.  */
-                    if (insn & (1 << 24)) {
-                        tcg_gen_addi_i32(addr, addr, -offset);
-                    }
-                    /* Fault if writeback register is in register list.  */
-                    if (insn & (1 << rn))
-                        goto illegal_op;
-                    store_reg(s, rn, addr);
-                } else {
-                    tcg_temp_free_i32(addr);
-                }
+                /* Load/store multiple, in decodetree */
+                goto illegal_op;
             }
         }
         break;
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 02d7e5b202..96c47aaf2a 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -40,6 +40,7 @@
 &mrs_bank        rd r sysm
 &ldst_rr         p w u rn rt rm shimm shtype
 &ldst_ri         p w u rn rt imm
+&ldst_block      rn i b u w list
 &strex           rn rd rt rt2 imm
 &ldrex           rn rt rt2 imm
 &bfx             rd rn lsb widthm1
@@ -514,3 +515,8 @@ SMMLA            .... 0111 0101 .... .... .... 0001 ....      @rdamn
 SMMLAR           .... 0111 0101 .... .... .... 0011 ....      @rdamn
 SMMLS            .... 0111 0101 .... .... .... 1101 ....      @rdamn
 SMMLSR           .... 0111 0101 .... .... .... 1111 ....      @rdamn
+
+# Block data transfer
+
+STM              ---- 100 b:1 i:1 u:1 w:1 0 rn:4 list:16   &ldst_block
+LDM              ---- 100 b:1 i:1 u:1 w:1 1 rn:4 list:16   &ldst_block
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index fdcfb60cc5..3ab82c0962 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -37,6 +37,7 @@
 &mrs_bank        !extern rd r sysm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
+&ldst_block      !extern rn i b u w list
 &strex           !extern rn rd rt rt2 imm
 &ldrex           !extern rn rt rt2 imm
 &bfx             !extern rd rn lsb widthm1
@@ -563,3 +564,12 @@ SXTAB16          1111 1010 0010 .... 1111 .... 10.. ....      @rrr_rot
 UXTAB16          1111 1010 0011 .... 1111 .... 10.. ....      @rrr_rot
 SXTAB            1111 1010 0100 .... 1111 .... 10.. ....      @rrr_rot
 UXTAB            1111 1010 0101 .... 1111 .... 10.. ....      @rrr_rot
+
+# Load/store multiple
+
+@ldstm           .... .... .. w:1 . rn:4 list:16              &ldst_block u=0
+
+STM              1110 1000 10.0 .... ................         @ldstm i=1 b=0
+STM              1110 1001 00.0 .... ................         @ldstm i=0 b=1
+LDM              1110 1000 10.1 .... ................         @ldstm i=1 b=0
+LDM              1110 1001 00.1 .... ................         @ldstm i=0 b=1
-- 
2.17.1


