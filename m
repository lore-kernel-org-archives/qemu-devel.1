Received: from eggs.gnu.org ([2001:4830:134:3::10]:56473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJD6-00089s-7n
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJD5-0002II-BL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:56 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:32 -0500
Message-Id: <20181213050453.9677-53-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 52/73] s390x: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
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
index 4d70ba785c..d1594c90d9 100644
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
