Received: from eggs.gnu.org ([2001:4830:134:3::10]:46909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fdfPZ-00058I-Mn
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fdfPX-0005s3-3q
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:29:49 -0400
Received: from mail-am5eur03on0726.outbound.protection.outlook.com
	([2a01:111:f400:fe08::726]:26229
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fdfPW-0005nq-FU
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 13:29:47 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Thu, 12 Jul 2018 20:29:27 +0300
Message-Id: <1531416567-13558-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] dump: add kernel_gs_base to QEMU CPU state
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

 target/i386/arch_dump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 35b55fc..cc8750f 100644
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
@@ -315,6 +321,8 @@ static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
     s->cr[2] = env->cr[2];
     s->cr[3] = env->cr[3];
     s->cr[4] = env->cr[4];
+
+    s->kernel_gs_base = env->kernelgsbase;
 }
 
 static inline int cpu_write_qemu_note(WriteCoreDumpFunction f,
-- 
2.7.4
