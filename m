Received: from eggs.gnu.org ([2001:4830:134:3::10]:50961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDZ-0003Kv-4x
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDX-0004sX-Ju
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:33 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:37318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDX-0004re-Cq
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:31 -0500
Received: by mail-pg0-x243.google.com with SMTP id o13so9956543pgp.4
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:39 -0800
Message-Id: <20171229063145.29167-33-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 32/38] target/hppa: Add migration for the cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h         |   1 +
 target/hppa/cpu.c         |   1 +
 target/hppa/machine.c     | 181 ++++++++++++++++++++++++++++++++++++++++++++++
 target/hppa/Makefile.objs |   1 +
 4 files changed, 184 insertions(+)
 create mode 100644 target/hppa/machine.c

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8c8ce66094..648b78986e 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -350,6 +350,7 @@ int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw, int midx);
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               MMUAccessType type, hwaddr *pphys, int *pprot);
 extern const MemoryRegionOps hppa_io_eir_ops;
+extern const struct VMStateDescription vmstate_hppa_cpu;
 void hppa_cpu_alarm_timer(void *);
 #endif
 void QEMU_NORETURN hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 586b42067a..1ecefc4070 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -176,6 +176,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     cc->handle_mmu_fault = hppa_cpu_handle_mmu_fault;
 #else
     cc->get_phys_page_debug = hppa_cpu_get_phys_page_debug;
+    dc->vmsd = &vmstate_hppa_cpu;
 #endif
     cc->do_unaligned_access = hppa_cpu_do_unaligned_access;
     cc->disas_set_info = hppa_cpu_disas_set_info;
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
new file mode 100644
index 0000000000..31312b561c
--- /dev/null
+++ b/target/hppa/machine.c
@@ -0,0 +1,181 @@
+/*
+ *  HPPA interrupt helper routines
+ *
+ *  Copyright (c) 2017 Richard Henderson
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
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/boards.h"
+#include "migration/cpu.h"
+
+#if TARGET_REGISTER_BITS == 64
+#define qemu_put_betr   qemu_put_be64
+#define qemu_get_betr   qemu_get_be64
+#define VMSTATE_UINTTL_V(_f, _s, _v) \
+    VMSTATE_UINT64_V(_f, _s, _v)
+#define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v) \
+    VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
+#else
+#define qemu_put_betr   qemu_put_be32
+#define qemu_get_betr   qemu_get_be32
+#define VMSTATE_UINTTR_V(_f, _s, _v) \
+    VMSTATE_UINT32_V(_f, _s, _v)
+#define VMSTATE_UINTTR_ARRAY_V(_f, _s, _n, _v) \
+    VMSTATE_UINT32_ARRAY_V(_f, _s, _n, _v)
+#endif
+
+#define VMSTATE_UINTTR(_f, _s) \
+    VMSTATE_UINTTR_V(_f, _s, 0)
+#define VMSTATE_UINTTR_ARRAY(_f, _s, _n) \
+    VMSTATE_UINTTR_ARRAY_V(_f, _s, _n, 0)
+
+
+static int get_psw(QEMUFile *f, void *opaque, size_t size, VMStateField *field)
+{
+    CPUHPPAState *env = opaque;
+    cpu_hppa_put_psw(env, qemu_get_betr(f));
+    return 0;
+}
+
+static int put_psw(QEMUFile *f, void *opaque, size_t size,
+                   VMStateField *field, QJSON *vmdesc)
+{
+    CPUHPPAState *env = opaque;
+    qemu_put_betr(f, cpu_hppa_get_psw(env));
+    return 0;
+}
+
+static const VMStateInfo vmstate_psw = {
+    .name = "psw",
+    .get = get_psw,
+    .put = put_psw,
+};
+
+/* FIXME: Use the PA2.0 format, which is a superset of the PA1.1 format.  */
+static int get_tlb(QEMUFile *f, void *opaque, size_t size, VMStateField *field)
+{
+    hppa_tlb_entry *ent = opaque;
+    uint32_t val;
+
+    memset(ent, 0, sizeof(*ent));
+
+    ent->va_b = qemu_get_be64(f);
+    ent->pa = qemu_get_betr(f);
+    val = qemu_get_be32(f);
+
+    ent->entry_valid = extract32(val, 0, 1);
+    ent->access_id = extract32(val, 1, 18);
+    ent->u = extract32(val, 19, 1);
+    ent->ar_pl2 = extract32(val, 20, 2);
+    ent->ar_pl1 = extract32(val, 22, 2);
+    ent->ar_type = extract32(val, 24, 3);
+    ent->b = extract32(val, 27, 1);
+    ent->d = extract32(val, 28, 1);
+    ent->t = extract32(val, 29, 1);
+
+    ent->va_e = ent->va_b + TARGET_PAGE_SIZE - 1;
+    return 0;
+}
+
+static int put_tlb(QEMUFile *f, void *opaque, size_t size,
+                   VMStateField *field, QJSON *vmdesc)
+{
+    hppa_tlb_entry *ent = opaque;
+    uint32_t val = 0;
+
+    if (ent->entry_valid) {
+        val = 1;
+        val = deposit32(val, 1, 18, ent->access_id);
+        val = deposit32(val, 19, 1, ent->u);
+        val = deposit32(val, 20, 2, ent->ar_pl2);
+        val = deposit32(val, 22, 2, ent->ar_pl1);
+        val = deposit32(val, 24, 3, ent->ar_type);
+        val = deposit32(val, 27, 1, ent->b);
+        val = deposit32(val, 28, 1, ent->d);
+        val = deposit32(val, 29, 1, ent->t);
+    }
+
+    qemu_put_be64(f, ent->va_b);
+    qemu_put_betr(f, ent->pa);
+    qemu_put_be32(f, val);
+    return 0;
+}
+
+static const VMStateInfo vmstate_tlb = {
+    .name = "tlb entry",
+    .get = get_tlb,
+    .put = put_tlb,
+};
+
+static VMStateField vmstate_env_fields[] = {
+    VMSTATE_UINTTR_ARRAY(gr, CPUHPPAState, 32),
+    VMSTATE_UINT64_ARRAY(fr, CPUHPPAState, 32),
+    VMSTATE_UINT64_ARRAY(sr, CPUHPPAState, 8),
+    VMSTATE_UINTTR_ARRAY(cr, CPUHPPAState, 32),
+    VMSTATE_UINTTR_ARRAY(cr_back, CPUHPPAState, 2),
+    VMSTATE_UINTTR_ARRAY(shadow, CPUHPPAState, 7),
+
+    /* Save the architecture value of the psw, not the internally
+       expanded version.  Since this architecture value does not
+       exist in memory to be stored, this requires a but of hoop
+       jumping.  We want OFFSET=0 so that we effectively pass ENV
+       to the helper functions, and we need to fill in the name by
+       hand since there's no field of that name.  */
+    {
+        .name = "psw",
+        .version_id = 0,
+        .size = sizeof(uint64_t),
+        .info = &vmstate_psw,
+        .flags = VMS_SINGLE,
+        .offset = 0
+    },
+
+    VMSTATE_UINTTR(iaoq_f, CPUHPPAState),
+    VMSTATE_UINTTR(iaoq_b, CPUHPPAState),
+    VMSTATE_UINT64(iasq_f, CPUHPPAState),
+    VMSTATE_UINT64(iasq_b, CPUHPPAState),
+
+    VMSTATE_UINT32(fr0_shadow, CPUHPPAState),
+
+    VMSTATE_ARRAY(tlb, CPUHPPAState, ARRAY_SIZE(((CPUHPPAState*)0)->tlb), 0,
+                  vmstate_tlb, hppa_tlb_entry),
+    VMSTATE_UINT32(tlb_last, CPUHPPAState),
+
+    VMSTATE_END_OF_LIST()
+};
+
+static const VMStateDescription vmstate_env = {
+    .name = "env",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = vmstate_env_fields,
+};
+
+static VMStateField vmstate_cpu_fields[] = {
+    VMSTATE_CPU(),
+    VMSTATE_STRUCT(env, HPPACPU, 1, vmstate_env, CPUHPPAState),
+    VMSTATE_END_OF_LIST()
+};
+
+const VMStateDescription vmstate_hppa_cpu = {
+    .name = "cpu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = vmstate_cpu_fields,
+};
diff --git a/target/hppa/Makefile.objs b/target/hppa/Makefile.objs
index dcd60a6839..3359da5341 100644
--- a/target/hppa/Makefile.objs
+++ b/target/hppa/Makefile.objs
@@ -1,2 +1,3 @@
 obj-y += translate.o helper.o cpu.o op_helper.o gdbstub.o mem_helper.o
 obj-y += int_helper.o
+obj-$(CONFIG_SOFTMMU) += machine.o
-- 
2.14.3
