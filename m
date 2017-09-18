Received: from eggs.gnu.org ([2001:4830:134:3::10]:37855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUc-0007bJ-Dw
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUW-0008ET-QC
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUW-0008Dx-HE
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:48 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 18:00:03 +0200
Message-Id: <20170918160012.4317-19-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 18/27] s390x/tcg: implement SIGP SENSE
 RUNNING STATUS
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

Preparation for TCG, for KVM is this is completely handled in the
kernel.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h  |  2 ++
 target/s390x/sigp.c | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5d03802c7d..5aa755d7b5 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -594,6 +594,7 @@ struct sysib_322 {
 #define SIGP_SET_PREFIX        0x0d
 #define SIGP_STORE_STATUS_ADDR 0x0e
 #define SIGP_SET_ARCH          0x12
+#define SIGP_SENSE_RUNNING     0x15
 #define SIGP_STORE_ADTL_STATUS 0x17
 
 /* SIGP condition codes */
@@ -604,6 +605,7 @@ struct sysib_322 {
 
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
2.13.5
