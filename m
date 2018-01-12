Received: from eggs.gnu.org ([2001:4830:134:3::10]:42051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZH-0007w8-8d
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZG-00060J-HD
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:15 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:42373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZG-0005z8-BH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:14 -0500
Received: by mail-wm0-x242.google.com with SMTP id b141so11528484wme.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:10 +0100
Message-Id: <1515756676-3860-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 46/52] checkpatch: Enforce proper do/while (0)
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

From: Eric Blake <eblake@redhat.com>

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
Message-Id: <20171201232433.25193-8-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3dc27d9..accba24 100755
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
1.8.3.1
