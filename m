Received: from eggs.gnu.org ([2001:4830:134:3::10]:48421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0S-0004H0-4n
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csp0O-00035e-0Z
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:44 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csp0N-00035S-Oo
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:09:39 -0400
Received: by mail-wr0-x22b.google.com with SMTP id u1so99368467wra.2
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:09:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Mar 2017 12:09:31 +0100
Message-Id: <20170328110936.24806-2-alex.bennee@linaro.org>
In-Reply-To: <20170328110936.24806-1-alex.bennee@linaro.org>
References: <20170328110936.24806-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/6] user-exec: handle synchronous signals from
 QEMU gracefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

When "tcg: enable thread-per-vCPU" (commit 3725794) was merged the
lifetime of current_cpu was changed. Previously a broken linux-user
call might abort() which can eventually escalate into a SIGSEGV which
would then crash qemu as it attempted to deref a NULL current_cpu.
After commit 3725794 it would attempt to fixup state and re-start the
run-loop and much hilarity (i.e. a looping lockup) would ensue from
jumping into a stale jmp_env.

As we can actually tell if we are in the run-loop from looking at the
cpu->running flag we should catch this badness first and abort()
cleanly rather than try to soldier on. There is a theoretical race
between the flag being set and sigsetjmp refreshing the jump buffer
but we can try really hard to not introduce crashes into that code.

[LV: setgroups03 fails on powerpc LTP]
Reported-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 user-exec.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/user-exec.c b/user-exec.c
index 6db075884d..a8f95fa1e1 100644
--- a/user-exec.c
+++ b/user-exec.c
@@ -57,10 +57,23 @@ static void cpu_exit_tb_from_sighandler(CPUState *cpu, sigset_t *old_set)
 static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
                                     int is_write, sigset_t *old_set)
 {
-    CPUState *cpu;
+    CPUState *cpu = current_cpu;
     CPUClass *cc;
     int ret;
 
+    /* For synchronous signals we expect to be coming from the vCPU
+     * thread (so current_cpu should be valid) and either from running
+     * code or during translation which can fault as we cross pages.
+     *
+     * If neither is true then something has gone wrong and we should
+     * abort rather than try and restart the vCPU execution.
+     */
+    if (!cpu || !cpu->running) {
+        printf("qemu:%s received signal outside vCPU context @ pc=0x%"
+               PRIxPTR "\n",  __func__, pc);
+        abort();
+    }
+
 #if defined(DEBUG_SIGNAL)
     printf("qemu: SIGSEGV pc=0x%08lx address=%08lx w=%d oldset=0x%08lx\n",
            pc, address, is_write, *(unsigned long *)old_set);
@@ -83,7 +96,7 @@ static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
              * currently executing TB was modified and must be exited
              * immediately.
              */
-            cpu_exit_tb_from_sighandler(current_cpu, old_set);
+            cpu_exit_tb_from_sighandler(cpu, old_set);
             g_assert_not_reached();
         default:
             g_assert_not_reached();
@@ -94,7 +107,6 @@ static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
        are still valid segv ones */
     address = h2g_nocheck(address);
 
-    cpu = current_cpu;
     cc = CPU_GET_CLASS(cpu);
     /* see if it is an MMU fault */
     g_assert(cc->handle_mmu_fault);
-- 
2.11.0
