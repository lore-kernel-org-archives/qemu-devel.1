Received: from eggs.gnu.org ([2001:4830:134:3::10]:59076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fkPcd-0007cC-AA
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fkPcX-00019V-Kk
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:03:11 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fkPcX-00019D-D5
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:03:05 -0400
Received: by mail-wr1-x42c.google.com with SMTP id g6-v6so15594490wrp.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 01:03:05 -0700 (PDT)
Received: from donizetti.redhat.com
	(94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
	by smtp.gmail.com with ESMTPSA id
	j8-v6sm21748565wru.41.2018.07.31.01.03.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 31 Jul 2018 01:03:02 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 31 Jul 2018 10:02:57 +0200
Message-Id: <20180731080259.15934-3-pbonzini@redhat.com>
In-Reply-To: <20180731080259.15934-1-pbonzini@redhat.com>
References: <20180731080259.15934-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] i386: implement MSR_SMI_COUNT for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is trivial, so just do it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/misc_helper.c | 3 +++
 target/i386/smm_helper.c  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 628f64a..78f2020 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -447,6 +447,9 @@ void helper_rdmsr(CPUX86State *env)
         val = env->tsc_aux;
         break;
 #endif
+    case MSR_SMI_COUNT:
+        val = env->msr_smi_count;
+        break;
     case MSR_MTRRphysBase(0):
     case MSR_MTRRphysBase(1):
     case MSR_MTRRphysBase(2):
diff --git a/target/i386/smm_helper.c b/target/i386/smm_helper.c
index 90621e5..c1c34a7 100644
--- a/target/i386/smm_helper.c
+++ b/target/i386/smm_helper.c
@@ -54,6 +54,7 @@ void do_smm_enter(X86CPU *cpu)
     qemu_log_mask(CPU_LOG_INT, "SMM: enter\n");
     log_cpu_state_mask(CPU_LOG_INT, CPU(cpu), CPU_DUMP_CCOP);
 
+    env->msr_smi_count++;
     env->hflags |= HF_SMM_MASK;
     if (env->hflags2 & HF2_NMI_MASK) {
         env->hflags2 |= HF2_SMM_INSIDE_NMI_MASK;
-- 
1.8.3.1
