Received: from eggs.gnu.org ([2001:4830:134:3::10]:35980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4LN-0000t1-Ip
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP4LK-0000Y3-Hz
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 06:00:37 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 13:00:24 +0300
Message-Id: <149838482405.6497.13492154521657281100.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 19/26] target: [tcg,
 arm] Port to init_globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/arm/translate.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c469bc70ac..cc11dacd56 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11879,6 +11879,18 @@ static void arm_trblock_init_disas_context(Disas=
ContextBase *db, CPUState *cpu)
     dc->ss_same_el =3D false; /* Can't be true since EL_d must be AArch6=
4 */
 }
=20
+static void arm_trblock_init_globals(DisasContextBase *db, CPUState *cpu=
)
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
@@ -11909,14 +11921,7 @@ void gen_intermediate_code(CPUState *cpu, Transl=
ationBlock *tb)
     arm_trblock_init_disas_context(db, cpu);
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
+    arm_trblock_init_globals(db, cpu);
     next_page_start =3D (db->pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_=
SIZE;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
     if (max_insns =3D=3D 0) {
