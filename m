Received: from eggs.gnu.org ([2001:4830:134:3::10]:45133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLwQI-0005Mm-IV
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLwQH-000790-F6
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:56:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 16 Jun 2017 14:56:37 -0400
Message-Id: <1497639397-19453-3-git-send-email-cota@braap.org>
In-Reply-To: <1497639397-19453-1-git-send-email-cota@braap.org>
References: <1497639397-19453-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 2/2] gen-icount: use tcg_ctx.tcg_env instead
 of cpu_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>

We are relying on cpu_env being defined as a global, yet most
targets (i.e. all but arm/a64) have it defined as a local variable.
Luckily all of them use the same "cpu_env" name, but really
compilation shouldn't break if the name of that local variable
changed.

Fix it by using tcg_ctx.tcg_env, which all targets set in their
translate_init function. This change also helps paving the way
for the upcoming "translation loop common to all targets" work.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/gen-icount.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 547c979..9b3cb14 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -19,7 +19,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
         count = tcg_temp_new_i32();
     }
 
-    tcg_gen_ld_i32(count, cpu_env,
+    tcg_gen_ld_i32(count, tcg_ctx.tcg_env,
                    -ENV_OFFSET + offsetof(CPUState, icount_decr.u32));
 
     if (tb->cflags & CF_USE_ICOUNT) {
@@ -37,7 +37,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
     tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, exitreq_label);
 
     if (tb->cflags & CF_USE_ICOUNT) {
-        tcg_gen_st16_i32(count, cpu_env,
+        tcg_gen_st16_i32(count, tcg_ctx.tcg_env,
                          -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.low));
     }
 
@@ -62,14 +62,16 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
 static inline void gen_io_start(void)
 {
     TCGv_i32 tmp = tcg_const_i32(1);
-    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
+    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env,
+                   -ENV_OFFSET + offsetof(CPUState, can_do_io));
     tcg_temp_free_i32(tmp);
 }
 
 static inline void gen_io_end(void)
 {
     TCGv_i32 tmp = tcg_const_i32(0);
-    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
+    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env,
+                   -ENV_OFFSET + offsetof(CPUState, can_do_io));
     tcg_temp_free_i32(tmp);
 }
 
-- 
2.7.4
