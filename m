Received: from eggs.gnu.org ([2001:4830:134:3::10]:38334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAz-0007ec-VL
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAz-00010p-5v
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:57 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAy-0000zm-Vl
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:57 -0400
Received: by mail-wr0-x243.google.com with SMTP id u7-v6so6680676wrn.12
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:53 +0200
Message-Id: <1530216310-52873-44-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 43/60] target-i386: Add NMI interception to SVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Check for SVM interception prior to injecting an NMI. Tested via the
Jailhouse hypervisor.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-Id: <c65877e9a011ee4962931287e59f502c482b8d0b.1522769774.git.jan.kiszka@web.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/seg_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 600a4d7..00301a0 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1337,6 +1337,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
             ret = true;
         } else if ((interrupt_request & CPU_INTERRUPT_NMI) &&
                    !(env->hflags2 & HF2_NMI_MASK)) {
+            cpu_svm_check_intercept_param(env, SVM_EXIT_NMI, 0, 0);
             cs->interrupt_request &= ~CPU_INTERRUPT_NMI;
             env->hflags2 |= HF2_NMI_MASK;
             do_interrupt_x86_hardirq(env, EXCP02_NMI, 1);
-- 
1.8.3.1
