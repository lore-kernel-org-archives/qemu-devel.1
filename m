Received: from eggs.gnu.org ([2001:4830:134:3::10]:53572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfa4-0004nQ-5n
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfa2-0003Zg-CY
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfa2-0003ZR-6i
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:46 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:58 +0200
Message-Id: <20170928203708.9376-21-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 20/30] s390x/tcg: implement SIGP SENSE
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

Add it as preparation for TCG. Sensing coul later be done completely
lockless.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/sigp.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index c57312b743..063a34ccc7 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -32,6 +32,32 @@ static void set_sigp_status(SigpInfo *si, uint64_t status)
     si->cc = SIGP_CC_STATUS_STORED;
 }
 
+static void sigp_sense(S390CPU *dst_cpu, SigpInfo *si)
+{
+    uint8_t state = s390_cpu_get_state(dst_cpu);
+    bool ext_call = dst_cpu->env.pending_int & INTERRUPT_EXTERNAL_CALL;
+    uint64_t status = 0;
+
+    if (!tcg_enabled()) {
+        /* handled in KVM */
+        set_sigp_status(si, SIGP_STAT_INVALID_ORDER);
+        return;
+    }
+
+    /* sensing without locks is racy, but it's the same for real hw */
+    if (state != CPU_STATE_STOPPED && !ext_call) {
+        si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+    } else {
+        if (ext_call) {
+            status |= SIGP_STAT_EXT_CALL_PENDING;
+        }
+        if (state == CPU_STATE_STOPPED) {
+            status |= SIGP_STAT_STOPPED;
+        }
+        set_sigp_status(si, status);
+    }
+}
+
 static void sigp_start(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
@@ -277,6 +303,9 @@ static int handle_sigp_single_dst(S390CPU *dst_cpu, uint8_t order,
     }
 
     switch (order) {
+    case SIGP_SENSE:
+        sigp_sense(dst_cpu, &si);
+        break;
     case SIGP_START:
         run_on_cpu(CPU(dst_cpu), sigp_start, RUN_ON_CPU_HOST_PTR(&si));
         break;
-- 
2.13.5
