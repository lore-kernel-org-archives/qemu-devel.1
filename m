Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F282DC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAEA420659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEA420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGXU-0002Sm-SW
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51024)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiGJw-0005pr-Kc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiGJq-0007pR-Rr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiGJo-0007gD-Li
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F9DE30821BE;
 Tue,  2 Jul 2019 10:47:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCC34196BF;
 Tue,  2 Jul 2019 10:47:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D4D4B11328A5; Tue,  2 Jul 2019 12:47:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 12:47:09 +0200
Message-Id: <20190702104716.9140-12-armbru@redhat.com>
In-Reply-To: <20190702104716.9140-1-armbru@redhat.com>
References: <20190702104716.9140-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 02 Jul 2019 10:47:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/18] hw/core: Collect QMP command handlers in
 hw/core/
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The handlers for qapi/machine.json's QMP commands are spread over
cpus.c, hw/core/numa.c, monitor/misc.c, monitor/qmp-cmds.c, and vl.c.
Move them all to new hw/core/machine-qmp-cmds.c, where they are
covered by MAINTAINERS section "Machine core", just like
qapi/machine.json.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190619201050.19040-11-armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS                |   1 +
 cpus.c                     | 188 ---------------------
 hw/core/Makefile.objs      |   1 +
 hw/core/machine-qmp-cmds.c | 328 +++++++++++++++++++++++++++++++++++++
 hw/core/numa.c             |  62 -------
 include/sysemu/numa.h      |   2 +
 monitor/misc.c             |  13 --
 monitor/qmp-cmds.c         |  12 --
 vl.c                       |  45 -----
 9 files changed, 332 insertions(+), 320 deletions(-)
 create mode 100644 hw/core/machine-qmp-cmds.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 96eaa1e124..bf6742d59f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1264,6 +1264,7 @@ Machine core
 M: Eduardo Habkost <ehabkost@redhat.com>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
+F: hw/core/machine-qmp-cmds.c
 F: hw/core/machine.c
 F: hw/core/null-machine.c
 F: hw/core/numa.c
diff --git a/cpus.c b/cpus.c
index 100ce47fef..eef7b007ae 100644
--- a/cpus.c
+++ b/cpus.c
@@ -25,16 +25,13 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/config-file.h"
-#include "cpu.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
 #include "sysemu/block-backend.h"
 #include "exec/gdbstub.h"
@@ -57,7 +54,6 @@
 #include "tcg.h"
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
-#include "hw/boards.h"
=20
 #ifdef CONFIG_LINUX
=20
@@ -2201,190 +2197,6 @@ void list_cpus(const char *optarg)
 #endif
 }
=20
-CpuInfoList *qmp_query_cpus(Error **errp)
-{
-    MachineState *ms =3D MACHINE(qdev_get_machine());
-    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
-    CpuInfoList *head =3D NULL, *cur_item =3D NULL;
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        CpuInfoList *info;
-#if defined(TARGET_I386)
-        X86CPU *x86_cpu =3D X86_CPU(cpu);
-        CPUX86State *env =3D &x86_cpu->env;
-#elif defined(TARGET_PPC)
-        PowerPCCPU *ppc_cpu =3D POWERPC_CPU(cpu);
-        CPUPPCState *env =3D &ppc_cpu->env;
-#elif defined(TARGET_SPARC)
-        SPARCCPU *sparc_cpu =3D SPARC_CPU(cpu);
-        CPUSPARCState *env =3D &sparc_cpu->env;
-#elif defined(TARGET_RISCV)
-        RISCVCPU *riscv_cpu =3D RISCV_CPU(cpu);
-        CPURISCVState *env =3D &riscv_cpu->env;
-#elif defined(TARGET_MIPS)
-        MIPSCPU *mips_cpu =3D MIPS_CPU(cpu);
-        CPUMIPSState *env =3D &mips_cpu->env;
-#elif defined(TARGET_TRICORE)
-        TriCoreCPU *tricore_cpu =3D TRICORE_CPU(cpu);
-        CPUTriCoreState *env =3D &tricore_cpu->env;
-#elif defined(TARGET_S390X)
-        S390CPU *s390_cpu =3D S390_CPU(cpu);
-        CPUS390XState *env =3D &s390_cpu->env;
-#endif
-
-        cpu_synchronize_state(cpu);
-
-        info =3D g_malloc0(sizeof(*info));
-        info->value =3D g_malloc0(sizeof(*info->value));
-        info->value->CPU =3D cpu->cpu_index;
-        info->value->current =3D (cpu =3D=3D first_cpu);
-        info->value->halted =3D cpu->halted;
-        info->value->qom_path =3D object_get_canonical_path(OBJECT(cpu))=
;
-        info->value->thread_id =3D cpu->thread_id;
-#if defined(TARGET_I386)
-        info->value->arch =3D CPU_INFO_ARCH_X86;
-        info->value->u.x86.pc =3D env->eip + env->segs[R_CS].base;
-#elif defined(TARGET_PPC)
-        info->value->arch =3D CPU_INFO_ARCH_PPC;
-        info->value->u.ppc.nip =3D env->nip;
-#elif defined(TARGET_SPARC)
-        info->value->arch =3D CPU_INFO_ARCH_SPARC;
-        info->value->u.q_sparc.pc =3D env->pc;
-        info->value->u.q_sparc.npc =3D env->npc;
-#elif defined(TARGET_MIPS)
-        info->value->arch =3D CPU_INFO_ARCH_MIPS;
-        info->value->u.q_mips.PC =3D env->active_tc.PC;
-#elif defined(TARGET_TRICORE)
-        info->value->arch =3D CPU_INFO_ARCH_TRICORE;
-        info->value->u.tricore.PC =3D env->PC;
-#elif defined(TARGET_S390X)
-        info->value->arch =3D CPU_INFO_ARCH_S390;
-        info->value->u.s390.cpu_state =3D env->cpu_state;
-#elif defined(TARGET_RISCV)
-        info->value->arch =3D CPU_INFO_ARCH_RISCV;
-        info->value->u.riscv.pc =3D env->pc;
-#else
-        info->value->arch =3D CPU_INFO_ARCH_OTHER;
-#endif
-        info->value->has_props =3D !!mc->cpu_index_to_instance_props;
-        if (info->value->has_props) {
-            CpuInstanceProperties *props;
-            props =3D g_malloc0(sizeof(*props));
-            *props =3D mc->cpu_index_to_instance_props(ms, cpu->cpu_inde=
x);
-            info->value->props =3D props;
-        }
-
-        /* XXX: waiting for the qapi to support GSList */
-        if (!cur_item) {
-            head =3D cur_item =3D info;
-        } else {
-            cur_item->next =3D info;
-            cur_item =3D info;
-        }
-    }
-
-    return head;
-}
-
-static CpuInfoArch sysemu_target_to_cpuinfo_arch(SysEmuTarget target)
-{
-    /*
-     * The @SysEmuTarget -> @CpuInfoArch mapping below is based on the
-     * TARGET_ARCH -> TARGET_BASE_ARCH mapping in the "configure" script=
.
-     */
-    switch (target) {
-    case SYS_EMU_TARGET_I386:
-    case SYS_EMU_TARGET_X86_64:
-        return CPU_INFO_ARCH_X86;
-
-    case SYS_EMU_TARGET_PPC:
-    case SYS_EMU_TARGET_PPC64:
-        return CPU_INFO_ARCH_PPC;
-
-    case SYS_EMU_TARGET_SPARC:
-    case SYS_EMU_TARGET_SPARC64:
-        return CPU_INFO_ARCH_SPARC;
-
-    case SYS_EMU_TARGET_MIPS:
-    case SYS_EMU_TARGET_MIPSEL:
-    case SYS_EMU_TARGET_MIPS64:
-    case SYS_EMU_TARGET_MIPS64EL:
-        return CPU_INFO_ARCH_MIPS;
-
-    case SYS_EMU_TARGET_TRICORE:
-        return CPU_INFO_ARCH_TRICORE;
-
-    case SYS_EMU_TARGET_S390X:
-        return CPU_INFO_ARCH_S390;
-
-    case SYS_EMU_TARGET_RISCV32:
-    case SYS_EMU_TARGET_RISCV64:
-        return CPU_INFO_ARCH_RISCV;
-
-    default:
-        return CPU_INFO_ARCH_OTHER;
-    }
-}
-
-static void cpustate_to_cpuinfo_s390(CpuInfoS390 *info, const CPUState *=
cpu)
-{
-#ifdef TARGET_S390X
-    S390CPU *s390_cpu =3D S390_CPU(cpu);
-    CPUS390XState *env =3D &s390_cpu->env;
-
-    info->cpu_state =3D env->cpu_state;
-#else
-    abort();
-#endif
-}
-
-/*
- * fast means: we NEVER interrupt vCPU threads to retrieve
- * information from KVM.
- */
-CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
-{
-    MachineState *ms =3D MACHINE(qdev_get_machine());
-    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
-    CpuInfoFastList *head =3D NULL, *cur_item =3D NULL;
-    SysEmuTarget target =3D qapi_enum_parse(&SysEmuTarget_lookup, TARGET=
_NAME,
-                                          -1, &error_abort);
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        CpuInfoFastList *info =3D g_malloc0(sizeof(*info));
-        info->value =3D g_malloc0(sizeof(*info->value));
-
-        info->value->cpu_index =3D cpu->cpu_index;
-        info->value->qom_path =3D object_get_canonical_path(OBJECT(cpu))=
;
-        info->value->thread_id =3D cpu->thread_id;
-
-        info->value->has_props =3D !!mc->cpu_index_to_instance_props;
-        if (info->value->has_props) {
-            CpuInstanceProperties *props;
-            props =3D g_malloc0(sizeof(*props));
-            *props =3D mc->cpu_index_to_instance_props(ms, cpu->cpu_inde=
x);
-            info->value->props =3D props;
-        }
-
-        info->value->arch =3D sysemu_target_to_cpuinfo_arch(target);
-        info->value->target =3D target;
-        if (target =3D=3D SYS_EMU_TARGET_S390X) {
-            cpustate_to_cpuinfo_s390(&info->value->u.s390x, cpu);
-        }
-
-        if (!cur_item) {
-            head =3D cur_item =3D info;
-        } else {
-            cur_item->next =3D info;
-            cur_item =3D info;
-        }
-    }
-
-    return head;
-}
-
 void qmp_memsave(int64_t addr, int64_t size, const char *filename,
                  bool has_cpu, int64_t cpu_index, Error **errp)
 {
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index e3a8307be6..99e7abe982 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -23,4 +23,5 @@ common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
 common-obj-$(CONFIG_SOFTMMU) +=3D generic-loader.o
 common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
=20
+obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o
 obj-$(CONFIG_SOFTMMU) +=3D numa.o
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
new file mode 100644
index 0000000000..1e08252af7
--- /dev/null
+++ b/hw/core/machine-qmp-cmds.c
@@ -0,0 +1,328 @@
+/*
+ * QMP commands related to machines and CPUs
+ *
+ * Copyright (C) 2014 Red Hat Inc
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/boards.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
+#include "qapi/qmp/qerror.h"
+#include "sysemu/hostmem.h"
+#include "sysemu/hw_accel.h"
+#include "sysemu/numa.h"
+#include "sysemu/sysemu.h"
+
+CpuInfoList *qmp_query_cpus(Error **errp)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+    CpuInfoList *head =3D NULL, *cur_item =3D NULL;
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        CpuInfoList *info;
+#if defined(TARGET_I386)
+        X86CPU *x86_cpu =3D X86_CPU(cpu);
+        CPUX86State *env =3D &x86_cpu->env;
+#elif defined(TARGET_PPC)
+        PowerPCCPU *ppc_cpu =3D POWERPC_CPU(cpu);
+        CPUPPCState *env =3D &ppc_cpu->env;
+#elif defined(TARGET_SPARC)
+        SPARCCPU *sparc_cpu =3D SPARC_CPU(cpu);
+        CPUSPARCState *env =3D &sparc_cpu->env;
+#elif defined(TARGET_RISCV)
+        RISCVCPU *riscv_cpu =3D RISCV_CPU(cpu);
+        CPURISCVState *env =3D &riscv_cpu->env;
+#elif defined(TARGET_MIPS)
+        MIPSCPU *mips_cpu =3D MIPS_CPU(cpu);
+        CPUMIPSState *env =3D &mips_cpu->env;
+#elif defined(TARGET_TRICORE)
+        TriCoreCPU *tricore_cpu =3D TRICORE_CPU(cpu);
+        CPUTriCoreState *env =3D &tricore_cpu->env;
+#elif defined(TARGET_S390X)
+        S390CPU *s390_cpu =3D S390_CPU(cpu);
+        CPUS390XState *env =3D &s390_cpu->env;
+#endif
+
+        cpu_synchronize_state(cpu);
+
+        info =3D g_malloc0(sizeof(*info));
+        info->value =3D g_malloc0(sizeof(*info->value));
+        info->value->CPU =3D cpu->cpu_index;
+        info->value->current =3D (cpu =3D=3D first_cpu);
+        info->value->halted =3D cpu->halted;
+        info->value->qom_path =3D object_get_canonical_path(OBJECT(cpu))=
;
+        info->value->thread_id =3D cpu->thread_id;
+#if defined(TARGET_I386)
+        info->value->arch =3D CPU_INFO_ARCH_X86;
+        info->value->u.x86.pc =3D env->eip + env->segs[R_CS].base;
+#elif defined(TARGET_PPC)
+        info->value->arch =3D CPU_INFO_ARCH_PPC;
+        info->value->u.ppc.nip =3D env->nip;
+#elif defined(TARGET_SPARC)
+        info->value->arch =3D CPU_INFO_ARCH_SPARC;
+        info->value->u.q_sparc.pc =3D env->pc;
+        info->value->u.q_sparc.npc =3D env->npc;
+#elif defined(TARGET_MIPS)
+        info->value->arch =3D CPU_INFO_ARCH_MIPS;
+        info->value->u.q_mips.PC =3D env->active_tc.PC;
+#elif defined(TARGET_TRICORE)
+        info->value->arch =3D CPU_INFO_ARCH_TRICORE;
+        info->value->u.tricore.PC =3D env->PC;
+#elif defined(TARGET_S390X)
+        info->value->arch =3D CPU_INFO_ARCH_S390;
+        info->value->u.s390.cpu_state =3D env->cpu_state;
+#elif defined(TARGET_RISCV)
+        info->value->arch =3D CPU_INFO_ARCH_RISCV;
+        info->value->u.riscv.pc =3D env->pc;
+#else
+        info->value->arch =3D CPU_INFO_ARCH_OTHER;
+#endif
+        info->value->has_props =3D !!mc->cpu_index_to_instance_props;
+        if (info->value->has_props) {
+            CpuInstanceProperties *props;
+            props =3D g_malloc0(sizeof(*props));
+            *props =3D mc->cpu_index_to_instance_props(ms, cpu->cpu_inde=
x);
+            info->value->props =3D props;
+        }
+
+        /* XXX: waiting for the qapi to support GSList */
+        if (!cur_item) {
+            head =3D cur_item =3D info;
+        } else {
+            cur_item->next =3D info;
+            cur_item =3D info;
+        }
+    }
+
+    return head;
+}
+
+static CpuInfoArch sysemu_target_to_cpuinfo_arch(SysEmuTarget target)
+{
+    /*
+     * The @SysEmuTarget -> @CpuInfoArch mapping below is based on the
+     * TARGET_ARCH -> TARGET_BASE_ARCH mapping in the "configure" script=
.
+     */
+    switch (target) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return CPU_INFO_ARCH_X86;
+
+    case SYS_EMU_TARGET_PPC:
+    case SYS_EMU_TARGET_PPC64:
+        return CPU_INFO_ARCH_PPC;
+
+    case SYS_EMU_TARGET_SPARC:
+    case SYS_EMU_TARGET_SPARC64:
+        return CPU_INFO_ARCH_SPARC;
+
+    case SYS_EMU_TARGET_MIPS:
+    case SYS_EMU_TARGET_MIPSEL:
+    case SYS_EMU_TARGET_MIPS64:
+    case SYS_EMU_TARGET_MIPS64EL:
+        return CPU_INFO_ARCH_MIPS;
+
+    case SYS_EMU_TARGET_TRICORE:
+        return CPU_INFO_ARCH_TRICORE;
+
+    case SYS_EMU_TARGET_S390X:
+        return CPU_INFO_ARCH_S390;
+
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return CPU_INFO_ARCH_RISCV;
+
+    default:
+        return CPU_INFO_ARCH_OTHER;
+    }
+}
+
+static void cpustate_to_cpuinfo_s390(CpuInfoS390 *info, const CPUState *=
cpu)
+{
+#ifdef TARGET_S390X
+    S390CPU *s390_cpu =3D S390_CPU(cpu);
+    CPUS390XState *env =3D &s390_cpu->env;
+
+    info->cpu_state =3D env->cpu_state;
+#else
+    abort();
+#endif
+}
+
+/*
+ * fast means: we NEVER interrupt vCPU threads to retrieve
+ * information from KVM.
+ */
+CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+    CpuInfoFastList *head =3D NULL, *cur_item =3D NULL;
+    SysEmuTarget target =3D qapi_enum_parse(&SysEmuTarget_lookup, TARGET=
_NAME,
+                                          -1, &error_abort);
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        CpuInfoFastList *info =3D g_malloc0(sizeof(*info));
+        info->value =3D g_malloc0(sizeof(*info->value));
+
+        info->value->cpu_index =3D cpu->cpu_index;
+        info->value->qom_path =3D object_get_canonical_path(OBJECT(cpu))=
;
+        info->value->thread_id =3D cpu->thread_id;
+
+        info->value->has_props =3D !!mc->cpu_index_to_instance_props;
+        if (info->value->has_props) {
+            CpuInstanceProperties *props;
+            props =3D g_malloc0(sizeof(*props));
+            *props =3D mc->cpu_index_to_instance_props(ms, cpu->cpu_inde=
x);
+            info->value->props =3D props;
+        }
+
+        info->value->arch =3D sysemu_target_to_cpuinfo_arch(target);
+        info->value->target =3D target;
+        if (target =3D=3D SYS_EMU_TARGET_S390X) {
+            cpustate_to_cpuinfo_s390(&info->value->u.s390x, cpu);
+        }
+
+        if (!cur_item) {
+            head =3D cur_item =3D info;
+        } else {
+            cur_item->next =3D info;
+            cur_item =3D info;
+        }
+    }
+
+    return head;
+}
+
+MachineInfoList *qmp_query_machines(Error **errp)
+{
+    GSList *el, *machines =3D object_class_get_list(TYPE_MACHINE, false)=
;
+    MachineInfoList *mach_list =3D NULL;
+
+    for (el =3D machines; el; el =3D el->next) {
+        MachineClass *mc =3D el->data;
+        MachineInfoList *entry;
+        MachineInfo *info;
+
+        info =3D g_malloc0(sizeof(*info));
+        if (mc->is_default) {
+            info->has_is_default =3D true;
+            info->is_default =3D true;
+        }
+
+        if (mc->alias) {
+            info->has_alias =3D true;
+            info->alias =3D g_strdup(mc->alias);
+        }
+
+        info->name =3D g_strdup(mc->name);
+        info->cpu_max =3D !mc->max_cpus ? 1 : mc->max_cpus;
+        info->hotpluggable_cpus =3D mc->has_hotpluggable_cpus;
+
+        entry =3D g_malloc0(sizeof(*entry));
+        entry->value =3D info;
+        entry->next =3D mach_list;
+        mach_list =3D entry;
+    }
+
+    g_slist_free(machines);
+    return mach_list;
+}
+
+CurrentMachineParams *qmp_query_current_machine(Error **errp)
+{
+    CurrentMachineParams *params =3D g_malloc0(sizeof(*params));
+    params->wakeup_suspend_support =3D qemu_wakeup_suspend_enabled();
+
+    return params;
+}
+
+HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+
+    if (!mc->has_hotpluggable_cpus) {
+        error_setg(errp, QERR_FEATURE_DISABLED, "query-hotpluggable-cpus=
");
+        return NULL;
+    }
+
+    return machine_query_hotpluggable_cpus(ms);
+}
+
+void qmp_cpu_add(int64_t id, Error **errp)
+{
+    MachineClass *mc;
+
+    mc =3D MACHINE_GET_CLASS(current_machine);
+    if (mc->hot_add_cpu) {
+        mc->hot_add_cpu(id, errp);
+    } else {
+        error_setg(errp, "Not supported");
+    }
+}
+
+void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
+{
+    if (!runstate_check(RUN_STATE_PRECONFIG)) {
+        error_setg(errp, "The command is permitted only in '%s' state",
+                   RunState_str(RUN_STATE_PRECONFIG));
+         return;
+    }
+
+    set_numa_options(MACHINE(qdev_get_machine()), cmd, errp);
+}
+
+static int query_memdev(Object *obj, void *opaque)
+{
+    MemdevList **list =3D opaque;
+    MemdevList *m =3D NULL;
+
+    if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
+        m =3D g_malloc0(sizeof(*m));
+
+        m->value =3D g_malloc0(sizeof(*m->value));
+
+        m->value->id =3D object_get_canonical_path_component(obj);
+        m->value->has_id =3D !!m->value->id;
+
+        m->value->size =3D object_property_get_uint(obj, "size",
+                                                  &error_abort);
+        m->value->merge =3D object_property_get_bool(obj, "merge",
+                                                   &error_abort);
+        m->value->dump =3D object_property_get_bool(obj, "dump",
+                                                  &error_abort);
+        m->value->prealloc =3D object_property_get_bool(obj,
+                                                      "prealloc",
+                                                      &error_abort);
+        m->value->policy =3D object_property_get_enum(obj,
+                                                    "policy",
+                                                    "HostMemPolicy",
+                                                    &error_abort);
+        object_property_get_uint16List(obj, "host-nodes",
+                                       &m->value->host_nodes,
+                                       &error_abort);
+
+        m->next =3D *list;
+        *list =3D m;
+    }
+
+    return 0;
+}
+
+MemdevList *qmp_query_memdev(Error **errp)
+{
+    Object *obj =3D object_get_objects_root();
+    MemdevList *list =3D NULL;
+
+    object_child_foreach(obj, query_memdev, &list);
+    return list;
+}
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 6f85407c46..76c447f90a 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -27,14 +27,10 @@
 #include "exec/cpu-common.h"
 #include "exec/ramlist.h"
 #include "qemu/bitmap.h"
-#include "qom/cpu.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
-#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-visit-machine.h"
-#include "hw/boards.h"
-#include "sysemu/hostmem.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/memory-device.h"
 #include "qemu/option.h"
@@ -174,7 +170,6 @@ static void parse_numa_distance(NumaDistOptions *dist=
, Error **errp)
     have_numa_distance =3D true;
 }
=20
-static
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **err=
p)
 {
     Error *err =3D NULL;
@@ -447,17 +442,6 @@ void parse_numa_opts(MachineState *ms)
     qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, &error_fat=
al);
 }
=20
-void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
-{
-    if (!runstate_check(RUN_STATE_PRECONFIG)) {
-        error_setg(errp, "The command is permitted only in '%s' state",
-                   RunState_str(RUN_STATE_PRECONFIG));
-         return;
-    }
-
-    set_numa_options(MACHINE(qdev_get_machine()), cmd, errp);
-}
-
 void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **=
errp)
 {
     int node_id =3D object_property_get_int(OBJECT(dev), "node-id", &err=
or_abort);
@@ -592,52 +576,6 @@ void query_numa_node_mem(NumaNodeMem node_mem[])
     }
 }
=20
-static int query_memdev(Object *obj, void *opaque)
-{
-    MemdevList **list =3D opaque;
-    MemdevList *m =3D NULL;
-
-    if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
-        m =3D g_malloc0(sizeof(*m));
-
-        m->value =3D g_malloc0(sizeof(*m->value));
-
-        m->value->id =3D object_get_canonical_path_component(obj);
-        m->value->has_id =3D !!m->value->id;
-
-        m->value->size =3D object_property_get_uint(obj, "size",
-                                                  &error_abort);
-        m->value->merge =3D object_property_get_bool(obj, "merge",
-                                                   &error_abort);
-        m->value->dump =3D object_property_get_bool(obj, "dump",
-                                                  &error_abort);
-        m->value->prealloc =3D object_property_get_bool(obj,
-                                                      "prealloc",
-                                                      &error_abort);
-        m->value->policy =3D object_property_get_enum(obj,
-                                                    "policy",
-                                                    "HostMemPolicy",
-                                                    &error_abort);
-        object_property_get_uint16List(obj, "host-nodes",
-                                       &m->value->host_nodes,
-                                       &error_abort);
-
-        m->next =3D *list;
-        *list =3D m;
-    }
-
-    return 0;
-}
-
-MemdevList *qmp_query_memdev(Error **errp)
-{
-    Object *obj =3D object_get_objects_root();
-    MemdevList *list =3D NULL;
-
-    object_child_foreach(obj, query_memdev, &list);
-    return list;
-}
-
 void ram_block_notifier_add(RAMBlockNotifier *n)
 {
     QLIST_INSERT_HEAD(&ram_list.ramblock_notifiers, n, next);
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index b6ac7de43e..01a263eba2 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -22,6 +22,8 @@ struct NumaNodeMem {
 };
=20
 extern NodeInfo numa_info[MAX_NODES];
+
+void set_numa_options(MachineState *ms, NumaOptions *object, Error **err=
p);
 void parse_numa_opts(MachineState *ms);
 void numa_complete_configuration(MachineState *ms);
 void query_numa_node_mem(NumaNodeMem node_mem[]);
diff --git a/monitor/misc.c b/monitor/misc.c
index 2fb6896e84..45f3f55a4d 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -2338,16 +2338,3 @@ void monitor_init_globals(void)
     sortcmdlist();
     qemu_mutex_init(&mon_fdsets_lock);
 }
-
-HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
-{
-    MachineState *ms =3D MACHINE(qdev_get_machine());
-    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
-
-    if (!mc->has_hotpluggable_cpus) {
-        error_setg(errp, QERR_FEATURE_DISABLED, "query-hotpluggable-cpus=
");
-        return NULL;
-    }
-
-    return machine_query_hotpluggable_cpus(ms);
-}
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 5788db5c59..b9ae40eec7 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -114,18 +114,6 @@ void qmp_system_powerdown(Error **erp)
     qemu_system_powerdown_request();
 }
=20
-void qmp_cpu_add(int64_t id, Error **errp)
-{
-    MachineClass *mc;
-
-    mc =3D MACHINE_GET_CLASS(current_machine);
-    if (mc->hot_add_cpu) {
-        mc->hot_add_cpu(id, errp);
-    } else {
-        error_setg(errp, "Not supported");
-    }
-}
-
 void qmp_x_exit_preconfig(Error **errp)
 {
     if (!runstate_check(RUN_STATE_PRECONFIG)) {
diff --git a/vl.c b/vl.c
index 0eb9b2c8bd..ddefa75c1d 100644
--- a/vl.c
+++ b/vl.c
@@ -55,7 +55,6 @@ int main(int argc, char **argv)
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "hw/hw.h"
-#include "hw/boards.h"
 #include "sysemu/accel.h"
 #include "hw/usb.h"
 #include "hw/isa/isa.h"
@@ -125,7 +124,6 @@ int main(int argc, char **argv)
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qapi-visit-ui.h"
 #include "qapi/qapi-commands-block-core.h"
-#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qerror.h"
@@ -1406,41 +1404,6 @@ static MachineClass *find_default_machine(GSList *=
machines)
     return NULL;
 }
=20
-MachineInfoList *qmp_query_machines(Error **errp)
-{
-    GSList *el, *machines =3D object_class_get_list(TYPE_MACHINE, false)=
;
-    MachineInfoList *mach_list =3D NULL;
-
-    for (el =3D machines; el; el =3D el->next) {
-        MachineClass *mc =3D el->data;
-        MachineInfoList *entry;
-        MachineInfo *info;
-
-        info =3D g_malloc0(sizeof(*info));
-        if (mc->is_default) {
-            info->has_is_default =3D true;
-            info->is_default =3D true;
-        }
-
-        if (mc->alias) {
-            info->has_alias =3D true;
-            info->alias =3D g_strdup(mc->alias);
-        }
-
-        info->name =3D g_strdup(mc->name);
-        info->cpu_max =3D !mc->max_cpus ? 1 : mc->max_cpus;
-        info->hotpluggable_cpus =3D mc->has_hotpluggable_cpus;
-
-        entry =3D g_malloc0(sizeof(*entry));
-        entry->value =3D info;
-        entry->next =3D mach_list;
-        mach_list =3D entry;
-    }
-
-    g_slist_free(machines);
-    return mach_list;
-}
-
 static int machine_help_func(QemuOpts *opts, MachineState *machine)
 {
     ObjectProperty *prop;
@@ -1739,14 +1702,6 @@ bool qemu_wakeup_suspend_enabled(void)
     return wakeup_suspend_enabled;
 }
=20
-CurrentMachineParams *qmp_query_current_machine(Error **errp)
-{
-    CurrentMachineParams *params =3D g_malloc0(sizeof(*params));
-    params->wakeup_suspend_support =3D qemu_wakeup_suspend_enabled();
-
-    return params;
-}
-
 void qemu_system_killed(int signal, pid_t pid)
 {
     shutdown_signal =3D signal;
--=20
2.21.0


