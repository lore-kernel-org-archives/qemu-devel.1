Received: from eggs.gnu.org ([2001:4830:134:3::10]:42005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqv-0000Xt-LO
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqp-0002ss-QY
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:57 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:35581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqp-0002rK-Kg
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:51 -0400
Received: by mail-pg0-x22d.google.com with SMTP id 188so12739150pgb.2
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:06:07 -0700
Message-Id: <20170906160612.22769-28-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/32] target/arm: [tcg,a64] Port to disas_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Richard Henderson <rth@twiddle.net>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Incrementally paves the way towards using the generic instruction translation
loop.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Message-Id: <150002606914.22386.15524101311003685068.stgit@frigg.lan>
[rth: Move tb->size computation and use that result.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 723e86c976..1973a36462 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11393,6 +11393,16 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
+static void aarch64_tr_disas_log(const DisasContextBase *dcbase,
+                                      CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
+    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size,
+                     4 | (bswap_code(dc->sctlr_b) ? 2 : 0));
+}
+
 void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
                                TranslationBlock *tb)
 {
@@ -11468,18 +11478,17 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
 
     gen_tb_end(tb, dc->base.num_insns);
 
+    dc->base.tb->size = dc->pc - dc->base.pc_first;
+    dc->base.tb->icount = dc->base.num_insns;
+
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
         qemu_log_in_addr_range(dc->base.pc_first)) {
         qemu_log_lock();
         qemu_log("----------------\n");
-        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
-        log_target_disas(cs, dc->base.pc_first, dc->pc - dc->base.pc_first,
-                         4 | (bswap_code(dc->sctlr_b) ? 2 : 0));
+        aarch64_tr_disas_log(&dc->base, cs);
         qemu_log("\n");
         qemu_log_unlock();
     }
 #endif
-    dc->base.tb->size = dc->pc - dc->base.pc_first;
-    dc->base.tb->icount = dc->base.num_insns;
 }
-- 
2.13.5
