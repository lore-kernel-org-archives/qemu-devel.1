Received: from eggs.gnu.org ([2001:4830:134:3::10]:56655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhye-0004wW-Uu
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhye-0007Nn-0N
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:20 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:41770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyd-0007NS-Oy
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:19 -0500
Received: by mail-wm0-x242.google.com with SMTP id g75so11359434wme.0
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:19 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:52 +0100
Message-Id: <1513790098-9815-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 40/46] checkpatch: volatile with a comment or
 sig_atomic_t is okay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This assumes that the comment gives some justification;
"volatile sig_atomic_t" is also self-explanatory and usually
correct.

Discussed in:
'[Qemu-devel] [PATCH] dump-guest-memory.py: fix "You can't do that without a process to debug"'

Suggested-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20171215181810.4122-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 34df753..3dc27d9 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2475,8 +2475,11 @@ sub process {
 
 # no volatiles please
 		my $asm_volatile = qr{\b(__asm__|asm)\s+(__volatile__|volatile)\b};
-		if ($line =~ /\bvolatile\b/ && $line !~ /$asm_volatile/) {
-			ERROR("Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt\n" . $herecurr);
+		if ($line =~ /\bvolatile\b/ && $line !~ /$asm_volatile/ &&
+                    $line !~ /sig_atomic_t/ &&
+                    !ctx_has_comment($first_line, $linenr)) {
+			my $msg = "Use of volatile is usually wrong, please add a comment\n" . $herecurr;
+                        ERROR($msg);
 		}
 
 # warn about #if 0
-- 
1.8.3.1
