Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541EBC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C846206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GmV7xq+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C846206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyNXH-0008KV-S2
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 17:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNRv-0002vZ-E6
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNRu-0006Bs-58
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:38:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1236ab962=alistair.francis@wdc.com>)
 id 1hyNRt-00069s-IT; Thu, 15 Aug 2019 17:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1565905101; x=1597441101;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uwuM+Bgdl8OMIy2aZPhcFOR0tnj4yo5dn4bBCycd9KM=;
 b=GmV7xq+7LzHQjRo2mNmDRM5kjMM1sjP5mYwd3aj/x1YfJQXX3gXFtpTA
 RWJL81JskilnTaV2aI6z206/24sew3nWyx5q130LYzqCyoKIghc4d6Ajg
 CfxTvXzovVx6Ebp1G7sojIyOLxUARSaULU3/RWX7ShxSYqDxvEEJU0qde
 McsdJZtIJawtjGQ68lLlw2hRk4d56FaXtymhtxU4l6uLyO+M88xG4CbT7
 SqST5ouvofHYVFr36xlOEfIvi0QKCqS45J/8MQupE5GoF3E+FOXyj5Y+j
 dU6gPbd10aHJeLlY6f0o2jSeopplwTWZVtxgLGalarAf9+KsDvjcYfHk8 Q==;
IronPort-SDR: 6J3tMr70V1cm63s3gwp6CtJq0E+fXX+F4qTZXfuHLmci5Vf51X1bYPWnjk2oriaWcZm+GfhyIm
 xgBCUF9Hs3yAfwRLKLt+S6nCsJ+w8C9KZ6uZzo0UTD+hocR2Sy3J6IfvKEFhQwWZ0gO9+reE9R
 F5XSnvDFHHxqOcYAZ2a9PUGG7nLadLbrkMiTsxG6be6hl8hEvHnEFoIKUJxyB/Rc0zRrKNuapv
 Ik13DcIqeSFdl0l5RoEcy1ohIqfebAUFUaEYsJGKBkGrBu5p+ChUn6i9sjWTX9oOF7cHQ97EUk
 RZo=
X-IronPort-AV: E=Sophos;i="5.64,389,1559491200"; d="scan'208";a="222470296"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 05:38:20 +0800
IronPort-SDR: psuVA4GYRt6KWkF5hg/83ElHm6yiQK8IkH6LO+StH40qSMFl7wfZijGTepfQrXnFIKxTAZa77f
 QZwRbruXreioxJr2ArYqNZ6+CKeO+uuTEuDEB1fgL8JNQd9vPluTLrGBrbqcw7iNVFfTm4rEOz
 OkZzQjuhr40FY7PS1HlcvVYLeO1WOAjJZpDhJ0a+K3uuugL/M6yyTBSdtbOSZvNlbI5ByWLVpY
 h1I9/+lPI5FzkFDb0Xyz2aHDn5qm1huZ/ZSdwTe7S9mvgItk2SSYNtPf98R/6Flhj08Cl6EtnE
 fwZ6PfYlwcDWOmqE4DTqASym
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Aug 2019 14:35:51 -0700
IronPort-SDR: XKMbtE5St5PYGt6C/VT6HyaqFX5FPK/hugYtVM5AW8odpl1aeTiSYWqy8OgS/gf6C6v0lK/n5m
 g+omsZdEK/OuakzhtrjZpCqnB++ln9PfJSY0d2I89/fOGKg0jYy2GhsEwH4cf1xyiOpcr6jiWP
 8TNbz/V4VMEBUIVEMCawKko2cUdUvPk3XxJ46eMcUcL7qrScVCo5dqCWt9TmijiGEoRDSw/W/G
 EBVA4+4yMrS0qf2xFL3J52Jqs+oIY2Xw/hEqltz5PqBQ4GEzUTFMTq1tVU8XCyJsImUk47cFhO
 yg0=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2019 14:38:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Thu, 15 Aug 2019 14:34:52 -0700
Message-Id: <dd11f1aa023aea048d2af7f2f7822895b05d238c.1565904855.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1565904855.git.alistair.francis@wdc.com>
References: <cover.1565904855.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v3 3/7] target/riscv: Create function to test
 if FP is enabled
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's create a function that tests if floating point support is
enabled. We can then protect all floating point operations based on if
they are enabled.

This patch so far doesn't change anything, it's just preparing for the
Hypervisor support for floating point operations.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Christophe de Dinechin <dinechin@redhat.com>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
---
 target/riscv/cpu.h        |  6 +++++-
 target/riscv/cpu_helper.c | 10 ++++++++++
 target/riscv/csr.c        | 20 +++++++++++---------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0adb307f32..2dc9b17678 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -255,6 +255,7 @@ void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
+bool riscv_cpu_fp_enabled(CPURISCVState *env);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
@@ -298,7 +299,10 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 #ifdef CONFIG_USER_ONLY
     *flags = TB_FLAGS_MSTATUS_FS;
 #else
-    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
+    *flags = cpu_mmu_index(env, 0);
+    if (riscv_cpu_fp_enabled(env)) {
+        *flags |= env->mstatus & MSTATUS_FS;
+    }
 #endif
 }
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f027be7f16..225e407cff 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -71,6 +71,16 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 #if !defined(CONFIG_USER_ONLY)
 
+/* Return true is floating point support is currently enabled */
+bool riscv_cpu_fp_enabled(CPURISCVState *env)
+{
+    if (env->mstatus & MSTATUS_FS) {
+        return true;
+    }
+
+    return false;
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e0d4586760..2789215b5e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -46,7 +46,7 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
 static int fs(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
 #endif
@@ -108,7 +108,7 @@ static int pmp(CPURISCVState *env, int csrno)
 static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
 #endif
@@ -119,7 +119,7 @@ static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
@@ -131,7 +131,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
 static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
 #endif
@@ -142,7 +142,7 @@ static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
@@ -154,7 +154,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
 static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
 #endif
@@ -166,7 +166,7 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
@@ -307,6 +307,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 {
     target_ulong mstatus = env->mstatus;
     target_ulong mask = 0;
+    int dirty;
 
     /* flush tlb on mstatus fields that affect VM */
     if (env->priv_ver <= PRIV_VERSION_1_09_1) {
@@ -340,8 +341,9 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 
     mstatus = (mstatus & ~mask) | (val & mask);
 
-    int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
-                ((mstatus & MSTATUS_XS) == MSTATUS_XS);
+    dirty = (riscv_cpu_fp_enabled(env) &&
+             ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
+            ((mstatus & MSTATUS_XS) == MSTATUS_XS);
     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
     env->mstatus = mstatus;
 
-- 
2.22.0


