Received: from eggs.gnu.org ([2001:4830:134:3::10]:48413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZ9-00052g-0f
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZ7-0007AX-Hp
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54062 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZ7-00079y-Bw
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:01 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:43 +0200
Message-Id: <1531840015-28804-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
References: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/13] dump: add kernel_gs_base to QEMU CPU state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

This patch adds field with content of KERNEL_GS_BASE MSR to QEMU note in
ELF dump.

On Windows, if all vCPUs are running usermode tasks at the time the dump is
created, this can be helpful in the discovery of guest system structures
during conversion ELF dump to MEMORY.DMP dump.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Message-Id: <20180714123000.11326-1-viktor.prutyanov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/arch_dump.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 35b55fc..004141f 100644
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
1.8.3.1
