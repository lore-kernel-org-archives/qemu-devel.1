Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C9CC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309CF206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvgcKpym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309CF206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0CL-00033i-7X
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jT0Ag-0000sK-Sa
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jT0Ag-0006Rx-1t
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:35:26 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jT0Af-0006Rl-Lx
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:35:25 -0400
Received: by mail-pg1-x544.google.com with SMTP id l20so513581pgb.11
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aUhSOX5F9CnJa419cEE1CR1ViWa3Cn5/hFvSKu87UUQ=;
 b=TvgcKpym8RHEVSHzBgemvusOZ8Nj2S7ZQxBxPdSIwu7Ygx+FrTIvCDZIgjEk6ABd0Y
 Pvaz887lIb4Ku9xLbTS6XmsP04nIy6McweujVm4hzYkRhmPqzQX2CM0CgzyRdOHVfhpS
 XUyuzZ1t1jdcuZTKGIDJ+rk6r29c2B4ygWX5CzrffDbzYk9A7+V7KuqaB/YFeXmPdqUb
 BJSVClEthO9H+/kk0Kga0p2Pi02dZQhS4FsQfZUN5cfgKjdA0aGTbq08BlPDOE0+u4mM
 WX04f2vlcNE9QXywzigf+YBUReWvI6eH5TOXLs86y8F5bWYjQskfDdndjFFQRDBJmWeD
 IbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aUhSOX5F9CnJa419cEE1CR1ViWa3Cn5/hFvSKu87UUQ=;
 b=hRFDyqCtH2BiclLUDfzDqWSI8JepSA4Pz9FgstOaZP1wk0DBMNSIZ3spP5AKGAhGk4
 AdL1hFkqrOKO4v+iLfAGpvHT5+uZoOuCd9nqNNp64OgcSrY9X5IXwtwrNyfnJMyc2TcC
 4fMQ3GBHmJ66y0m9gHvlkcfDQSQtoqo/vCFsjZU85t1IpG0zPhCMVyJ7OMxhLAOT+3gv
 n/ZOLh4i/Z0j4iGxB8clM6ix9EZ9SeAQHlKD9g68teMWLOIsebwTUvHrY+YtCpB/32X5
 cthZW4rnYX8xAWqrB7SIF4Tsmp1VVJElbU4ixOUb6UBVXbow2/VEvmpIPEO7bKjftMH4
 yQ1Q==
X-Gm-Message-State: AGi0PubTvcqA69PRPOHfNCUmLwJzkswJrWNANUXhQ41eBoq9ogSLbchF
 6zaYhjz0CXlniIqr6DgqdhE=
X-Google-Smtp-Source: APiQypLFVjj7+Wld3M8AgTACRW/mV6PbUJwJFz0dQ3or4n44J/pb99/oGiUDtSYSHraBb5TuOYkBnA==
X-Received: by 2002:a62:be0c:: with SMTP id l12mr21430990pff.95.1587980123869; 
 Mon, 27 Apr 2020 02:35:23 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u9sm11333073pfn.197.2020.04.27.02.35.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2020 02:35:23 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 4/7] target/mips: Add Loongson-3 CPU definition
Date: Mon, 27 Apr 2020 17:33:12 +0800
Message-Id: <1587979995-17717-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
R1/R2. Loongson-3A R4 is the newest and its ISA is almost the superset
of all others. To reduce complexity, we just define a "Loongson-3A" CPU
which is corresponding to Loongson-3A R4. Loongson-3A has CONFIG6 and
CONFIG7, so add their bit-fields as well.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/cpu.h                | 28 ++++++++++++++++++++++
 target/mips/internal.h           |  2 ++
 target/mips/mips-defs.h          |  7 ++++--
 target/mips/translate.c          |  2 ++
 target/mips/translate_init.inc.c | 51 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 94d01ea..0b3c987 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -940,7 +940,35 @@ struct CPUMIPSState {
 #define CP0C5_UFR          2
 #define CP0C5_NFExists     0
     int32_t CP0_Config6;
+    int32_t CP0_Config6_rw_bitmask;
+#define CP0C6_BPPASS          31
+#define CP0C6_KPOS            24
+#define CP0C6_KE              23
+#define CP0C6_VTLBONLY        22
+#define CP0C6_LASX            21
+#define CP0C6_SSEN            20
+#define CP0C6_DISDRTIME       19
+#define CP0C6_PIXNUEN         18
+#define CP0C6_SCRAND          17
+#define CP0C6_LLEXCEN         16
+#define CP0C6_DISVC           15
+#define CP0C6_VCLRU           14
+#define CP0C6_DCLRU           13
+#define CP0C6_PIXUEN          12
+#define CP0C6_DISBLKLYEN      11
+#define CP0C6_UMEMUALEN       10
+#define CP0C6_SFBEN           8
+#define CP0C6_FLTINT          7
+#define CP0C6_VLTINT          6
+#define CP0C6_DISBTB          5
+#define CP0C6_STPREFCTL       2
+#define CP0C6_INSTPREF        1
+#define CP0C6_DATAPREF        0
     int32_t CP0_Config7;
+    int64_t CP0_Config7_rw_bitmask;
+#define CP0C7_NAPCGEN       2
+#define CP0C7_UNIMUEN       1
+#define CP0C7_VFPUCGEN      0
     uint64_t CP0_LLAddr;
     uint64_t CP0_MAAR[MIPS_MAAR_MAX];
     int32_t CP0_MAARI;
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 1bf274b..7853cb1 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -36,7 +36,9 @@ struct mips_def_t {
     int32_t CP0_Config5;
     int32_t CP0_Config5_rw_bitmask;
     int32_t CP0_Config6;
+    int32_t CP0_Config6_rw_bitmask;
     int32_t CP0_Config7;
+    int32_t CP0_Config7_rw_bitmask;
     target_ulong CP0_LLAddr_rw_bitmask;
     int CP0_LLAddr_shift;
     int32_t SYNCI_Step;
diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index a831bb4..c2c96db 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -51,8 +51,9 @@
  */
 #define INSN_LOONGSON2E   0x0001000000000000ULL
 #define INSN_LOONGSON2F   0x0002000000000000ULL
-#define INSN_VR54XX       0x0004000000000000ULL
-#define INSN_R5900        0x0008000000000000ULL
+#define INSN_LOONGSON3A   0x0004000000000000ULL
+#define INSN_VR54XX       0x0008000000000000ULL
+#define INSN_R5900        0x0010000000000000ULL
 /*
  *   bits 56-63: vendor-specific ASEs
  */
@@ -94,6 +95,8 @@
 /* Wave Computing: "nanoMIPS" */
 #define CPU_NANOMIPS32  (CPU_MIPS32R6 | ISA_NANOMIPS32)
 
+#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A)
+
 /*
  * Strictly follow the architecture standard:
  * - Disallow "special" instruction handling for PMON/SPIM.
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 25b595a..2caf4cb 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -31206,7 +31206,9 @@ void cpu_state_reset(CPUMIPSState *env)
     env->CP0_Config5 = env->cpu_model->CP0_Config5;
     env->CP0_Config5_rw_bitmask = env->cpu_model->CP0_Config5_rw_bitmask;
     env->CP0_Config6 = env->cpu_model->CP0_Config6;
+    env->CP0_Config6_rw_bitmask = env->cpu_model->CP0_Config6_rw_bitmask;
     env->CP0_Config7 = env->cpu_model->CP0_Config7;
+    env->CP0_Config7_rw_bitmask = env->cpu_model->CP0_Config7_rw_bitmask;
     env->CP0_LLAddr_rw_bitmask = env->cpu_model->CP0_LLAddr_rw_bitmask
                                  << env->cpu_model->CP0_LLAddr_shift;
     env->CP0_LLAddr_shift = env->cpu_model->CP0_LLAddr_shift;
diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index 6d145a9..a32412d 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -802,6 +802,57 @@ const mips_def_t mips_defs[] =
         .mmu_type = MMU_TYPE_R4000,
     },
     {
+        .name = "Loongson-3A",
+        .CP0_PRid = 0x14C000,
+        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
+        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
+                       (MMU_TYPE_R4000 << CP0C0_MT),
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
+                       (2 << CP0C1_IS) | (4 << CP0C1_IL) | (3 << CP0C1_IA) |
+                       (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
+                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
+        .CP0_Config2 = MIPS_CONFIG2,
+        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MSAP) |
+                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_ULRI) |
+                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
+        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE) |
+                       (1 << CP0C4_AE) | (0x1c << CP0C4_KScrExist),
+        .CP0_Config4_rw_bitmask = 0,
+        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_NFExists) | (1 << 18),
+        .CP0_Config5_rw_bitmask = (1 << CP0C5_K) | (1 << CP0C5_CV) |
+                                  (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE) |
+                                  (1 << CP0C5_FRE) | (1 << CP0C5_SBRI),
+        .CP0_Config6 = (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) | (1 << CP0C6_SFBEN) |
+                       (1 << CP0C6_FLTINT) | (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
+        .CP0_Config6_rw_bitmask = (1 << CP0C6_BPPASS) | (0x3f << CP0C6_KPOS) |
+                                  (1 << CP0C6_KE) | (1 << CP0C6_VTLBONLY) | (1 << CP0C6_LASX) |
+                                  (1 << CP0C6_SSEN) | (1 << CP0C6_DISDRTIME) |
+                                  (1 << CP0C6_PIXNUEN) | (1 << CP0C6_SCRAND) |
+                                  (1 << CP0C6_LLEXCEN) | (1 << CP0C6_DISVC) |
+                                  (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) |
+                                  (1 << CP0C6_PIXUEN) | (1 << CP0C6_DISBLKLYEN) |
+                                  (1 << CP0C6_UMEMUALEN) | (1 << CP0C6_SFBEN) |
+                                  (1 << CP0C6_FLTINT) | (1 << CP0C6_VLTINT) |
+                                  (1 << CP0C6_DISBTB) | (3 << CP0C6_STPREFCTL) |
+                                  (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
+        .CP0_Config7 = 0,
+        .CP0_Config7_rw_bitmask = (1 << CP0C7_NAPCGEN) | (1 << CP0C7_UNIMUEN) | \
+                                  (1 << CP0C7_VFPUCGEN),
+        .CP0_LLAddr_rw_bitmask = 1,
+        .SYNCI_Step = 16,
+        .CCRes = 2,
+        .CP0_Status_rw_bitmask = 0x7DDBFFFF,
+        .CP0_PageGrain_rw_bitmask = (1U << CP0PG_RIE) | (1 << CP0PG_XIE) |
+                    (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
+        .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << FCR0_F64),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
+        .SEGBITS = 48,
+        .PABITS = 48,
+        .insn_flags = CPU_LOONGSON3A,
+        .mmu_type = MMU_TYPE_R4000,
+    },
+    {
         /* A generic CPU providing MIPS64 DSP R2 ASE features.
            FIXME: Eventually this should be replaced by a real CPU model. */
         .name = "mips64dspr2",
-- 
2.7.0


