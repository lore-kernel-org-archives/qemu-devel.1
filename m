Received: from eggs.gnu.org ([2001:4830:134:3::10]:44829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKug8-0007d4-GA
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 18:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKug6-0004d6-NO
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 18:25:08 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Dec 2017 17:24:33 -0600
Message-Id: <20171201232433.25193-8-eblake@redhat.com>
In-Reply-To: <20171201232433.25193-1-eblake@redhat.com>
References: <20171201232433.25193-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/7] checkpatch: Enforce proper do/while (0)
 style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, qemu-trivial@nongnu.org, pbonzini@redhat.com

Use of a loop construct for code that is not intended to repeat
does not make much idiomatic sense, except in one place: it is a
common usage in macros in order to wrap arbitrary code with
single-statement semantics.  But when used in a macro, it is more
typical for the caller to supply the trailing ';' when calling
the macro.

Although qemu coding style frowns on bare:
  if (cond)
    statement1;
  else
    statement2;
where extra semicolons actually cause syntax errors, we still
want our macro styles to be easily copied to other projects.
Thus, declare it an error if we encounter any form of 'while (0)'
with a semicolon in the same line.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 34df753571..27800a4ed9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1622,6 +1622,11 @@ sub process {
 			}
 		}

+# 'do ... while (0/false)' only makes sense in macros, without trailing ';'
+		if ($line =~ /while\s*\((0|false)\);/) {
+			ERROR("suspicious ; after while (0)\n" . $herecurr);
+		}
+
 # Check relative indent for conditionals and blocks.
 		if ($line =~ /\b(?:(?:if|while|for)\s*\(|do\b)/ && $line !~ /^.\s*#/ && $line !~ /\}\s*while\s*/) {
 			my ($s, $c) = ($stat, $cond);
-- 
2.14.3
