Received: from eggs.gnu.org ([2001:4830:134:3::10]:59698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTP-00046V-6H
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTL-00010T-1V
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:34559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCTTK-0000fG-LU
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:34 -0400
Received: by mail-pf1-x429.google.com with SMTP id f78-v6so6060615pfe.1
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:49:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 10:48:52 -0700
Message-Id: <20181016174911.9052-3-richard.henderson@linaro.org>
In-Reply-To: <20181016174911.9052-1-richard.henderson@linaro.org>
References: <20181016174911.9052-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 02/21] tcg: access cpu->icount_decr.u16.high
 with atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Consistently access u16.high with atomics to avoid
undefined behaviour in MTTCG.

Note that icount_decr.u16.low is only used in icount mode,
so regular accesses to it are OK.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20181010144853.13005-2-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.2
