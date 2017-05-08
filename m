Received: from eggs.gnu.org ([2001:4830:134:3::10]:47298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d7kPV-0005X2-3Z
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d7kPU-0001Ca-7Y
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:17:17 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d7kPU-0001CP-3i
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:17:16 -0400
Received: by mail-qt0-x244.google.com with SMTP id j13so9958739qta.3
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 08:17:16 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	r55sm7864331qte.22.2017.05.08.08.17.14 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 May 2017 08:17:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  8 May 2017 08:17:04 -0700
Message-Id: <20170508151707.5434-4-rth@twiddle.net>
In-Reply-To: <20170508151707.5434-1-rth@twiddle.net>
References: <20170508151707.5434-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 3/6] target/s390x: Diagnose specification
 exception for atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

All of the interlocked access facility instructions raise a
specification exception for unaligned accesses.  Do this by
using the (previously unused) unaligned_access hook.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.c    |  1 +
 target/s390x/cpu.h    |  3 +++
 target/s390x/helper.c | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 066dcd1..a1bf2ba 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -430,6 +430,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->write_elf64_note = s390_cpu_write_elf64_note;
     cc->cpu_exec_interrupt = s390_cpu_exec_interrupt;
     cc->debug_excp_handler = s390x_cpu_debug_excp_handler;
+    cc->do_unaligned_access = s390x_cpu_do_unaligned_access;
 #endif
     cc->disas_set_info = s390_cpu_disas_set_info;
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 058ddad..bbed320 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -480,6 +480,9 @@ int s390_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
 
 #ifndef CONFIG_USER_ONLY
 void do_restart_interrupt(CPUS390XState *env);
+void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                   MMUAccessType access_type,
+                                   int mmu_idx, uintptr_t retaddr);
 
 static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
                                        uint8_t *ar)
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 68bd2f9..9978490 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -718,4 +718,20 @@ void s390x_cpu_debug_excp_handler(CPUState *cs)
         cpu_loop_exit_noexc(cs);
     }
 }
+
+/* Unaligned accesses are only diagnosed with MO_ALIGN.  At the moment,
+   this is only for the atomic operations, for which we want to raise a
+   specification exception.  */
+void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                   MMUAccessType access_type,
+                                   int mmu_idx, uintptr_t retaddr)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
+    if (retaddr) {
+        cpu_restore_state(cs, retaddr);
+    }
+    program_interrupt(env, PGM_SPECIFICATION, ILEN_LATER);
+}
 #endif /* CONFIG_USER_ONLY */
-- 
2.9.3
