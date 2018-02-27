Received: from eggs.gnu.org ([2001:4830:134:3::10]:40033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eqbx7-0002B7-8u
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eqbx5-0005Qd-0V
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:53:41 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57666)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eqbx4-0005Pj-C2
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:53:38 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 27 Feb 2018 12:53:38 +0300
Message-ID: <20180227095338.1060.27385.stgit@pasha-VirtualBox>
In-Reply-To: <20180227095135.1060.36549.stgit@pasha-VirtualBox>
References: <20180227095135.1060.36549.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 22/22] tcg: fix cpu_io_recompile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org

cpu_io_recompile() function was broken by
the commit 9b990ee5a3cc6aa38f81266fb0c6ef37a36c45b9. Instead of regenerating
the block starting from PC of the original block, it just set the instruction
counter for TCG. In most cases this was unnoticed, but in icount mode
there was an exception for incorrect usage of CF_LAST_IO flag.
This patch recovers recompilation of the original block and also
configures translation for executing single IO instruction which
caused a recompilation.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 accel/tcg/translate-all.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 67795cd..5ad1b91 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1728,7 +1728,8 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     CPUArchState *env = cpu->env_ptr;
 #endif
     TranslationBlock *tb;
-    uint32_t n;
+    uint32_t n, flags;
+    target_ulong pc, cs_base;
 
     tb_lock();
     tb = tb_find_pc(retaddr);
@@ -1766,8 +1767,14 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
         cpu_abort(cpu, "TB too big during recompile");
     }
 
-    /* Adjust the execution state of the next TB.  */
-    cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | n;
+    pc = tb->pc;
+    cs_base = tb->cs_base;
+    flags = tb->flags;
+    tb_phys_invalidate(tb, -1);
+
+    /* Execute one IO instruction without caching
+       instead of creating large TB. */
+    cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | CF_NOCACHE | 1;
 
     if (tb->cflags & CF_NOCACHE) {
         if (tb->orig_tb) {
@@ -1778,6 +1785,11 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
         tb_remove(tb);
     }
 
+    /* Generate new TB instead of the current one. */
+    /* FIXME: In theory this could raise an exception.  In practice
+       we have already translated the block once so it's probably ok.  */
+    tb_gen_code(cpu, pc, cs_base, flags, curr_cflags() | CF_LAST_IO | n);
+
     /* TODO: If env->pc != tb->pc (i.e. the faulting instruction was not
      * the first in the TB) then we end up generating a whole new TB and
      *  repeating the fault, which is horribly inefficient.
