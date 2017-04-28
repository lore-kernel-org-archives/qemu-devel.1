Received: from eggs.gnu.org ([2001:4830:134:3::10]:39823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d4BOU-0001kb-Pd
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d4BOS-0005nz-5n
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:17:30 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35221)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1d4BOR-0005nl-VF
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:17:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 28 Apr 2017 15:17:24 -0400
Message-Id: <1493407045-24172-2-git-send-email-cota@braap.org>
In-Reply-To: <1493407045-24172-1-git-send-email-cota@braap.org>
References: <20170427120006.20564-1-rth@twiddle.net>
	<1493407045-24172-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 + 1/2] target/aarch64: optimize cross-page
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
Cc: Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org

Perf numbers in next commit's log.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/translate-a64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 24de30d..5b691fc 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -373,8 +373,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
         } else if (s->singlestep_enabled) {
             gen_exception_internal(EXCP_DEBUG);
         } else {
-            tcg_gen_exit_tb(0);
-            s->is_jmp = DISAS_TB_JUMP;
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
         }
     }
 }
-- 
2.7.4
