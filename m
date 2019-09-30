Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147A7C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24C120842
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="D6IF20RY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24C120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvAn-0006fy-Gc
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 08:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iEv55-0002P3-EP
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iEv53-00029W-SX
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:11 -0400
Received: from shirlock.uni-paderborn.de ([131.234.189.15]:41622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1iEv50-00025G-00
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xqk3PN04qMp2t4i9+u82S0iUwX9sCmLd7NEY+qxP7jE=; b=D6IF20RYpprmYLuop0NiXSAlq+
 tXYdgnsrNwqy7VA10K6ZpQy+UL0yt0C8/ofMxGSjaAbKSDP0b+RDp+YHplxNLybyMMEK5FQDOQQet
 KcxKqAPMnZiBMUWNsFTnVTw5QZaBLep0SvIFjjwkG48pNsa0ARwG8/EBNash8I7mJZBM=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] target/tricore: Implement gdbstub
Date: Mon, 30 Sep 2019 14:46:43 +0200
Message-Id: <20190930124643.179695-6-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930124643.179695-1-kbastian@mail.uni-paderborn.de>
References: <20190930124643.179695-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.9.30.123917, AntiVirus-Engine: 5.65.0,
 AntiVirus-Data: 2019.9.30.5650000
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 131.234.189.15
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
Cc: david.brenken@efs-auto.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/Makefile.objs |   2 +-
 target/tricore/cpu.c         |  10 +++
 target/tricore/cpu.h         |   2 +
 target/tricore/gdbstub.c     | 138 +++++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 target/tricore/gdbstub.c

diff --git a/target/tricore/Makefile.objs b/target/tricore/Makefile.objs
index 7a05670718..281b55f08d 100644
--- a/target/tricore/Makefile.objs
+++ b/target/tricore/Makefile.objs
@@ -1 +1 @@
-obj-y += translate.o helper.o cpu.o op_helper.o fpu_helper.o
+obj-y += translate.o helper.o cpu.o op_helper.o fpu_helper.o gdbstub.o
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 7159d9cf8f..fee2f0f5d7 100644
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
index 8c014fad07..49d282f728 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -353,6 +353,8 @@ enum {
 
 uint32_t psw_read(CPUTriCoreState *env);
 void psw_write(CPUTriCoreState *env, uint32_t val);
+int tricore_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n);
+int tricore_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n);
 
 void fpu_set_state(CPUTriCoreState *env);
 
diff --git a/target/tricore/gdbstub.c b/target/tricore/gdbstub.c
new file mode 100644
index 0000000000..87761f20e9
--- /dev/null
+++ b/target/tricore/gdbstub.c
@@ -0,0 +1,138 @@
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
+static void tricore_cpu_gdb_write_csfr(CPUTriCoreState *env, int n, uint32_t val)
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
+int tricore_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    TriCoreCPU *cpu = TRICORE_CPU(cs);
+    CPUTriCoreState *env = &cpu->env;
+
+    if (n < 16) { /* data registers */
+        return gdb_get_reg32(mem_buf, env->gpr_d[n]);
+    } else if (n < 32) { /* address registers */
+        return gdb_get_reg32(mem_buf, env->gpr_a[n-16]);
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
+        env->gpr_d[n-16] = tmp;
+    } else {
+        tricore_cpu_gdb_write_csfr(env, n, tmp);
+    }
+    return 4;
+}
-- 
2.23.0


