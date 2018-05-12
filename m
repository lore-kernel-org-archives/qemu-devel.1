Received: from eggs.gnu.org ([2001:4830:134:3::10]:34836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHQqk-0006F1-Ot
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fHQqj-0000oM-Ou
	for qemu-devel@nongnu.org; Sat, 12 May 2018 05:29:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat, 12 May 2018 10:28:19 +0100
Message-Id: <20180512092824.13848-4-stefanha@redhat.com>
In-Reply-To: <20180512092824.13848-1-stefanha@redhat.com>
References: <20180512092824.13848-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 3/8] checkpatch: check utf-8 content from a
 commit log when it's missing from charset
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

From: Pasi Savanainen <pasi.savanainen@nixu.com>

Check that a commit log doesn't contain UTF-8 when a mail header
explicitly defines a different charset, like

'Content-Type: text/plain; charset="us-ascii"'

Signed-off-by: Pasi Savanainen <pasi.savanainen@nixu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Message-id: 20180430124651.10340-3-stefanha@redhat.com
Cc: Joe Perches <joe@perches.com>
Cc: Andy Whitcroft <apw@canonical.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit fa64205df9dfd7b7662cc64a7e82115c00e428e5)
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/checkpatch.pl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c667d085ae..25bf43bad0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1186,6 +1186,8 @@ sub process {
 	my $in_header_lines = 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 
+	my $non_utf8_charset = 0;
+
 	our @report = ();
 	our $cnt_lines = 0;
 	our $cnt_error = 0;
@@ -1414,8 +1416,15 @@ sub process {
 			$in_commit_log = 1;
 		}
 
-# Still not yet in a patch, check for any UTF-8
-		if ($in_commit_log && $realfile =~ /^$/ &&
+# Check if there is UTF-8 in a commit log when a mail header has explicitly
+# declined it, i.e defined some charset where it is missing.
+		if ($in_header_lines &&
+		    $rawline =~ /^Content-Type:.+charset="(.+)".*$/ &&
+		    $1 !~ /utf-8/i) {
+			$non_utf8_charset = 1;
+		}
+
+		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&
 		    $rawline =~ /$NON_ASCII_UTF8/) {
 			WARN("8-bit UTF-8 used in possible commit log\n" . $herecurr);
 		}
-- 
2.17.0
