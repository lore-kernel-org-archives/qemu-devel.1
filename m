Received: from eggs.gnu.org ([2001:4830:134:3::10]:53469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1et6fP-0003Bl-6h
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1et6fK-0003tl-5B
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:05:43 -0500
Received: from smtp20.cstnet.cn ([159.226.251.20]:51677 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1et6fJ-0003sD-FI
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:05:38 -0500
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Tue,  6 Mar 2018 15:04:50 +0800
Message-Id: <1520319890-19761-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] [PATCH v4] scripts/checkpatch.pl: add check for
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
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1b4b812e28fa..b1a8407d7406 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2352,8 +2352,9 @@ sub process {
 			}
 		}
 
-# check for missing bracing round if etc
-		if ($line =~ /(^.*)\bif\b/ && $line !~ /\#\s*if/) {
+# check for missing bracing around if etc
+		if ($line =~ /(^.*)\b(?:if|while|for)\b/ &&
+			$line !~ /\#\s*(?:if|while|for)/) {
 			my ($level, $endln, @chunks) =
 				ctx_statement_full($linenr, $realcnt, 1);
                         if ($dbg_adv_apw) {
-- 
2.7.4
