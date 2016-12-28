Received: from eggs.gnu.org ([2001:4830:134:3::10]:50729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMEtT-0001UK-G5
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 09:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMEtR-0003Sn-P3
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 09:07:51 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:35128)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMEtR-0003Sb-Cv
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 09:07:49 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Dec 2016 15:07:47 +0100
Message-Id: <148293406779.28901.5431438339167080665.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148293406236.28901.9490775858242540392.stgit@fimbulvetr.bsc.es>
References: <148293406236.28901.9490775858242540392.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 1/7] exec: [tcg] Refactor flush of per-CPU
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
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

The function is reused in later patches.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 cputlb.c                |    2 +-
 include/exec/exec-all.h |    6 ++++++
 translate-all.c         |   14 +++++++++-----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/cputlb.c b/cputlb.c
index 813279f3bc..9bf9960e1b 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -80,7 +80,7 @@ void tlb_flush(CPUState *cpu, int flush_global)
=20
     memset(env->tlb_table, -1, sizeof(env->tlb_table));
     memset(env->tlb_v_table, -1, sizeof(env->tlb_v_table));
-    memset(cpu->tb_jmp_cache, 0, sizeof(cpu->tb_jmp_cache));
+    tb_flush_jmp_cache_all(cpu);
=20
     env->vtlb_index =3D 0;
     env->tlb_flush_addr =3D -1;
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index a8c13cee66..57cd978578 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -256,6 +256,12 @@ struct TranslationBlock {
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
=20
diff --git a/translate-all.c b/translate-all.c
index 3dd9214904..29ccb9e546 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -941,11 +941,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_da=
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
@@ -1741,6 +1737,14 @@ void tb_check_watchpoint(CPUState *cpu)
     }
 }
=20
+void tb_flush_jmp_cache_all(CPUState *cpu)
+{
+    int i;
+    for (i =3D 0; i < TB_JMP_CACHE_SIZE; ++i) {
+        atomic_set(&cpu->tb_jmp_cache[i], NULL);
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 /* in deterministic execution mode, instructions doing device I/Os
    must be at the end of the TB */
