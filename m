Received: from eggs.gnu.org ([2001:4830:134:3::10]:38812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fcuT0-0007pW-8g
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fcuSv-00006n-8N
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:22:14 -0400
Received: from mail-eopbgr70114.outbound.protection.outlook.com
	([40.107.7.114]:5312
	helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fcuSu-000069-HJ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:22:09 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Tue, 10 Jul 2018 18:21:09 +0300
Message-Id: <1531236069-7500-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] dump: add kernel_gs_base to QEMU CPU state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, rkagan@virtuozzo.com, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

This patch adds field with content of KERNEL_GS_BASE MSR to QEMU note in
ELF dump.

On Windows, if all vCPUs are running usermode tasks at the time the dump is
created, this can be helpful in the discovery of guest system structures
during conversion ELF dump to MEMORY.DMP dump.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 target/i386/arch_dump.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 35b55fc..a702138 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -237,7 +237,7 @@ int x86_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
  * please count up QEMUCPUSTATE_VERSION if you have changed definition of
  * QEMUCPUState, and modify the tools using this information accordingly.
  */
-#define QEMUCPUSTATE_VERSION (1)
+#define QEMUCPUSTATE_VERSION (2)
 
 struct QEMUCPUSegment {
     uint32_t selector;
@@ -258,6 +258,7 @@ struct QEMUCPUState {
     QEMUCPUSegment cs, ds, es, fs, gs, ss;
     QEMUCPUSegment ldt, tr, gdt, idt;
     uint64_t cr[5];
+    uint64_t kernel_gs_base;
 };
 
 typedef struct QEMUCPUState QEMUCPUState;
@@ -315,6 +316,8 @@ static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
     s->cr[2] = env->cr[2];
     s->cr[3] = env->cr[3];
     s->cr[4] = env->cr[4];
+
+    s->kernel_gs_base = env->kernelgsbase;
 }
 
 static inline int cpu_write_qemu_note(WriteCoreDumpFunction f,
-- 
2.7.4
