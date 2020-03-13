Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9B8C2BAEE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 03:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A0B206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 03:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A0B206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCbR9-0006fa-MN
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 23:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiangyifei@huawei.com>) id 1jCbMJ-0006ti-Ov
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 23:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiangyifei@huawei.com>) id 1jCbMH-0000b8-OJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 23:51:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34964 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiangyifei@huawei.com>)
 id 1jCbMH-0000SH-Az; Thu, 12 Mar 2020 23:51:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8AF45C604A1ED36CCD46;
 Fri, 13 Mar 2020 11:51:31 +0800 (CST)
Received: from huawei.com (10.133.201.158) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 13 Mar 2020
 11:51:23 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH RFC 6/9] target/riscv: Support start kernel directly by KVM
Date: Fri, 13 Mar 2020 11:49:46 +0800
Message-ID: <20200313034949.3028-7-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200313034949.3028-1-jiangyifei@huawei.com>
References: <20200313034949.3028-1-jiangyifei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.201.158]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: anup.patel@wdc.com, zhang.zhanghailiang@huawei.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 victor.zhangxiaofeng@huawei.com, Alistair.Francis@wdc.com,
 yinyipeng1@huawei.com, palmer@dabbelt.com, Yifei Jiang <jiangyifei@huawei.com>,
 dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Get kernel and fdt start address in virt.c, and pass them to KVM
when cpu reset.In addition,add kvm_riscv.h to place riscv specific
interface.

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
---
 hw/riscv/virt.c          | 15 +++++++++++++--
 target/riscv/cpu.c       |  4 ++++
 target/riscv/cpu.h       |  3 +++
 target/riscv/kvm.c       | 14 ++++++++++++++
 target/riscv/kvm_riscv.h | 24 ++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/kvm_riscv.h

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 85ec9e22aa..e42c61208d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -42,6 +42,7 @@
 #include "exec/address-spaces.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
+#include "sysemu/kvm.h"
=20
 #include <libfdt.h>
=20
@@ -480,6 +481,9 @@ static void riscv_virt_board_init(MachineState *machi=
ne)
     target_ulong start_addr =3D memmap[VIRT_DRAM].base;
     int i;
     unsigned int smp_cpus =3D machine->smp.cpus;
+    uint64_t kernel_entry =3D 0;
+    hwaddr start_fdt;
+    CPUState *cs;
=20
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->s=
oc),
@@ -510,7 +514,7 @@ static void riscv_virt_board_init(MachineState *machi=
ne)
                                  memmap[VIRT_DRAM].base);
=20
     if (machine->kernel_filename) {
-        uint64_t kernel_entry =3D riscv_load_kernel(machine->kernel_file=
name,
+        kernel_entry =3D riscv_load_kernel(machine->kernel_filename,
                                                   NULL);
=20
         if (machine->initrd_filename) {
@@ -564,10 +568,17 @@ static void riscv_virt_board_init(MachineState *mac=
hine)
         exit(1);
     }
     qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
+    start_fdt =3D memmap[VIRT_MROM].base + sizeof(reset_vec);
     rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
-                          memmap[VIRT_MROM].base + sizeof(reset_vec),
+                          start_fdt,
                           &address_space_memory);
=20
+    for (cs =3D first_cpu; cs; cs =3D CPU_NEXT(cs)) {
+        RISCVCPU *riscv_cpu =3D RISCV_CPU(cs);
+        riscv_cpu->env.loader_start =3D kernel_entry;
+        riscv_cpu->env.fdt_start =3D start_fdt;
+    }
+
     /* create PLIC hart topology configuration string */
     plic_hart_config_len =3D (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_c=
pus;
     plic_hart_config =3D g_malloc0(plic_hart_config_len);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c0b7023100..3c3264869f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -28,6 +28,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
+#include "kvm_riscv.h"
=20
 /* RISC-V CPU definitions */
=20
@@ -346,6 +347,9 @@ static void riscv_cpu_reset(CPUState *cs)
     cs->exception_index =3D EXCP_NONE;
     env->load_res =3D -1;
     set_default_nan_mode(1, &env->fp_status);
+#ifdef CONFIG_KVM
+    kvm_riscv_reset_vcpu(cpu);
+#endif
 }
=20
 static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info=
)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3dcdf92227..2724eca714 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -213,6 +213,9 @@ struct CPURISCVState {
=20
     /* Fields from here on are preserved across CPU reset. */
     QEMUTimer *timer; /* Internal timer */
+
+    hwaddr loader_start;
+    hwaddr fdt_start;
 };
=20
 #define RISCV_CPU_CLASS(klass) \
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 6dffda36bb..b9aec66b69 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -37,6 +37,7 @@
 #include "hw/irq.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
+#include "kvm_riscv.h"
=20
 static __u64 kvm_riscv_reg_id(__u64 type, __u64 idx)
 {
@@ -426,3 +427,16 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_ru=
n *run)
 {
     return 0;
 }
+
+void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
+{
+    CPURISCVState *env =3D &cpu->env;
+
+    if (!kvm_enabled()) {
+        return;
+    }
+    env->pc =3D cpu->env.loader_start;
+    env->gpr[10] =3D kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
+    env->gpr[11] =3D cpu->env.fdt_start;         /* a1 */
+}
+
diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
new file mode 100644
index 0000000000..f38c82bf59
--- /dev/null
+++ b/target/riscv/kvm_riscv.h
@@ -0,0 +1,24 @@
+/*
+ * QEMU KVM support -- RISC-V specific functions.
+ *
+ * Copyright (c) 2020 Huawei Technologies Co., Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef QEMU_KVM_RISCV_H
+#define QEMU_KVM_RISCV_H
+
+void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
+
+#endif
--=20
2.19.1



