Received: from eggs.gnu.org ([2001:4830:134:3::10]:58880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vtk-0002r8-RC
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vtj-0003Ql-JC
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:55:32 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:53 +0200
Message-Id: <20171020115418.2050-22-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 21/46] s390x/tcg: implement SIGP SENSE
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

Add it as preparation for TCG. Sensing could later be done completely
lockless.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928203708.9376-21-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
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
2.13.6
