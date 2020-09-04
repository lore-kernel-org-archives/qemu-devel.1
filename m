Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298F0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6BE206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hN3QhRwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6BE206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEH5k-00030i-DC
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH4u-0001HL-JR
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:08:52 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:33788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH4s-0000mL-Ke
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:08:52 -0400
Received: by mail-pf1-x435.google.com with SMTP id u20so5144801pfn.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dcLJ8DgGDTL1maWyR1pbuCeF33EfSNqcckI9fDw+wKw=;
 b=hN3QhRwzMQCRkmE3EUVAJpZVLpeg5XxPCA3ipaknAt8KK8ShbXrGNxSkeAZWtEf00u
 nqp2ohVjy0fJItBZN93ScrQzOu/P+gee3ZRz0BRkOzdMYYFo3c3I5d+zyMwTo97vCwv4
 fMmhBraKYx+lTD+isWJK9MG/8v/2LlIeZ+lfx8bqRDkGIbsvQtK99jqvKPzLhl55MQSq
 2dEGW98DV630Nacsch8xqYKwFiGmkTsJ46W6L/SPXD3poJRxf7njmuQ3cGzYCOyNSuBz
 wIh0NIz/ZAtyyb8o9VS2M/l1jeQFaevWaqIHoJAZBGl6hgmKd+pleaWSIMXw0YZMiUcH
 z6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dcLJ8DgGDTL1maWyR1pbuCeF33EfSNqcckI9fDw+wKw=;
 b=ToAlKEK2rlC8LSGcqNFfXZyfO5E9AIt+6dKfS/Hmc2EOucQawbGiojpgt9ly4Y1m9n
 RpK4kHLYVhv+ImI/PzG60PG7kFYfVwlGRoQBtYvH+0f2wgWV8hP2F68FN18z5uLQBisJ
 Uc3BQuABH9mOak8mOdyce1/l3LM4vNMXjNKNf/h6RlvK2QYiMuD0uR8cjUDeUPBNdfa+
 A1rxrPZQJYP15Vh225mgC1adETr9DR6Iptg3fZhkCbgQPEETLAdyPTJ+E0E1snlZg8mq
 cIKZNf+594Lq1qg0Wb+RRUmbl3G41dvnhf7hGMBauL+qpK/BYkFuF8mPrFGSWjXFs9QW
 hXmg==
X-Gm-Message-State: AOAM533EWH8umYLBB3DmLdBzkjFn/+Zx0OE2UhZN2zVaa2B9cjIcMAxg
 DspUSY4tAkBPXPYL4uEYgMa61qqwqwX0dA==
X-Google-Smtp-Source: ABdhPJxGZmAWT1kHhkOKYKZ0aJvYobyf2dgd0Hpsw9nRS2jxcmhqZhQ0V3ZodAXLUxcCuCYUSdrfzg==
X-Received: by 2002:a62:1d43:: with SMTP id d64mr877496pfd.76.1599246528759;
 Fri, 04 Sep 2020 12:08:48 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:08:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/19] target/microblaze: Cleanup mb_cpu_do_interrupt
Date: Fri,  4 Sep 2020 12:08:26 -0700
Message-Id: <20200904190842.2282109-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: edgar.iglesias@xilinx.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reindent; remove dead/commented code.
Use D_FLAG to set ESS[DS].
Sink MSR adjustment for kernel entry, iflags and res_addr clear.
Improve CPU_LOG_INT formatting; report pc and msr before and after.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.c | 209 ++++++++++++++++---------------------
 1 file changed, 91 insertions(+), 118 deletions(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 00090526da..27a24bb99a 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -111,6 +111,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
     uint32_t t, msr = mb_cpu_read_msr(env);
+    bool set_esr;
 
     /* IMM flag cannot propagate across a branch and into the dslot.  */
     assert((env->iflags & (D_FLAG | IMM_FLAG)) != (D_FLAG | IMM_FLAG));
@@ -118,142 +119,114 @@ void mb_cpu_do_interrupt(CPUState *cs)
     assert((env->iflags & (D_FLAG | BIMM_FLAG)) != BIMM_FLAG);
     /* RTI flags are private to translate. */
     assert(!(env->iflags & (DRTI_FLAG | DRTE_FLAG | DRTB_FLAG)));
-    env->res_addr = RES_ADDR_NONE;
+
     switch (cs->exception_index) {
-        case EXCP_HW_EXCP:
-            if (!(env->pvr.regs[0] & PVR0_USE_EXC_MASK)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "Exception raised on system without exceptions!\n");
-                return;
-            }
+    case EXCP_HW_EXCP:
+        if (!(env->pvr.regs[0] & PVR0_USE_EXC_MASK)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Exception raised on system without exceptions!\n");
+            return;
+        }
 
-            env->regs[17] = env->pc + 4;
-            env->esr &= ~(1 << 12);
+        qemu_log_mask(CPU_LOG_INT,
+                      "INT: HWE at pc=%08x msr=%08x iflags=%x\n",
+                      env->pc, msr, env->iflags);
 
-            /* Exception breaks branch + dslot sequence?  */
-            if (env->iflags & D_FLAG) {
-                env->esr |= 1 << 12 ;
-                env->btr = env->btarget;
-            }
+        /* Exception breaks branch + dslot sequence?  */
+        set_esr = true;
+        env->esr &= ~D_FLAG;
+        if (env->iflags & D_FLAG) {
+            env->esr |= D_FLAG;
+            env->btr = env->btarget;
+        }
 
-            /* Disable the MMU.  */
-            t = (msr & (MSR_VM | MSR_UM)) << 1;
-            msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
-            msr |= t;
-            /* Exception in progress.  */
-            msr |= MSR_EIP;
-            mb_cpu_write_msr(env, msr);
+        /* Exception in progress. */
+        msr |= MSR_EIP;
+        env->regs[17] = env->pc + 4;
+        env->pc = cpu->cfg.base_vectors + 0x20;
+        break;
 
-            qemu_log_mask(CPU_LOG_INT,
-                          "hw exception at pc=%x ear=%" PRIx64 " "
-                          "esr=%x iflags=%x\n",
-                          env->pc, env->ear,
-                          env->esr, env->iflags);
-            log_cpu_state_mask(CPU_LOG_INT, cs, 0);
-            env->iflags = 0;
-            env->pc = cpu->cfg.base_vectors + 0x20;
-            break;
+    case EXCP_MMU:
+        qemu_log_mask(CPU_LOG_INT,
+                      "INT: MMU at pc=%08x msr=%08x "
+                      "ear=%" PRIx64 " iflags=%x\n",
+                      env->pc, msr, env->ear, env->iflags);
 
-        case EXCP_MMU:
+        /* Exception breaks branch + dslot sequence? */
+        set_esr = true;
+        env->esr &= ~D_FLAG;
+        if (env->iflags & D_FLAG) {
+            env->esr |= D_FLAG;
+            env->btr = env->btarget;
+            /* Reexecute the branch. */
+            env->regs[17] = env->pc - (env->iflags & BIMM_FLAG ? 8 : 4);
+        } else if (env->iflags & IMM_FLAG) {
+            /* Reexecute the imm. */
+            env->regs[17] = env->pc - 4;
+        } else {
             env->regs[17] = env->pc;
+        }
 
-            qemu_log_mask(CPU_LOG_INT,
-                          "MMU exception at pc=%x iflags=%x ear=%" PRIx64 "\n",
-                          env->pc, env->iflags, env->ear);
+        /* Exception in progress. */
+        msr |= MSR_EIP;
+        env->pc = cpu->cfg.base_vectors + 0x20;
+        break;
 
-            env->esr &= ~(1 << 12);
-            /* Exception breaks branch + dslot sequence?  */
-            if (env->iflags & D_FLAG) {
-                env->esr |= 1 << 12 ;
-                env->btr = env->btarget;
+    case EXCP_IRQ:
+        assert(!(msr & (MSR_EIP | MSR_BIP)));
+        assert(msr & MSR_IE);
+        assert(!(env->iflags & (D_FLAG | IMM_FLAG)));
 
-                /* Reexecute the branch.  */
-                env->regs[17] -= 4;
-                /* was the branch immprefixed?.  */
-                if (env->iflags & BIMM_FLAG) {
-                    env->regs[17] -= 4;
-                    log_cpu_state_mask(CPU_LOG_INT, cs, 0);
-                }
-            } else if (env->iflags & IMM_FLAG) {
-                env->regs[17] -= 4;
-            }
+        qemu_log_mask(CPU_LOG_INT,
+                      "INT: DEV at pc=%08x msr=%08x iflags=%x\n",
+                      env->pc, msr, env->iflags);
+        set_esr = false;
 
-            /* Disable the MMU.  */
-            t = (msr & (MSR_VM | MSR_UM)) << 1;
-            msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
-            msr |= t;
-            /* Exception in progress.  */
-            msr |= MSR_EIP;
-            mb_cpu_write_msr(env, msr);
+        /* Disable interrupts.  */
+        msr &= ~MSR_IE;
+        env->regs[14] = env->pc;
+        env->pc = cpu->cfg.base_vectors + 0x10;
+        break;
 
-            qemu_log_mask(CPU_LOG_INT,
-                          "exception at pc=%x ear=%" PRIx64 " iflags=%x\n",
-                          env->pc, env->ear, env->iflags);
-            log_cpu_state_mask(CPU_LOG_INT, cs, 0);
-            env->iflags = 0;
-            env->pc = cpu->cfg.base_vectors + 0x20;
-            break;
+    case EXCP_HW_BREAK:
+        assert(!(env->iflags & (D_FLAG | IMM_FLAG)));
 
-        case EXCP_IRQ:
-            assert(!(msr & (MSR_EIP | MSR_BIP)));
-            assert(msr & MSR_IE);
-            assert(!(env->iflags & (D_FLAG | IMM_FLAG)));
+        qemu_log_mask(CPU_LOG_INT,
+                      "INT: BRK at pc=%08x msr=%08x iflags=%x\n",
+                      env->pc, msr, env->iflags);
+        set_esr = false;
 
-            t = (msr & (MSR_VM | MSR_UM)) << 1;
+        /* Break in progress. */
+        msr |= MSR_BIP;
+        env->regs[16] = env->pc;
+        env->pc = cpu->cfg.base_vectors + 0x18;
+        break;
 
-#if 0
-#include "disas/disas.h"
+    default:
+        cpu_abort(cs, "unhandled exception type=%d\n", cs->exception_index);
+        /* not reached */
+    }
 
-/* Useful instrumentation when debugging interrupt issues in either
-   the models or in sw.  */
-            {
-                const char *sym;
+    /* Save previous mode, disable mmu, disable user-mode. */
+    t = (msr & (MSR_VM | MSR_UM)) << 1;
+    msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
+    msr |= t;
+    mb_cpu_write_msr(env, msr);
 
-                sym = lookup_symbol(env->pc);
-                if (sym
-                    && (!strcmp("netif_rx", sym)
-                        || !strcmp("process_backlog", sym))) {
+    env->res_addr = RES_ADDR_NONE;
+    env->iflags = 0;
 
-                    qemu_log("interrupt at pc=%x msr=%x %x iflags=%x sym=%s\n",
-                             env->pc, msr, t, env->iflags, sym);
-
-                    log_cpu_state(cs, 0);
-                }
-            }
-#endif
-            qemu_log_mask(CPU_LOG_INT,
-                          "interrupt at pc=%x msr=%x %x iflags=%x\n",
-                          env->pc, msr, t, env->iflags);
-
-            msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM | MSR_IE);
-            msr |= t;
-            mb_cpu_write_msr(env, msr);
-
-            env->regs[14] = env->pc;
-            env->iflags = 0;
-            env->pc = cpu->cfg.base_vectors + 0x10;
-            //log_cpu_state_mask(CPU_LOG_INT, cs, 0);
-            break;
-
-        case EXCP_HW_BREAK:
-            assert(!(env->iflags & (D_FLAG | IMM_FLAG)));
-
-            t = (msr & (MSR_VM | MSR_UM)) << 1;
-            qemu_log_mask(CPU_LOG_INT,
-                          "break at pc=%x msr=%x %x iflags=%x\n",
-                          env->pc, msr, t, env->iflags);
-            log_cpu_state_mask(CPU_LOG_INT, cs, 0);
-            msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
-            msr |= t;
-            msr |= MSR_BIP;
-            env->regs[16] = env->pc;
-            env->iflags = 0;
-            env->pc = cpu->cfg.base_vectors + 0x18;
-            mb_cpu_write_msr(env, msr);
-            break;
-        default:
-            cpu_abort(cs, "unhandled exception type=%d\n",
-                      cs->exception_index);
-            break;
+    if (!set_esr) {
+        qemu_log_mask(CPU_LOG_INT,
+                      "         to pc=%08x msr=%08x\n", env->pc, msr);
+    } else if (env->esr & D_FLAG) {
+        qemu_log_mask(CPU_LOG_INT,
+                      "         to pc=%08x msr=%08x esr=%04x btr=%08x\n",
+                      env->pc, msr, env->esr, env->btr);
+    } else {
+        qemu_log_mask(CPU_LOG_INT,
+                      "         to pc=%08x msr=%08x esr=%04x\n",
+                      env->pc, msr, env->esr);
     }
 }
 
-- 
2.25.1


