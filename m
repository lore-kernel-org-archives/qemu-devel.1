Received: from eggs.gnu.org ([2001:4830:134:3::10]:56259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy9-0004SB-Uf
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhy9-00078N-3S
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:49 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhy8-00077o-SI
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:49 -0500
Received: by mail-wr0-x242.google.com with SMTP id l41so10723741wre.11
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:25 +0100
Message-Id: <1513790098-9815-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/46] cpu-exec: fix missed CPU kick during
 interrupt injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

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
Message-Id: <20171129191319.11483-1-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9b544d8..4452cd9 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -525,19 +525,13 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
                                         TranslationBlock **last_tb)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-    int32_t insns_left;
 
     /* Clear the interrupt flag now since we're processing
      * cpu->interrupt_request and cpu->exit_request.
+     * Ensure zeroing happens before reading cpu->exit_request or
+     * cpu->interrupt_request (see also smp_wmb in cpu_exit())
      */
-    insns_left = atomic_read(&cpu->icount_decr.u32);
-    atomic_set(&cpu->icount_decr.u16.high, 0);
-    if (unlikely(insns_left < 0)) {
-        /* Ensure the zeroing of icount_decr comes before the next read
-         * of cpu->exit_request or cpu->interrupt_request.
-         */
-        smp_mb();
-    }
+    atomic_mb_set(&cpu->icount_decr.u16.high, 0);
 
     if (unlikely(atomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
-- 
1.8.3.1
