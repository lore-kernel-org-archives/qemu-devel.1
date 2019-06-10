Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44258C468BD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166D320820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="empLdOAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166D320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haAAO-0006mI-CO
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53371)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eM-0006wf-PG
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eJ-00022z-CW
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:05 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:39497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9eH-0001yX-EF
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:02 -0400
Received: by mail-pg1-x533.google.com with SMTP id 196so4153017pgc.6
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qPjUQH6Gnjw3woo8tVennI13rz+FQ3RM//Ufnw5/vLw=;
 b=empLdOANKSZ0wOqjuutmzftQ7MIjP7Ix42+iSNW8lPtIUlrg9xHJ3MV/axcInylY6J
 Gcu0Z0M59cH8bRyAabC1Pq80ofHnGn9vgRyPkhOdIjBXjrYHRGGrhdwIRah8mjnpELYI
 /iYXhxc3zn7j49RH4//Qa3HpJMXD4Dkucf+D/dhCxhW+doFxRiRRv3wJbmHJcB9DJxeV
 UoclO/PhCiwhdYyR6PwNQgzrddSgz/G3cdCde10Lob4+PuIFKnCNDZUeCeXZnGE+BWzC
 vAC/QtRt9tlPM94TJc0/8zBkQ+ITmO7hzje4Gx6+yyKQ+1soQu+/uzaJhcqUiswjLTZc
 oxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qPjUQH6Gnjw3woo8tVennI13rz+FQ3RM//Ufnw5/vLw=;
 b=HTgM291C9nXA8l9VMo5L+XKZmiadkKM95wcSywayjWXj4SVnrLOCKdb+CAuJCqpvrk
 EysxR5W2+QNg4s03T+0oePh6xxKYQ09/F3RVf70MsmRxhMr8i3z+zk6epjAiHcazgJBr
 L7yXpABAdRQxamjqQKGB/blp1W6F3MQX0rhP6/zEq8CM+5XHRtMYVWjU33804ffa25Ew
 7pVY/bBLaPJ0CQVNppUfYFkIP2cugwrg1gDSVnc5nu83fc11NciXjHB1z7z3P7UeZpPc
 RcgwCOp61kR5Bv2Hehm5e2f/Bp6qC/K6+UMxc6nP1mBrrDS4TE0xWXWq7M9NB1MwRySR
 0e0Q==
X-Gm-Message-State: APjAAAUYsAX9FVBh/qgWH3/kWcae9yuIbJa+e+Q8cNUsJniDbvF48fBu
 tSpj9+hh67ii5ZO0KKsa39AkCmL2mZo=
X-Google-Smtp-Source: APXvYqzLu9/0t70jwrKaD1T6aFCw5pSG1WH9H4R2prKK4ux1cKx8od/3ORWi355uxbTHHHov4x+PAw==
X-Received: by 2002:a63:6647:: with SMTP id a68mr13532109pgc.414.1560132177614; 
 Sun, 09 Jun 2019 19:02:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:10 -0700
Message-Id: <20190610020218.9228-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: [Qemu-devel] [PULL 31/39] cpu: Move ENV_OFFSET to exec/gen-icount.h
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we have ArchCPU, we can define this generically,
in the one place that needs it.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gen-icount.h | 2 ++
 target/alpha/cpu.h        | 1 -
 target/arm/cpu.h          | 2 --
 target/cris/cpu.h         | 1 -
 target/hppa/cpu.h         | 1 -
 target/i386/cpu.h         | 1 -
 target/lm32/cpu.h         | 1 -
 target/m68k/cpu.h         | 1 -
 target/microblaze/cpu.h   | 1 -
 target/mips/cpu.h         | 1 -
 target/moxie/cpu.h        | 1 -
 target/nios2/cpu.h        | 1 -
 target/openrisc/cpu.h     | 1 -
 target/ppc/cpu.h          | 1 -
 target/riscv/cpu.h        | 2 --
 target/s390x/cpu.h        | 1 -
 target/sh4/cpu.h          | 1 -
 target/sparc/cpu.h        | 1 -
 target/tilegx/cpu.h       | 1 -
 target/tricore/cpu.h      | 1 -
 target/unicore32/cpu.h    | 1 -
 target/xtensa/cpu.h       | 2 --
 22 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 24f7991781..9cfa6ccce5 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -5,6 +5,8 @@
 
 /* Helpers for instruction counting code generation.  */
 
+#define ENV_OFFSET   offsetof(ArchCPU, env)
+
 static TCGOp *icount_start_insn;
 
 static inline void gen_tb_start(TranslationBlock *tb)
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 86d3e953b9..361f85c976 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -278,7 +278,6 @@ struct AlphaCPU {
     QEMUTimer *alarm_timer;
 };
 
-#define ENV_OFFSET offsetof(AlphaCPU, env)
 
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_alpha_cpu;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c7df3816b5..abe6fce7ab 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -917,8 +917,6 @@ void arm_cpu_post_init(Object *obj);
 
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
 
-#define ENV_OFFSET offsetof(ARMCPU, env)
-
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_arm_cpu;
 #endif
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index e9e4e39a40..83c350377a 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -183,7 +183,6 @@ struct CRISCPU {
     CPUCRISState env;
 };
 
-#define ENV_OFFSET offsetof(CRISCPU, env)
 
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_cris_cpu;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 75e6a91a5e..7f9f54731b 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -222,7 +222,6 @@ struct HPPACPU {
     QEMUTimer *alarm_timer;
 };
 
-#define ENV_OFFSET      offsetof(HPPACPU, env)
 
 typedef CPUHPPAState CPUArchState;
 typedef HPPACPU ArchCPU;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 709d88cfcf..3a155c12d3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1480,7 +1480,6 @@ struct X86CPU {
     int32_t hv_max_vps;
 };
 
-#define ENV_OFFSET offsetof(X86CPU, env)
 
 #ifndef CONFIG_USER_ONLY
 extern struct VMStateDescription vmstate_x86_cpu;
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 7fb65fb4b6..2c934472d6 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -195,7 +195,6 @@ struct LM32CPU {
     uint32_t features;
 };
 
-#define ENV_OFFSET offsetof(LM32CPU, env)
 
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_lm32_cpu;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7f3fa8d141..4006663494 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -163,7 +163,6 @@ struct M68kCPU {
     CPUM68KState env;
 };
 
-#define ENV_OFFSET offsetof(M68kCPU, env)
 
 void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 8402cc81f6..a17c12ca2f 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -310,7 +310,6 @@ struct MicroBlazeCPU {
     CPUMBState env;
 };
 
-#define ENV_OFFSET offsetof(MicroBlazeCPU, env)
 
 void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index cb09425476..24fe25f61c 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1071,7 +1071,6 @@ struct MIPSCPU {
     CPUMIPSState env;
 };
 
-#define ENV_OFFSET offsetof(MIPSCPU, env)
 
 void mips_cpu_list(void);
 
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index b9f5635e50..3d418c8f1d 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -90,7 +90,6 @@ typedef struct MoxieCPU {
     CPUMoxieState env;
 } MoxieCPU;
 
-#define ENV_OFFSET offsetof(MoxieCPU, env)
 
 void moxie_cpu_do_interrupt(CPUState *cs);
 void moxie_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 9490ba83e4..c96d797dda 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -194,7 +194,6 @@ typedef struct Nios2CPU {
     uint32_t fast_tlb_miss_addr;
 } Nios2CPU;
 
-#define ENV_OFFSET offsetof(Nios2CPU, env)
 
 void nios2_tcg_init(void);
 void nios2_cpu_do_interrupt(CPUState *cs);
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 9e46ac5266..39e2765aa2 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -317,7 +317,6 @@ typedef struct OpenRISCCPU {
 
 } OpenRISCCPU;
 
-#define ENV_OFFSET offsetof(OpenRISCCPU, env)
 
 void cpu_openrisc_list(void);
 void openrisc_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 73ef868a7b..73b92c189c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1203,7 +1203,6 @@ struct PowerPCCPU {
     int32_t mig_slb_nr;
 };
 
-#define ENV_OFFSET offsetof(PowerPCCPU, env)
 
 PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 29a1e08f03..d9611eaced 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -239,8 +239,6 @@ extern const char * const riscv_fpr_regnames[];
 extern const char * const riscv_excp_names[];
 extern const char * const riscv_intr_names[];
 
-#define ENV_OFFSET offsetof(RISCVCPU, env)
-
 void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index d18b279d87..dbf13c9221 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -163,7 +163,6 @@ struct S390CPU {
     uint32_t irqstate_saved_size;
 };
 
-#define ENV_OFFSET offsetof(S390CPU, env)
 
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_s390_cpu;
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 089eea261c..610a8db6de 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -207,7 +207,6 @@ struct SuperHCPU {
     CPUSH4State env;
 };
 
-#define ENV_OFFSET offsetof(SuperHCPU, env)
 
 void superh_cpu_do_interrupt(CPUState *cpu);
 bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index adcd9e3000..0cc36873ce 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -532,7 +532,6 @@ struct SPARCCPU {
     CPUSPARCState env;
 };
 
-#define ENV_OFFSET offsetof(SPARCCPU, env)
 
 #ifndef CONFIG_USER_ONLY
 extern const struct VMStateDescription vmstate_sparc_cpu;
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 7f8fe7c513..643b7dbd17 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -138,7 +138,6 @@ typedef struct TileGXCPU {
     CPUTLGState env;
 } TileGXCPU;
 
-#define ENV_OFFSET offsetof(TileGXCPU, env)
 
 /* TILE-Gx memory attributes */
 #define MMU_USER_IDX    0  /* Current memory operation is in user mode */
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 6a40d37362..9f45bb5c24 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -208,7 +208,6 @@ struct TriCoreCPU {
     CPUTriCoreState env;
 };
 
-#define ENV_OFFSET offsetof(TriCoreCPU, env)
 
 hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void tricore_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 595dc43c99..c1130e9548 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -76,7 +76,6 @@ struct UniCore32CPU {
     CPUUniCore32State env;
 };
 
-#define ENV_OFFSET offsetof(UniCore32CPU, env)
 
 void uc32_cpu_do_interrupt(CPUState *cpu);
 bool uc32_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 97b7bae0fe..e89605747a 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -559,8 +559,6 @@ struct XtensaCPU {
     CPUXtensaState env;
 };
 
-#define ENV_OFFSET offsetof(XtensaCPU, env)
-
 
 bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
-- 
2.17.1


