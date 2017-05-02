Received: from eggs.gnu.org ([2001:4830:134:3::10]:59594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOY-00022u-QT
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOY-0001pn-1X
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:34 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOX-0001pM-Sv
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:33 -0400
Received: by mail-qt0-x241.google.com with SMTP id g60so3856604qtd.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:56 -0700
Message-Id: <20170502192300.2124-22-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v6 21/25] target/aarch64: optimize cross-page
 direct jumps in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

Perf numbers in next commit's log.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 24de30d..1e28094 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -373,7 +373,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
         } else if (s->singlestep_enabled) {
             gen_exception_internal(EXCP_DEBUG);
         } else {
-            tcg_gen_exit_tb(0);
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
             s->is_jmp = DISAS_TB_JUMP;
         }
     }
-- 
2.9.3
