Received: from eggs.gnu.org ([2001:4830:134:3::10]:60888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3x-0001Ap-9K
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3n-0005er-M3
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:20 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3m-0005S1-KG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id k5-v6so4942221wre.10
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:10 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:37 +0200
Message-Id: <1534870966-9287-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/74] checkpatch: fix filename detection when
 using -f
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Fix $realfile filename when using -f/--file to not remove first level
directory as if the filename was used in a -P1 patch.  Only strip the
first level directory (typically a or b) for P1 patches.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(extracted from Linux commit 2b7ab45395dc4d91ef30985f76d90a8f28f58c27)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 42e1c50..0553634 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1367,10 +1367,10 @@ sub process {
 		# extract the filename as it passes
 		if ($line =~ /^diff --git.*?(\S+)$/) {
 			$realfile = $1;
-			$realfile =~ s@^([^/]*)/@@;
+			$realfile =~ s@^([^/]*)/@@ if (!$file);
 		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
 			$realfile = $1;
-			$realfile =~ s@^([^/]*)/@@;
+			$realfile =~ s@^([^/]*)/@@ if (!$file);
 
 			$p1_prefix = $1;
 			if (!$file && $tree && $p1_prefix ne '' &&
-- 
1.8.3.1
