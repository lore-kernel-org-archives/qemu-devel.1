Received: from eggs.gnu.org ([209.51.188.92]:60082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7w-00065u-Ie
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7v-0004G3-1k
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:52 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7u-00045K-O7
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:50 -0500
Received: by mail-wr1-x430.google.com with SMTP id z18so205451wrh.2
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:36:15 +0100
Message-Id: <1549305379-51117-74-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 73/77] i386: hvf: Fix smp boot hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Heiher <r@hev.cc>

From: Heiher <r@hev.cc>

The machine that with hvf accelerator and smp sometimes boot hangs
because all processors are executing instructions at startup,
including early I/O emulations. We should just allow the bootstrap
processor to initialize the machine and then to wake up slave
processors by interrupt.

Signed-off-by: Heiher <r@hev.cc>
Message-Id: <20190123073402.28465-1-r@hev.cc>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 689b585..42f9447 100644
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
1.8.3.1
