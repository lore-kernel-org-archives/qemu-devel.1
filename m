Received: from eggs.gnu.org ([2001:4830:134:3::10]:53414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYz-0003u1-IP
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYy-0003AU-SI
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfYy-0003A3-M5
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:40 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:49 +0200
Message-Id: <20170928203708.9376-12-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/30] s390x/kvm: pass ipb directly into
 handle_sigp()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
List-ID: <qemu-devel.nongnu.org>

No need to pass kvm_run. Pass parameters alphabetically ordered.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 8dc82fbb59..43f8f7331a 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1876,7 +1876,7 @@ static int sigp_set_architecture(S390CPU *cpu, uint32_t param,
     return SIGP_CC_STATUS_STORED;
 }
 
-static int handle_sigp(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
+static int handle_sigp(S390CPU *cpu, uint8_t ipa1, uint32_t ipb)
 {
     CPUS390XState *env = &cpu->env;
     const uint8_t r1 = ipa1 >> 4;
@@ -1890,7 +1890,7 @@ static int handle_sigp(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
     cpu_synchronize_state(CPU(cpu));
 
     /* get order code */
-    order = decode_basedisp_rs(env, run->s390_sieic.ipb, NULL)
+    order = decode_basedisp_rs(env, ipb, NULL)
         & SIGP_ORDER_MASK;
     status_reg = &env->regs[r1];
     param = (r1 % 2) ? env->regs[r1] : env->regs[r1 + 1];
@@ -1948,7 +1948,7 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
         r = handle_diag(cpu, run, run->s390_sieic.ipb);
         break;
     case IPA0_SIGP:
-        r = handle_sigp(cpu, run, ipa1);
+        r = handle_sigp(cpu, ipa1, run->s390_sieic.ipb);
         break;
     }
 
-- 
2.13.5
