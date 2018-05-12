Received: from eggs.gnu.org ([2001:4830:134:3::10]:34818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHQqj-0006CR-Le
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHQqi-0000nr-Pi
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:29:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat, 12 May 2018 10:28:20 +0100
Message-Id: <20180512092824.13848-5-stefanha@redhat.com>
In-Reply-To: <20180512092824.13848-1-stefanha@redhat.com>
References: <20180512092824.13848-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] checkpatch: ignore email headers better
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

There are some patches created by git format-patch that when scanned by
checkpatch report errors on lines like

To:	address.tld

This is a checkpatch false positive.

Improve the logic a bit to ignore folded email headers to avoid emitting
these messages.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180430124651.10340-4-stefanha@redhat.com
(cherry picked from commit 29ee1b0c67e0dd7dea8dd718e8326076bce5b6fe)
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25bf43bad0..20d5b62586 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1183,7 +1183,7 @@ sub process {
 	my $signoff = 0;
 	my $is_patch = 0;
 
-	my $in_header_lines = 1;
+	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 
 	my $non_utf8_charset = 0;
@@ -1411,7 +1411,8 @@ sub process {
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
2.17.0
