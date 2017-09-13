Received: from eggs.gnu.org ([2001:4830:134:3::10]:37010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ds3gR-0006Aa-5h
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ds3gM-00038Z-Sr
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:10:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ds3gM-00037J-Jh
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:10:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 176934ACCA
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:10:05 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 13 Sep 2017 10:10:00 +0100
Message-Id: <20170913091000.9005-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3] scripts: let checkpatch.pl process an
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

There are now three modes it can operate in 1) check a patch 2) check a source
file, or 3) check a git branch.

If no flags are given, the mode is determined by checking the args passed to
the command. If the args contain a literal ".." it is treated as a GIT revision
list. If the args end in ".patch" or equal "-" it is treated as a patch file.
Otherwise it is treated as a source file.

This automatic guessing can be overridden using --[no-]patch --[no-]file or
--[no-]branch

For example to check a GIT revision list:

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

will force it to load a patch file called "master..", or equivalently

  $ ./scripts/checkpatch.pl --no-branch master..

will simply turn off guessing of GIT revision lists.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---

Changed in v3:

 - Re-add --branch/--no-branch arg
 - Refactor default arg type guessing to fully consider the matrix of
   possible --[no-]branch, --[no-]patch, --[no-]file arg values

 scripts/checkpatch.pl | 138 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 111 insertions(+), 27 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fa478074b8..28d71b3733 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -18,11 +18,12 @@ use Getopt::Long qw(:config no_auto_abbrev);
 my $quiet = 0;
 my $tree = 1;
 my $chk_signoff = 1;
-my $chk_patch = 1;
+my $chk_patch = undef;
+my $chk_branch = undef;
 my $tst_only;
 my $emacs = 0;
 my $terse = 0;
-my $file = 0;
+my $file = undef;
 my $no_warnings = 0;
 my $summary = 1;
 my $mailback = 0;
@@ -35,14 +36,19 @@ sub help {
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
   -q, --quiet                quiet
   --no-tree                  run without a kernel tree
   --no-signoff               do not check for 'Signed-off-by' line
-  --patch                    treat FILE as patchfile (default)
+  --patch                    treat FILE as patchfile
+  --branch                   treat args as GIT revision list
   --emacs                    emacs compile window format
   --terse                    one line per report
   -f, --file                 treat FILE as regular source file
@@ -69,6 +75,7 @@ GetOptions(
 	'tree!'		=> \$tree,
 	'signoff!'	=> \$chk_signoff,
 	'patch!'	=> \$chk_patch,
+	'branch!'	=> \$chk_branch,
 	'emacs!'	=> \$emacs,
 	'terse!'	=> \$terse,
 	'f|file!'	=> \$file,
@@ -93,6 +100,49 @@ if ($#ARGV < 0) {
 	exit(1);
 }
 
+if (!defined $chk_branch && !defined $chk_patch && !defined $file) {
+	$chk_branch = $ARGV[0] =~ /\.\./ ? 1 : 0;
+	$chk_patch = $chk_branch ? 0 :
+		$ARGV[0] =~ /\.patch$/ || $ARGV[0] eq "-" ? 1 : 0;
+	$file = $chk_branch || $chk_patch ? 0 : 1;
+} elsif (!defined $chk_branch && !defined $chk_patch) {
+	if ($file) {
+		$chk_branch = $chk_patch = 0;
+	} else {
+		$chk_branch = $ARGV[0] =~ /\.\./ ? 1 : 0;
+		$chk_patch = $chk_branch ? 0 : 1;
+	}
+} elsif (!defined $chk_branch && !defined $file) {
+	if ($chk_patch) {
+		$chk_branch = $file = 0;
+	} else {
+		$chk_branch = $ARGV[0] =~ /\.\./ ? 1 : 0;
+		$file = $chk_branch ? 0 : 1;
+	}
+} elsif (!defined $chk_patch && !defined $file) {
+	if ($chk_branch) {
+		$chk_patch = $file = 0;
+	} else {
+		$chk_patch = $ARGV[0] =~ /\.patch$/ || $ARGV[0] eq "-" ? 1 : 0;
+		$file = $chk_patch ? 0 : 1;
+	}
+} elsif (!defined $chk_branch) {
+	$chk_branch = $chk_patch || $file ? 0 : 1;
+} elsif (!defined $chk_patch) {
+	$chk_patch = $chk_branch || $file ? 0 : 1;
+} elsif (!defined $file) {
+	$file = $chk_patch || $chk_branch ? 0 : 1;
+}
+
+if (($chk_patch && $chk_branch) ||
+    ($chk_patch && $file) ||
+    ($chk_branch && $file)) {
+	die "Only one of --file, --branch, --patch is permitted\n";
+}
+if (!$chk_patch && !$chk_branch && !$file) {
+	die "One of --file, --branch, --patch is required\n";
+}
+
 my $dbg_values = 0;
 my $dbg_possible = 0;
 my $dbg_type = 0;
@@ -251,32 +301,66 @@ $chk_signoff = 0 if ($file);
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
+	open($HASH, "-|", "git", "log", "--format=%H", $ARGV[0]) ||
+		die "$P: git log --format=%H $ARGV[0] failed - $!\n";
+
+	while (<$HASH>) {
 		chomp;
-		push(@rawlines, $_);
+		push @patches, $_;
+	}
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
 	}
-	close($FILE);
-	if (!process($filename)) {
-		$exit = 1;
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
