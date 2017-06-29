Received: from eggs.gnu.org ([2001:4830:134:3::10]:55589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQYOH-0000VV-LC
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQYOE-00050y-Bh
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:17:45 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:34088 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQYOD-00050u-VS
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:17:42 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 29 Jun 2017 15:17:32 +0300
Message-Id: <149873865231.9180.13927490238451232263.stgit@frigg.lan>
In-Reply-To: <149873841036.9180.16600465902334229930.stgit@frigg.lan>
References: <149873841036.9180.16600465902334229930.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 1/7] exec: [tcg] Refactor flush of per-CPU
 virtual TB cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

The function is reused in later patches.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 accel/tcg/cputlb.c        |    2 +-
 accel/tcg/translate-all.c |   15 ++++++++++-----
 include/exec/exec-all.h   |    6 ++++++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 743776ae19..6a2b762325 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -118,7 +118,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
=20
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
-    memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
+    tb_flush_jmp_cache_all(cpu);
=20
     env->vtlb_index =3D 0;
     env->tlb_flush_addr =3D -1;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f6ad46b613..03820e3aeb 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -928,11 +928,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_da=
ta tb_flush_count)
     }
=20
     CPU_FOREACH(cpu) {
-        int i;
-
-        for (i =3D 0; i < TB_JMP_CACHE_SIZE; ++i) {
-            atomic_set(&cpu->tb_jmp_cache[i], NULL);
-        }
+        tb_flush_jmp_cache_all(cpu);
     }
=20
     tcg_ctx.tb_ctx.nb_tbs =3D 0;
@@ -949,6 +945,15 @@ done:
     tb_unlock();
 }
=20
+void tb_flush_jmp_cache_all(CPUState *cpu)
+{
+    int i;
+
+    for (i =3D 0; i < TB_JMP_CACHE_SIZE; ++i) {
+        atomic_set(&cpu->tb_jmp_cache[i], NULL);
+    }
+}
+
 void tb_flush(CPUState *cpu)
 {
     if (tcg_enabled()) {
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 724ec73dce..b0281b000f 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -366,6 +366,12 @@ struct TranslationBlock {
 };
=20
 void tb_free(TranslationBlock *tb);
+/**
+ * tb_flush_jmp_cache_all:
+ *
+ * Flush the virtual translation block cache.
+ */
+void tb_flush_jmp_cache_all(CPUState *env);
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
