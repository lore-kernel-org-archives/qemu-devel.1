Received: from eggs.gnu.org ([2001:4830:134:3::10]:59009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f95bS-0004JG-Bm
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f95bI-0004sc-Sp
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:11:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41706 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f95bI-0004sH-OR
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:11:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 19 Apr 2018 17:11:03 +0800
Message-Id: <20180419091105.3943-4-stefanha@redhat.com>
In-Reply-To: <20180419091105.3943-1-stefanha@redhat.com>
References: <20180419091105.3943-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] checkpatch: ignore email headers better
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

There are some patches created by git format-patch that when scanned by
checkpatch report errors on lines like

To:	address.tld

This is a checkpatch false positive.

Improve the logic a bit to ignore folded email headers to avoid emitting
these messages.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 29ee1b0c67e0dd7dea8dd718e8326076bce5b6fe)
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b2b088bab7..f3b166d5e2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1182,7 +1182,7 @@ sub process {
 	my $signoff = 0;
 	my $is_patch = 0;
 
-	my $in_header_lines = 1;
+	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 
 	my $non_utf8_charset = 0;
@@ -1410,7 +1410,8 @@ sub process {
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
2.14.3
