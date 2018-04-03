Received: from eggs.gnu.org ([2001:4830:134:3::10]:59602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3Ngb-0003YY-UI
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3NgX-0004UF-Rd
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:17:25 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:60025 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1f3NgX-0004Oo-5i
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:17:21 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Tue,  3 Apr 2018 23:17:13 +0800
Message-Id: <1522768634-5548-3-git-send-email-suhang16@mails.ucas.ac.cn>
In-Reply-To: <1522768634-5548-1-git-send-email-suhang16@mails.ucas.ac.cn>
References: <1522768634-5548-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel]  [PATCH v2] scripts/checkpatch.pl: Bug fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org

checkpatch.pl stops complaining about following pattern:
"""
do {
    //do somethins;
} while (conditions);
"""

One things need to be mentioned:
Becasue `if`, `while` and `for` check have been done in this
`if` block(Line: 2356), and this block contains following statement:
""" Line: 2379
$suppress_ifbraces{$ln + $offset} = 1;
"""
So the behind block may never run:
""" Line: 2415
if (!defined $suppress_ifbraces{$linenr - 1} &&
    $line =~ /\b(if|while|for|else)\b/ &&
    $line !~ /\#\s*if/ &&
    $line !~ /\#\s*else/) {
"""
I'm not sure, please give me some advice.

(Sorry, I don't know this patch should base on which commit,
 so I generate this patch based on
 commit:fb8446d94ec7a3dc0c3a7e7da672406476f075ac,
 I choose this by `git log -2 scripts/checkpath.pl`.
 Sincerely say sorry, if I have misunderstand any meaning.)

Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
 scripts/checkpatch.pl | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a88af61ed4ee..d6f0747ba20a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2352,8 +2352,22 @@ sub process {
 			}
 		}

-# check for missing bracing round if etc
-		if ($line =~ /(^.*)\bif\b/ && $line !~ /\#\s*if/) {
+# check for missing bracing around if etc
+		if ($line =~ /(^.*)\b(?:if|while|for)\b/ &&
+			$line !~ /\#\s*if/) {
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
+
 			my ($level, $endln, @chunks) =
 				ctx_statement_full($linenr, $realcnt, 1);
                         if ($dbg_adv_apw) {
@@ -2362,7 +2376,6 @@ sub process {
                                 if $#chunks >= 1;
                         }
 			if ($#chunks >= 0 && $level == 0) {
-				my $allowed = 0;
 				my $seen = 0;
 				my $herectx = $here . "\n";
 				my $ln = $linenr - 1;
@@ -2406,7 +2419,7 @@ sub process {
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
