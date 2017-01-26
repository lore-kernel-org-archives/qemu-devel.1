Received: from eggs.gnu.org ([2001:4830:134:3::10]:58531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWjpd-0006Y2-5Q
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWjpZ-0001X5-5L
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cWjpZ-0001Wm-0D
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:11:13 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 417476AACF
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 13:11:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 26 Jan 2017 14:11:03 +0100
Message-Id: <1485436265-12573-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1485436265-12573-1-git-send-email-thuth@redhat.com>
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 3/5] checkpatch: ignore email headers better
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

commit 29ee1b0c67e0dd7dea8dd718e8326076bce5b6fe
Author: Joe Perches <joe@perches.com>
Date:   Wed Aug 6 16:10:35 2014 -0700

    checkpatch: ignore email headers better

    There are some patches created by git format-patch that when scanned by
    checkpatch report errors on lines like

    To: address.tld

    This is a checkpatch false positive.

    Improve the logic a bit to ignore folded email headers to avoid emitting
    these messages.

    Signed-off-by: Joe Perches <joe@perches.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0f88e3b..52ad64a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1094,7 +1094,7 @@ sub process {
 	my $signoff = 0;
 	my $is_patch = 0;
 
-	my $in_header_lines = 1;
+	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 
 	my $non_utf8_charset = 0;
@@ -1321,7 +1321,8 @@ sub process {
 # Check if it's the start of a commit log
 # (not a header line and we haven't seen the patch filename)
 		if ($in_header_lines && $realfile =~ /^$/ &&
-		    $rawline !~ /^(commit\b|from\b|\w+:).+$/i) {
+		    !($rawline =~ /^\s+\S/ ||
+		      $rawline =~ /^(commit\b|from\b|[\w-]+:).*$/i)) {
 			$in_header_lines = 0;
 			$in_commit_log = 1;
 		}
-- 
1.8.3.1
