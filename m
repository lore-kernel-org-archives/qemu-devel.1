Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619D1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D8E20665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GD3E5qCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D8E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgDU-0005xd-AA
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg38-00079f-88
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:10 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg36-0001fs-85
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id t9so4126129pfq.8
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kxuKPEsnkZdfVwCBdweXYlcCCLoCz5+CGJqBlv/VqWk=;
 b=GD3E5qCkYkw51GLIr33M6sGVxn/rVSX/MWl0QOQb2E+cyhWEkZcJD4KDWGnRylaLoR
 QZu+t7CJgJg+cgJo74sXw+8yZxkg52/Q6Z0IX6etci8Ym+XWdv40WRgygURjL6YliLB0
 N0PGY3DYU4A9Tg1nsFHfhwM0dk72Vlq8T2SuNRlsTLhD/UaIl/zEFHPnpSc5QP9rDQro
 BXmNQ28GOV8kX5+GROm3MSf/nmpo4vC9LR0H5MzQXx3kcTv5djLJ9/x3K1auXx1g0nJE
 uuuLqmVEQAxc9cB8EyVB0A9EuFGXHJwESg4Z9BrUwVfuIzJku7cjA4MHaTKhh3cAAYGA
 CJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kxuKPEsnkZdfVwCBdweXYlcCCLoCz5+CGJqBlv/VqWk=;
 b=rPeeobzl2FagcnvN6A/8gbB6jX1T25Y3CGSQ7u0TqMizA8yv9QOZCUEtIv4ySCNpuI
 HfBCgV3RSbxrgmyn1t1LXfhaUN6WhmoyQ/9SRER9oH1gFY9bvw2DZf2N+ovb+07IRsPU
 NycIhuxX2Gr6qV2MYaA/q5PMSbFD0nv1jy80FRKDi2UdYnqAnoGo2mEugAbQITRYdQd8
 rQtqpgf6cMRABLVn0YuH0HmItuBdk+ESUGQZOdjAYIr/HQRMmN0Ts1PnUKCZSfnXxeBP
 QsI6Eb2BnCn/yVfQAfg/w1c/7+h3fA9k5Ep6lQm6hhNUR2ss6iDnmhRhmnqCNUpT1iC+
 dUiw==
X-Gm-Message-State: AOAM532+E+rZZUuvUiObR/N+UC0j5oH6zeCKC1VvPBzpXa/b1MfXi1Ym
 zuyU1SGaGXWMemT5jN8PS4a15FfxdTdLaw==
X-Google-Smtp-Source: ABdhPJzVyojSFyxParfEuS5cPh5n8x2q2j9C6ca1W9v5wtt/tHIy/NrXGGPVb1HTn///H7Gx41tbCw==
X-Received: by 2002:a62:18ce:: with SMTP id 197mr9227929pfy.85.1598389206419; 
 Tue, 25 Aug 2020 14:00:06 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/77] target/microblaze: Split out EDR from env->sregs
Date: Tue, 25 Aug 2020 13:58:44 -0700
Message-Id: <20200825205950.730499-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Finish eliminating the sregs array in favor of individual members.
Does not correct the width of EDR, yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  2 +-
 linux-user/elfload.c          |  9 ++++++---
 target/microblaze/gdbstub.c   |  4 ++--
 target/microblaze/translate.c | 16 +++-------------
 4 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index deddb47abb..610ddfb719 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -242,7 +242,7 @@ struct CPUMBState {
     uint64_t esr;
     uint64_t fsr;
     uint64_t btr;
-    uint64_t sregs[14];
+    uint64_t edr;
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
     uint32_t slr, shr;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fe9dfe795d..bbfb665321 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1032,9 +1032,12 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
         (*regs)[pos++] = tswapreg(env->regs[i]);
     }
 
-    for (i = 0; i < 6; i++) {
-        (*regs)[pos++] = tswapreg(env->sregs[i]);
-    }
+    (*regs)[pos++] = tswapreg(env->pc);
+    (*regs)[pos++] = tswapreg(env->msr);
+    (*regs)[pos++] = 0;
+    (*regs)[pos++] = tswapreg(env->ear);
+    (*regs)[pos++] = 0;
+    (*regs)[pos++] = tswapreg(env->esr);
 }
 
 #endif /* TARGET_MICROBLAZE */
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index cde8c169bf..9cba9d2215 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -81,7 +81,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->pvr.regs[n - GDB_PVR0];
         break;
     case GDB_EDR:
-        val = env->sregs[SR_EDR];
+        val = env->edr;
         break;
     case GDB_SLR:
         val = env->slr;
@@ -137,7 +137,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->pvr.regs[n - GDB_PVR0] = tmp;
         break;
     case GDB_EDR:
-        env->sregs[SR_EDR] = tmp;
+        env->edr = tmp;
         break;
     case GDB_SLR:
         env->slr = tmp;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 469e1f103a..7d307e6b48 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -103,12 +103,6 @@ static const char *regnames[] =
     "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
 };
 
-static const char *special_regnames[] =
-{
-    "rpc", "rmsr", "sr2", "rear", "sr4", "resr", "sr6", "rfsr",
-    "sr8", "sr9", "sr10", "rbtr", "sr12", "redr"
-};
-
 static inline void t_sync_flags(DisasContext *dc)
 {
     /* Synch the tb dependent flags between translator and runtime.  */
@@ -1828,7 +1822,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
     /* Registers that aren't modeled are reported as 0 */
     qemu_fprintf(f, "redr=%" PRIx64 " rpid=0 rzpr=0 rtlbx=0 rtlbsx=0 "
-                    "rtlblo=0 rtlbhi=0\n", env->sregs[SR_EDR]);
+                    "rtlblo=0 rtlbhi=0\n", env->edr);
     qemu_fprintf(f, "slr=%x shr=%x\n", env->slr, env->shr);
     for (i = 0; i < 32; i++) {
         qemu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
@@ -1881,12 +1875,8 @@ void mb_tcg_init(void)
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, fsr), "rfsr");
     cpu_SR[SR_BTR] =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, btr), "rbtr");
-
-    for (i = SR_BTR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
-        cpu_SR[i] = tcg_global_mem_new_i64(cpu_env,
-                          offsetof(CPUMBState, sregs[i]),
-                          special_regnames[i]);
-    }
+    cpu_SR[SR_EDR] =
+        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, edr), "redr");
 }
 
 void restore_state_to_opc(CPUMBState *env, TranslationBlock *tb,
-- 
2.25.1


