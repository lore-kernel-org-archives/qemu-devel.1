Received: from eggs.gnu.org ([2001:4830:134:3::10]:52647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9miy-0000z5-BR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9miv-0000M0-Jq
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:46:35 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  9 Oct 2018 09:46:20 +0200
Message-Id: <1539071180-2028-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/cris/translate: Get rid of
 qemu_log_separate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-trivial@nongnu.org

The gen_BUG() function calls already cpu_abort(), which prints the
information to stderr and the log already. So instead of additionally
printing the dc->pc via fprintf() and qemu_log here, too, we can
simply pass this information to cpu_abort() instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/cris/translate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 4ae1c04..0ee2c5d 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -137,11 +137,7 @@ typedef struct DisasContext {
 
 static void gen_BUG(DisasContext *dc, const char *file, int line)
 {
-    fprintf(stderr, "BUG: pc=%x %s %d\n", dc->pc, file, line);
-    if (qemu_log_separate()) {
-        qemu_log("BUG: pc=%x %s %d\n", dc->pc, file, line);
-    }
-    cpu_abort(CPU(dc->cpu), "%s:%d\n", file, line);
+    cpu_abort(CPU(dc->cpu), "%s:%d dc->pc=%x\n", file, line, dc->pc);
 }
 
 static const char *regnames_v32[] =
-- 
1.8.3.1
