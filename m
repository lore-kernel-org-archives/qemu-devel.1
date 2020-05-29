Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C39C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13523207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13523207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZPN-0001Ek-67
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jeZLL-0002ew-8x
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:22:15 -0400
Received: from hoth.uni-paderborn.de ([2001:638:502:c003::19]:38044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jeZLI-0000gT-Em
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:22:14 -0400
Received: from magmaria.uni-paderborn.de ([131.234.189.24]
 helo=localhost.localdomain)
 by mail.uni-paderborn.de with esmtp (Exim 4.93 hoth)
 id 1jeZLG-0007uS-RB
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:22:10 +0200
Received: from mail.uni-paderborn.de by magmaria with queue id 3990296-3
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:22:09 GMT
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] target/tricore: Implement gdbstub
Date: Fri, 29 May 2020 09:21:48 +0200
Message-Id: <20200529072148.284037-6-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529072148.284037-1-kbastian@mail.uni-paderborn.de>
References: <20200529072148.284037-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.5.29.71219, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.5.29.5740000
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=6374313, da=78345994,
 mc=156, sc=3, hc=153, sp=1, fso=6374313, re=0, sd=0, hd=0
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: 
Received-SPF: pass client-ip=2001:638:502:c003::19;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=hoth.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
v1 -> v2:
  - tricore_cpu_gdb_read_registers uses a GByteArray pointer for the mem_buf
    argument

 target/tricore/Makefile.objs |   2 +-
 target/tricore/cpu.c         |  10 +++
 target/tricore/cpu.h         |   2 +
 target/tricore/gdbstub.c     | 139 +++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 target/tricore/gdbstub.c

diff --git a/target/tricore/Makefile.objs b/target/tricore/Makefile.objs
index 7a05670718..281b55f08d 100644
--- a/target/tricore/Makefile.objs
+++ b/target/tricore/Makefile.objs
@@ -1 +1 @@
-obj-y += translate.o helper.o cpu.o op_helper.o fpu_helper.o
+obj-y += translate.o helper.o cpu.o op_helper.o fpu_helper.o gdbstub.o
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index c8c1e9e7d5..2f2e5b029f 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -28,6 +28,11 @@ static inline void set_feature(CPUTriCoreState *env, int feature)
     env->features |= 1ULL << feature;
 }
 
+static gchar *tricore_gdb_arch_name(CPUState *cs)
+{
+    return g_strdup("tricore");
+}
+
 static void tricore_cpu_set_pc(CPUState *cs, vaddr value)
 {
     TriCoreCPU *cpu = TRICORE_CPU(cs);
@@ -150,6 +155,11 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     cc->class_by_name = tricore_cpu_class_by_name;
     cc->has_work = tricore_cpu_has_work;
 
+    cc->gdb_read_register = tricore_cpu_gdb_read_register;
+    cc->gdb_write_register = tricore_cpu_gdb_write_register;
+    cc->gdb_num_core_regs = 44;
+    cc->gdb_arch_name = tricore_gdb_arch_name;
+
     cc->dump_state = tricore_cpu_dump_state;
     cc->set_pc = tricore_cpu_set_pc;
     cc->synchronize_from_tb = tricore_cpu_synchronize_from_tb;
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 8c014fad07..b82349d1b1 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -353,6 +353,8 @@ enum {
 
 uint32_t psw_read(CPUTriCoreState *env);
 void psw_write(CPUTriCoreState *env, uint32_t val);
+int tricore_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n);
+int tricore_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n);
 
 void fpu_set_state(CPUTriCoreState *env);
 
diff --git a/target/tricore/gdbstub.c b/target/tricore/gdbstub.c
new file mode 100644
index 0000000000..0f4e612a04
--- /dev/null
+++ b/target/tricore/gdbstub.c
@@ -0,0 +1,139 @@
+/*
+ * TriCore gdb server stub
+ *
+ * Copyright (c) 2019 Bastian Koppelmann, Paderborn University
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "exec/gdbstub.h"
+
+
+#define LCX_REGNUM         32
+#define FCX_REGNUM         33
+#define PCXI_REGNUM        34
+#define TRICORE_PSW_REGNUM 35
+#define TRICORE_PC_REGNUM  36
+#define ICR_REGNUM         37
+#define ISP_REGNUM         38
+#define BTV_REGNUM         39
+#define BIV_REGNUM         40
+#define SYSCON_REGNUM      41
+#define PMUCON0_REGNUM     42
+#define DMUCON_REGNUM      43
+
+static uint32_t tricore_cpu_gdb_read_csfr(CPUTriCoreState *env, int n)
+{
+    switch (n) {
+    case LCX_REGNUM:
+        return env->LCX;
+    case FCX_REGNUM:
+        return env->FCX;
+    case PCXI_REGNUM:
+        return env->PCXI;
+    case TRICORE_PSW_REGNUM:
+        return psw_read(env);
+    case TRICORE_PC_REGNUM:
+        return env->PC;
+    case ICR_REGNUM:
+        return env->ICR;
+    case ISP_REGNUM:
+        return env->ISP;
+    case BTV_REGNUM:
+        return env->BTV;
+    case BIV_REGNUM:
+        return env->BIV;
+    case SYSCON_REGNUM:
+        return env->SYSCON;
+    case PMUCON0_REGNUM:
+        return 0; /* PMUCON0 */
+    case DMUCON_REGNUM:
+        return 0; /* DMUCON0 */
+    default:
+        return 0;
+    }
+}
+
+static void tricore_cpu_gdb_write_csfr(CPUTriCoreState *env, int n,
+                                       uint32_t val)
+{
+    switch (n) {
+    case LCX_REGNUM:
+        env->LCX = val;
+        break;
+    case FCX_REGNUM:
+        env->FCX = val;
+        break;
+    case PCXI_REGNUM:
+        env->PCXI = val;
+        break;
+    case TRICORE_PSW_REGNUM:
+        psw_write(env, val);
+        break;
+    case TRICORE_PC_REGNUM:
+        env->PC = val;
+        break;
+    case ICR_REGNUM:
+        env->ICR = val;
+        break;
+    case ISP_REGNUM:
+        env->ISP = val;
+        break;
+    case BTV_REGNUM:
+        env->BTV = val;
+        break;
+    case BIV_REGNUM:
+        env->BIV = val;
+        break;
+    case SYSCON_REGNUM:
+        env->SYSCON = val;
+        break;
+    }
+}
+
+
+int tricore_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
+    TriCoreCPU *cpu = TRICORE_CPU(cs);
+    CPUTriCoreState *env = &cpu->env;
+
+    if (n < 16) { /* data registers */
+        return gdb_get_reg32(mem_buf, env->gpr_d[n]);
+    } else if (n < 32) { /* address registers */
+        return gdb_get_reg32(mem_buf, env->gpr_a[n - 16]);
+    } else { /* csfr */
+        return gdb_get_reg32(mem_buf, tricore_cpu_gdb_read_csfr(env, n));
+    }
+    return 0;
+}
+
+int tricore_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    TriCoreCPU *cpu = TRICORE_CPU(cs);
+    CPUTriCoreState *env = &cpu->env;
+    uint32_t tmp;
+
+    tmp = ldl_p(mem_buf);
+
+    if (n < 16) { /* data registers */
+        env->gpr_d[n] = tmp;
+    } else if (n < 32) { /* address registers */
+        env->gpr_d[n - 16] = tmp;
+    } else {
+        tricore_cpu_gdb_write_csfr(env, n, tmp);
+    }
+    return 4;
+}
-- 
2.26.2


