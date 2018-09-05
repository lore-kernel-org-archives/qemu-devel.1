Received: from eggs.gnu.org ([2001:4830:134:3::10]:57692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxg0Q-0001DG-1D
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxg0L-00041W-Kx
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=7790e8633=Alistair.Francis@wdc.com>)
	id 1fxg0L-0003le-4q
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:29 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed,  5 Sep 2018 15:09:30 -0700
Message-Id: <20180905220932.6152-8-alistair.francis@wdc.com>
In-Reply-To: <20180905220932.6152-1-alistair.francis@wdc.com>
References: <20180905220932.6152-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL v2 07/10] target/riscv: call gen_goto_tb on
 DISAS_TOO_MANY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Alistair Francis <alistair.francis@wdc.com>

From: "Emilio G. Cota" <cota@braap.org>

Performance impact of this and the previous commits, measured with
the very-easy-to-cross-compile rv8-bench:
  https://github.com/rv8-io/rv8-bench

Host: Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz

- Key:
  before: master
  after1,2,3: the 3 commits in this series (i.e. 3 is this commit)

- User-mode:

 bench      before  after1  after2  after3  final speedup
---------------------------------------------------------
 aes        1.12s   1.12s   1.10s   1.00s   1.12
 bigint     0.78s   0.78s   0.78s   0.78s   1
 dhrystone  0.96s   0.97s   0.49s   0.49s   1.9591837
 miniz      1.94s   1.94s   1.88s   1.86s   1.0430108
 norx       0.51s   0.51s   0.49s   0.48s   1.0625
 primes     0.85s   0.85s   0.84s   0.84s   1.0119048
 qsort      4.87s   4.88s   1.86s   1.86s   2.6182796
 sha512     0.76s   0.77s   0.64s   0.64s   1.1875

(after1 only applies to softmmu, so no surprises here)

- Full-system (fedora):

 bench      before  after1  after2  after3  final speedup
---------------------------------------------------------
 aes        2.68s   2.54s   2.60s   2.34s   1.1452991
 bigint     1.61s   1.56s   1.55s   1.64s   0.98170732
 dhrystone  1.78s   1.67s   1.25s   1.24s   1.4354839
 miniz      3.53s   3.35s   3.28s   3.35s   1.0537313
 norx       1.13s   1.09s   1.07s   1.06s   1.0660377
 primes     15.37s  15.41s  15.20s  15.37s  1
 qsort      7.20s   6.71s   3.85s   3.96s   1.8181818
 sha512     1.07s   1.04s   0.90s   0.90s   1.1888889

SoftMMU slows things down, so the numbers are less sensitive.
Cross-page jumps improve things a little bit, though.

Note that I'm not showing here averages, just results from a
single run, so with primes there isn't much to worry about.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 66a80ca772..18d7b6d147 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1868,12 +1868,7 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 
     switch (ctx->base.is_jmp) {
     case DISAS_TOO_MANY:
-        tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-        if (ctx->base.singlestep_enabled) {
-            gen_exception_debug();
-        } else {
-            tcg_gen_exit_tb(NULL, 0);
-        }
+        gen_goto_tb(ctx, 0, ctx->base.pc_next);
         break;
     case DISAS_NORETURN:
         break;
-- 
2.17.1
