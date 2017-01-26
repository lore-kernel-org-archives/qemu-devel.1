Received: from eggs.gnu.org ([2001:4830:134:3::10]:58507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWjpb-0006Wz-SF
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWjpa-0001Yb-UH
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cWjpa-0001XS-MV
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:14 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E609B61B9A
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 13:11:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 26 Jan 2017 14:11:04 +0100
Message-Id: <1485436265-12573-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1485436265-12573-1-git-send-email-thuth@redhat.com>
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 4/5] checkpatch: emit a reminder about
 MAINTAINERS on file add/move/delete
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

commit 13f1937ef33950b1112049972249e6191b82e6c9
Author: Joe Perches <joe@perches.com>
Date:   Wed Aug 6 16:10:59 2014 -0700

    checkpatch: emit a warning on file add/move/delete

    Whenever files are added, moved, or deleted, the MAINTAINERS file
    patterns can be out of sync or outdated.

    To try to keep MAINTAINERS more up-to-date, add a one-time warning
    whenever a patch does any of those.

    Signed-off-by: Joe Perches <joe@perches.com>
    Acked-by: Andy Whitcroft <apw@canonical.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Note: I've changed the "WARNING:" into a "NOTE:" since this is often
caused by false positives, so a warning seems too harsh to me.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/checkpatch.pl | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 52ad64a..e1be7b3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1096,7 +1096,7 @@ sub process {
 
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
-
+	my $reported_maintainer_file = 0;
 	my $non_utf8_charset = 0;
 
 	our @report = ();
@@ -1300,6 +1300,17 @@ sub process {
 			}
 		}
 
+# Check for added, moved or deleted files
+		if (!$reported_maintainer_file && !$in_commit_log &&
+		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
+		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
+		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
+		      (defined($1) || defined($2))))) {
+			$reported_maintainer_file = 1;
+			print "NOTE: added, moved or deleted file(s), "
+			      ."does MAINTAINERS need updating?\n" . $herecurr;
+		}
+
 # Check for wrappage within a valid hunk of the file
 		if ($realcnt != 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
 			ERROR("patch seems to be corrupt (line wrapped?)\n" .
-- 
1.8.3.1
