Received: from eggs.gnu.org ([209.51.188.92]:46175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkUBg-0006cF-6d
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkUBf-0008L6-E7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:27:56 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkUBe-0008IB-DL
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:27:55 -0500
Received: by mail-wr1-x444.google.com with SMTP id l9so14988284wrt.13
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 05:27:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 13:27:50 +0000
Message-Id: <20190118132750.25932-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] checkpatch: Don't spuriously warn about /**
 comment starters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Reported-by : Thomas Huth" <thuth@redhat.com>

In checkpatch we attempt to check for and warn about
block comments which start with /* or /** followed by a
non-blank. Unfortunately a bug in the regex meant that
we would incorrectly warn about comments starting with
"/**" with no following text:

  git show 9813dc6ac3954d58ba16b3920556f106f97e1c67|./scripts/checkpatch.pl -
  WARNING: Block comments use a leading /* on a separate line
  #34: FILE: tests/libqtest.h:233:
  +/**

The sequence "/\*\*?" was intended to match either "/*" or "/**",
but Perl's semantics for '?' allow it to backtrack and try the
"matches 0 chars" option if the "matches 1 char" choice leads to
a failure of the rest of the regex to match.  Switch to "/\*\*?+"
which uses what perlre(1) calls the "possessive" quantifier form:
this means that if it matches the "/**" string it will not later
backtrack to matching just the "/*" prefix.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This comment check is unique to QEMU checkpatch so the bug
doesn't exist in the Linux version.
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d10dddf1be4..5f1ec537d21 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1624,7 +1624,7 @@ sub process {
 
 		# Block comments use /* on a line of its own
 		if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&	#inline /*...*/
-		    $rawline =~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-blank
+		    $rawline =~ m@^\+.*/\*\*?+[ \t]*.+[ \t]*$@) { # /* or /** non-blank
 			WARN("Block comments use a leading /* on a separate line\n" . $herecurr);
 		}
 
-- 
2.20.1
