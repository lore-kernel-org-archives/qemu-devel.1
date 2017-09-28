Received: from eggs.gnu.org ([2001:4830:134:3::10]:53601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfa7-0004rA-EC
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfa6-0003bi-LO
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfa6-0003bU-Ff
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:38:50 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:37:00 +0200
Message-Id: <20170928203708.9376-23-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 22/30] s390x/tcg: implement SIGP EMERGENCY
 SIGNAL
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
 target/s390x/sigp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 080bce3fba..d492885787 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -76,6 +76,18 @@ static void sigp_external_call(S390CPU *src_cpu, S390CPU *dst_cpu, SigpInfo *si)
     }
 }
 
+static void sigp_emergency(S390CPU *src_cpu, S390CPU *dst_cpu, SigpInfo *si)
+{
+    if (!tcg_enabled()) {
+        /* handled in KVM */
+        set_sigp_status(si, SIGP_STAT_INVALID_ORDER);
+        return;
+    }
+
+    cpu_inject_emergency_signal(dst_cpu, src_cpu->env.core_id);
+    si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+}
+
 static void sigp_start(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
@@ -327,6 +339,9 @@ static int handle_sigp_single_dst(S390CPU *cpu, S390CPU *dst_cpu, uint8_t order,
     case SIGP_EXTERNAL_CALL:
         sigp_external_call(cpu, dst_cpu, &si);
         break;
+    case SIGP_EMERGENCY:
+        sigp_emergency(cpu, dst_cpu, &si);
+        break;
     case SIGP_START:
         run_on_cpu(CPU(dst_cpu), sigp_start, RUN_ON_CPU_HOST_PTR(&si));
         break;
-- 
2.13.5
