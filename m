Received: from eggs.gnu.org ([2001:4830:134:3::10]:58036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsM-0006Ds-58
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMsL-0007Ek-8d
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:57 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMsJ-00072A-2Z
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:55 -0400
Received: by mail-lj1-x241.google.com with SMTP id y17-v6so4801469ljy.8
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:47 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:49 -0700
Message-Id: <20180905014352.970-13-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 12/15] target/xtensa: always end TB on CCOUNT
 access/CCOMPARE write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Currently we only end TB in icount mode, because access to CCOUNT or
write to CCOMPARE are IO operations. Simplify the behaviour a bit and
end TB unconditionally.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 0af3f1b16792..028b4d4c8652 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -505,9 +505,8 @@ static bool gen_rsr_ccount(DisasContext *dc, TCGv_i32 d, uint32_t sr)
     tcg_gen_mov_i32(d, cpu_SR[sr]);
     if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
-        return true;
     }
-    return false;
+    return true;
 }
 
 static bool gen_rsr_ptevaddr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
@@ -735,10 +734,9 @@ static bool gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     gen_helper_wsr_ccount(cpu_env, v);
     if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
-        gen_jumpi_check_loop_end(dc, 0);
-        return true;
     }
-    return false;
+    gen_jumpi_check_loop_end(dc, 0);
+    return true;
 }
 
 static bool gen_wsr_icount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
@@ -773,10 +771,9 @@ static bool gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
     tcg_temp_free(tmp);
     if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
-        gen_jumpi_check_loop_end(dc, 0);
-        return true;
     }
-    return false;
+    gen_jumpi_check_loop_end(dc, 0);
+    return true;
 }
 #else
 static void gen_check_interrupts(DisasContext *dc)
-- 
2.11.0
