Received: from eggs.gnu.org ([2001:4830:134:3::10]:36613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1exvGu-0005Cs-NN
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 09:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1exvGp-0003Kk-Sf
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 09:56:20 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:40667 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1exvGp-0003HR-7d
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 09:56:15 -0400
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Mon, 19 Mar 2018 21:56:08 +0800
Message-Id: <1521467768-3162-1-git-send-email-suhang16@mails.ucas.ac.cn>
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
