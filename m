Received: from eggs.gnu.org ([2001:4830:134:3::10]:52289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fhvzC-00007A-6k
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fhvz6-0003Jp-4L
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:00:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48770 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fhvz5-0003Jb-Vj
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:00:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F240805A530
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 12:00:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Jul 2018 14:00:03 +0200
Message-Id: <20180724120003.27053-2-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] i386: implement MSR_SMI_COUNT for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

This is trivial, so just do it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/misc_helper.c | 3 +++
 target/i386/smm_helper.c  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 628f64aad5..78f2020ef2 100644
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
index 90621e5977..c1c34a75db 100644
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
2.17.1
