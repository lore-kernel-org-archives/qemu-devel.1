Received: from eggs.gnu.org ([2001:4830:134:3::10]:38225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofW-0008MQ-2v
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofT-0004Bk-QL
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:22 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofT-0004BD-JO
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:19 -0500
Received: by mail-wr1-x441.google.com with SMTP id q18so5664870wrx.9
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.17
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:41:53 +0000
Message-Id: <20181214144214.1260-2-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/22] scripts/checkpatch.pl: Enforce multiline
 comment syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We now require Linux-kernel-style multiline comments:
    /*
     * line one
     * line two
     */

Enforce this in checkpatch.pl, by backporting the relevant
parts of the Linux kernel's checkpatch.pl. (The only changes
needed are that Linux's checkpatch.pl WARN() function takes
an extra argument that ours does not, and the kernel has a
special case for networking code we don't want.)"

The kernel's checkpatch does not enforce "leading /* on
a line of its own, so that part is unique to QEMU's checkpatch.

Sample warning output:

WARNING: Block comments use a leading /* on a separate line
#34: FILE: hw/intc/arm_gicv3_common.c:39:
+    /* Older versions of QEMU had a bug in the handling of state save/restore

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/checkpatch.pl | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a892a6cc7c3..18e16b79dfc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1569,6 +1569,54 @@ sub process {
 # check we are in a valid C source file if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|cpp)$/);
 
+# Block comment styles
+
+		# Block comments use /* on a line of its own
+		if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&	#inline /*...*/
+		    $rawline =~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-blank
+			WARN("Block comments use a leading /* on a separate line\n" . $herecurr);
+		}
+
+# Block comments use * on subsequent lines
+		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
+		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
+		    $prevrawline !~ /\*\/[ \t]*$/ &&		#no trailing */
+		    $rawline =~ /^\+/ &&			#line is new
+		    $rawline !~ /^\+[ \t]*\*/) {		#no leading *
+			WARN("Block comments use * on subsequent lines\n" . $hereprev);
+		}
+
+# Block comments use */ on trailing lines
+		if ($rawline !~ m@^\+[ \t]*\*/[ \t]*$@ &&	#trailing */
+		    $rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&	#inline /*...*/
+		    $rawline !~ m@^\+.*\*{2,}/[ \t]*$@ &&	#trailing **/
+		    $rawline =~ m@^\+[ \t]*.+\*\/[ \t]*$@) {	#non blank */
+			WARN("Block comments use a trailing */ on a separate line\n" . $herecurr);
+		}
+
+# Block comment * alignment
+		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
+		    $line =~ /^\+[ \t]*$;/ &&			#leading comment
+		    $rawline =~ /^\+[ \t]*\*/ &&		#leading *
+		    (($prevrawline =~ /^\+.*?\/\*/ &&		#leading /*
+		      $prevrawline !~ /\*\/[ \t]*$/) ||		#no trailing */
+		     $prevrawline =~ /^\+[ \t]*\*/)) {		#leading *
+			my $oldindent;
+			$prevrawline =~ m@^\+([ \t]*/?)\*@;
+			if (defined($1)) {
+				$oldindent = expand_tabs($1);
+			} else {
+				$prevrawline =~ m@^\+(.*/?)\*@;
+				$oldindent = expand_tabs($1);
+			}
+			$rawline =~ m@^\+([ \t]*)\*@;
+			my $newindent = $1;
+			$newindent = expand_tabs($newindent);
+			if (length($oldindent) ne length($newindent)) {
+				WARN("Block comments should align the * on each line\n" . $hereprev);
+			}
+		}
+
 # Check for potential 'bare' types
 		my ($stat, $cond, $line_nr_next, $remain_next, $off_next,
 		    $realline_next);
-- 
2.19.2
