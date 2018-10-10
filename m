Received: from eggs.gnu.org ([2001:4830:134:3::10]:58915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gAFnU-0002nu-GB
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gAFnP-0004ba-MU
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gAFnP-0004aP-F0
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 10 Oct 2018 10:48:50 -0400
Message-Id: <20181010144853.13005-2-cota@braap.org>
In-Reply-To: <20181010144853.13005-1-cota@braap.org>
References: <20181010144853.13005-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 1/4] tcg: access cpu->icount_decr.u16.high with
 atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

Consistently access u16.high with atomics to avoid
undefined behaviour in MTTCG.

Note that icount_decr.u16.low is only used in icount mode,
so regular accesses to it are OK.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/tcg-all.c       | 2 +-
 accel/tcg/translate-all.c | 2 +-
 qom/cpu.c                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 56dbb56a16..3d25bdcc17 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -51,7 +51,7 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
     } else {
-        cpu->icount_decr.u16.high = -1;
+        atomic_set(&cpu->icount_decr.u16.high, -1);
         if (use_icount &&
             !cpu->can_do_io
             && (mask & ~old_mask) != 0) {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ad5c758246..356dcd0948 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2341,7 +2341,7 @@ void cpu_interrupt(CPUState *cpu, int mask)
 {
     g_assert(qemu_mutex_iothread_locked());
     cpu->interrupt_request |= mask;
-    cpu->icount_decr.u16.high = -1;
+    atomic_set(&cpu->icount_decr.u16.high, -1);
 }
 
 /*
diff --git a/qom/cpu.c b/qom/cpu.c
index 92599f3541..20ad54d43f 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -266,7 +266,7 @@ static void cpu_common_reset(CPUState *cpu)
     cpu->mem_io_pc = 0;
     cpu->mem_io_vaddr = 0;
     cpu->icount_extra = 0;
-    cpu->icount_decr.u32 = 0;
+    atomic_set(&cpu->icount_decr.u32, 0);
     cpu->can_do_io = 1;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
-- 
2.17.1
