Received: from eggs.gnu.org ([2001:4830:134:3::10]:45755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCLO-0008OK-Kv
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCLL-0007Sj-JZ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:45:18 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:57159)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQCLL-0007SL-6b
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:45:15 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Jun 2017 15:44:54 +0300
Message-Id: <149865389443.17063.5223786571159875501.stgit@frigg.lan>
In-Reply-To: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 07/29] target/i386: [tcg] Refactor
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
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Incrementally paves the way towards using the generic instruction transla=
tion
loop.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 target/i386/translate.c |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 04453ce48a..d015ea73fa 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8435,6 +8435,22 @@ static void i386_trblock_init_disas_context(DisasC=
ontextBase *dcbase, CPUState *
 #endif
 }
=20
+static void i386_trblock_init_globals(DisasContextBase *dcbase, CPUState=
 *cpu)
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
@@ -8451,18 +8467,7 @@ void gen_intermediate_code(CPUState *cpu, Translat=
ionBlock *tb)
     dc->base.pc_next =3D dc->base.pc_first;
     i386_trblock_init_disas_context(&dc->base, cpu);
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
+    i386_trblock_init_globals(&dc->base, cpu);
=20
     num_insns =3D 0;
     max_insns =3D tb->cflags & CF_COUNT_MASK;
