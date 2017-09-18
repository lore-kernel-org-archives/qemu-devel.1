Received: from eggs.gnu.org ([2001:4830:134:3::10]:37908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUh-0007gE-Ht
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUe-0008H3-Q3
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUe-0008Gn-KX
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:01:56 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 18:00:06 +0200
Message-Id: <20170918160012.4317-22-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 21/27] s390x/tcg: implement SIGP EMERGENCY
 SIGNAL
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
