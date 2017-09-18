Received: from eggs.gnu.org ([2001:4830:134:3::10]:37492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyU6-00079u-11
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyU2-0007xB-1k
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyU1-0007wk-Si
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:17 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 17:59:55 +0200
Message-Id: <20170918160012.4317-11-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 10/27] s390x/kvm: pass ipb directly into
 handle_sigp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

No need to pass kvm_run.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 14f864697d..da3f7e9895 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1852,7 +1852,7 @@ static int sigp_set_architecture(S390CPU *cpu, uint32_t param,
     return SIGP_CC_STATUS_STORED;
 }
 
-static int handle_sigp(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
+static int handle_sigp(S390CPU *cpu, uint32_t ipb, uint8_t ipa1)
 {
     CPUS390XState *env = &cpu->env;
     const uint8_t r1 = ipa1 >> 4;
@@ -1866,7 +1866,7 @@ static int handle_sigp(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
     cpu_synchronize_state(CPU(cpu));
 
     /* get order code */
-    order = decode_basedisp_rs(env, run->s390_sieic.ipb, NULL)
+    order = decode_basedisp_rs(env, ipb, NULL)
         & SIGP_ORDER_MASK;
     status_reg = &env->regs[r1];
     param = (r1 % 2) ? env->regs[r1] : env->regs[r1 + 1];
@@ -1924,7 +1924,7 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
         r = handle_diag(cpu, run, run->s390_sieic.ipb);
         break;
     case IPA0_SIGP:
-        r = handle_sigp(cpu, run, ipa1);
+        r = handle_sigp(cpu, run->s390_sieic.ipb, ipa1);
         break;
     }
 
-- 
2.13.5
