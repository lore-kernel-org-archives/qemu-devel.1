Received: from eggs.gnu.org ([2001:4830:134:3::10]:58470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWjpY-0006U8-GF
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWjpX-0001WM-J3
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cWjpX-0001W0-Da
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:11 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1B2FC04B93E
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 13:11:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 26 Jan 2017 14:11:02 +0100
Message-Id: <1485436265-12573-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1485436265-12573-1-git-send-email-thuth@redhat.com>
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 2/5] checkpatch: check utf-8 content from a
 commit log when it's missing from charset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is a port of the following commit from the Linux kernel:

commit fa64205df9dfd7b7662cc64a7e82115c00e428e5
Author: Pasi Savanainen <pasi.savanainen@nixu.com>
Date:   Thu Oct 4 17:13:29 2012 -0700

    checkpatch: check utf-8 content from a commit log when it's missing from charset

    Check that a commit log doesn't contain UTF-8 when a mail header
    explicitly defines a different charset, like

    'Content-Type: text/plain; charset="us-ascii"'

    Signed-off-by: Pasi Savanainen <pasi.savanainen@nixu.com>
    Cc: Joe Perches <joe@perches.com>
    Cc: Andy Whitcroft <apw@canonical.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Note: I slightly updated the regex for the "Content-Type" line check
since most of the time, the character set does not seem to be given
in quotes.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/checkpatch.pl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5da423a..0f88e3b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1097,6 +1097,8 @@ sub process {
 	my $in_header_lines = 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 
+	my $non_utf8_charset = 0;
+
 	our @report = ();
 	our $cnt_lines = 0;
 	our $cnt_error = 0;
@@ -1324,8 +1326,15 @@ sub process {
 			$in_commit_log = 1;
 		}
 
-# Still not yet in a patch, check for any UTF-8
-		if ($in_commit_log && $realfile =~ /^$/ &&
+# Check if there is UTF-8 in a commit log when a mail header has explicitly
+# declined it, i.e defined some charset where it is missing.
+		if ($in_header_lines &&
+		    $rawline =~ /^Content-Type:.+charset=(.+)$/ &&
+		    $1 !~ /utf-8/i) {
+			$non_utf8_charset = 1;
+		}
+
+		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&
 		    $rawline =~ /$NON_ASCII_UTF8/) {
 			WARN("8-bit UTF-8 used in possible commit log\n"
 			     . $herecurr);
-- 
1.8.3.1
