Received: from eggs.gnu.org ([2001:4830:134:3::10]:52090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MR-0000hG-3q
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MO-00007S-Hh
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:42 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MK-0008L9-PW
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:38 -0500
Received: by mail-wr1-x443.google.com with SMTP id q18so18081112wrx.9
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:24 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:26 +0100
Message-Id: <1544628195-37728-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/54] checkpatch: improve handling of multiple
 patches or files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Similar to how patchew output looks like for multiple patches,
say what file or patch is being tested _before_ emitting errors.
This is clearer to a human that scans the output from top to
bottom.

In addition, provide a truncated commit hash and subject instead of
the full hash, and process the commits first-to-last rather than
last-to-first.

Inspired by Linux commit 0dea9f1eef86bedacad91b6f652ca1ab0d08854c
("checkpatch: reduce number of `git log` calls with --git", 2016-03-20).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 506aa6c..2edb4e2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -340,13 +340,18 @@ my @lines = ();
 my $vname;
 if ($chk_branch) {
 	my @patches;
+	my %git_commits = ();
 	my $HASH;
-	open($HASH, "-|", "git", "log", "--format=%H", $ARGV[0]) ||
-		die "$P: git log --format=%H $ARGV[0] failed - $!\n";
-
-	while (<$HASH>) {
-		chomp;
-		push @patches, $_;
+	open($HASH, "-|", "git", "log", "--reverse", "--no-merges", "--format=%H %s", $ARGV[0]) ||
+		die "$P: git log --reverse --no-merges --format='%H %s' $ARGV[0] failed - $!\n";
+
+	for my $line (<$HASH>) {
+		$line =~ /^([0-9a-fA-F]{40,40}) (.*)$/;
+		next if (!defined($1) || !defined($2));
+		my $sha1 = $1;
+		my $subject = $2;
+		push(@patches, $sha1);
+		$git_commits{$sha1} = $subject;
 	}
 
 	close $HASH;
@@ -354,21 +359,31 @@ if ($chk_branch) {
 	die "$P: no revisions returned for revlist '$chk_branch'\n"
 	    unless @patches;
 
+	my $i = 1;
+	my $num_patches = @patches;
 	for my $hash (@patches) {
 		my $FILE;
 		open($FILE, '-|', "git", "show", $hash) ||
 			die "$P: git show $hash - $!\n";
-		$vname = $hash;
 		while (<$FILE>) {
 			chomp;
 			push(@rawlines, $_);
 		}
 		close($FILE);
+		$vname = substr($hash, 0, 12) . ' (' . $git_commits{$hash} . ')';
+		if ($num_patches > 1 && $quiet == 0) {
+			print "$i/$num_patches Checking commit $vname\n";
+			$vname = "Patch $i/$num_patches";
+		} else {
+			$vname = "Commit " . $vname;
+		}
 		if (!process($hash)) {
 			$exit = 1;
+			print "\n" if ($num_patches > 1 && $quiet == 0);
 		}
 		@rawlines = ();
 		@lines = ();
+		$i++;
 	}
 } else {
 	for my $filename (@ARGV) {
@@ -387,6 +402,7 @@ if ($chk_branch) {
 		} else {
 			$vname = $filename;
 		}
+		print "Checking $filename...\n" if @ARGV > 1 && $quiet == 0;
 		while (<$FILE>) {
 			chomp;
 			push(@rawlines, $_);
-- 
1.8.3.1
