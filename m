Received: from eggs.gnu.org ([209.51.188.92]:43476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkXM9-00088b-By
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkXM8-0006ep-6x
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:50:57 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:36032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkXM8-0006bw-0O
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:50:56 -0500
Received: by mail-wr1-x42b.google.com with SMTP id u4so15875764wrp.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 08:50:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 16:50:50 +0000
Message-Id: <20190118165050.22270-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] checkpatch: Don't emit spurious warnings
 about block comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>

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

The other end of the regex is also wrong: it is attempting
to check for "/* or /** followed by something that isn't
just whitespace", but [ \t]*.+[ \t]* will match on pure
whitespace. This is less significant but means that a line
with just a comment-starter followed by trailing whitespace
will generate an incorrect warning about block comment style
as well as the correct error about trailing whitespace which
a different checkpatch test emits.

Reported-by: Thomas Huth <thuth@redhat.com>
Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This comment check is unique to QEMU checkpatch so the bugs
don't exist in the Linux version.

v1->v2 changes: Add the fix to the other end of the regex
pointed out by Eric, so that we don't emit spurious warnings
for block comment starters with trailing whitespace.

---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d10dddf1be4..88682cb0a9f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1624,7 +1624,7 @@ sub process {
 
 		# Block comments use /* on a line of its own
 		if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&	#inline /*...*/
-		    $rawline =~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-blank
+		    $rawline =~ m@^\+.*/\*\*?+[ \t]*[^ \t]@) { # /* or /** non-blank
 			WARN("Block comments use a leading /* on a separate line\n" . $herecurr);
 		}
 
-- 
2.20.1
