Received: from eggs.gnu.org ([2001:4830:134:3::10]:38374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1gDTqs-0004SY-3p
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1gDTql-00086j-VA
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:26:01 -0400
Received: from mail.sysgo.com ([176.9.12.79]:41338)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1gDTql-00082Y-ML
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:25:55 -0400
From: Roman Kapl <rka@sysgo.com>
Date: Fri, 19 Oct 2018 14:24:49 +0200
Message-Id: <20181019122449.26387-1-rka@sysgo.com>
Subject: [Qemu-devel] [PATCH] Clear RF on SYSCALL instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Rudolf Marek <rudolf.marek@sysgo.com>, Roman Kapl <rka@sysgo.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

From: Rudolf Marek <rudolf.marek@sysgo.com>

Fix the SYSCALL instruction in 64-bit (long mode). The RF flag
should be cleared in R11 as well as in the RFLAGS. Intel
and AMD CPUs behave same. AMD has this documented in the
APM vol 3.

Signed-off-by: Roman Kapl <rka@sysgo.com>
Signed-off-by: Rudolf Marek <rudolf.marek@sysgo.com>
---
 target/i386/seg_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 33714bc6e1..63e265cb38 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -991,11 +991,11 @@ void helper_syscall(CPUX86State *env, int next_eip_addend)
         int code64;
 
         env->regs[R_ECX] = env->eip + next_eip_addend;
-        env->regs[11] = cpu_compute_eflags(env);
+        env->regs[11] = cpu_compute_eflags(env) & ~RF_MASK;
 
         code64 = env->hflags & HF_CS64_MASK;
 
-        env->eflags &= ~env->fmask;
+        env->eflags &= ~(env->fmask | RF_MASK);
         cpu_load_eflags(env, env->eflags, 0);
         cpu_x86_load_seg_cache(env, R_CS, selector & 0xfffc,
                            0, 0xffffffff,
-- 
2.11.0
