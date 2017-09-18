Received: from eggs.gnu.org ([2001:4830:134:3::10]:37950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUk-0007j6-9k
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUh-0008I5-TR
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUh-0008Hm-Kg
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:59 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 18:00:07 +0200
Message-Id: <20170918160012.4317-23-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 22/27] s390x/tcg: implement SIGP CONDITIONAL
 EMERGENCY SIGNAL
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

Mostly analogous to the kernel/KVM version (so I assume the checks are
correct :) ). As a preparation for TCG.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h  |  1 +
 target/s390x/sigp.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5aa755d7b5..97d4abb6c0 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -594,6 +594,7 @@ struct sysib_322 {
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
2.13.5
