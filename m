Received: from eggs.gnu.org ([2001:4830:134:3::10]:36115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utg-0007lQ-WD
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Ute-0007IM-ML
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:32 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Ute-0007Ee-G5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:30 -0400
Received: by mail-wm0-x242.google.com with SMTP id i3so4561703wmf.3
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:30 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:04 +0200
Message-Id: <1523034681-33787-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/20] scripts/checkpatch.pl: Bug fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Su Hang <suhang16@mails.ucas.ac.cn>

From: Su Hang <suhang16@mails.ucas.ac.cn>

Commit 2b9aef6fcd96ba7ed8c1ee723e391901852d344c introduced a regression:
checkpatch.pl started complaining about the following valid pattern:
do {
     /* something */
} while (condition);

Fix the script to once again permit this pattern.

Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
Message-Id: <1522029982-4650-1-git-send-email-suhang16@mails.ucas.ac.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 57daae0..d52207a 100755
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
1.8.3.1
