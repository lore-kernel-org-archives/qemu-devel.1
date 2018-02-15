Received: from eggs.gnu.org ([2001:4830:134:3::10]:43272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emA0E-00049P-K6
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 22:14:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emA09-0000dJ-Ph
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 22:14:30 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 14 Feb 2018 22:14:20 -0500
Message-Id: <1518664462-2960-2-git-send-email-cota@braap.org>
In-Reply-To: <1518664462-2960-1-git-send-email-cota@braap.org>
References: <1518664462-2960-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 1/3] translator: add retcode to
 translator_loop_temp_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

This will allow us to print further info from target code.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translator.c    | 4 +++-
 include/exec/translator.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 23c6602..f409a95 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -23,12 +23,14 @@
    (1) the target is sufficiently clean to support reporting,
    (2) as and when all temporaries are known to be consumed.
    For most targets, (2) is at the end of translate_insn.  */
-void translator_loop_temp_check(DisasContextBase *db)
+int translator_loop_temp_check(DisasContextBase *db)
 {
     if (tcg_check_temp_count()) {
         qemu_log("warning: TCG temporary leaks before "
                  TARGET_FMT_lx "\n", db->pc_next);
+        return 1;
     }
+    return 0;
 }
 
 void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
diff --git a/include/exec/translator.h b/include/exec/translator.h
index e2dc2a0..8833340 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -139,6 +139,6 @@ typedef struct TranslatorOps {
 void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
                      CPUState *cpu, TranslationBlock *tb);
 
-void translator_loop_temp_check(DisasContextBase *db);
+int translator_loop_temp_check(DisasContextBase *db);
 
 #endif  /* EXEC__TRANSLATOR_H */
-- 
2.7.4
