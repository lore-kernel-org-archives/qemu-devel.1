Received: from eggs.gnu.org ([2001:4830:134:3::10]:43057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28Y-0000I2-KS
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28W-0003Gf-RR
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ28W-0003GH-Is
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:20 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:31 +0100
Message-Id: <20181217231700.24482-7-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/35] checkpatch: colorize output to terminal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Add optional colors to make seeing message types a bit easier.
The default is to show them on a tty.

Inspired by Linux commits 57230297116fa ("checkpatch: colorize output
to terminal") and 737c0767758b ("checkpatch: change format of --color
argument to --color[=3DWHEN]").

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 scripts/checkpatch.pl | 49 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2184a481ac..df2da09b06 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7,6 +7,7 @@
=20
 use strict;
 use warnings;
+use Term::ANSIColor qw(:constants);
=20
 my $P =3D $0;
 $P =3D~ s@.*/@@g;
@@ -26,6 +27,7 @@ my $tst_only;
 my $emacs =3D 0;
 my $terse =3D 0;
 my $file =3D undef;
+my $color =3D "auto";
 my $no_warnings =3D 0;
 my $summary =3D 1;
 my $mailback =3D 0;
@@ -64,6 +66,8 @@ Options:
                              is all off)
   --test-only=3DWORD           report only warnings/errors containing WO=
RD
                              literally
+  --color[=3DWHEN]             Use colors 'always', 'never', or only whe=
n output
+                             is a terminal ('auto'). Default is 'auto'.
   -h, --help, --version      display this help and exit
=20
 When FILE is - read standard input.
@@ -72,6 +76,14 @@ EOM
 	exit($exitcode);
 }
=20
+# Perl's Getopt::Long allows options to take optional arguments after a =
space.
+# Prevent --color by itself from consuming other arguments
+foreach (@ARGV) {
+	if ($_ eq "--color" || $_ eq "-color") {
+		$_ =3D "--color=3D$color";
+	}
+}
+
 GetOptions(
 	'q|quiet+'	=3D> \$quiet,
 	'tree!'		=3D> \$tree,
@@ -89,6 +101,8 @@ GetOptions(
=20
 	'debug=3Ds'	=3D> \%debug,
 	'test-only=3Ds'	=3D> \$tst_only,
+	'color=3Ds'       =3D> \$color,
+	'no-color'      =3D> sub { $color =3D 'never'; },
 	'h|help'	=3D> \$help,
 	'version'	=3D> \$help
 ) or help(1);
@@ -144,6 +158,16 @@ if (!$chk_patch && !$chk_branch && !$file) {
 	die "One of --file, --branch, --patch is required\n";
 }
=20
+if ($color =3D~ /^always$/i) {
+	$color =3D 1;
+} elsif ($color =3D~ /^never$/i) {
+	$color =3D 0;
+} elsif ($color =3D~ /^auto$/i) {
+	$color =3D (-t STDOUT);
+} else {
+	die "Invalid color mode: $color\n";
+}
+
 my $dbg_values =3D 0;
 my $dbg_possible =3D 0;
 my $dbg_type =3D 0;
@@ -371,7 +395,9 @@ if ($chk_branch) {
 		close($FILE);
 		$vname =3D substr($hash, 0, 12) . ' (' . $git_commits{$hash} . ')';
 		if ($num_patches > 1 && $quiet =3D=3D 0) {
-			print "$i/$num_patches Checking commit $vname\n";
+			my $prefix =3D "$i/$num_patches";
+			$prefix =3D BLUE . BOLD . $prefix . RESET if $color;
+			print "$prefix Checking commit $vname\n";
 			$vname =3D "Patch $i/$num_patches";
 		} else {
 			$vname =3D "Commit " . $vname;
@@ -1181,14 +1207,23 @@ sub possible {
 my $prefix =3D '';
=20
 sub report {
-	if (defined $tst_only && $_[0] !~ /\Q$tst_only\E/) {
+	my ($level, $msg) =3D @_;
+	if (defined $tst_only && $msg !~ /\Q$tst_only\E/) {
 		return 0;
 	}
-	my $line =3D $prefix . $_[0];
=20
-	$line =3D (split('\n', $line))[0] . "\n" if ($terse);
+	my $output =3D '';
+	$output .=3D BOLD if $color;
+	$output .=3D $prefix;
+	$output .=3D RED if $color && $level eq 'ERROR';
+	$output .=3D MAGENTA if $color && $level eq 'WARNING';
+	$output .=3D $level . ':';
+	$output .=3D RESET if $color;
+	$output .=3D ' ' . $msg . "\n";
+
+	$output =3D (split('\n', $output))[0] . "\n" if ($terse);
=20
-	push(our @report, $line);
+	push(our @report, $output);
=20
 	return 1;
 }
@@ -1196,13 +1231,13 @@ sub report_dump {
 	our @report;
 }
 sub ERROR {
-	if (report("ERROR: $_[0]\n")) {
+	if (report("ERROR", $_[0])) {
 		our $clean =3D 0;
 		our $cnt_error++;
 	}
 }
 sub WARN {
-	if (report("WARNING: $_[0]\n")) {
+	if (report("WARNING", $_[0])) {
 		our $clean =3D 0;
 		our $cnt_warn++;
 	}
--=20
2.20.1
