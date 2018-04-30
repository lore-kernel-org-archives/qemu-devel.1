Received: from eggs.gnu.org ([2001:4830:134:3::10]:52654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD8Cx-00048l-6X
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD8Cw-0001WX-Cs
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:47:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fD8Cw-0001WD-8G
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 08:47:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 30 Apr 2018 13:46:50 +0100
Message-Id: <20180430124651.10340-5-stefanha@redhat.com>
In-Reply-To: <20180430124651.10340-1-stefanha@redhat.com>
References: <20180430124651.10340-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] checkpatch: emit a warning on file
 add/move/delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>

From: Joe Perches <joe@perches.com>

Whenever files are added, moved, or deleted, the MAINTAINERS file
patterns can be out of sync or outdated.

To try to keep MAINTAINERS more up-to-date, add a one-time warning
whenever a patch does any of those.

Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Andy Whitcroft <apw@canonical.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 13f1937ef33950b1112049972249e6191b82e6c9)
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>

Conflicts:
  QEMU WARN() only takes one argument, drop the 'type' value in the
  first argument.
---
 scripts/checkpatch.pl | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 20d5b62586..84bdf53af7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1185,7 +1185,7 @@ sub process {
 
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
-
+	my $reported_maintainer_file = 0;
 	my $non_utf8_charset = 0;
 
 	our @report = ();
@@ -1390,6 +1390,16 @@ sub process {
 			}
 		}
 
+# Check for added, moved or deleted files
+		if (!$reported_maintainer_file && !$in_commit_log &&
+		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
+		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
+		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
+		      (defined($1) || defined($2))))) {
+			$reported_maintainer_file = 1;
+			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
+		}
+
 # Check for wrappage within a valid hunk of the file
 		if ($realcnt != 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
 			ERROR("patch seems to be corrupt (line wrapped?)\n" .
-- 
2.14.3
