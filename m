Received: from eggs.gnu.org ([2001:4830:134:3::10]:57582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCyN-000627-HO
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCyI-0007mc-I2
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:25:35 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Jun 2017 16:25:14 +0300
Message-Id: <149865631443.17063.7093785957776924619.stgit@frigg.lan>
In-Reply-To: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 17/29] target/arm: [tcg] Port to
 init_globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/arm/translate.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 23a07fc2c6..fc28cd45f7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11843,6 +11843,18 @@ static void arm_trblock_init_disas_context(Disas=
ContextBase *dcbase,
     dc->ss_same_el =3D false; /* Can't be true since EL_d must be AArch6=
4 */
 }
=20
+static void arm_trblock_init_globals(DisasContextBase *dcbase, CPUState =
*cpu)
+{
+    cpu_F0s =3D tcg_temp_new_i32();
+    cpu_F1s =3D tcg_temp_new_i32();
+    cpu_F0d =3D tcg_temp_new_i64();
+    cpu_F1d =3D tcg_temp_new_i64();
+    cpu_V0 =3D cpu_F0d;
+    cpu_V1 =3D cpu_F1d;
+    /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
+    cpu_M0 =3D tcg_temp_new_i64();
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
@@ -11871,14 +11883,7 @@ void gen_intermediate_code(CPUState *cpu, Transl=
ationBlock *tb)
     arm_trblock_init_disas_context(&dc->base, cpu);
=20
=20
-    cpu_F0s =3D tcg_temp_new_i32();
-    cpu_F1s =3D tcg_temp_new_i32();
-    cpu_F0d =3D tcg_temp_new_i64();
-    cpu_F1d =3D tcg_temp_new_i64();
-    cpu_V0 =3D cpu_F0d;
-    cpu_V1 =3D cpu_F1d;
-    /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
-    cpu_M0 =3D tcg_temp_new_i64();
+    arm_trblock_init_globals(&dc->base, cpu);
     next_page_start =3D (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_=
PAGE_SIZE;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
