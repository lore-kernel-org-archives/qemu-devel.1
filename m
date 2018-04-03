Received: from eggs.gnu.org ([2001:4830:134:3::10]:38191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f3NzA-0008Sw-EU
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f3Nz7-00089R-7i
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:36:36 -0400
Received: from mout.web.de ([212.227.15.4]:37331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1f3Nz6-000898-Ui
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:36:33 -0400
From: Jan Kiszka <jan.kiszka@web.de>
Date: Tue,  3 Apr 2018 17:36:11 +0200
Message-Id: <c65877e9a011ee4962931287e59f502c482b8d0b.1522769774.git.jan.kiszka@web.de>
In-Reply-To: <cover.1522769774.git.jan.kiszka@web.de>
References: <cover.1522769774.git.jan.kiszka@web.de>
In-Reply-To: <cover.1522769774.git.jan.kiszka@web.de>
References: <cover.1522769774.git.jan.kiszka@web.de>
Subject: [Qemu-devel] [PATCH v2 1/4] target-i386: Add NMI interception to SVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Check for SVM interception prior to injecting an NMI. Tested via the
Jailhouse hypervisor.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 target/i386/seg_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 600a4d7586..00301a0c04 100644
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
2.13.6
