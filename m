Received: from eggs.gnu.org ([2001:4830:134:3::10]:55769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1feJih-0000q5-Px
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 08:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1feJid-0001DX-QP
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 08:32:15 -0400
Received: from mail-eopbgr40093.outbound.protection.outlook.com
	([40.107.4.93]:33061
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1feJid-0001AM-98
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 08:32:11 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Sat, 14 Jul 2018 15:30:00 +0300
Message-Id: <20180714123000.11326-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] dump: add kernel_gs_base to QEMU CPU state
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
 v2: keep version 1 in QEMUCPUState and document the extension procedure
 v3: enable kernel_gs_base filling only on x86_64

 target/i386/arch_dump.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 35b55fc200..004141fc04 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -258,6 +258,12 @@ struct QEMUCPUState {
     QEMUCPUSegment cs, ds, es, fs, gs, ss;
     QEMUCPUSegment ldt, tr, gdt, idt;
     uint64_t cr[5];
+    /*
+     * Fields below are optional and are being added at the end without
+     * changing the version. External tools may identify their presence
+     * by checking 'size' field.
+     */
+    uint64_t kernel_gs_base;
 };
 
 typedef struct QEMUCPUState QEMUCPUState;
@@ -315,6 +321,10 @@ static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
     s->cr[2] = env->cr[2];
     s->cr[3] = env->cr[3];
     s->cr[4] = env->cr[4];
+
+#ifdef TARGET_X86_64
+    s->kernel_gs_base = env->kernelgsbase;
+#endif
 }
 
 static inline int cpu_write_qemu_note(WriteCoreDumpFunction f,
-- 
2.14.3
