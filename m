Received: from eggs.gnu.org ([2001:4830:134:3::10]:33940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1droPb-0002nt-EL
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1droPY-0007qc-56
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1droPX-0007q6-TX
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:51:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E748C5F7A9
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 16:51:42 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 17:51:39 +0100
Message-Id: <20170912165139.16212-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2] scripts: let checkpatch.pl process an
 entire GIT branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Currently before submitting a series, devs should run checkpatch.pl
across each patch to be submitted. This can be automated using a
command such as:

  git rebase -i master -x 'git show | ./scripts/checkpatch.pl -'

This is rather long winded to type, so this patch introduces a way
to tell checkpatch.pl to validate a series of GIT revisions.

If checkpatch.pl is given a single argument that contains a literal
'..', this is interpreted as a GIT revision list.

For example:

    $ ./scripts/checkpatch.pl master..
    total: 0 errors, 0 warnings, 297 lines checked

    b886d352a2bf58f0996471fb3991a138373a2957 has no obvious style problems and is ready for submission.
    total: 0 errors, 0 warnings, 182 lines checked

    2a731f9a9ce145e0e0df6d42dd2a3ce4dfc543fa has no obvious style problems and is ready for submission.
    total: 0 errors, 0 warnings, 102 lines checked

    11844169bcc0c8ed4449eb3744a69877ed329dd7 has no obvious style problems and is ready for submission.

If a genuine patch filename contains the characters '..' it is
possible to force interpretation of the arg as a patch

  $ ./scripts/checkpatch.pl --patch master..

will force it to load a patch file called "master.."

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/checkpatch.pl | 102 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 25 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fa478074b8..213777d488 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -18,7 +18,8 @@ use Getopt::Long qw(:config no_auto_abbrev);
 my $quiet = 0;
 my $tree = 1;
 my $chk_signoff = 1;
-my $chk_patch = 1;
+my $chk_patch = undef;
+my $chk_branch = undef;
 my $tst_only;
 my $emacs = 0;
 my $terse = 0;
@@ -35,7 +36,11 @@ sub help {
 	my ($exitcode) = @_;
 
 	print << "EOM";
-Usage: $P [OPTION]... [FILE]...
+Usage:
+
+    $P [OPTION]... [FILE]...
+    $P [OPTION]... [GIT-REV-LIST]
+
 Version: $V
 
 Options:
@@ -88,6 +93,19 @@ help(0) if ($help);
 
 my $exit = 0;
 
+if (!defined $chk_patch) {
+    if (!$file) {
+	if ($#ARGV == 0 && $ARGV[0] =~ /\.\./) {
+	    $chk_branch = $ARGV[0];
+	    $chk_patch = 0;
+	} else {
+	    $chk_patch = 1;
+	}
+    } else {
+	$chk_patch = 0;
+    }
+}
+
 if ($#ARGV < 0) {
 	print "$P: no input files\n";
 	exit(1);
@@ -251,32 +269,66 @@ $chk_signoff = 0 if ($file);
 my @rawlines = ();
 my @lines = ();
 my $vname;
-for my $filename (@ARGV) {
-	my $FILE;
-	if ($file) {
-		open($FILE, '-|', "diff -u /dev/null $filename") ||
-			die "$P: $filename: diff failed - $!\n";
-	} elsif ($filename eq '-') {
-		open($FILE, '<&STDIN');
-	} else {
-		open($FILE, '<', "$filename") ||
-			die "$P: $filename: open failed - $!\n";
-	}
-	if ($filename eq '-') {
-		$vname = 'Your patch';
-	} else {
-		$vname = $filename;
-	}
-	while (<$FILE>) {
+if ($chk_branch) {
+	my @patches;
+	my $HASH;
+	open($HASH, "-|", "git", "log", "--format=%H", $chk_branch) ||
+		die "$P: git log --format=%H $chk_branch failed - $!\n";
+
+	while (<$HASH>) {
 		chomp;
-		push(@rawlines, $_);
+		push @patches, $_;
 	}
-	close($FILE);
-	if (!process($filename)) {
-		$exit = 1;
+
+	close $HASH;
+
+	die "$P: no revisions returned for revlist '$chk_branch'\n"
+	    unless @patches;
+
+	for my $hash (@patches) {
+		my $FILE;
+		open($FILE, '-|', "git", "show", $hash) ||
+			die "$P: git show $hash - $!\n";
+		$vname = $hash;
+		while (<$FILE>) {
+			chomp;
+			push(@rawlines, $_);
+		}
+		close($FILE);
+		if (!process($hash)) {
+			$exit = 1;
+		}
+		@rawlines = ();
+		@lines = ();
+	}
+} else {
+	for my $filename (@ARGV) {
+		my $FILE;
+		if ($file) {
+			open($FILE, '-|', "diff -u /dev/null $filename") ||
+				die "$P: $filename: diff failed - $!\n";
+		} elsif ($filename eq '-') {
+			open($FILE, '<&STDIN');
+		} else {
+			open($FILE, '<', "$filename") ||
+				die "$P: $filename: open failed - $!\n";
+		}
+		if ($filename eq '-') {
+			$vname = 'Your patch';
+		} else {
+			$vname = $filename;
+		}
+		while (<$FILE>) {
+			chomp;
+			push(@rawlines, $_);
+		}
+		close($FILE);
+		if (!process($filename)) {
+			$exit = 1;
+		}
+		@rawlines = ();
+		@lines = ();
 	}
-	@rawlines = ();
-	@lines = ();
 }
 
 exit($exit);
-- 
2.13.5
