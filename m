Received: from eggs.gnu.org ([2001:4830:134:3::10]:33977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIp-0008Qs-Up
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIo-0000pQ-Tw
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 25 Apr 2017 03:53:51 -0400
Message-Id: <1493106839-10438-6-git-send-email-cota@braap.org>
In-Reply-To: <1493106839-10438-1-git-send-email-cota@braap.org>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 05/13] tcg-runtime: add lookup_tb_ptr helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg-runtime.c     | 7 +++++++
 tcg/tcg-runtime.h | 2 ++
 tcg/tcg.h         | 1 +
 3 files changed, 10 insertions(+)

diff --git a/tcg-runtime.c b/tcg-runtime.c
index 4c60c96..f291184 100644
--- a/tcg-runtime.c
+++ b/tcg-runtime.c
@@ -141,6 +141,13 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
     return ctpop64(arg);
 }
 
+void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
+{
+    TranslationBlock *tb = tb_from_jmp_cache(env, addr);
+
+    return tb ? tb->tc_ptr : tcg_ctx.code_gen_epilogue;
+}
+
 void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(ENV_GET_CPU(env), GETPC());
diff --git a/tcg/tcg-runtime.h b/tcg/tcg-runtime.h
index 114ea6f..c41d38a 100644
--- a/tcg/tcg-runtime.h
+++ b/tcg/tcg-runtime.h
@@ -24,6 +24,8 @@ DEF_HELPER_FLAGS_1(clrsb_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(ctpop_i32, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
+DEF_HELPER_FLAGS_2(lookup_tb_ptr, TCG_CALL_NO_WG_SE, ptr, env, tl)
+
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
 #ifdef CONFIG_SOFTMMU
diff --git a/tcg/tcg.h b/tcg/tcg.h
index b26f0ef..625e2aa 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -647,6 +647,7 @@ struct TCGContext {
         GHashTable *helpers;
 
         void *code_gen_prologue;
+        void *code_gen_epilogue;
         void *code_gen_buffer;
         size_t code_gen_buffer_size;
 
-- 
2.7.4
