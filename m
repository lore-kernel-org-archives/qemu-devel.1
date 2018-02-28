Received: from eggs.gnu.org ([2001:4830:134:3::10]:49352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eqsTf-0006Ae-FK
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 22:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eqsTb-0003Uj-Fu
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 22:32:23 -0500
Received: from smtp20.cstnet.cn ([159.226.251.20]:58768 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eqsTa-0003TZ-Qz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 22:32:19 -0500
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Wed, 28 Feb 2018 11:31:29 +0800
Message-Id: <1519788689-11967-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] [PATCH v3] scripts/checkpatch.pl: add check for
 `while` and `for`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, eblake@redhat.com, stefanha@redhat.com
Cc: qemu-devel@nongnu.org

Adding check for `while` and `for` statements, which condition has more than
one line.

The former checkpatch.pl can check `if` statement, which condition has more
than one line, whether block misses brace round, like this:
'''
if (cond1 ||
    cond2)
    statement;
'''
But it doesn't do the same check for `for` and `while` statements.

Using `(?:...)` instead of `(...)` in regex pattern catch.
Because `(?:...)` is faster and avoids unwanted side-effect.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Suggested-by: Eric Blake <eblake@redhat.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 10c138344fa9..bed1dbbd54d1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2352,9 +2352,9 @@ sub process {
 			}
 		}
 
-# check for missing bracing round if etc
-		if ($line =~ /(^.*)\b(for|while|if)\b/ &&
-			$line !~ /\#\s*(for|while|if)/) {
+# check for missing bracing around if etc
+		if ($line =~ /(^.*)\b(?:for|while|if)\b/ &&
+			$line !~ /\#\s*(?:for|while|if)/) {
 			my ($level, $endln, @chunks) =
 				ctx_statement_full($linenr, $realcnt, 1);
                         if ($dbg_adv_apw) {
-- 
2.7.4
