Received: from eggs.gnu.org ([209.51.188.92]:41520)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <r@hev.cc>)
	id 1gmD39-0005YX-91
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r@hev.cc>) id 1gmD38-0001pK-Io
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:34:15 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <r@hev.cc>) id 1gmD38-0001od-7P
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:34:14 -0500
Received: by mail-oi1-x241.google.com with SMTP id m6so1005736oig.11
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 23:34:12 -0800 (PST)
From: Heiher <r@hev.cc>
Date: Wed, 23 Jan 2019 15:34:02 +0800
Message-Id: <20190123073402.28465-1-r@hev.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC v1] i386: hvf: Fix smp boot hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Heiher <r@hev.cc>

The machine that with hvf accelerator and smp sometimes boot hangs
because all processors are executing instructions at startup,
including early I/O emulations. We should just allow the bootstrap
processor to initialize the machine and then to wake up slave
processors by interrupt.

Signed-off-by: Heiher <r@hev.cc>
---
 target/i386/hvf/hvf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index e193022c03..0921fcba45 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -499,7 +499,6 @@ void hvf_reset_vcpu(CPUState *cpu) {
     }
 
     hv_vm_sync_tsc(0);
-    cpu->halted = 0;
     hv_vcpu_invalidate_tlb(cpu->hvf_fd);
     hv_vcpu_flush(cpu->hvf_fd);
 }
@@ -582,8 +581,6 @@ int hvf_init_vcpu(CPUState *cpu)
 
     wvmcs(cpu->hvf_fd, VMCS_TPR_THRESHOLD, 0);
 
-    hvf_reset_vcpu(cpu);
-
     x86cpu = X86_CPU(cpu);
     x86cpu->env.xsave_buf = qemu_memalign(4096, 4096);
 
@@ -659,8 +656,6 @@ int hvf_vcpu_exec(CPUState *cpu)
     int ret = 0;
     uint64_t rip = 0;
 
-    cpu->halted = 0;
-
     if (hvf_process_events(cpu)) {
         return EXCP_HLT;
     }
-- 
2.20.1
