Received: from eggs.gnu.org ([2001:4830:134:3::10]:55459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZddF-0005iQ-Ti
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZddC-0003vQ-J2
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:19:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZddC-0003um-BT
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:19:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C2A463647
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:19:29 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-76.ams2.redhat.com
	[10.36.112.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0C7B17197
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:19:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Dec 2018 16:18:47 +0100
Message-Id: <20181219151917.3874-6-pbonzini@redhat.com>
In-Reply-To: <20181219151917.3874-1-pbonzini@redhat.com>
References: <20181219151917.3874-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/35] checkpatch: improve handling of multiple
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
index 42e782a656..b8e78d51c2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -339,13 +339,18 @@ my @lines =3D ();
 my $vname;
 if ($chk_branch) {
 	my @patches;
+	my %git_commits =3D ();
 	my $HASH;
-	open($HASH, "-|", "git", "log", "--format=3D%H", $ARGV[0]) ||
-		die "$P: git log --format=3D%H $ARGV[0] failed - $!\n";
-
-	while (<$HASH>) {
-		chomp;
-		push @patches, $_;
+	open($HASH, "-|", "git", "log", "--reverse", "--no-merges", "--format=3D=
%H %s", $ARGV[0]) ||
+		die "$P: git log --reverse --no-merges --format=3D'%H %s' $ARGV[0] fai=
led - $!\n";
+
+	for my $line (<$HASH>) {
+		$line =3D~ /^([0-9a-fA-F]{40,40}) (.*)$/;
+		next if (!defined($1) || !defined($2));
+		my $sha1 =3D $1;
+		my $subject =3D $2;
+		push(@patches, $sha1);
+		$git_commits{$sha1} =3D $subject;
 	}
=20
 	close $HASH;
@@ -353,21 +358,31 @@ if ($chk_branch) {
 	die "$P: no revisions returned for revlist '$chk_branch'\n"
 	    unless @patches;
=20
+	my $i =3D 1;
+	my $num_patches =3D @patches;
 	for my $hash (@patches) {
 		my $FILE;
 		open($FILE, '-|', "git", "show", $hash) ||
 			die "$P: git show $hash - $!\n";
-		$vname =3D $hash;
 		while (<$FILE>) {
 			chomp;
 			push(@rawlines, $_);
 		}
 		close($FILE);
+		$vname =3D substr($hash, 0, 12) . ' (' . $git_commits{$hash} . ')';
+		if ($num_patches > 1 && $quiet =3D=3D 0) {
+			print "$i/$num_patches Checking commit $vname\n";
+			$vname =3D "Patch $i/$num_patches";
+		} else {
+			$vname =3D "Commit " . $vname;
+		}
 		if (!process($hash)) {
 			$exit =3D 1;
+			print "\n" if ($num_patches > 1 && $quiet =3D=3D 0);
 		}
 		@rawlines =3D ();
 		@lines =3D ();
+		$i++;
 	}
 } else {
 	for my $filename (@ARGV) {
@@ -386,6 +401,7 @@ if ($chk_branch) {
 		} else {
 			$vname =3D $filename;
 		}
+		print "Checking $filename...\n" if @ARGV > 1 && $quiet =3D=3D 0;
 		while (<$FILE>) {
 			chomp;
 			push(@rawlines, $_);
--=20
2.20.1
