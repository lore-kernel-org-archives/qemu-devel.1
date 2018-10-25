Received: from eggs.gnu.org ([2001:4830:134:3::10]:59515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5G-0002yu-3r
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgvS-0008WR-Hv
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:55 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:46:23 -0400
Message-Id: <20181025144644.15464-50-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 50/71] s390x: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/intc/s390_flic.c | 2 +-
 target/s390x/cpu.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index bfb5cf1d07..d944824e67 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -189,7 +189,7 @@ static void qemu_s390_flic_notify(uint32_t type)
     CPU_FOREACH(cs) {
         S390CPU *cpu = S390_CPU(cs);
 
-        cs->interrupt_request |= CPU_INTERRUPT_HARD;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_HARD);
 
         /* ignore CPUs that are not sleeping */
         if (s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING &&
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 956d4e1d18..1f91df57bc 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -65,7 +65,7 @@ static bool s390_cpu_has_work(CPUState *cs)
         return false;
     }
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+    if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
         return false;
     }
 
-- 
2.17.1
