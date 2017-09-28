Received: from eggs.gnu.org ([2001:4830:134:3::10]:53590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfa5-0004oh-BT
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfa4-0003af-HS
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfa4-0003aF-Bs
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:48 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:59 +0200
Message-Id: <20170928203708.9376-22-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 21/30] s390x/tcg: implement SIGP EXTERNAL
 CALL
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

As preparation for TCG.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/sigp.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 063a34ccc7..080bce3fba 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -58,6 +58,24 @@ static void sigp_sense(S390CPU *dst_cpu, SigpInfo *si)
     }
 }
 
+static void sigp_external_call(S390CPU *src_cpu, S390CPU *dst_cpu, SigpInfo *si)
+{
+    int ret;
+
+    if (!tcg_enabled()) {
+        /* handled in KVM */
+        set_sigp_status(si, SIGP_STAT_INVALID_ORDER);
+        return;
+    }
+
+    ret = cpu_inject_external_call(dst_cpu, src_cpu->env.core_id);
+    if (!ret) {
+        si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+    } else {
+        set_sigp_status(si, SIGP_STAT_EXT_CALL_PENDING);
+    }
+}
+
 static void sigp_start(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
@@ -282,7 +300,7 @@ static void sigp_sense_running(S390CPU *dst_cpu, SigpInfo *si)
     }
 }
 
-static int handle_sigp_single_dst(S390CPU *dst_cpu, uint8_t order,
+static int handle_sigp_single_dst(S390CPU *cpu, S390CPU *dst_cpu, uint8_t order,
                                   uint64_t param, uint64_t *status_reg)
 {
     SigpInfo si = {
@@ -306,6 +324,9 @@ static int handle_sigp_single_dst(S390CPU *dst_cpu, uint8_t order,
     case SIGP_SENSE:
         sigp_sense(dst_cpu, &si);
         break;
+    case SIGP_EXTERNAL_CALL:
+        sigp_external_call(cpu, dst_cpu, &si);
+        break;
     case SIGP_START:
         run_on_cpu(CPU(dst_cpu), sigp_start, RUN_ON_CPU_HOST_PTR(&si));
         break;
@@ -389,7 +410,7 @@ int handle_sigp(CPUS390XState *env, uint8_t order, uint64_t r1, uint64_t r3)
     default:
         /* all other sigp orders target a single vcpu */
         dst_cpu = s390_cpu_addr2state(env->regs[r3]);
-        ret = handle_sigp_single_dst(dst_cpu, order, param, status_reg);
+        ret = handle_sigp_single_dst(cpu, dst_cpu, order, param, status_reg);
     }
     qemu_mutex_unlock(&qemu_sigp_mutex);
 
-- 
2.13.5
