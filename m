Received: from eggs.gnu.org ([2001:4830:134:3::10]:58882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vtk-0002rE-SK
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vth-0003PV-Q8
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:32 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:52 +0200
Message-Id: <20171020115418.2050-21-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 20/46] s390x/tcg: implement SIGP SENSE RUNNING
 STATUS
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

Preparation for TCG, for KVM is this is completely handled in the
kernel.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-20-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h  |  2 ++
 target/s390x/sigp.c | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index f94d7f96e0..6b92b0751a 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -590,6 +590,7 @@ struct sysib_322 {
 #define SIGP_SET_PREFIX        0x0d
 #define SIGP_STORE_STATUS_ADDR 0x0e
 #define SIGP_SET_ARCH          0x12
+#define SIGP_SENSE_RUNNING     0x15
 #define SIGP_STORE_ADTL_STATUS 0x17
 
 /* SIGP condition codes */
@@ -600,6 +601,7 @@ struct sysib_322 {
 
 /* SIGP status bits */
 #define SIGP_STAT_EQUIPMENT_CHECK   0x80000000UL
+#define SIGP_STAT_NOT_RUNNING       0x00000400UL
 #define SIGP_STAT_INCORRECT_STATE   0x00000200UL
 #define SIGP_STAT_INVALID_PARAMETER 0x00000100UL
 #define SIGP_STAT_EXT_CALL_PENDING  0x00000080UL
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 9587c3d319..c57312b743 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -234,6 +234,28 @@ static void sigp_set_prefix(CPUState *cs, run_on_cpu_data arg)
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
+static void sigp_sense_running(S390CPU *dst_cpu, SigpInfo *si)
+{
+    if (!tcg_enabled()) {
+        /* handled in KVM */
+        set_sigp_status(si, SIGP_STAT_INVALID_ORDER);
+        return;
+    }
+
+    /* sensing without locks is racy, but it's the same for real hw */
+    if (!s390_has_feat(S390_FEAT_SENSE_RUNNING_STATUS)) {
+        set_sigp_status(si, SIGP_STAT_INVALID_ORDER);
+        return;
+    }
+
+    /* If halted (which includes also STOPPED), it is not running */
+    if (CPU(dst_cpu)->halted) {
+        si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+    } else {
+        set_sigp_status(si, SIGP_STAT_NOT_RUNNING);
+    }
+}
+
 static int handle_sigp_single_dst(S390CPU *dst_cpu, uint8_t order,
                                   uint64_t param, uint64_t *status_reg)
 {
@@ -282,6 +304,9 @@ static int handle_sigp_single_dst(S390CPU *dst_cpu, uint8_t order,
     case SIGP_CPU_RESET:
         run_on_cpu(CPU(dst_cpu), sigp_cpu_reset, RUN_ON_CPU_HOST_PTR(&si));
         break;
+    case SIGP_SENSE_RUNNING:
+        sigp_sense_running(dst_cpu, &si);
+        break;
     default:
         set_sigp_status(&si, SIGP_STAT_INVALID_ORDER);
     }
-- 
2.13.6
