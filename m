Received: from eggs.gnu.org ([2001:4830:134:3::10]:37838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUa-0007ZJ-BX
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUZ-0008F1-DX
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUZ-0008Eq-7E
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:51 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 18:00:04 +0200
Message-Id: <20170918160012.4317-20-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 19/27] s390x/tcg: implement SIGP SENSE
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
