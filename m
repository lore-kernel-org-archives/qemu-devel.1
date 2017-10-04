Received: from eggs.gnu.org ([2001:4830:134:3::10]:35629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dzkOP-00078J-9l
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dzkOL-0002K3-7C
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:11:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dzkOK-0002IH-UL
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:11:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42743780E4
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 14:11:15 +0000 (UTC)
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
	<1505824179-21541-45-git-send-email-pbonzini@redhat.com>
	<20171003160706.2671a6ea@t450s.home>
	<20171004083329.GB17517@redhat.com>
	<20171004071735.66f20b86@t450s.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4141ed57-05be-b60e-d66f-dd5fe08a2ac2@redhat.com>
Date: Wed, 4 Oct 2017 16:11:07 +0200
MIME-Version: 1.0
In-Reply-To: <20171004071735.66f20b86@t450s.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 44/50] scripts: let checkpatch.pl process an
 entire GIT branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On 04/10/2017 15:17, Alex Williamson wrote:
> Yes, it works with the new --patch option.  I use stgit which does
> not add a filename extension to the patch name on export, nor have I
> ever known patch files to have any accepted standard file extension.
> checkpatch.pl has always assumed it's operating on a patch file, as
> implied by the name of the script, with an option to check regular
> files.  I'd suggest maintaining behavior consistent with the script name
> using more comprehensive heuristics than a non-standard file extension.
> Thanks,

We are already limiting source files to only a handful of extensions, 
perhaps we can reuse that in the DWIM mode selection code.  While at it,
do not match "../foo" as a branch name:

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3c0a28e644..9eca0f8458 100755
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
@@ -1442,7 +1443,7 @@ sub process {
 		}
 
 # check we are in a valid source file if not then ignore this hunk
-		next if ($realfile !~ /\.(h|c|cpp|s|S|pl|py|sh)$/);
+		next if ($realfile !~ /$SrcFile/);
 
 #90 column limit
 		if ($line =~ /^\+/ &&

Paolo
