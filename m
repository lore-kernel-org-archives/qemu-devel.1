Received: from eggs.gnu.org ([209.51.188.92]:41147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNc-00038Y-NV
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNb-0000WU-QI
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:32 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:44061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBNU-0000DJ-FQ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:26 -0500
Received: by mail-wr1-x433.google.com with SMTP id z5so19119715wrt.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.11.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:37 +0000
Message-Id: <20190128181047.20781-17-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/26] checkpatch: Don't emit spurious warnings
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

Fixes: 8c06fbdf36bf4d ("scripts/checkpatch.pl: Enforce multiline comment syntax")
Reported-by: Thomas Huth <thuth@redhat.com>
Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20190118165050.22270-1-peter.maydell@linaro.org
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
