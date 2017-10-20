Received: from eggs.gnu.org ([2001:4830:134:3::10]:59058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vtu-00031M-2h
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vtq-0003WS-6C
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:42 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:56 +0200
Message-Id: <20171020115418.2050-25-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 24/46] s390x/tcg: implement SIGP CONDITIONAL
 EMERGENCY SIGNAL
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

Mostly analogous to the kernel/KVM version (so I assume the checks are
correct :) ). As a preparation for TCG.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-24-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h  |  1 +
 target/s390x/sigp.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 6b92b0751a..7f4f03f410 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -590,6 +590,7 @@ struct sysib_322 {
 #define SIGP_SET_PREFIX        0x0d
 #define SIGP_STORE_STATUS_ADDR 0x0e
 #define SIGP_SET_ARCH          0x12
+#define SIGP_COND_EMERGENCY    0x13
 #define SIGP_SENSE_RUNNING     0x15
 #define SIGP_STORE_ADTL_STATUS 0x17
 
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index d492885787..ce8fda9d01 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -290,6 +290,40 @@ static void sigp_set_prefix(CPUState *cs, run_on_cpu_data arg)
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
+static void sigp_cond_emergency(S390CPU *src_cpu, S390CPU *dst_cpu,
+                                SigpInfo *si)
+{
+    const uint64_t psw_int_mask = PSW_MASK_IO | PSW_MASK_EXT;
+    uint16_t p_asn, s_asn, asn;
+    uint64_t psw_addr, psw_mask;
+    bool idle;
+
+    if (!tcg_enabled()) {
+        /* handled in KVM */
+        set_sigp_status(si, SIGP_STAT_INVALID_ORDER);
+        return;
+    }
+
+    /* this looks racy, but these values are only used when STOPPED */
+    idle = CPU(dst_cpu)->halted;
+    psw_addr = dst_cpu->env.psw.addr;
+    psw_mask = dst_cpu->env.psw.mask;
+    asn = si->param;
+    p_asn = dst_cpu->env.cregs[4] & 0xffff;  /* Primary ASN */
+    s_asn = dst_cpu->env.cregs[3] & 0xffff;  /* Secondary ASN */
+
+    if (s390_cpu_get_state(dst_cpu) != CPU_STATE_STOPPED ||
+        (psw_mask & psw_int_mask) != psw_int_mask ||
+        (idle && psw_addr != 0) ||
+        (!idle && (asn == p_asn || asn == s_asn))) {
+        cpu_inject_emergency_signal(dst_cpu, src_cpu->env.core_id);
+    } else {
+        set_sigp_status(si, SIGP_STAT_INCORRECT_STATE);
+    }
+
+    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+}
+
 static void sigp_sense_running(S390CPU *dst_cpu, SigpInfo *si)
 {
     if (!tcg_enabled()) {
@@ -369,6 +403,9 @@ static int handle_sigp_single_dst(S390CPU *cpu, S390CPU *dst_cpu, uint8_t order,
     case SIGP_CPU_RESET:
         run_on_cpu(CPU(dst_cpu), sigp_cpu_reset, RUN_ON_CPU_HOST_PTR(&si));
         break;
+    case SIGP_COND_EMERGENCY:
+        sigp_cond_emergency(cpu, dst_cpu, &si);
+        break;
     case SIGP_SENSE_RUNNING:
         sigp_sense_running(dst_cpu, &si);
         break;
-- 
2.13.6
