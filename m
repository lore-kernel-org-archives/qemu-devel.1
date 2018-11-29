Received: from eggs.gnu.org ([2001:4830:134:3::10]:54076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSICO-0002A9-Gs
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSICN-0002sT-J6
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:01:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSICN-0002rZ-Au
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:01:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B149D3154871
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 09:01:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Nov 2018 10:01:19 +0100
Message-Id: <20181129090120.28828-4-pbonzini@redhat.com>
In-Reply-To: <20181129090120.28828-1-pbonzini@redhat.com>
References: <20181129090120.28828-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 3/4] checkpatch: improve handling of
 multiple patches or files
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
index c216c55e01..f5284d910c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -340,13 +340,18 @@ my @lines =3D ();
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
@@ -354,21 +359,31 @@ if ($chk_branch) {
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
@@ -387,6 +402,7 @@ if ($chk_branch) {
 		} else {
 			$vname =3D $filename;
 		}
+		print "Checking $filename...\n" if @ARGV > 1 && $quiet =3D=3D 0;
 		while (<$FILE>) {
 			chomp;
 			push(@rawlines, $_);
--=20
2.19.1
