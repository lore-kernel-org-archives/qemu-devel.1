Received: from eggs.gnu.org ([2001:4830:134:3::10]:58486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWjpa-0006W4-9n
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWjpW-0001Vq-1O
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cWjpV-0001VV-PC
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:09 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 066D2804FE
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 13:11:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 26 Jan 2017 14:11:01 +0100
Message-Id: <1485436265-12573-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1485436265-12573-1-git-send-email-thuth@redhat.com>
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 1/5] checkpatch: add a check for utf-8 in
 commit logs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This patch is a port of the following commit from the Linux kernel:

commit 15662b3e8644905032c2e26808401a487d4e90c1
Author: Joe Perches <joe@perches.com>
Date:   Mon Oct 31 17:13:12 2011 -0700

    checkpatch: add a --strict check for utf-8 in commit logs

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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/checkpatch.pl | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f084542..5da423a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -172,9 +172,8 @@ our $NonptrType;
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
@@ -183,6 +182,11 @@ our $UTF8	= qr {
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
@@ -1090,6 +1094,9 @@ sub process {
 	my $signoff = 0;
 	my $is_patch = 0;
 
+	my $in_header_lines = 1;
+	my $in_commit_log = 0;		#Scanning lines before patch
+
 	our @report = ();
 	our $cnt_lines = 0;
 	our $cnt_error = 0;
@@ -1242,7 +1249,6 @@ sub process {
 		if ($line =~ /^diff --git.*?(\S+)$/) {
 			$realfile = $1;
 			$realfile =~ s@^([^/]*)/@@;
-
 		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
 			$realfile = $1;
 			$realfile =~ s@^([^/]*)/@@;
@@ -1281,6 +1287,7 @@ sub process {
 		if ($line =~ /^\s*signed-off-by:/i) {
 			# This is a signoff, if ugly, so do not double report.
 			$signoff++;
+			$in_commit_log = 0;
 			if (!($line =~ /^\s*Signed-off-by:/)) {
 				ERROR("The correct form is \"Signed-off-by\"\n" .
 					$herecurr);
@@ -1309,6 +1316,21 @@ sub process {
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
+			WARN("8-bit UTF-8 used in possible commit log\n"
+			     . $herecurr);
+		}
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
1.8.3.1
