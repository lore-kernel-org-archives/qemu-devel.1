Received: from eggs.gnu.org ([2001:4830:134:3::10]:51665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gA8a4-0002s5-RH
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gA8a1-0004Dz-Ly
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:06:52 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 10 Oct 2018 09:06:38 +0200
Message-Id: <1539155198-5873-1-git-send-email-thuth@redhat.com>
In-Reply-To: <f8c0f859-2d70-b53e-a39a-48c2bf253be6@redhat.com>
References: <f8c0f859-2d70-b53e-a39a-48c2bf253be6@redhat.com>
Subject: [Qemu-devel] [PATCH v2] target/cris/translate: Get rid of
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
Cc: qemu-trivial@nongnu.org, philmd@redhat.com

The gen_BUG() function calls already cpu_abort(), which prints the
information to stderr and the log already. So instead of additionally
printing the dc->pc via fprintf() and qemu_log here, too, we can
simply pass this information to cpu_abort() instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use "pc=" instead of "dc->pc=" in the string as suggested by Phil

 target/cris/translate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 4ae1c04..11b2c11 100644
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
+    cpu_abort(CPU(dc->cpu), "%s:%d pc=%x\n", file, line, dc->pc);
 }
 
 static const char *regnames_v32[] =
-- 
1.8.3.1
