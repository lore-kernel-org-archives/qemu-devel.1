Received: from eggs.gnu.org ([2001:4830:134:3::10]:46113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmY-0001Ac-SR
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmU-0008GK-FK
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmU-0008FM-6v
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:03:47 -0400
Message-Id: <1500235468-15341-5-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/45] tcg: fix corruption of code_time
 profiling counter upon tb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Whenever there is an overflow in code_gen_buffer (e.g. we run out
of space in it and have to flush it), the code_time profiling counter
ends up with an invalid value (that is, code_time -= profile_getclock(),
without later on getting += profile_getclock() due to the goto).

Fix it by using the ti variable, so that we only update code_time
when there is no overflow. Note that in case there is an overflow
we fail to account for the elapsed coding time, but this is quite rare
so we can probably live with it.

"info jit" before/after, roughly at the same time during debian-arm bootup:

- before:
Statistics:
TB flush count      1
TB invalidate count 4665
TLB flush count     998
JIT cycles          -615191529184601 (-256329.804 s at 2.4 GHz)
translated TBs      302310 (aborted=0 0.0%)
avg ops/TB          48.4 max=438
deleted ops/TB      8.54
avg temps/TB        32.31 max=38
avg host code/TB    361.5
avg search data/TB  24.5
cycles/op           -42014693.0
cycles/in byte      -121444900.2
cycles/out byte     -5629031.1
cycles/search byte     -83114481.0
  gen_interm time   -0.0%
  gen_code time     100.0%
optim./code time    -0.0%
liveness/code time  -0.0%
cpu_restore count   6236
  avg cycles        110.4

- after:
Statistics:
TB flush count      1
TB invalidate count 4665
TLB flush count     1010
JIT cycles          1996899624 (0.832 s at 2.4 GHz)
translated TBs      297961 (aborted=0 0.0%)
avg ops/TB          48.5 max=438
deleted ops/TB      8.56
avg temps/TB        32.31 max=38
avg host code/TB    361.8
avg search data/TB  24.5
cycles/op           138.2
cycles/in byte      398.4
cycles/out byte     18.5
cycles/search byte     273.1
  gen_interm time   14.0%
  gen_code time     86.0%
optim./code time    19.4%
liveness/code time  10.3%
cpu_restore count   6372
  avg cycles        111.0

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 3ee69e5..63f8538 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1300,7 +1300,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 #ifdef CONFIG_PROFILER
     tcg_ctx.tb_count++;
     tcg_ctx.interm_time += profile_getclock() - ti;
-    tcg_ctx.code_time -= profile_getclock();
+    ti = profile_getclock();
 #endif
 
     /* ??? Overflow could be handled better here.  In particular, we
@@ -1318,7 +1318,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
 
 #ifdef CONFIG_PROFILER
-    tcg_ctx.code_time += profile_getclock();
+    tcg_ctx.code_time += profile_getclock() - ti;
     tcg_ctx.code_in_len += tb->size;
     tcg_ctx.code_out_len += gen_code_size;
     tcg_ctx.search_out_len += search_size;
-- 
2.7.4
