Received: from eggs.gnu.org ([2001:4830:134:3::10]:55544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK7nW-0007qd-9k
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eK7nS-0003b3-AL
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:13:30 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Nov 2017 20:13:19 +0100
Message-Id: <20171129191319.11483-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] cpu-exec: fix missed CPU kick during
 interrupt injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

The conditional memory barrier not only looks strange but actually is
wrong.

On s390x, I can reproduce interrupts via cpu_interrupt() not leading to
a proper kick out of emulation every now and then. cpu_interrupt() is
especially used for inter CPU communication via SIGP (esp. external
calls and emergency interrupts).

With this patch, I was not able to reproduce. (esp. no stalls or hangs
in the guest).

My setup is s390x MTTCG with 16 VCPUs on 8 CPU host, running make -j16.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 accel/tcg/cpu-exec.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9b544d88c8..dfba5ebd29 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -525,19 +525,15 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                                         TranslationBlock **last_tb)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-    int32_t insns_left;
 
     /* Clear the interrupt flag now since we're processing
      * cpu->interrupt_request and cpu->exit_request.
      */
-    insns_left = atomic_read(&cpu->icount_decr.u32);
     atomic_set(&cpu->icount_decr.u16.high, 0);
-    if (unlikely(insns_left < 0)) {
-        /* Ensure the zeroing of icount_decr comes before the next read
-         * of cpu->exit_request or cpu->interrupt_request.
-         */
-        smp_mb();
-    }
+    /* Ensure zeroing happens before reading cpu->exit_request or
+     * cpu->interrupt_request. (also see cpu_exit())
+     */
+    smp_mb();
 
     if (unlikely(atomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
-- 
2.14.3
