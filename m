Received: from eggs.gnu.org ([2001:4830:134:3::10]:32967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fB5lQ-0002sS-C4
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fB5lN-00077R-Vo
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:46:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53832 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fB5lN-00077L-PG
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:46:13 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Tue, 24 Apr 2018 23:45:50 +0200
Message-Id: <20180424214550.32549-7-lersek@redhat.com>
In-Reply-To: <20180424214550.32549-1-lersek@redhat.com>
References: <20180424214550.32549-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] qapi: discriminate CpuInfo[Fast] on
 SysEmuTarget, not CpuInfoArch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Add a new field @target (of type @SysEmuTarget) to the outputs of the
@query-cpus and @query-cpus-fast commands, which provides more information
about the emulation target than the field @arch (of type @CpuInfoArch).
Keep @arch for compatibility.

Make @target the new discriminator for the @CpuInfo and @CpuInfoFast
return structures. This lets us hoist @arch to @CpuInfoCommon, but it also
requires some gymnastics in qmp_query_cpus() and qmp_query_cpus_fast().

In particular, conditional compilation cannot be removed, because each
pair of CPU base arch structures, such as X86CPU/CPUX86State,
PowerPCCPU/CPUPPCState, SPARCCPU/CPUSPARCState, is only visible when
building QEMU for a target that maps to that CPU base arch.

Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    PATCHv1:
    
    - new patch

 qapi/misc.json | 118 ++++++++++++++++++-------
 cpus.c         | 275 ++++++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 291 insertions(+), 102 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index d7b776a5af37..98c15880f9f0 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -361,77 +361,105 @@
 # Collects fields common to @CpuInfoBase and @CpuInfoFastBase; that is,
 # fields that are shared by @query-cpus and @query-cpus-fast, and not
 # specific to the target architecture.
 #
 # @qom-path: path to the CPU object in the QOM tree (since 2.4)
 #
 # @thread-id: ID of the underlying host thread
 #
 # @props: properties describing which node/socket/core/thread the
 #         virtual CPU belongs to, if supported by the board (since 2.10)
 #
+# @arch: base architecture of the cpu (since 2.6)
+#
 # Since: 2.13
 ##
 { 'struct' : 'CpuInfoCommon',
   'data'   : { 'qom-path'  : 'str',
                'thread-id' : 'int',
-               '*props'    : 'CpuInstanceProperties' } }
+               '*props'    : 'CpuInstanceProperties',
+               'arch'      : 'CpuInfoArch' } }
 
 ##
 # @CpuInfoBase:
 #
 # Extends @CpuInfoCommon with fields that are specific to the @query-cpus
 # command, but not specific to the target architecture.
 #
 # @CPU: the index of the virtual CPU
 #
 # @current: this only exists for backwards compatibility and should be ignored
 #
 # @halted: true if the virtual CPU is in the halt state.  Halt usually refers
 #          to a processor specific low power mode.
 #
-# @arch: architecture of the cpu, which determines which additional fields
-#        will be listed (since 2.6)
+# @target: the QEMU system emulation target, which is more specific than
+#          @arch and determines which additional fields will be listed
+#
 #
 # Since: 2.13
 #
 # Notes: @halted is a transient state that changes frequently.  By the time the
 #        data is sent to the client, the guest may no longer be halted.
-#        Moreover, @arch cannot be moved up to @CpuInfoCommon because
+#        Moreover, @target cannot be moved up to @CpuInfoCommon because
 #        that would prevent its use as the discriminator in @CpuInfo.
 ##
 { 'struct' : 'CpuInfoBase',
   'base'   : 'CpuInfoCommon',
   'data'   : { 'CPU'     : 'int',
                'current' : 'bool',
                'halted'  : 'bool',
-               'arch'    : 'CpuInfoArch' } }
+               'target'  : 'SysEmuTarget' } }
 
 ##
 # @CpuInfo:
 #
 # Information about a virtual CPU
 #
 # Since: 0.14.0
 ##
-{ 'union': 'CpuInfo',
-  'base': 'CpuInfoBase',
-  'discriminator': 'arch',
-  'data': { 'x86': 'CpuInfoX86',
-            'sparc': 'CpuInfoSPARC',
-            'ppc': 'CpuInfoPPC',
-            'mips': 'CpuInfoMIPS',
-            'tricore': 'CpuInfoTricore',
-            's390': 'CpuInfoS390',
-            'riscv': 'CpuInfoRISCV',
-            'other': 'CpuInfoOther' } }
+{ 'union'         : 'CpuInfo',
+  'base'          : 'CpuInfoBase',
+  'discriminator' : 'target',
+  'data'          : { 'i386'         : 'CpuInfoX86',
+                      'x86_64'       : 'CpuInfoX86',
+                      'sparc'        : 'CpuInfoSPARC',
+                      'sparc64'      : 'CpuInfoSPARC',
+                      'ppc'          : 'CpuInfoPPC',
+                      'ppcemb'       : 'CpuInfoPPC',
+                      'ppc64'        : 'CpuInfoPPC',
+                      'mips'         : 'CpuInfoMIPS',
+                      'mipsel'       : 'CpuInfoMIPS',
+                      'mips64'       : 'CpuInfoMIPS',
+                      'mips64el'     : 'CpuInfoMIPS',
+                      'tricore'      : 'CpuInfoTricore',
+                      's390x'        : 'CpuInfoS390',
+                      'riscv32'      : 'CpuInfoRISCV',
+                      'riscv64'      : 'CpuInfoRISCV',
+                      'aarch64'      : 'CpuInfoOther',
+                      'alpha'        : 'CpuInfoOther',
+                      'arm'          : 'CpuInfoOther',
+                      'cris'         : 'CpuInfoOther',
+                      'hppa'         : 'CpuInfoOther',
+                      'lm32'         : 'CpuInfoOther',
+                      'm68k'         : 'CpuInfoOther',
+                      'microblaze'   : 'CpuInfoOther',
+                      'microblazeel' : 'CpuInfoOther',
+                      'moxie'        : 'CpuInfoOther',
+                      'nios2'        : 'CpuInfoOther',
+                      'or1k'         : 'CpuInfoOther',
+                      'sh4'          : 'CpuInfoOther',
+                      'sh4eb'        : 'CpuInfoOther',
+                      'unicore32'    : 'CpuInfoOther',
+                      'xtensa'       : 'CpuInfoOther',
+                      'xtensaeb'     : 'CpuInfoOther' } }
 
 ##
 # @CpuInfoX86:
 #
 # Additional information about a virtual i386 or x86_64 CPU
 #
 # @pc: the 64-bit instruction pointer
 #
 # Since: 2.6
 ##
 { 'struct': 'CpuInfoX86', 'data': { 'pc': 'int' } }
@@ -543,84 +571,110 @@
 #
 # Example:
 #
 # -> { "execute": "query-cpus" }
 # <- { "return": [
 #          {
 #             "CPU":0,
 #             "current":true,
 #             "halted":false,
 #             "qom-path":"/machine/unattached/device[0]",
 #             "arch":"x86",
+#             "target":"x86_64",
 #             "pc":3227107138,
 #             "thread-id":3134
 #          },
 #          {
 #             "CPU":1,
 #             "current":false,
 #             "halted":true,
 #             "qom-path":"/machine/unattached/device[2]",
 #             "arch":"x86",
+#             "target":"x86_64",
 #             "pc":7108165,
 #             "thread-id":3135
 #          }
 #       ]
 #    }
 #
 # Notes: This interface is deprecated (since 2.12.0), and it is strongly
 #        recommended that you avoid using it. Use @query-cpus-fast to
 #        obtain information about virtual CPUs.
 #
 ##
 { 'command': 'query-cpus', 'returns': ['CpuInfo'] }
 
 ##
 # @CpuInfoFastBase:
 #
 # Extends @CpuInfoCommon with fields that are specific to the
 # @query-cpus-fast command, but not specific to the target architecture.
 #
 # @cpu-index: index of the virtual CPU
 #
-# @arch: architecture of the cpu, which determines which additional fields
-#        will be listed
+# @target: the QEMU system emulation target, which is more specific than
+#          @arch and determines which additional fields will be listed
 #
 # Since: 2.13
 #
-# Notes: @arch cannot be moved up to @CpuInfoCommon because that would
+# Notes: @target cannot be moved up to @CpuInfoCommon because that would
 #        prevent its use as the discriminator in @CpuInfoFast.
 ##
 { 'struct' : 'CpuInfoFastBase',
   'base'   : 'CpuInfoCommon',
   'data'   : { 'cpu-index' : 'int',
-               'arch'      : 'CpuInfoArch' } }
+               'target'    : 'SysEmuTarget' } }
 
 ##
 # @CpuInfoFast:
 #
 # Information about a virtual CPU
 #
 # Since: 2.12
 #
 ##
-{ 'union': 'CpuInfoFast',
-  'base': 'CpuInfoFastBase',
-  'discriminator': 'arch',
-  'data': { 'x86': 'CpuInfoOther',
-            'sparc': 'CpuInfoOther',
-            'ppc': 'CpuInfoOther',
-            'mips': 'CpuInfoOther',
-            'tricore': 'CpuInfoOther',
-            's390': 'CpuInfoS390',
-            'riscv': 'CpuInfoOther',
-            'other': 'CpuInfoOther' } }
+{ 'union'         : 'CpuInfoFast',
+  'base'          : 'CpuInfoFastBase',
+  'discriminator' : 'target',
+  'data'          : { 'i386'         : 'CpuInfoOther',
+                      'x86_64'       : 'CpuInfoOther',
+                      'sparc'        : 'CpuInfoOther',
+                      'sparc64'      : 'CpuInfoOther',
+                      'ppc'          : 'CpuInfoOther',
+                      'ppcemb'       : 'CpuInfoOther',
+                      'ppc64'        : 'CpuInfoOther',
+                      'mips'         : 'CpuInfoOther',
+                      'mipsel'       : 'CpuInfoOther',
+                      'mips64'       : 'CpuInfoOther',
+                      'mips64el'     : 'CpuInfoOther',
+                      'tricore'      : 'CpuInfoOther',
+                      's390x'        : 'CpuInfoS390',
+                      'riscv32'      : 'CpuInfoOther',
+                      'riscv64'      : 'CpuInfoOther',
+                      'aarch64'      : 'CpuInfoOther',
+                      'alpha'        : 'CpuInfoOther',
+                      'arm'          : 'CpuInfoOther',
+                      'cris'         : 'CpuInfoOther',
+                      'hppa'         : 'CpuInfoOther',
+                      'lm32'         : 'CpuInfoOther',
+                      'm68k'         : 'CpuInfoOther',
+                      'microblaze'   : 'CpuInfoOther',
+                      'microblazeel' : 'CpuInfoOther',
+                      'moxie'        : 'CpuInfoOther',
+                      'nios2'        : 'CpuInfoOther',
+                      'or1k'         : 'CpuInfoOther',
+                      'sh4'          : 'CpuInfoOther',
+                      'sh4eb'        : 'CpuInfoOther',
+                      'unicore32'    : 'CpuInfoOther',
+                      'xtensa'       : 'CpuInfoOther',
+                      'xtensaeb'     : 'CpuInfoOther' } }
 
 ##
 # @query-cpus-fast:
 #
 # Returns information about all virtual CPUs. This command does not
 # incur a performance penalty and should be used in production
 # instead of query-cpus.
 #
 # Returns: list of @CpuInfoFast
 #
 # Since: 2.12
@@ -630,33 +684,35 @@
 # -> { "execute": "query-cpus-fast" }
 # <- { "return": [
 #         {
 #             "thread-id": 25627,
 #             "props": {
 #                 "core-id": 0,
 #                 "thread-id": 0,
 #                 "socket-id": 0
 #             },
 #             "qom-path": "/machine/unattached/device[0]",
 #             "arch":"x86",
+#             "target":"x86_64",
 #             "cpu-index": 0
 #         },
 #         {
 #             "thread-id": 25628,
 #             "props": {
 #                 "core-id": 0,
 #                 "thread-id": 0,
 #                 "socket-id": 1
 #             },
 #             "qom-path": "/machine/unattached/device[2]",
 #             "arch":"x86",
+#             "target":"x86_64",
 #             "cpu-index": 1
 #         }
 #     ]
 # }
 ##
 { 'command': 'query-cpus-fast', 'returns': [ 'CpuInfoFast' ] }
 
 ##
 # @IOThreadInfo:
 #
 # Information about an iothread
diff --git a/cpus.c b/cpus.c
index 60563a6d54ec..86eed0ffe796 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2093,88 +2093,235 @@ int vm_stop_force_state(RunState state)
     }
 }
 
 void list_cpus(FILE *f, fprintf_function cpu_fprintf, const char *optarg)
 {
     /* XXX: implement xxx_cpu_list for targets that still miss it */
 #if defined(cpu_list)
     cpu_list(f, cpu_fprintf);
 #endif
 }
 
+static CpuInfoArch sysemu_target_to_cpuinfo_arch(SysEmuTarget target)
+{
+    /*
+     * The @SysEmuTarget -> @CpuInfoArch mapping below is based on the
+     * TARGET_ARCH -> TARGET_BASE_ARCH mapping in the "configure" script.
+     */
+    switch (target) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return CPU_INFO_ARCH_X86;
+
+    case SYS_EMU_TARGET_PPC:
+    case SYS_EMU_TARGET_PPCEMB:
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
+static void cpustate_to_cpuinfo_x86(CpuInfoX86 *info, const CPUState *cpu)
+{
+#ifdef TARGET_I386
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    info->pc = env->eip + env->segs[R_CS].base;
+#else
+    abort();
+#endif
+}
+
+static void cpustate_to_cpuinfo_ppc(CpuInfoPPC *info, const CPUState *cpu)
+{
+#ifdef TARGET_PPC
+    PowerPCCPU *ppc_cpu = POWERPC_CPU(cpu);
+    CPUPPCState *env = &ppc_cpu->env;
+
+    info->nip = env->nip;
+#else
+    abort();
+#endif
+}
+
+static void cpustate_to_cpuinfo_sparc(CpuInfoSPARC *info, const CPUState *cpu)
+{
+#ifdef TARGET_SPARC
+    SPARCCPU *sparc_cpu = SPARC_CPU(cpu);
+    CPUSPARCState *env = &sparc_cpu->env;
+
+    info->pc = env->pc;
+    info->npc = env->npc;
+#else
+    abort();
+#endif
+}
+
+static void cpustate_to_cpuinfo_mips(CpuInfoMIPS *info, const CPUState *cpu)
+{
+#ifdef TARGET_MIPS
+    MIPSCPU *mips_cpu = MIPS_CPU(cpu);
+    CPUMIPSState *env = &mips_cpu->env;
+
+    info->PC = env->active_tc.PC;
+#else
+    abort();
+#endif
+}
+
+static void cpustate_to_cpuinfo_tricore(CpuInfoTricore *info,
+                                        const CPUState *cpu)
+{
+#ifdef TARGET_TRICORE
+    TriCoreCPU *tricore_cpu = TRICORE_CPU(cpu);
+    CPUTriCoreState *env = &tricore_cpu->env;
+
+    info->PC = env->PC;
+#else
+    abort();
+#endif
+}
+
+static void cpustate_to_cpuinfo_s390(CpuInfoS390 *info, const CPUState *cpu)
+{
+#ifdef TARGET_S390X
+    S390CPU *s390_cpu = S390_CPU(cpu);
+    CPUS390XState *env = &s390_cpu->env;
+
+    info->cpu_state = env->cpu_state;
+#else
+    abort();
+#endif
+}
+
+static void cpustate_to_cpuinfo_riscv(CpuInfoRISCV *info, const CPUState *cpu)
+{
+#ifdef TARGET_RISCV
+    RISCVCPU *riscv_cpu = RISCV_CPU(cpu);
+    CPURISCVState *env = &riscv_cpu->env;
+
+    info->pc = env->pc;
+#else
+    abort();
+#endif
+}
+
 CpuInfoList *qmp_query_cpus(Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CpuInfoList *head = NULL, *cur_item = NULL;
+    SysEmuTarget target = qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME,
+                                          -1, &error_abort);
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
         CpuInfoList *info;
-#if defined(TARGET_I386)
-        X86CPU *x86_cpu = X86_CPU(cpu);
-        CPUX86State *env = &x86_cpu->env;
-#elif defined(TARGET_PPC)
-        PowerPCCPU *ppc_cpu = POWERPC_CPU(cpu);
-        CPUPPCState *env = &ppc_cpu->env;
-#elif defined(TARGET_SPARC)
-        SPARCCPU *sparc_cpu = SPARC_CPU(cpu);
-        CPUSPARCState *env = &sparc_cpu->env;
-#elif defined(TARGET_RISCV)
-        RISCVCPU *riscv_cpu = RISCV_CPU(cpu);
-        CPURISCVState *env = &riscv_cpu->env;
-#elif defined(TARGET_MIPS)
-        MIPSCPU *mips_cpu = MIPS_CPU(cpu);
-        CPUMIPSState *env = &mips_cpu->env;
-#elif defined(TARGET_TRICORE)
-        TriCoreCPU *tricore_cpu = TRICORE_CPU(cpu);
-        CPUTriCoreState *env = &tricore_cpu->env;
-#elif defined(TARGET_S390X)
-        S390CPU *s390_cpu = S390_CPU(cpu);
-        CPUS390XState *env = &s390_cpu->env;
-#endif
 
         cpu_synchronize_state(cpu);
 
         info = g_malloc0(sizeof(*info));
         info->value = g_malloc0(sizeof(*info->value));
         info->value->CPU = cpu->cpu_index;
         info->value->current = (cpu == first_cpu);
         info->value->halted = cpu->halted;
         info->value->qom_path = object_get_canonical_path(OBJECT(cpu));
         info->value->thread_id = cpu->thread_id;
-#if defined(TARGET_I386)
-        info->value->arch = CPU_INFO_ARCH_X86;
-        info->value->u.x86.pc = env->eip + env->segs[R_CS].base;
-#elif defined(TARGET_PPC)
-        info->value->arch = CPU_INFO_ARCH_PPC;
-        info->value->u.ppc.nip = env->nip;
-#elif defined(TARGET_SPARC)
-        info->value->arch = CPU_INFO_ARCH_SPARC;
-        info->value->u.q_sparc.pc = env->pc;
-        info->value->u.q_sparc.npc = env->npc;
-#elif defined(TARGET_MIPS)
-        info->value->arch = CPU_INFO_ARCH_MIPS;
-        info->value->u.q_mips.PC = env->active_tc.PC;
-#elif defined(TARGET_TRICORE)
-        info->value->arch = CPU_INFO_ARCH_TRICORE;
-        info->value->u.tricore.PC = env->PC;
-#elif defined(TARGET_S390X)
-        info->value->arch = CPU_INFO_ARCH_S390;
-        info->value->u.s390.cpu_state = env->cpu_state;
-#elif defined(TARGET_RISCV)
-        info->value->arch = CPU_INFO_ARCH_RISCV;
-        info->value->u.riscv.pc = env->pc;
-#else
-        info->value->arch = CPU_INFO_ARCH_OTHER;
-#endif
+        info->value->arch = sysemu_target_to_cpuinfo_arch(target);
+        info->value->target = target;
+
+        /*
+         * The @SysEmuTarget -> @CpuInfo mapping below is based on the
+         * TARGET_ARCH -> TARGET_BASE_ARCH mapping in the "configure" script.
+         */
+        switch (target) {
+        case SYS_EMU_TARGET_I386:
+            cpustate_to_cpuinfo_x86(&info->value->u.i386, cpu);
+            break;
+        case SYS_EMU_TARGET_X86_64:
+            cpustate_to_cpuinfo_x86(&info->value->u.x86_64, cpu);
+            break;
+
+        case SYS_EMU_TARGET_PPC:
+            cpustate_to_cpuinfo_ppc(&info->value->u.ppc, cpu);
+            break;
+        case SYS_EMU_TARGET_PPCEMB:
+            cpustate_to_cpuinfo_ppc(&info->value->u.ppcemb, cpu);
+            break;
+        case SYS_EMU_TARGET_PPC64:
+            cpustate_to_cpuinfo_ppc(&info->value->u.ppc64, cpu);
+            break;
+
+        case SYS_EMU_TARGET_SPARC:
+            cpustate_to_cpuinfo_sparc(&info->value->u.q_sparc, cpu);
+            break;
+        case SYS_EMU_TARGET_SPARC64:
+            cpustate_to_cpuinfo_sparc(&info->value->u.sparc64, cpu);
+            break;
+
+        case SYS_EMU_TARGET_MIPS:
+            cpustate_to_cpuinfo_mips(&info->value->u.q_mips, cpu);
+            break;
+        case SYS_EMU_TARGET_MIPSEL:
+            cpustate_to_cpuinfo_mips(&info->value->u.mipsel, cpu);
+            break;
+        case SYS_EMU_TARGET_MIPS64:
+            cpustate_to_cpuinfo_mips(&info->value->u.mips64, cpu);
+            break;
+        case SYS_EMU_TARGET_MIPS64EL:
+            cpustate_to_cpuinfo_mips(&info->value->u.mips64el, cpu);
+            break;
+
+        case SYS_EMU_TARGET_TRICORE:
+            cpustate_to_cpuinfo_tricore(&info->value->u.tricore, cpu);
+            break;
+
+        case SYS_EMU_TARGET_S390X:
+            cpustate_to_cpuinfo_s390(&info->value->u.s390x, cpu);
+            break;
+
+        case SYS_EMU_TARGET_RISCV32:
+            cpustate_to_cpuinfo_riscv(&info->value->u.riscv32, cpu);
+            break;
+        case SYS_EMU_TARGET_RISCV64:
+            cpustate_to_cpuinfo_riscv(&info->value->u.riscv64, cpu);
+            break;
+
+        default:
+            /* do nothing for @CpuInfoOther */
+            break;
+        }
+
         info->value->has_props = !!mc->cpu_index_to_instance_props;
         if (info->value->has_props) {
             CpuInstanceProperties *props;
             props = g_malloc0(sizeof(*props));
             *props = mc->cpu_index_to_instance_props(ms, cpu->cpu_index);
             info->value->props = props;
         }
 
         /* XXX: waiting for the qapi to support GSList */
         if (!cur_item) {
             head = cur_item = info;
@@ -2188,64 +2335,50 @@ CpuInfoList *qmp_query_cpus(Error **errp)
 }
 
 /*
  * fast means: we NEVER interrupt vCPU threads to retrieve
  * information from KVM.
  */
 CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CpuInfoFastList *head = NULL, *cur_item = NULL;
+    SysEmuTarget target = qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME,
+                                          -1, &error_abort);
     CPUState *cpu;
-#if defined(TARGET_S390X)
-    S390CPU *s390_cpu;
-    CPUS390XState *env;
-#endif
 
     CPU_FOREACH(cpu) {
         CpuInfoFastList *info = g_malloc0(sizeof(*info));
         info->value = g_malloc0(sizeof(*info->value));
 
         info->value->cpu_index = cpu->cpu_index;
         info->value->qom_path = object_get_canonical_path(OBJECT(cpu));
         info->value->thread_id = cpu->thread_id;
 
         info->value->has_props = !!mc->cpu_index_to_instance_props;
         if (info->value->has_props) {
             CpuInstanceProperties *props;
             props = g_malloc0(sizeof(*props));
             *props = mc->cpu_index_to_instance_props(ms, cpu->cpu_index);
             info->value->props = props;
         }
 
-#if defined(TARGET_I386)
-        info->value->arch = CPU_INFO_ARCH_X86;
-#elif defined(TARGET_PPC)
-        info->value->arch = CPU_INFO_ARCH_PPC;
-#elif defined(TARGET_SPARC)
-        info->value->arch = CPU_INFO_ARCH_SPARC;
-#elif defined(TARGET_MIPS)
-        info->value->arch = CPU_INFO_ARCH_MIPS;
-#elif defined(TARGET_TRICORE)
-        info->value->arch = CPU_INFO_ARCH_TRICORE;
-#elif defined(TARGET_S390X)
-        s390_cpu = S390_CPU(cpu);
-        env = &s390_cpu->env;
-        info->value->arch = CPU_INFO_ARCH_S390;
-        info->value->u.s390.cpu_state = env->cpu_state;
-#elif defined(TARGET_RISCV)
-        info->value->arch = CPU_INFO_ARCH_RISCV;
-#else
-        info->value->arch = CPU_INFO_ARCH_OTHER;
-#endif
+        info->value->arch = sysemu_target_to_cpuinfo_arch(target);
+        info->value->target = target;
+        if (target == SYS_EMU_TARGET_S390X) {
+            cpustate_to_cpuinfo_s390(&info->value->u.s390x, cpu);
+        } else {
+            /* do nothing for @CpuInfoOther */
+        }
+
         if (!cur_item) {
             head = cur_item = info;
         } else {
             cur_item->next = info;
             cur_item = info;
         }
     }
 
     return head;
 }
 
-- 
2.14.1.3.gb7cf6e02401b
