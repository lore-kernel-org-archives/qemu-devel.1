Received: from eggs.gnu.org ([2001:4830:134:3::10]:53704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fC93U-00063r-72
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fC93S-0000z6-HC
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34472 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fC93S-0000ye-Bo
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:29:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0D4042709C9
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 19:29:13 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri, 27 Apr 2018 21:28:51 +0200
Message-Id: <20180427192852.15013-5-lersek@redhat.com>
In-Reply-To: <20180427192852.15013-1-lersek@redhat.com>
References: <20180427192852.15013-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/5] qapi: discriminate CpuInfoFast on
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Add a new field @target (of type @SysEmuTarget) to the output of the
@query-cpus-fast command, which provides more information about the
emulation target than the field @arch (of type @CpuInfoArch). Make @target
the new discriminator for the @CpuInfoFast return structure. Keep @arch
for compatibility.

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---

Notes:
    PATCHv3:
    
    - remove superfluous empty comment line addition after @target
    
    - pick up Eric's R-b
    
    - skip Markus's R-b due to the next patch
    
    PATCHv2:
    
    - drop patch v1 5/6 with the CpuInfoCommon refactoring / extraction, as
      @CpuInfo / @query-cpus are deprecated [Eric, Markus]
    
    - for the same reason, add @target to @CpuInfoFast / @query-cpus-fast
      only [Eric, Markus]
    
    - Can't set @arch compatibly from a QAPI enum lookup of the proposed
      TARGET_BASE_ARCH macro, because TARGET_BASE_ARCH=s390x is not
      identical to the @s390 @CpuInfoArch constant -- see more at
      <http://mid.mail-archive.com/f0c9c7ca-3dcf-4f74-9812-5dea5b6376cd@redhat.com>.
      Keep sysemu_target_to_cpuinfo_arch() instead. [Markus, Eric]
    
    - update CC list
    
    PATCHv1:
    
    - new patch

 qapi/misc.json | 62 +++++++++++++++++++++++++++++++----------
 cpus.c         | 87 ++++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 110 insertions(+), 39 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 460866cf542f..fa4eec7b6b63 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -550,41 +550,71 @@
 # Information about a virtual CPU
 #
 # @cpu-index: index of the virtual CPU
 #
 # @qom-path: path to the CPU object in the QOM tree
 #
 # @thread-id: ID of the underlying host thread
 #
 # @props: properties describing to which node/socket/core/thread
 #         virtual CPU belongs to, provided if supported by board
 #
-# @arch: architecture of the cpu, which determines which additional fields
-#        will be listed
+# @arch: base architecture of the cpu
+#
+# @target: the QEMU system emulation target, which is more specific than
+#          @arch and determines which additional fields will be listed
+#          (since 2.13)
 #
 # Since: 2.12
 #
 ##
-{ 'union': 'CpuInfoFast',
-  'base': {'cpu-index': 'int', 'qom-path': 'str',
-           'thread-id': 'int', '*props': 'CpuInstanceProperties',
-           'arch': 'CpuInfoArch' },
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
+  'base'          : { 'cpu-index'    : 'int',
+                      'qom-path'     : 'str',
+                      'thread-id'    : 'int',
+                      '*props'       : 'CpuInstanceProperties',
+                      'arch'         : 'CpuInfoArch',
+                      'target'       : 'SysEmuTarget' },
+  'discriminator' : 'target',
+  'data'          : { 'aarch64'      : 'CpuInfoOther',
+                      'alpha'        : 'CpuInfoOther',
+                      'arm'          : 'CpuInfoOther',
+                      'cris'         : 'CpuInfoOther',
+                      'hppa'         : 'CpuInfoOther',
+                      'i386'         : 'CpuInfoOther',
+                      'lm32'         : 'CpuInfoOther',
+                      'm68k'         : 'CpuInfoOther',
+                      'microblaze'   : 'CpuInfoOther',
+                      'microblazeel' : 'CpuInfoOther',
+                      'mips'         : 'CpuInfoOther',
+                      'mips64'       : 'CpuInfoOther',
+                      'mips64el'     : 'CpuInfoOther',
+                      'mipsel'       : 'CpuInfoOther',
+                      'moxie'        : 'CpuInfoOther',
+                      'nios2'        : 'CpuInfoOther',
+                      'or1k'         : 'CpuInfoOther',
+                      'ppc'          : 'CpuInfoOther',
+                      'ppc64'        : 'CpuInfoOther',
+                      'ppcemb'       : 'CpuInfoOther',
+                      'riscv32'      : 'CpuInfoOther',
+                      'riscv64'      : 'CpuInfoOther',
+                      's390x'        : 'CpuInfoS390',
+                      'sh4'          : 'CpuInfoOther',
+                      'sh4eb'        : 'CpuInfoOther',
+                      'sparc'        : 'CpuInfoOther',
+                      'sparc64'      : 'CpuInfoOther',
+                      'tricore'      : 'CpuInfoOther',
+                      'unicore32'    : 'CpuInfoOther',
+                      'x86_64'       : 'CpuInfoOther',
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
@@ -594,33 +624,35 @@
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
index 60563a6d54ec..5bcd3ecf3848 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2179,73 +2179,112 @@ CpuInfoList *qmp_query_cpus(Error **errp)
         if (!cur_item) {
             head = cur_item = info;
         } else {
             cur_item->next = info;
             cur_item = info;
         }
     }
 
     return head;
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
