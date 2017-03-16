Received: from eggs.gnu.org ([2001:4830:134:3::10]:51571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cqIvd-0005uu-Ge
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cqIva-0002nJ-B0
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:30:21 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Thu, 16 Mar 2017 12:14:16 +0100
Message-Id: <20170316111416.25587-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH] checkpatch: Supress warning in function
 pointer typedefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-trivial@nongnu.org, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Vinzenz Feenstra <vfeenstr@redhat.com>

When importing dynamically functions via `GetProcAddress` in windows
related code, it is quite common to make a typedef for the resulting
function pointer. When the function to be imported, has a stdcall
calling convention, usually the `WINAPI` macro is used. This patch adds an
exception in the checkpatch.pl script to allow the calling convention
specification in function pointer typedefs, to be `WINAPI`.

Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
---
 scripts/checkpatch.pl | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f084542..33bf585 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1774,7 +1774,14 @@ sub process {
 			# likely a typedef for a function.
 			} elsif ($ctx =~ /$Type$/) {
 
-			} else {
+            # If this is a typedef we need to allow WINAPI as a calling
+            # convention. Even though there should be only one space around the
+            # star, we allow none or any, to suppress the following warning.
+            # The check for the number of spaces around the star is checked
+            # elsewhere.
+			} elsif($ctx =~ /^\s*typedef\s+$Type\(WINAPI\s*\*\s*$Ident\)/) {
+
+            } else {
 				ERROR("space prohibited between function name and open parenthesis '('\n" . $herecurr);
 			}
 		}
-- 
2.9.3
