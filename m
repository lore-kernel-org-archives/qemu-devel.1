Received: from eggs.gnu.org ([2001:4830:134:3::10]:35650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxs-0003If-3R
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxp-0001wG-Gf
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:04 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:46844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qxp-0001va-Ag
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:01 -0400
Received: by mail-wm0-x244.google.com with SMTP id m72so10990723wmc.1
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:01 -0700 (PDT)
Received: from 640k.lan (94-39-155-245.adsl-ull.clienti.tiscali.it.
	[94.39.155.245])
	by smtp.gmail.com with ESMTPSA id 69sm13436794wmm.2.2017.10.18.09.12.57
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Oct 2017 09:12:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:11:53 +0200
Message-Id: <1508343141-31835-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/29] checkpatch: refine mode selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

stgit produces patch files that lack the ".patch" extensions.  Others
might be using ".diff" too.  But since we are already limiting source files
to only a handful of extensions, we can reuse that in the mode selection
code.

While at it, do not match "../foo" as a branch name.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0c41f12..ce9f08e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -11,6 +11,8 @@ use warnings;
 my $P = $0;
 $P =~ s@.*/@@g;
 
+our $SrcFile    = qr{\.(?:h|c|cpp|s|S|pl|py|sh)$};
+
 my $V = '0.31';
 
 use Getopt::Long qw(:config no_auto_abbrev);
@@ -101,30 +103,29 @@ if ($#ARGV < 0) {
 }
 
 if (!defined $chk_branch && !defined $chk_patch && !defined $file) {
-	$chk_branch = $ARGV[0] =~ /\.\./ ? 1 : 0;
-	$chk_patch = $chk_branch ? 0 :
-		$ARGV[0] =~ /\.patch$/ || $ARGV[0] eq "-" ? 1 : 0;
-	$file = $chk_branch || $chk_patch ? 0 : 1;
+	$chk_branch = $ARGV[0] =~ /.\.\./ ? 1 : 0;
+	$file = $ARGV[0] =~ /$SrcFile/ ? 1 : 0;
+	$chk_patch = $chk_branch || $file ? 0 : 1;
 } elsif (!defined $chk_branch && !defined $chk_patch) {
 	if ($file) {
 		$chk_branch = $chk_patch = 0;
 	} else {
-		$chk_branch = $ARGV[0] =~ /\.\./ ? 1 : 0;
+		$chk_branch = $ARGV[0] =~ /.\.\./ ? 1 : 0;
 		$chk_patch = $chk_branch ? 0 : 1;
 	}
 } elsif (!defined $chk_branch && !defined $file) {
 	if ($chk_patch) {
 		$chk_branch = $file = 0;
 	} else {
-		$chk_branch = $ARGV[0] =~ /\.\./ ? 1 : 0;
+		$chk_branch = $ARGV[0] =~ /.\.\./ ? 1 : 0;
 		$file = $chk_branch ? 0 : 1;
 	}
 } elsif (!defined $chk_patch && !defined $file) {
 	if ($chk_branch) {
 		$chk_patch = $file = 0;
 	} else {
-		$chk_patch = $ARGV[0] =~ /\.patch$/ || $ARGV[0] eq "-" ? 1 : 0;
-		$file = $chk_patch ? 0 : 1;
+		$file = $ARGV[0] =~ /$SrcFile/ ? 1 : 0;
+		$chk_patch = $file ? 0 : 1;
 	}
 } elsif (!defined $chk_branch) {
 	$chk_branch = $chk_patch || $file ? 0 : 1;
@@ -1443,7 +1444,7 @@ sub process {
 		}
 
 # check we are in a valid source file if not then ignore this hunk
-		next if ($realfile !~ /\.(h|c|cpp|s|S|pl|py|sh)$/);
+		next if ($realfile !~ /$SrcFile/);
 
 #90 column limit
 		if ($line =~ /^\+/ &&
-- 
1.8.3.1
