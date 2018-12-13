Received: from eggs.gnu.org ([2001:4830:134:3::10]:41013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVFZ-0000in-2W
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVFV-00081T-SD
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:58:16 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 18:58:07 +0100
Message-Id: <20181213175807.12039-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] vl: Use error_fatal to simplify obvious fatal
 errors (again)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Patch created mechanically by rerunning:

    $ spatch --in-place --sp-file scripts/coccinelle/use-error_fatal.cocci \
             --macro-file scripts/cocci-macro-file.h vl.c

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/vl.c b/vl.c
index a5ae5f23d2..702a828ca2 100644
--- a/vl.c
+++ b/vl.c
@@ -3138,11 +3138,8 @@ int main(int argc, char **argv, char **envp)
                     Visitor *v;
                     BlockdevOptions_queue *bdo;
 
-                    v = qobject_input_visitor_new_str(optarg, "driver", &err);
-                    if (!v) {
-                        error_report_err(err);
-                        exit(1);
-                    }
+                    v = qobject_input_visitor_new_str(optarg, "driver",
+                                                      &error_fatal);
 
                     bdo = g_new(BlockdevOptions_queue, 1);
                     visit_type_BlockdevOptions(v, NULL, &bdo->bdo,
-- 
2.17.2
