Received: from eggs.gnu.org ([2001:4830:134:3::10]:45930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ewRK7-0001I0-5B
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ewRK2-0006sr-4O
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:45:31 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:58174 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ewRK0-0006pK-Re
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:45:26 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Thu, 15 Mar 2018 19:45:16 +0800
Message-Id: <1521114316-19980-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel]  [PATCH RFC] scripts/checkpatch.pl: Bug fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, vsementsov@virtuozzo.com
Cc: qemu-devel@nongnu.org

Bug fix: checkpatch.pl stops complaining about following pattern:
"""
do {
    //do somethins;
} while (conditions);
"""

Two things need to be mentioned:
1) Before I casue this bug, checkpatch.pl will raise a wrong
complain:
"""
ERROR: braces {} are necessary even for single statement blocks
+    for (i == 0; i < 0; ++i)
+    {
+        ;
+    } else
"""
In this patch, this wrong complain get fixed.

2) Becasue all(`if`, `while`, `for`) check have been done in this
`if` block(Line: 2356), and this block contains following statement:
""" Line: 2379
$suppress_ifbraces{$ln + $offset} = 1;
"""
So the block after this block may never run:
""" Line: 2415
if (!defined $suppress_ifbraces{$linenr - 1} &&
	$line =~ /\b(if|while|for|else)\b/ &&
	$line !~ /\#\s*if/ &&
	$line !~ /\#\s*else/) {
"""
But I think, maybe it's ok, becasue all check has been done by
up block. I'm not sure, please give me some advice.

Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
 scripts/checkpatch.pl | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d1fe79bcc47c..2ca833f22e5a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2355,6 +2355,18 @@ sub process {
 # check for missing bracing around if etc
 		if ($line =~ /(^.*)\b(?:if|while|for)\b/ &&
 			$line !~ /\#\s*if/) {
+			my $allowed = 0;
+
+			# Check the pre-context.
+			if ($line =~ /(\}.*?)$/) {
+				my $pre = $1;
+
+				if ($line !~ /else/) {
+					print "APW: ALLOWED: pre<$pre> line<$line>\n"
+						if $dbg_adv_apw;
+					$allowed = 1;
+				}
+			}
 			my ($level, $endln, @chunks) =
 				ctx_statement_full($linenr, $realcnt, 1);
                         if ($dbg_adv_apw) {
@@ -2363,7 +2375,6 @@ sub process {
                                 if $#chunks >= 1;
                         }
 			if ($#chunks >= 0 && $level == 0) {
-				my $allowed = 0;
 				my $seen = 0;
 				my $herectx = $here . "\n";
 				my $ln = $linenr - 1;
@@ -2407,7 +2418,7 @@ sub process {
                                             $allowed = 1;
 					}
 				}
-				if ($seen != ($#chunks + 1)) {
+				if ($seen != ($#chunks + 1) && !$allowed) {
 					ERROR("braces {} are necessary for all arms of this statement\n" . $herectx);
 				}
 			}
--
2.7.4
