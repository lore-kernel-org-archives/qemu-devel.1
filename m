Received: from eggs.gnu.org ([2001:4830:134:3::10]:42994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgZjE-0005yE-SY
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgZj9-00028P-Rq
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:25:20 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cgZj9-000283-Jl
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:25:15 -0500
Received: by mail-wr0-x234.google.com with SMTP id 97so5639530wrb.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 08:25:13 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 22 Feb 2017 16:25:06 +0000
Message-Id: <20170222162507.25987-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hmp: add PC information for ARM vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus.c           |  6 ++++++
 hmp.c            |  3 +++
 qapi-schema.json | 14 +++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 559a0805bc..dc8dbfb0f0 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1869,6 +1869,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
 #elif defined(TARGET_TRICORE)
         TriCoreCPU *tricore_cpu = TRICORE_CPU(cpu);
         CPUTriCoreState *env = &tricore_cpu->env;
+#elif defined(TARGET_AARCH64)
+        ARMCPU *arm_cpu = ARM_CPU(cpu);
+        CPUARMState *env = &arm_cpu->env;
 #endif
 
         cpu_synchronize_state(cpu);
@@ -1896,6 +1899,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
 #elif defined(TARGET_TRICORE)
         info->value->arch = CPU_INFO_ARCH_TRICORE;
         info->value->u.tricore.PC = env->PC;
+#elif defined(TARGET_AARCH64)
+        info->value->arch = CPU_INFO_ARCH_ARM;
+        info->value->u.arm.pc = env->pc;
 #else
         info->value->arch = CPU_INFO_ARCH_OTHER;
 #endif
diff --git a/hmp.c b/hmp.c
index 2bc4f062bb..03ef6ffdd7 100644
--- a/hmp.c
+++ b/hmp.c
@@ -369,6 +369,9 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
         case CPU_INFO_ARCH_TRICORE:
             monitor_printf(mon, " PC=0x%016" PRIx64, cpu->value->u.tricore.PC);
             break;
+        case CPU_INFO_ARCH_ARM:
+            monitor_printf(mon, " pc=0x%016" PRIx64, cpu->value->u.arm.pc);
+            break;
         default:
             break;
         }
diff --git a/qapi-schema.json b/qapi-schema.json
index e9a6364b7d..650e98c950 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1277,7 +1277,7 @@
 # Since: 2.6
 ##
 { 'enum': 'CpuInfoArch',
-  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'other' ] }
+  'data': ['x86', 'sparc', 'ppc', 'mips', 'tricore', 'arm', 'other' ] }
 
 ##
 # @CpuInfo:
@@ -1312,6 +1312,7 @@
             'ppc': 'CpuInfoPPC',
             'mips': 'CpuInfoMIPS',
             'tricore': 'CpuInfoTricore',
+            'arm': 'CpuInfoARM',
             'other': 'CpuInfoOther' } }
 
 ##
@@ -1372,6 +1373,17 @@
 { 'struct': 'CpuInfoTricore', 'data': { 'PC': 'int' } }
 
 ##
+# @CpuInfoARM:
+#
+# Additional information about a virtual ARM CPU
+#
+# @pc: the instruction pointer
+#
+# Since: 2.9
+##
+{ 'struct': 'CpuInfoARM', 'data': { 'pc': 'int' } }
+
+##
 # @CpuInfoOther:
 #
 # No additional information is available about the virtual CPU
-- 
2.11.0
