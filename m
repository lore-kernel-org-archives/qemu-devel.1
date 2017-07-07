Received: from eggs.gnu.org ([2001:4830:134:3::10]:55366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRkX-0007e8-G5
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRkU-0007fA-9I
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:48:41 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:40102 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRkT-0007eq-Tk
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:48:38 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri,  7 Jul 2017 13:48:22 +0200
Message-Id: <149942810176.8972.2271168155656858925.stgit@frigg.lan>
In-Reply-To: <149942760788.8972.474351671751194003.stgit@frigg.lan>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 02/27] cpu-exec: Avoid global variables in
 icount-related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 include/exec/gen-icount.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 62d462e494..6c28ef59c3 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -19,7 +19,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
         count =3D tcg_temp_new_i32();
     }
=20
-    tcg_gen_ld_i32(count, cpu_env,
+    tcg_gen_ld_i32(count, tcg_ctx.tcg_env,
                    -ENV_OFFSET + offsetof(CPUState, icount_decr.u32));
=20
     if (tb->cflags & CF_USE_ICOUNT) {
@@ -37,7 +37,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
     tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, exitreq_label);
=20
     if (tb->cflags & CF_USE_ICOUNT) {
-        tcg_gen_st16_i32(count, cpu_env,
+        tcg_gen_st16_i32(count, tcg_ctx.tcg_env,
                          -ENV_OFFSET + offsetof(CPUState, icount_decr.u1=
6.low));
     }
=20
@@ -62,14 +62,16 @@ static void gen_tb_end(TranslationBlock *tb, int num_=
insns)
 static inline void gen_io_start(void)
 {
     TCGv_i32 tmp =3D tcg_const_i32(1);
-    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do=
_io));
+    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env,
+                   -ENV_OFFSET + offsetof(CPUState, can_do_io));
     tcg_temp_free_i32(tmp);
 }
=20
 static inline void gen_io_end(void)
 {
     TCGv_i32 tmp =3D tcg_const_i32(0);
-    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do=
_io));
+    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env,
+                   -ENV_OFFSET + offsetof(CPUState, can_do_io));
     tcg_temp_free_i32(tmp);
 }
=20
