Received: from eggs.gnu.org ([2001:4830:134:3::10]:60780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ey6TR-0006un-VT
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ey6TO-0006C9-RT
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:54:01 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:56588 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ey6TO-0006A2-52
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 21:53:58 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Tue, 20 Mar 2018 09:53:52 +0800
Message-Id: <1521510832-28718-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel]  [PATCH RFC v3] scripts/checkpatch.pl: Bug fix
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

Commit 2b9aef6fcd96ba7ed8c1ee723e391901852d344c introduced a regression:
checkpatch.pl started complaining about the following valid pattern:
do {
     /* something */
} while (condition);

Fix the script to once again permit this pattern.

Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
v1: fix bug.
v2: correct inappropriate patch description.
v3: put version description under Signed-off-by line.

 scripts/checkpatch.pl | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 57daae05ea18..d52207a3cc9d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2356,6 +2356,18 @@ sub process {
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
@@ -2364,7 +2376,6 @@ sub process {
                                 if $#chunks >= 1;
                         }
 			if ($#chunks >= 0 && $level == 0) {
-				my $allowed = 0;
 				my $seen = 0;
 				my $herectx = $here . "\n";
 				my $ln = $linenr - 1;
@@ -2408,7 +2419,7 @@ sub process {
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
