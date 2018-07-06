Received: from eggs.gnu.org ([2001:4830:134:3::10]:51119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK7-0001JA-Jh
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK6-0000qf-Ip
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:11 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fbUK6-0000oR-By
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:10 -0400
Received: by mail-wm0-x243.google.com with SMTP id b188-v6so15570719wme.3
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 10:15:10 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	h40-v6sm13784683wrf.40.2018.07.06.10.15.08
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 06 Jul 2018 10:15:08 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Jul 2018 19:14:28 +0200
Message-Id: <1530897268-22932-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
References: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] checkpatch: handle token pasting better
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
index 223681b..42e1c50 100755
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
1.8.3.1
