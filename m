Received: from eggs.gnu.org ([2001:4830:134:3::10]:58869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f95bD-0004Aq-5G
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f95b8-0004m9-Tl
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:11:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40944 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f95b8-0004l9-PK
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:11:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 19 Apr 2018 17:11:01 +0800
Message-Id: <20180419091105.3943-2-stefanha@redhat.com>
In-Reply-To: <20180419091105.3943-1-stefanha@redhat.com>
References: <20180419091105.3943-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] checkpatch: add a --strict check for utf-8
 in commit logs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>

From: Joe Perches <joe@perches.com>

Some find using utf-8 in commit logs inappropriate.

Some patch commit logs contain unintended utf-8 characters when doing
things like copy/pasting compilation output.

Look for the start of any commit log by skipping initial lines that look
like email headers and "From: " lines.

Stop looking for utf-8 at the first signature line.

Signed-off-by: Joe Perches <joe@perches.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 15662b3e8644905032c2e26808401a487d4e90c1)
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/checkpatch.pl | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d52207a3cc..2d28db03a0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -224,9 +224,8 @@ our $NonptrType;
 our $Type;
 our $Declare;
 
-our $UTF8	= qr {
-	[\x09\x0A\x0D\x20-\x7E]              # ASCII
-	| [\xC2-\xDF][\x80-\xBF]             # non-overlong 2-byte
+our $NON_ASCII_UTF8	= qr{
+	[\xC2-\xDF][\x80-\xBF]               # non-overlong 2-byte
 	|  \xE0[\xA0-\xBF][\x80-\xBF]        # excluding overlongs
 	| [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2}  # straight 3-byte
 	|  \xED[\x80-\x9F][\x80-\xBF]        # excluding surrogates
@@ -235,6 +234,11 @@ our $UTF8	= qr {
 	|  \xF4[\x80-\x8F][\x80-\xBF]{2}     # plane 16
 }x;
 
+our $UTF8	= qr{
+	[\x09\x0A\x0D\x20-\x7E]              # ASCII
+	| $NON_ASCII_UTF8
+}x;
+
 # There are still some false positives, but this catches most
 # common cases.
 our $typeTypedefs = qr{(?x:
@@ -1178,6 +1182,9 @@ sub process {
 	my $signoff = 0;
 	my $is_patch = 0;
 
+	my $in_header_lines = 1;
+	my $in_commit_log = 0;		#Scanning lines before patch
+
 	our @report = ();
 	our $cnt_lines = 0;
 	our $cnt_error = 0;
@@ -1330,7 +1337,6 @@ sub process {
 		if ($line =~ /^diff --git.*?(\S+)$/) {
 			$realfile = $1;
 			$realfile =~ s@^([^/]*)/@@;
-
 		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
 			$realfile = $1;
 			$realfile =~ s@^([^/]*)/@@;
@@ -1369,6 +1375,8 @@ sub process {
 		if ($line =~ /^\s*signed-off-by:/i) {
 			# This is a signoff, if ugly, so do not double report.
 			$signoff++;
+			$in_commit_log = 0;
+
 			if (!($line =~ /^\s*Signed-off-by:/)) {
 				ERROR("The correct form is \"Signed-off-by\"\n" .
 					$herecurr);
@@ -1397,6 +1405,21 @@ sub process {
 			ERROR("Invalid UTF-8, patch and commit message should be encoded in UTF-8\n" . $hereptr);
 		}
 
+# Check if it's the start of a commit log
+# (not a header line and we haven't seen the patch filename)
+		if ($in_header_lines && $realfile =~ /^$/ &&
+		    $rawline !~ /^(commit\b|from\b|\w+:).+$/i) {
+			$in_header_lines = 0;
+			$in_commit_log = 1;
+		}
+
+# Still not yet in a patch, check for any UTF-8
+		if ($in_commit_log && $realfile =~ /^$/ &&
+		    $rawline =~ /$NON_ASCII_UTF8/) {
+			CHK("UTF8_BEFORE_PATCH",
+			    "8-bit UTF-8 used in possible commit log\n" . $herecurr);
+		}
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
2.14.3
