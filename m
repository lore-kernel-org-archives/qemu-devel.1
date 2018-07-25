Received: from eggs.gnu.org ([2001:4830:134:3::10]:39474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIiB-0002rR-Cs
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIi8-0005hT-Cd
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:11 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36730)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fiIi8-0005gi-2c
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:16:08 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 25 Jul 2018 15:15:38 +0300
Message-ID: <20180725121538.12867.66418.stgit@pasha-VirtualBox>
In-Reply-To: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 14/24] translator: fix breakpoint processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

QEMU cannot pass through the breakpoints when 'si' command is used
in remote gdb. This patch disables inserting the breakpoints
when we are already single stepping though the gdb remote protocol.
This patch also fixes icount calculation for the blocks that include
breakpoints - instruction with breakpoint is not executed and shouldn't
be used in icount calculation.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 accel/tcg/translator.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 0f9dca9..afd0a49 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -34,6 +34,8 @@ void translator_loop_temp_check(DisasContextBase *db)
 void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
                      CPUState *cpu, TranslationBlock *tb)
 {
+    int bp_insn = 0;
+
     /* Initialize DisasContext */
     db->tb = tb;
     db->pc_first = tb->pc;
@@ -71,11 +73,13 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
         tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
         /* Pass breakpoint hits to target for further processing */
-        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
+        if (!db->singlestep_enabled
+            && unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
             CPUBreakpoint *bp;
             QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
                 if (bp->pc == db->pc_next) {
                     if (ops->breakpoint_check(db, cpu, bp)) {
+                        bp_insn = 1;
                         break;
                     }
                 }
@@ -118,7 +122,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
 
     /* Emit code to exit the TB, as indicated by db->is_jmp.  */
     ops->tb_stop(db, cpu);
-    gen_tb_end(db->tb, db->num_insns);
+    gen_tb_end(db->tb, db->num_insns - bp_insn);
 
     /* The disas_log hook may use these values rather than recompute.  */
     db->tb->size = db->pc_next - db->pc_first;
