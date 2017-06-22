Received: from eggs.gnu.org ([2001:4830:134:3::10]:36457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dO5zP-0000CA-2o
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dO5zK-0004kr-4N
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:33:55 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:34588 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dO5zJ-0004kj-Od
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:33:50 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 22 Jun 2017 20:33:41 +0300
Message-Id: <149815282083.32092.16307208186159398942.stgit@frigg.lan>
In-Reply-To: <149815276329.32092.14209722991890170116.stgit@frigg.lan>
References: <149815276329.32092.14209722991890170116.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 08/26] target: [tcg,
 i386] Refactor init_globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/i386/translate.c |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 84ff49030b..f0d12a3d13 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8452,6 +8452,22 @@ static void i386_trblock_init_disas_context(DisasC=
ontextBase *db, CPUState *cpu)
 #endif
 }
=20
+static void i386_trblock_init_globals(DisasContextBase *db, CPUState *cp=
u)
+{
+    cpu_T0 =3D tcg_temp_new();
+    cpu_T1 =3D tcg_temp_new();
+    cpu_A0 =3D tcg_temp_new();
+
+    cpu_tmp0 =3D tcg_temp_new();
+    cpu_tmp1_i64 =3D tcg_temp_new_i64();
+    cpu_tmp2_i32 =3D tcg_temp_new_i32();
+    cpu_tmp3_i32 =3D tcg_temp_new_i32();
+    cpu_tmp4 =3D tcg_temp_new();
+    cpu_ptr0 =3D tcg_temp_new_ptr();
+    cpu_ptr1 =3D tcg_temp_new_ptr();
+    cpu_cc_srcT =3D tcg_temp_local_new();
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
@@ -8469,18 +8485,7 @@ void gen_intermediate_code(CPUState *cpu, Translat=
ionBlock *tb)
     db->pc_next =3D db->pc_first;
     i386_trblock_init_disas_context(db, cpu);
=20
-    cpu_T0 =3D tcg_temp_new();
-    cpu_T1 =3D tcg_temp_new();
-    cpu_A0 =3D tcg_temp_new();
-
-    cpu_tmp0 =3D tcg_temp_new();
-    cpu_tmp1_i64 =3D tcg_temp_new_i64();
-    cpu_tmp2_i32 =3D tcg_temp_new_i32();
-    cpu_tmp3_i32 =3D tcg_temp_new_i32();
-    cpu_tmp4 =3D tcg_temp_new();
-    cpu_ptr0 =3D tcg_temp_new_ptr();
-    cpu_ptr1 =3D tcg_temp_new_ptr();
-    cpu_cc_srcT =3D tcg_temp_local_new();
+    i386_trblock_init_globals(db, cpu);
=20
     num_insns =3D 0;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
