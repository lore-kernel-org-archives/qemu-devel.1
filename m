Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492DAC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BD22077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EzPoTsWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BD22077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNlI-00063A-Ob
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaa-00074p-E4
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaY-0007K5-UP
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57667)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaY-0007Jf-Lb; Mon, 09 Dec 2019 13:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915414; x=1607451414;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sDww3pXxbEdwsxtODGuvbYWAO/9uNbLRdRcD+rClB3c=;
 b=EzPoTsWMgAL/d8Z/qLagNisOzSlu11LZdWXP4r9os4cl2KIarP5UuEx2
 X22s6EDBiCF3eumWx/H0UO5T78NuN4sI1T52E6KMT9la02rjG1Ev0Qc9Q
 fjpeNu2oOMpUsMDj3G5esr8PBWr9vlIi1mPXjmErHiBJ7Py9TrIV2rRRR
 sT42q5iJl+LjUb2/l/hRkUyf81fClst2VO8Oew49LY2R6vamxBjKbzyjY
 dtZ/JsSDZOAg+zMmrLz1WT4KthXQCIbdI2TSkkATgVdmFW4Nz8CrM7uUK
 iQ5WWqvqnqlC7Trh/+23wt/toJj7445xK3e4xoBornRllLS8OkXGynJOs w==;
IronPort-SDR: T1rK8dqzanTw5U/Jt8WvgKl2z8GR4nV/jaG/zroHsplMXslzo29AQAmkBsqHZAj+iGBwWXm7dJ
 8dxmgOp21/V03Bm9cDbk63j9IFoRMJ6aIWxEryr5YXJHlCvRyRVuFmcV0EYiDdB2xhk1DLIO0P
 t1uvOG91L0RFHcsO21ZCykOkkDJwMb2N24vC9AGYQfLe2zKm47x2D9XXPbHPqKweIeoRaIV+l4
 JrngsP1/VVhM+HwrCcFFpVcrL1o5EoUWaw5d0sNdvIgeBaudfBNdVC+KFjy939/Y+muvKOdtN+
 3JM=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="129370429"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:16:53 +0800
IronPort-SDR: cpSfH9EqOj9rmHo9FGXqci+jxVOofgUcnYbuuGJ8EM5Oqf8VigghspDNylKQRWnk21tJxptlKp
 Wf2OPl7ABTIlPHx7FHYa5fIQ7JUv1Twbe3DlmkeDoVMB7CVPqWqK880LsC4Gy6suvfDaB6Py9E
 BR8gWyxNYW3asKKD7f+tdqaOwYn5hQqM5U6ZRzygupUu0Ut+zzUBFiB4b5QJkNgJbNhTsiqS/x
 Win1gxAmsifmitAXMbwbjEI2ciTCR4NVeJcPfliY64XwKZT5VQPCoJEgM2V1rJKl99r+5yba9H
 kW++zXrb6PRNURyXHE+RLGtn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:31 -0800
IronPort-SDR: +C/iHtXuWP17WCkFKx0o9KXVBT+mAm9PIneCvK+w91Rruo4xYfL0E46AWRuhT5OecT5UjVO7Xw
 HyCyGjw99rShmfKhNh8nR7hScUqXjtr04GLiGDlGVE6tPh48ztkbbRDvn0AQLlxeP0hYFEl6Ea
 /Gh2o4Lt6/lJra9vEjPea8vSx4bABHa3SJlZRJAlQ/h6mNr30NwBD4LBnXpoZO+KCERTczsdWB
 S6kb/5Jhk39x829r9rZgumHAQmT40XPseutJMvl2KC0X3qYRdaNKZUAIyKaL3Qe5OeFiZuWlgy
 O6w=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:16:54 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 12/36] target/riscv: Add Hypervisor CSR access functions
Date: Mon,  9 Dec 2019 10:11:11 -0800
Message-Id: <d69ae8746c74f5ba16bff06d489a889255f4c0cf.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.141
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 136 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index eebfc1823d..b582d78529 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -98,6 +98,20 @@ static int smode(CPURISCVState *env, int csrno)
     return -!riscv_has_ext(env, RVS);
 }
 
+static int hmode(CPURISCVState *env, int csrno)
+{
+    if (riscv_has_ext(env, RVS) &&
+        riscv_has_ext(env, RVH)) {
+        /* Hypervisor extension is supported */
+        if ((env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
+            env->priv == PRV_M) {
+            return 0;
+        }
+    }
+
+    return -1;
+}
+
 static int pmp(CPURISCVState *env, int csrno)
 {
     return -!riscv_feature(env, RISCV_FEATURE_PMP);
@@ -226,8 +240,9 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
 
 /* Machine constants */
 
-#define M_MODE_INTERRUPTS (MIP_MSIP | MIP_MTIP | MIP_MEIP)
-#define S_MODE_INTERRUPTS (MIP_SSIP | MIP_STIP | MIP_SEIP)
+#define M_MODE_INTERRUPTS  (MIP_MSIP | MIP_MTIP | MIP_MEIP)
+#define S_MODE_INTERRUPTS  (MIP_SSIP | MIP_STIP | MIP_SEIP)
+#define VS_MODE_INTERRUPTS (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)
 
 static const target_ulong delegable_ints = S_MODE_INTERRUPTS;
 static const target_ulong all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS;
@@ -257,6 +272,7 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
     SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
 static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP;
+static const target_ulong hip_writable_mask = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP;
 
 #if defined(TARGET_RISCV32)
 static const char valid_vm_1_09[16] = {
@@ -757,6 +773,112 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+/* Hypervisor Extensions */
+static int read_hstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hstatus;
+    return 0;
+}
+
+static int write_hstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hstatus = val;
+    return 0;
+}
+
+static int read_hedeleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hedeleg;
+    return 0;
+}
+
+static int write_hedeleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hedeleg = val;
+    return 0;
+}
+
+static int read_hideleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hideleg;
+    return 0;
+}
+
+static int write_hideleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hideleg = val;
+    return 0;
+}
+
+static int rmw_hip(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                   target_ulong new_value, target_ulong write_mask)
+{
+    int ret = rmw_mip(env, 0, ret_value, new_value,
+                      write_mask & hip_writable_mask);
+
+    return ret;
+}
+
+static int read_hie(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mie & VS_MODE_INTERRUPTS;
+    return 0;
+}
+
+static int write_hie(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong newval = (env->mie & ~VS_MODE_INTERRUPTS) | (val & VS_MODE_INTERRUPTS);
+    return write_mie(env, CSR_MIE, newval);
+}
+
+static int read_hcounteren(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hcounteren;
+    return 0;
+}
+
+static int write_hcounteren(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hcounteren = val;
+    return 0;
+}
+
+static int read_htval(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->htval;
+    return 0;
+}
+
+static int write_htval(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->htval = val;
+    return 0;
+}
+
+static int read_htinst(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->htinst;
+    return 0;
+}
+
+static int write_htinst(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->htinst = val;
+    return 0;
+}
+
+static int read_hgatp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hgatp;
+    return 0;
+}
+
+static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hgatp = val;
+    return 0;
+}
+
 /* Physical Memory Protection */
 static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -960,6 +1082,16 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Supervisor Protection and Translation */
     [CSR_SATP] =                { smode, read_satp,        write_satp        },
 
+    [CSR_HSTATUS] =             { hmode,   read_hstatus,     write_hstatus    },
+    [CSR_HEDELEG] =             { hmode,   read_hedeleg,     write_hedeleg    },
+    [CSR_HIDELEG] =             { hmode,   read_hideleg,     write_hideleg    },
+    [CSR_HIP] =                 { hmode,   NULL,     NULL,     rmw_hip        },
+    [CSR_HIE] =                 { hmode,   read_hie,         write_hie        },
+    [CSR_HCOUNTEREN] =          { hmode,   read_hcounteren,  write_hcounteren },
+    [CSR_HTVAL] =               { hmode,   read_htval,       write_htval      },
+    [CSR_HTINST] =              { hmode,   read_htinst,      write_htinst     },
+    [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
+
     /* Physical Memory Protection */
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
-- 
2.24.0


