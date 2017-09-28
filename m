Received: from eggs.gnu.org ([2001:4830:134:3::10]:53346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYm-0003fs-9e
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYl-00035T-KF
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfYl-00034z-EQ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:27 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:44 +0200
Message-Id: <20170928203708.9376-7-david@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/30] s390x/tcg: STOPPED cpus can never
 wake up
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

Interrupts can't wake such CPUs up. SIGP from other CPUs has to be used
to toggle the state.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 9c2a1e6ac8..a0b139056f 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -57,6 +57,12 @@ static bool s390_cpu_has_work(CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
 
+    /* STOPPED cpus can never wake up */
+    if (s390_cpu_get_state(cpu) != CPU_STATE_LOAD &&
+        s390_cpu_get_state(cpu) != CPU_STATE_OPERATING) {
+        return false;
+    }
+
     if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
         return false;
     }
-- 
2.13.5
