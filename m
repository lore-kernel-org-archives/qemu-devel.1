Received: from eggs.gnu.org ([2001:4830:134:3::10]:46178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKPPg-0000N3-3C
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKPPc-0006x1-7C
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:02:04 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 30 Nov 2017 08:01:54 -0600
Message-Id: <20171130140154.11161-1-eblake@redhat.com>
In-Reply-To: <20171130134159.9697-1-eblake@redhat.com>
References: <20171130134159.9697-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 4/3] checkpatch: Enforce proper do/while (0)
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
Cc: qemu-trivial@nongnu.org

while (0) is only idiomatic in a macro definition, where the caller
will be supplying the trailing ';'.  Warn if the macro has a duplicate.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 34df753571..acb66bff34 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1622,6 +1622,11 @@ sub process {
 			}
 		}

+# 'while (0);' is odd; only macros should use while (0), without trailing ;
+		if ($line =~ /while\s*\(0\);/) {
+			ERROR("suspicious ; after while (0)\n" . $herecurr);
+		}
+
 # Check relative indent for conditionals and blocks.
 		if ($line =~ /\b(?:(?:if|while|for)\s*\(|do\b)/ && $line !~ /^.\s*#/ && $line !~ /\}\s*while\s*/) {
 			my ($s, $c) = ($stat, $cond);
-- 
2.14.3
