Received: from eggs.gnu.org ([2001:4830:134:3::10]:34777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHQqh-00064Q-K0
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHQqg-0000mc-CY
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:29:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat, 12 May 2018 10:28:18 +0100
Message-Id: <20180512092824.13848-3-stefanha@redhat.com>
In-Reply-To: <20180512092824.13848-1-stefanha@redhat.com>
References: <20180512092824.13848-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] checkpatch: add a --strict check for utf-8
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
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Joe Perches <joe@perches.com>

Some find using utf-8 in commit logs inappropriate.

Some patch commit logs contain unintended utf-8 characters when doing
things like copy/pasting compilation output.

Look for the start of any commit log by skipping initial lines that look
like email headers and "From: " lines.

Stop looking for utf-8 at the first signature line.

Signed-off-by: Joe Perches <joe@perches.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Message-id: 20180430124651.10340-2-stefanha@redhat.com
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 15662b3e8644905032c2e26808401a487d4e90c1)
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Conflicts:
  QEMU does not have CHK(), use WARN() instead.

  QEMU WARN() only takes one argument, drop the 'type' value in the
  first argument.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/checkpatch.pl | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5b8735defb..c667d085ae 100755
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
@@ -1179,6 +1183,9 @@ sub process {
 	my $signoff = 0;
 	my $is_patch = 0;
 
+	my $in_header_lines = 1;
+	my $in_commit_log = 0;		#Scanning lines before patch
+
 	our @report = ();
 	our $cnt_lines = 0;
 	our $cnt_error = 0;
@@ -1331,7 +1338,6 @@ sub process {
 		if ($line =~ /^diff --git.*?(\S+)$/) {
 			$realfile = $1;
 			$realfile =~ s@^([^/]*)/@@;
-
 		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
 			$realfile = $1;
 			$realfile =~ s@^([^/]*)/@@;
@@ -1370,6 +1376,8 @@ sub process {
 		if ($line =~ /^\s*signed-off-by:/i) {
 			# This is a signoff, if ugly, so do not double report.
 			$signoff++;
+			$in_commit_log = 0;
+
 			if (!($line =~ /^\s*Signed-off-by:/)) {
 				ERROR("The correct form is \"Signed-off-by\"\n" .
 					$herecurr);
@@ -1398,6 +1406,20 @@ sub process {
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
+			WARN("8-bit UTF-8 used in possible commit log\n" . $herecurr);
+		}
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
2.17.0
