Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9BCC56201
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F482076D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F482076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX18A-0002RU-0e
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kX16U-0000Zj-2m; Mon, 26 Oct 2020 07:55:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kX16R-0000hc-6B; Mon, 26 Oct 2020 07:55:57 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CKYFJ1N2CzkZdK;
 Mon, 26 Oct 2020 19:55:48 +0800 (CST)
Received: from huawei.com (10.174.186.209) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 26 Oct 2020
 19:55:37 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH V4 2/6] target/riscv: Add basic vmstate description of CPU
Date: Mon, 26 Oct 2020 19:55:26 +0800
Message-ID: <20201026115530.304-3-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20201026115530.304-1-jiangyifei@huawei.com>
References: <20201026115530.304-1-jiangyifei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.209]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=jiangyifei@huawei.com; helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 07:55:44
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, victor.zhangxiaofeng@huawei.com,
 richard.henderson@linaro.org, Yifei Jiang <jiangyifei@huawei.com>,
 Alistair Francis <alistair.francis@wdc.com>, yinyipeng1@huawei.com,
 palmer@dabbelt.com, wu.wubin@huawei.com, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add basic CPU state description to the newly created machine.c

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c       |  8 +----
 target/riscv/internals.h |  4 +++
 target/riscv/machine.c   | 74 ++++++++++++++++++++++++++++++++++++++++
 target/riscv/meson.build |  3 +-
 4 files changed, 81 insertions(+), 8 deletions(-)
 create mode 100644 target/riscv/machine.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index dd05a220c7..6a0264fc6b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -22,6 +22,7 @@
 #include "qemu/ctype.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "internals.h"
 #include "exec/exec-all.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -498,13 +499,6 @@ static void riscv_cpu_init(Object *obj)
     cpu_set_cpustate_pointers(cpu);
 }
 
-#ifndef CONFIG_USER_ONLY
-static const VMStateDescription vmstate_riscv_cpu = {
-    .name = "cpu",
-    .unmigratable = 1,
-};
-#endif
-
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("i", RISCVCPU, cfg.ext_i, true),
     DEFINE_PROP_BOOL("e", RISCVCPU, cfg.ext_e, false),
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index f1a546dba6..b15ad394bb 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -38,6 +38,10 @@ target_ulong fclass_d(uint64_t frs1);
 #define SEW32 2
 #define SEW64 3
 
+#ifndef CONFIG_USER_ONLY
+extern const VMStateDescription vmstate_riscv_cpu;
+#endif
+
 static inline uint64_t nanbox_s(float32 f)
 {
     return f | MAKE_64BIT_MASK(32, 32);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
new file mode 100644
index 0000000000..32edbcba7c
--- /dev/null
+++ b/target/riscv/machine.c
@@ -0,0 +1,74 @@
+/*
+ * RISC-V VMState Description
+ *
+ * Copyright (c) 2020 Huawei Technologies Co., Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "qemu/error-report.h"
+#include "sysemu/kvm.h"
+#include "migration/cpu.h"
+
+const VMStateDescription vmstate_riscv_cpu = {
+    .name = "cpu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
+        VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
+        VMSTATE_UINTTL(env.pc, RISCVCPU),
+        VMSTATE_UINTTL(env.load_res, RISCVCPU),
+        VMSTATE_UINTTL(env.load_val, RISCVCPU),
+        VMSTATE_UINTTL(env.frm, RISCVCPU),
+        VMSTATE_UINTTL(env.badaddr, RISCVCPU),
+        VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
+        VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
+        VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
+        VMSTATE_UINTTL(env.misa, RISCVCPU),
+        VMSTATE_UINTTL(env.misa_mask, RISCVCPU),
+        VMSTATE_UINT32(env.features, RISCVCPU),
+        VMSTATE_UINTTL(env.priv, RISCVCPU),
+        VMSTATE_UINTTL(env.virt, RISCVCPU),
+        VMSTATE_UINTTL(env.resetvec, RISCVCPU),
+        VMSTATE_UINTTL(env.mhartid, RISCVCPU),
+        VMSTATE_UINT64(env.mstatus, RISCVCPU),
+        VMSTATE_UINTTL(env.mip, RISCVCPU),
+        VMSTATE_UINT32(env.miclaim, RISCVCPU),
+        VMSTATE_UINTTL(env.mie, RISCVCPU),
+        VMSTATE_UINTTL(env.mideleg, RISCVCPU),
+        VMSTATE_UINTTL(env.sptbr, RISCVCPU),
+        VMSTATE_UINTTL(env.satp, RISCVCPU),
+        VMSTATE_UINTTL(env.sbadaddr, RISCVCPU),
+        VMSTATE_UINTTL(env.mbadaddr, RISCVCPU),
+        VMSTATE_UINTTL(env.medeleg, RISCVCPU),
+        VMSTATE_UINTTL(env.stvec, RISCVCPU),
+        VMSTATE_UINTTL(env.sepc, RISCVCPU),
+        VMSTATE_UINTTL(env.scause, RISCVCPU),
+        VMSTATE_UINTTL(env.mtvec, RISCVCPU),
+        VMSTATE_UINTTL(env.mepc, RISCVCPU),
+        VMSTATE_UINTTL(env.mcause, RISCVCPU),
+        VMSTATE_UINTTL(env.mtval, RISCVCPU),
+        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
+        VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
+        VMSTATE_UINTTL(env.sscratch, RISCVCPU),
+        VMSTATE_UINTTL(env.mscratch, RISCVCPU),
+        VMSTATE_UINT64(env.mfromhost, RISCVCPU),
+        VMSTATE_UINT64(env.mtohost, RISCVCPU),
+        VMSTATE_UINT64(env.timecmp, RISCVCPU),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index abd647fea1..14a5c62dac 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -27,7 +27,8 @@ riscv_ss.add(files(
 riscv_softmmu_ss = ss.source_set()
 riscv_softmmu_ss.add(files(
   'pmp.c',
-  'monitor.c'
+  'monitor.c',
+  'machine.c'
 ))
 
 target_arch += {'riscv': riscv_ss}
-- 
2.19.1


