Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BA1C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0382053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBvSq0aV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0382053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OWe-0001wm-S8
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.lee.qnl@gmail.com>)
 id 1k4KsV-0000kW-6D; Sat, 08 Aug 2020 05:10:59 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ethan.lee.qnl@gmail.com>)
 id 1k4KsT-0000bm-Hg; Sat, 08 Aug 2020 05:10:58 -0400
Received: by mail-pj1-x1043.google.com with SMTP id l60so2170076pjb.3;
 Sat, 08 Aug 2020 02:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fWKpYnUfRg0gxuuuKT5iT/I7/Zv/OLd6oIWfqWvvQUg=;
 b=EBvSq0aVNEf5XTvrqLvnxFtrcJOkxncyp0RHzljQ8G+uaGTpPdIWGCns6+GUDbTLno
 OD8fLHkGLgjCLFGmD/T+W2s/xruF+hRkJjJ8ip4gT5NyccGI2N11mVshNrtVpHY+4oNm
 jJ8K2IkCYWV9UsbqprhAVTQuHRLPxljPoT6lTDh2gIUonII5aOJAJ8OSCMUPWcwyOpQA
 vP32DbpjANZ1+Z2M/2QEo7C6eXX4tJZCET/VJ9O8YgTW0KsRI0iZxGOHkiY0llXbqNxP
 MTcj456MPfNsqwlhBs1QcONepCsaeeFgHRWJ2FqnDmCMMXR862OyjsYXlCTDSfDK5qxN
 MiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fWKpYnUfRg0gxuuuKT5iT/I7/Zv/OLd6oIWfqWvvQUg=;
 b=aOuGiRHjyWCpNRJB6kT/G+jCEbAL9fJTInWH7JEc7M7L4qO5yGbUk4WLFKS/WLwBdr
 JpykOXa7SBwAyYNcnbkrLmonRUDog4MiXXTOE94Np2Kj3STzrDWPllQ+wcYx3Pf3fyPw
 hjTODut6Md2UiIwUHVzS+UX2IrkvhXj3nCzzzmmyiDUJcAzIKpWli+iIHV60pfyB0mhU
 voaO+5gJ58ykM54831kjhF1WJTlgZh3cJWohD5jhV3uHEPSm0HLdD0QzPoRBnenu4v8X
 cBRlyeU14lFhHHrvckUi1gN7QUVrNXhpfhqE17w0BOaT3Qjx9Gv852g9L1FWIfHwvFR9
 pLZA==
X-Gm-Message-State: AOAM530i7HgHVCduWh1uim47T43XZIIgKhGHcvIIpVDVgkLb7YOlDDyn
 GiuzcWCG6gEfJ0A50XXbkNVZfGUIsWPZGQ==
X-Google-Smtp-Source: ABdhPJylzfvKTv1USFPo4NvG63pys7FzBVwTk13/oLwbBLcLs5kYzzzRWR/CuQ0g76mOsJexEPq92Q==
X-Received: by 2002:a17:902:ba83:: with SMTP id
 k3mr16155769pls.217.1596877855605; 
 Sat, 08 Aug 2020 02:10:55 -0700 (PDT)
Received: from localhost.localdomain (183178047145.ctinets.com.
 [183.178.47.145])
 by smtp.gmail.com with ESMTPSA id i11sm13312700pjv.30.2020.08.08.02.10.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Aug 2020 02:10:55 -0700 (PDT)
From: Hongzheng-Li <ethan.lee.qnl@gmail.com>
X-Google-Original-From: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/4] Add ePMP CSR accesses
Date: Sat,  8 Aug 2020 17:09:49 +0800
Message-Id: <20200808090950.13-4-Ethan.Lee.QNL@gmail.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200808090950.13-1-Ethan.Lee.QNL@gmail.com>
References: <20200808090950.13-1-Ethan.Lee.QNL@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=ethan.lee.qnl@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2020 08:59:47 -0400
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
Cc: Hou Weiying <weiying_hou@outlook.com>, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, Hongzheng-Li <Ethan.Lee.QNL@gmail.com>,
 Alistair.Francis@wdc.com, palmer@dabbelt.com,
 Myriad-Dreamin <camiyoru@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hou Weiying <weiying_hou@outlook.com>

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
---
 target/riscv/csr.c | 18 ++++++++++++++++++
 target/riscv/pmp.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 11d184cd16..e2395e3a51 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -112,6 +112,11 @@ static int hmode(CPURISCVState *env, int csrno)
     return -1;
 }
 
+static int epmp(CPURISCVState *env, int csrno)
+{
+    return -!(env->priv == PRV_M && riscv_feature(env, RISCV_FEATURE_EPMP));
+}
+
 static int pmp(CPURISCVState *env, int csrno)
 {
     return -!riscv_feature(env, RISCV_FEATURE_PMP);
@@ -1160,6 +1165,18 @@ static int write_pmpaddr(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int read_mseccfg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = mseccfg_csr_read(env);
+    return 0;
+}
+
+static int write_mseccfg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    mseccfg_csr_write(env, val);
+    return 0;
+}
+
 #endif
 
 /*
@@ -1368,6 +1385,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MTINST] =              { hmode,   read_mtinst,      write_mtinst     },
 
     /* Physical Memory Protection */
+    [CSR_MSECCFG] =             { epmp,    read_mseccfg,     write_mseccfg    },
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
 
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 8df389cecd..0eabaf690c 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -490,3 +490,43 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 
     return val;
 }
+
+
+/*
+ * Handle a write to a mseccfg CSR
+ */
+void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
+{
+    int i;
+
+    if (!MSECCFG_RLB_ISSET(env)) {
+        for (i = 0; i < MAX_RISCV_PMPS; i++) {
+            if (pmp_is_locked(env, i)) {
+                /*
+                 * Now that mseccfg.rlb is zero
+                 * the value of mseccfg.rlb should be locked.
+                 */
+                val &= ~MSECCFG_RLB;
+                break;
+            }
+        }
+    }
+
+    /*
+     * sticky bit
+     */
+    val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
+
+    env->mseccfg = val;
+    trace_mseccfg_csr_write(env->mhartid, val);
+}
+
+
+/*
+ * Handle a read from a mseccfg CSR
+ */
+target_ulong mseccfg_csr_read(CPURISCVState *env)
+{
+    trace_mseccfg_csr_read(env->mhartid, env->mseccfg);
+    return env->mseccfg;
+}
-- 
2.20.1


