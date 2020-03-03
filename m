Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09A9C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C492465E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEyA7e84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C492465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8w2O-0003qP-KV
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 20:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vl6-00032A-Jh
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vl5-0004eJ-6o
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:50:04 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vl5-0004dq-07
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:50:03 -0500
Received: by mail-pl1-x644.google.com with SMTP id u3so501436plr.9
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=hFvs1uriIPG137AabzLSMhSoJyIF8wxeh5khJdI5tCA=;
 b=MEyA7e84ywbhUOO5Put43vKHTkEfB/3l6JLzrkGv/1Xj8Pt6wR1JBfbVif7w0S7aYK
 U3dho1Yjmu9WLrEoXITwPOURSE67zZpj0JtdkN1Kb4fhi7oM0t+XuPT61C2faFWHEO+g
 S+hVEL5YrEMPTmq/wyqDddRCk4Q1XDeOo63FCgIucrmnckTQnLoCbHCiLpldCq2wZAdm
 oYC73cyaOtp0vSHmhdc8qHveSHUa4LAA4XbNeBZMcE3nQpsm+P18QKkapwhpnurTX6po
 9hSvmOnsET+lDcI0DkeJ2bqcL+f/VGZv34w4JL+RjJPnjobn2U+S4hGbgxd9urvN5EEc
 db/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=hFvs1uriIPG137AabzLSMhSoJyIF8wxeh5khJdI5tCA=;
 b=TRswbt/Tm1gwEDQ8JQhxQwjh2kWRQ7KBofN8tPgcVeazbhE841bJZRk8+68WZZigRc
 /YZ4005sQHZxawyXO6IA8B0b5lNPmpLyEpWiDQri4hi1JPFtC/A8670iEnxjC9Y/F8QM
 yhfadoZ1sKCbQrNLd2AXhlQwJx4YABAFYwHL9A3SvA+wwHYmaJsAfQx3yB6qW/OiWbkU
 e5NhY0Q290O93C1hlIPQx8mtOTYc7Oes1u3b+Z6obYAjLjaahAqQ0V3HtBcnGrv9Kkh6
 OELQUuEs6TRDkALNT6McRk2SzgVSDIzO8S9YcsWSEG34VYowhFGnTf4Jy2+OHlKQxjIz
 4JdA==
X-Gm-Message-State: ANhLgQ0W2OlArefllSfGUir5/kuLqAcmzxtXTvkNK6+ArRr0EPshHCM/
 1YIpPWiNMS3UdTsFrfa5AjsPiw==
X-Google-Smtp-Source: ADFU+vtCv/gmtcsKjP+S4rxMXxVt4LnuWyboyAcIVD5aVwyK2N/4nWyed2Lg/vvPP2fL11HuKczBrg==
X-Received: by 2002:a17:90a:348a:: with SMTP id
 p10mr1299631pjb.120.1583196601863; 
 Mon, 02 Mar 2020 16:50:01 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id r13sm22296675pgf.1.2020.03.02.16.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:50:01 -0800 (PST)
Subject: [PULL 37/38] target/riscv: Emulate TIME CSRs for privileged mode
Date: Mon,  2 Mar 2020 16:48:47 -0800
Message-Id: <20200303004848.136788-38-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Anup Patel <anup.patel@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <anup.patel@wdc.com>

Currently, TIME CSRs are emulated only for user-only mode. This
patch add TIME CSRs emulation for privileged mode.

For privileged mode, the TIME CSRs will return value provided
by rdtime callback which is registered by QEMU machine/platform
emulation (i.e. CLINT emulation). If rdtime callback is not
available then the monitor (i.e. OpenSBI) will trap-n-emulate
TIME CSRs in software.

We see 25+% performance improvement in hackbench numbers when
TIME CSRs are not trap-n-emulated.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu.h        |  5 +++
 target/riscv/cpu_helper.c |  5 +++
 target/riscv/csr.c        | 86 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d52f209361..3dcdf92227 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -159,6 +159,7 @@ struct CPURISCVState {
     target_ulong htval;
     target_ulong htinst;
     target_ulong hgatp;
+    uint64_t htimedelta;
 
     /* Virtual CSRs */
     target_ulong vsstatus;
@@ -201,6 +202,9 @@ struct CPURISCVState {
     /* physical memory protection */
     pmp_table_t pmp_state;
 
+    /* machine specific rdtime callback */
+    uint64_t (*rdtime_fn)(void);
+
     /* True if in debugger mode.  */
     bool debugger;
 #endif
@@ -322,6 +326,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
+void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void));
 #endif
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 29a1b37d88..5ea5d133aa 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -258,6 +258,11 @@ uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
     return old;
 }
 
+void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void))
+{
+    env->rdtime_fn = fn;
+}
+
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
 {
     if (newpriv > PRV_M) {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 572a478e8c..11d184cd16 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -238,6 +238,32 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
 
 #else /* CONFIG_USER_ONLY */
 
+static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
+
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+    *val = env->rdtime_fn() + delta;
+    return 0;
+}
+
+#if defined(TARGET_RISCV32)
+static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
+
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+    *val = (env->rdtime_fn() + delta) >> 32;
+    return 0;
+}
+#endif
+
 /* Machine constants */
 
 #define M_MODE_INTERRUPTS  (MIP_MSIP | MIP_MTIP | MIP_MEIP)
@@ -930,6 +956,56 @@ static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int read_htimedelta(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+#if defined(TARGET_RISCV32)
+    *val = env->htimedelta & 0xffffffff;
+#else
+    *val = env->htimedelta;
+#endif
+    return 0;
+}
+
+static int write_htimedelta(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+#if defined(TARGET_RISCV32)
+    env->htimedelta = deposit64(env->htimedelta, 0, 32, (uint64_t)val);
+#else
+    env->htimedelta = val;
+#endif
+    return 0;
+}
+
+#if defined(TARGET_RISCV32)
+static int read_htimedeltah(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+    *val = env->htimedelta >> 32;
+    return 0;
+}
+
+static int write_htimedeltah(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+    env->htimedelta = deposit64(env->htimedelta, 32, 32, (uint64_t)val);
+    return 0;
+}
+#endif
+
 /* Virtual CSR Registers */
 static int read_vsstatus(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -1202,14 +1278,12 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_INSTRETH] =            { ctr,  read_instreth                       },
 #endif
 
-    /* User-level time CSRs are only available in linux-user
-     * In privileged mode, the monitor emulates these CSRs */
-#if defined(CONFIG_USER_ONLY)
+    /* In privileged mode, the monitor will have to emulate TIME CSRs only if
+     * rdtime callback is not provided by machine/platform emulation */
     [CSR_TIME] =                { ctr,  read_time                           },
 #if defined(TARGET_RISCV32)
     [CSR_TIMEH] =               { ctr,  read_timeh                          },
 #endif
-#endif
 
 #if !defined(CONFIG_USER_ONLY)
     /* Machine Timers and Counters */
@@ -1275,6 +1349,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_HTVAL] =               { hmode,   read_htval,       write_htval      },
     [CSR_HTINST] =              { hmode,   read_htinst,      write_htinst     },
     [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
+    [CSR_HTIMEDELTA] =          { hmode,   read_htimedelta,  write_htimedelta },
+#if defined(TARGET_RISCV32)
+    [CSR_HTIMEDELTAH] =         { hmode,   read_htimedeltah, write_htimedeltah},
+#endif
 
     [CSR_VSSTATUS] =            { hmode,   read_vsstatus,    write_vsstatus   },
     [CSR_VSIP] =                { hmode,   NULL,     NULL,     rmw_vsip       },
-- 
2.25.0.265.gbab2e86ba0-goog


