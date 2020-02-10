Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C362C3B185
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 08:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3225F2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 08:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3225F2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j14F4-0007MR-Di
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 03:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j14Bh-0003oB-0u
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j14Bf-0008Es-Na
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:13:00 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52817)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j14Bf-0008Bo-8B; Mon, 10 Feb 2020 03:12:59 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.662041-0.00946318-0.328496;
 DS=CONTINUE|ham_system_inform|0.273365-0.0001951-0.72644;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03295; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GmO5bfp_1581322371; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GmO5bfp_1581322371)
 by smtp.aliyun-inc.com(10.147.40.44); Mon, 10 Feb 2020 16:12:52 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v4 3/4] target/riscv: support vector extension csr
Date: Mon, 10 Feb 2020 16:12:39 +0800
Message-Id: <20200210081240.11481-4-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
References: <20200210081240.11481-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The v0.7.1 specification does not define vector status within mstatus.
A future revision will define the privileged portion of the vector status.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/cpu_bits.h | 15 +++++++++
 target/riscv/csr.c      | 72 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e99834856c..1f588ebc14 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -29,6 +29,14 @@
 #define FSR_NXA             (FPEXC_NX << FSR_AEXC_SHIFT)
 #define FSR_AEXC            (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA | FSR_NXA)
 
+/* Vector Fixed-Point round model */
+#define FSR_VXRM_SHIFT      9
+#define FSR_VXRM            (0x3 << FSR_VXRM_SHIFT)
+
+/* Vector Fixed-Point saturation flag */
+#define FSR_VXSAT_SHIFT     8
+#define FSR_VXSAT           (0x1 << FSR_VXSAT_SHIFT)
+
 /* Control and Status Registers */
 
 /* User Trap Setup */
@@ -48,6 +56,13 @@
 #define CSR_FRM             0x002
 #define CSR_FCSR            0x003
 
+/* User Vector CSRs */
+#define CSR_VSTART          0x008
+#define CSR_VXSAT           0x009
+#define CSR_VXRM            0x00a
+#define CSR_VL              0xc20
+#define CSR_VTYPE           0xc21
+
 /* User Timers and Counters */
 #define CSR_CYCLE           0xc00
 #define CSR_TIME            0xc01
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0e34c292c5..4696c8c180 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -46,6 +46,10 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
 static int fs(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
+    /* loose check condition for fcsr in vector extension */
+    if ((csrno == CSR_FCSR) && (env->misa & RVV)) {
+        return 0;
+    }
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
@@ -53,6 +57,11 @@ static int fs(CPURISCVState *env, int csrno)
     return 0;
 }
 
+static int vs(CPURISCVState *env, int csrno)
+{
+    return 0;
+}
+
 static int ctr(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -158,8 +167,10 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
         return -1;
     }
 #endif
-    *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
-        | (env->frm << FSR_RD_SHIFT);
+    *val = (env->vext.vxrm << FSR_VXRM_SHIFT)
+            | (env->vext.vxsat << FSR_VXSAT_SHIFT)
+            | (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
+            | (env->frm << FSR_RD_SHIFT);
     return 0;
 }
 
@@ -172,10 +183,60 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
     env->mstatus |= MSTATUS_FS;
 #endif
     env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
+    env->vext.vxrm = (val & FSR_VXRM) >> FSR_VXRM_SHIFT;
+    env->vext.vxsat = (val & FSR_VXSAT) >> FSR_VXSAT_SHIFT;
     riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
     return 0;
 }
 
+static int read_vtype(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vext.vtype;
+    return 0;
+}
+
+static int read_vl(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vext.vl;
+    return 0;
+}
+
+static int read_vxrm(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vext.vxrm;
+    return 0;
+}
+
+static int read_vxsat(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vext.vxsat;
+    return 0;
+}
+
+static int read_vstart(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->vext.vstart;
+    return 0;
+}
+
+static int write_vxrm(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vext.vxrm = val;
+    return 0;
+}
+
+static int write_vxsat(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vext.vxsat = val;
+    return 0;
+}
+
+static int write_vstart(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->vext.vstart = val;
+    return 0;
+}
+
 /* User Timers and Counters */
 static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -877,7 +938,12 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_FFLAGS] =              { fs,   read_fflags,      write_fflags      },
     [CSR_FRM] =                 { fs,   read_frm,         write_frm         },
     [CSR_FCSR] =                { fs,   read_fcsr,        write_fcsr        },
-
+    /* Vector CSRs */
+    [CSR_VSTART] =              { vs,   read_vstart,      write_vstart      },
+    [CSR_VXSAT] =               { vs,   read_vxsat,       write_vxsat       },
+    [CSR_VXRM] =                { vs,   read_vxrm,        write_vxrm        },
+    [CSR_VL] =                  { vs,   read_vl                             },
+    [CSR_VTYPE] =               { vs,   read_vtype                          },
     /* User Timers and Counters */
     [CSR_CYCLE] =               { ctr,  read_instret                        },
     [CSR_INSTRET] =             { ctr,  read_instret                        },
-- 
2.23.0


