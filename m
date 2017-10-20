Received: from eggs.gnu.org ([2001:4830:134:3::10]:58643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VtP-0002X0-8h
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VtN-00038P-Ae
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:11 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:45 +0200
Message-Id: <20171020115418.2050-14-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 13/46] s390x/kvm: pass ipb directly into
 handle_sigp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

No need to pass kvm_run. Pass parameters alphabetically ordered.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-12-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 3f656cfd07..2e75bda31a 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1913,7 +1913,7 @@ static int sigp_set_architecture(S390CPU *cpu, uint32_t param,
     return SIGP_CC_STATUS_STORED;
 }
 
-static int handle_sigp(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
+static int handle_sigp(S390CPU *cpu, uint8_t ipa1, uint32_t ipb)
 {
     CPUS390XState *env = &cpu->env;
     const uint8_t r1 = ipa1 >> 4;
@@ -1927,7 +1927,7 @@ static int handle_sigp(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
     cpu_synchronize_state(CPU(cpu));
 
     /* get order code */
-    order = decode_basedisp_rs(env, run->s390_sieic.ipb, NULL)
+    order = decode_basedisp_rs(env, ipb, NULL)
         & SIGP_ORDER_MASK;
     status_reg = &env->regs[r1];
     param = (r1 % 2) ? env->regs[r1] : env->regs[r1 + 1];
@@ -1985,7 +1985,7 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
         r = handle_diag(cpu, run, run->s390_sieic.ipb);
         break;
     case IPA0_SIGP:
-        r = handle_sigp(cpu, run, ipa1);
+        r = handle_sigp(cpu, ipa1, run->s390_sieic.ipb);
         break;
     }
 
-- 
2.13.6
