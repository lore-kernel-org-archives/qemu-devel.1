Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66478C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0544C206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SGLz9X+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0544C206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wVs-0003an-0m
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLm-0005UM-Kc; Wed, 12 Aug 2020 15:23:50 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLk-0000UI-8i; Wed, 12 Aug 2020 15:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597260228; x=1628796228;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=07WsTc6gaeBdPMBMD4A/pfdjPV0i19qXTXVdCMkyTog=;
 b=SGLz9X+cXL209w5KlOQltX65pIWw21217a+is/DM/upMQjbj85ZLmBlh
 nSIGoBmqCqyebVaGYVIUYeE5StavHmWUCnNR+eefQ01tueGYY/gZhdSOx
 rVt9cEY2TkYxArvSI4ffDBhyy2Y/i6AJkKzgKQOUIwi/bO/st7mnXnY0d
 iTHRqmxg5VWqRxkk2AfAOoLz0qIS884iEcUClOsO/RKXKba5EcmqV5Ja3
 PWgrct7h5KRjmXre5JYYpynYpjjt0FQ76TR9/L9gEv6ZR+Bcv4DkARWXp
 2xMNovC+oAn/V1cz95b5bF6CRaimIvUmdK1vWQUHKpxLZaq41KzyQkRY+ g==;
IronPort-SDR: F/1duVC1eLkWNkRsJxCV6xULZZeyiDyA35Lzl2oObfms20eAPrgMPNJm7URunydozEp8+Yahcu
 OSATzHMkC/V0wvpZFZaOuozagORlg908TUg1C2OI9i/LDGF/rJjK0LwZ5etCnbvwabTz0dhmUG
 rCnlFbZnvig1j7+rxaDAgnYd12kPp6n5VlnTgu5g2nmM71LGGM9Wraz7vX++yMd5y+Nryci8QI
 pXt7fG7wFhDVkq8HFOiORUD/hZQfsaEy+hCPmaFdbERYkMFGiELLJTkC5SAFk07Ae8idNBzame
 bwc=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="146029215"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 03:23:47 +0800
IronPort-SDR: hlZEhZc/SvATxmO3cQsn5CsytzriY8slBcYoxeKuVRYNL7uh+Oe1RZjgne2pRwIkTgxr5cyqQl
 ubRsGpWVN0EA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 12:10:55 -0700
IronPort-SDR: 57/FA8X+pGpcRu0PeNnv63NqVhkzkaETnhevzqNIuQq8/CMu6js0xn8BlPu9+GdYSr8YzPkmnp
 /PWGfzoFZRaw==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Aug 2020 12:23:48 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 12/13] target/riscv: Return the exception from invalid CSR
 accesses
Date: Wed, 12 Aug 2020 12:13:46 -0700
Message-Id: <a487dad60c9b8fe7a2b992c5e0dcc2504a9000a7.1597259519.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597259519.git.alistair.francis@wdc.com>
References: <cover.1597259519.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 15:23:20
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, anup.patel@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When performing a CSR access let's return a negative exception value on
an error instead of -1. This will allow us to specify the exception in
future patches.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c       | 46 ++++++++++++++++++++--------------------
 target/riscv/op_helper.c | 18 ++++++++++------
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7dc50e6299..197ce97e95 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -51,7 +51,7 @@ static int fs(CPURISCVState *env, int csrno)
         return 0;
     }
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     return 0;
@@ -73,7 +73,7 @@ static int ctr(CPURISCVState *env, int csrno)
 
     if (!cpu->cfg.ext_counters) {
         /* The Counters extensions is not enabled */
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     return 0;
@@ -101,7 +101,7 @@ static int hmode(CPURISCVState *env, int csrno)
         }
     }
 
-    return -1;
+    return -RISCV_EXCP_ILLEGAL_INST;
 }
 
 static int pmp(CPURISCVState *env, int csrno)
@@ -115,7 +115,7 @@ static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     *val = riscv_cpu_get_fflags(env);
@@ -126,7 +126,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mstatus |= MSTATUS_FS;
 #endif
@@ -138,7 +138,7 @@ static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     *val = env->frm;
@@ -149,7 +149,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mstatus |= MSTATUS_FS;
 #endif
@@ -161,7 +161,7 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
@@ -177,7 +177,7 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mstatus |= MSTATUS_FS;
 #endif
@@ -291,7 +291,7 @@ static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
     uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
 
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     *val = env->rdtime_fn() + delta;
@@ -304,7 +304,7 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
     uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
 
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     *val = (env->rdtime_fn() + delta) >> 32;
@@ -570,7 +570,7 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
 static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
 {
     if (env->priv_ver < PRIV_VERSION_1_11_0) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     *val = env->mcounteren;
     return 0;
@@ -580,7 +580,7 @@ static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
 {
     if (env->priv_ver < PRIV_VERSION_1_11_0) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mcounteren = val;
     return 0;
@@ -804,7 +804,7 @@ static int read_satp(CPURISCVState *env, int csrno, target_ulong *val)
     }
 
     if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     } else {
         *val = env->satp;
     }
@@ -821,7 +821,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
         ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
     {
         if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
-            return -1;
+            return -RISCV_EXCP_ILLEGAL_INST;
         } else {
             if((val ^ env->satp) & SATP_ASID) {
                 tlb_flush(env_cpu(env));
@@ -991,7 +991,7 @@ static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
 static int read_htimedelta(CPURISCVState *env, int csrno, target_ulong *val)
 {
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
 #if defined(TARGET_RISCV32)
@@ -1005,7 +1005,7 @@ static int read_htimedelta(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_htimedelta(CPURISCVState *env, int csrno, target_ulong val)
 {
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
 #if defined(TARGET_RISCV32)
@@ -1020,7 +1020,7 @@ static int write_htimedelta(CPURISCVState *env, int csrno, target_ulong val)
 static int read_htimedeltah(CPURISCVState *env, int csrno, target_ulong *val)
 {
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     *val = env->htimedelta >> 32;
@@ -1030,7 +1030,7 @@ static int read_htimedeltah(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_htimedeltah(CPURISCVState *env, int csrno, target_ulong val)
 {
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     env->htimedelta = deposit64(env->htimedelta, 32, 32, (uint64_t)val);
@@ -1228,18 +1228,18 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
     if ((write_mask && read_only) ||
         (!env->debugger && (effective_priv < get_field(csrno, 0x300)))) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
 
     /* ensure the CSR extension is enabled. */
     if (!cpu->cfg.ext_icsr) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     /* check predicate */
     if (!csr_ops[csrno].predicate || csr_ops[csrno].predicate(env, csrno) < 0) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     /* execute combined read/write operation if it exists */
@@ -1249,7 +1249,7 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
     /* if no accessor exists then return failure */
     if (!csr_ops[csrno].read) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     /* read old value */
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 4b64bfe7d2..948d204793 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -43,8 +43,10 @@ target_ulong helper_csrrw(CPURISCVState *env, target_ulong src,
         target_ulong csr)
 {
     target_ulong val = 0;
-    if (riscv_csrrw(env, csr, &val, src, -1) < 0) {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    int ret = riscv_csrrw(env, csr, &val, src, -1);
+
+    if (ret < 0) {
+        riscv_raise_exception(env, -ret, GETPC());
     }
     return val;
 }
@@ -53,8 +55,10 @@ target_ulong helper_csrrs(CPURISCVState *env, target_ulong src,
         target_ulong csr, target_ulong rs1_pass)
 {
     target_ulong val = 0;
-    if (riscv_csrrw(env, csr, &val, -1, rs1_pass ? src : 0) < 0) {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    int ret = riscv_csrrw(env, csr, &val, -1, rs1_pass ? src : 0);
+
+    if (ret < 0) {
+        riscv_raise_exception(env, -ret, GETPC());
     }
     return val;
 }
@@ -63,8 +67,10 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
         target_ulong csr, target_ulong rs1_pass)
 {
     target_ulong val = 0;
-    if (riscv_csrrw(env, csr, &val, 0, rs1_pass ? src : 0) < 0) {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    int ret = riscv_csrrw(env, csr, &val, 0, rs1_pass ? src : 0);
+
+    if (ret < 0) {
+        riscv_raise_exception(env, -ret, GETPC());
     }
     return val;
 }
-- 
2.27.0


