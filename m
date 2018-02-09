Received: from eggs.gnu.org ([2001:4830:134:3::10]:43502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wO-00023S-KV
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wN-00065b-JV
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:56 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:07 +0100
Message-Id: <20180209092524.31348-13-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 12/29] s390x/flic: optimize CPU wakeup for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Kicking all CPUs on every floating interrupt is far from efficient.
Let's optimize it at least a little bit.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180129125623.21729-12-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/intc/s390_flic.c     | 31 +++++++++++++++++++++++++++++--
 target/s390x/cpu.h      |  4 ++++
 target/s390x/internal.h |  5 -----
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index cb216de9ba..5febde2d65 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -161,10 +161,37 @@ static void qemu_s390_flic_notify(uint32_t type)
 
     /*
      * We have to make all CPUs see CPU_INTERRUPT_HARD, so they might
-     * consider it. TODO: don't kick/wakeup all VCPUs but try to be
-     * smarter (using the interrupt type).
+     * consider it. We will kick all running CPUs and only relevant
+     * sleeping ones.
      */
     CPU_FOREACH(cs) {
+        S390CPU *cpu = S390_CPU(cs);
+
+        cs->interrupt_request |= CPU_INTERRUPT_HARD;
+
+        /* ignore CPUs that are not sleeping */
+        if (s390_cpu_get_state(cpu) != CPU_STATE_OPERATING &&
+            s390_cpu_get_state(cpu) != CPU_STATE_LOAD) {
+            continue;
+        }
+
+        /* we always kick running CPUs for now, this is tricky */
+        if (cs->halted) {
+            /* don't check for subclasses, CPUs double check when waking up */
+            if (type & FLIC_PENDING_SERVICE) {
+                if (!(cpu->env.psw.mask & PSW_MASK_EXT)) {
+                    continue;
+                }
+            } else if (type & FLIC_PENDING_IO) {
+                if (!(cpu->env.psw.mask & PSW_MASK_IO)) {
+                    continue;
+                }
+            } else if (type & FLIC_PENDING_MCHK_CR) {
+                if (!(cpu->env.psw.mask & PSW_MASK_MCHECK)) {
+                    continue;
+                }
+            }
+        }
         cpu_interrupt(cs, CPU_INTERRUPT_HARD);
     }
 }
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index ba6cf0cda5..76c31d970f 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -692,6 +692,10 @@ static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return 0;
 }
 #endif /* CONFIG_USER_ONLY */
+static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
+{
+    return cpu->env.cpu_state;
+}
 
 
 /* cpu_models.c */
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index fea165ffe4..d911e84958 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -278,11 +278,6 @@ static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data arg)
     cpu_reset(cs);
 }
 
-static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
-{
-    return cpu->env.cpu_state;
-}
-
 
 /* arch_dump.c */
 int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
-- 
2.13.6
