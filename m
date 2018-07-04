Received: from eggs.gnu.org ([2001:4830:134:3::10]:37247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fakOC-00015m-4r
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fakO7-0004rt-Gj
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:12:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54768 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fakO7-0004rb-B7
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:12:15 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  4 Jul 2018 18:12:13 +0200
Message-Id: <20180704161213.30687-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] checkpatch: handle token pasting better
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com

The mechanism to find possible type tokens can sometimes be confused and go into an
infinite loop.  This happens for example in QEMU for a line that looks like

         uint## BITS ##_t S = _S, T = _T;                            \
         uint## BITS ##_t as, at, xs, xt, xd;                        \

Because the token pasting operator does not have a space before _t, it does not
match $notPermitted.  However, (?x) is turned on in the regular expression for
modifiers, and thus ##_t matches the empty string.  As a result, annotate_values
goes in an infinite loop.

The solution is simply to remove token pasting operators from the string before
looking for modifiers.  In the example above, the string uintBITS_t will be
evaluated as a candidate modifier.  This is not optimal, but it works as long
as people do not write things like a##s##m, and it fits nicely into sub
possible.

For a similar reason, \# should be rejected always, even if it is not
at end of line or followed by whitespace.

The same patch was sent to the Linux kernel mailing list.

Reported-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 223681bfd0..42e1c50dd8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1132,11 +1132,10 @@ sub possible {
 			case|
 			else|
 			asm|__asm__|
-			do|
-			\#|
-			\#\#
+			do
 		)(?:\s|$)|
-		^(?:typedef|struct|enum)\b
+		^(?:typedef|struct|enum)\b|
+		^\#
 	    )}x;
 	warn "CHECK<$possible> ($line)\n" if ($dbg_possible > 2);
 	if ($possible !~ $notPermitted) {
@@ -1146,7 +1145,7 @@ sub possible {
 		if ($possible =~ /^\s*$/) {
 
 		} elsif ($possible =~ /\s/) {
-			$possible =~ s/\s*$Type\s*//g;
+			$possible =~ s/\s*(?:$Type|\#\#)\s*//g;
 			for my $modifier (split(' ', $possible)) {
 				if ($modifier !~ $notPermitted) {
 					warn "MODIFIER: $modifier ($possible) ($line)\n" if ($dbg_possible);
-- 
2.17.1
