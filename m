Received: from eggs.gnu.org ([2001:4830:134:3::10]:52183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MX-0000mJ-Hv
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MW-0000DA-DB
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:49 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MU-0008Lx-Ip
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id y139so6132166wmc.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:26 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.23 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:27 +0100
Message-Id: <1544628195-37728-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/54] checkpatch: colorize output to terminal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add optional colors to make seeing message types a bit easier.
The default is to show them on a tty.

Inspired by Linux commits 57230297116fa ("checkpatch: colorize output
to terminal") and 737c0767758b ("checkpatch: change format of --color
argument to --color[=WHEN]").

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/checkpatch.pl | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2edb4e2..a8d6e44 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7,6 +7,7 @@
 
 use strict;
 use warnings;
+use Term::ANSIColor qw(:constants);
 
 my $P = $0;
 $P =~ s@.*/@@g;
@@ -26,6 +27,7 @@ my $tst_only;
 my $emacs = 0;
 my $terse = 0;
 my $file = undef;
+my $color = "auto";
 my $no_warnings = 0;
 my $summary = 1;
 my $mailback = 0;
@@ -64,6 +66,8 @@ Options:
                              is all off)
   --test-only=WORD           report only warnings/errors containing WORD
                              literally
+  --color[=WHEN]             Use colors 'always', 'never', or only when output
+                             is a terminal ('auto'). Default is 'auto'.
   -h, --help, --version      display this help and exit
 
 When FILE is - read standard input.
@@ -72,6 +76,14 @@ EOM
 	exit($exitcode);
 }
 
+# Perl's Getopt::Long allows options to take optional arguments after a space.
+# Prevent --color by itself from consuming other arguments
+foreach (@ARGV) {
+	if ($_ eq "--color" || $_ eq "-color") {
+		$_ = "--color=$color";
+	}
+}
+
 GetOptions(
 	'q|quiet+'	=> \$quiet,
 	'tree!'		=> \$tree,
@@ -89,6 +101,8 @@ GetOptions(
 
 	'debug=s'	=> \%debug,
 	'test-only=s'	=> \$tst_only,
+	'color=s'       => \$color,
+	'no-color'      => sub { $color = 'never'; },
 	'h|help'	=> \$help,
 	'version'	=> \$help
 ) or help(1);
@@ -144,6 +158,16 @@ if (!$chk_patch && !$chk_branch && !$file) {
 	die "One of --file, --branch, --patch is required\n";
 }
 
+if ($color =~ /^always$/i) {
+	$color = 1;
+} elsif ($color =~ /^never$/i) {
+	$color = 0;
+} elsif ($color =~ /^auto$/i) {
+	$color = (-t STDOUT);
+} else {
+	die "Invalid color mode: $color\n";
+}
+
 my $dbg_values = 0;
 my $dbg_possible = 0;
 my $dbg_type = 0;
@@ -372,7 +396,9 @@ if ($chk_branch) {
 		close($FILE);
 		$vname = substr($hash, 0, 12) . ' (' . $git_commits{$hash} . ')';
 		if ($num_patches > 1 && $quiet == 0) {
-			print "$i/$num_patches Checking commit $vname\n";
+			my $prefix = "$i/$num_patches";
+			$prefix = BLUE . BOLD . $prefix . RESET if $color;
+			print "$prefix Checking commit $vname\n";
 			$vname = "Patch $i/$num_patches";
 		} else {
 			$vname = "Commit " . $vname;
@@ -1182,14 +1208,23 @@ sub possible {
 my $prefix = '';
 
 sub report {
-	if (defined $tst_only && $_[0] !~ /\Q$tst_only\E/) {
+	my ($level, $msg) = @_;
+	if (defined $tst_only && $msg !~ /\Q$tst_only\E/) {
 		return 0;
 	}
-	my $line = $prefix . $_[0];
 
-	$line = (split('\n', $line))[0] . "\n" if ($terse);
+	my $output = '';
+	$output .= BOLD if $color;
+	$output .= $prefix;
+	$output .= RED if $color && $level eq 'ERROR';
+	$output .= MAGENTA if $color && $level eq 'WARNING';
+	$output .= $level . ':';
+	$output .= RESET if $color;
+	$output .= ' ' . $msg . "\n";
+
+	$output = (split('\n', $output))[0] . "\n" if ($terse);
 
-	push(our @report, $line);
+	push(our @report, $output);
 
 	return 1;
 }
@@ -1197,13 +1232,13 @@ sub report_dump {
 	our @report;
 }
 sub ERROR {
-	if (report("ERROR: $_[0]\n")) {
+	if (report("ERROR", $_[0])) {
 		our $clean = 0;
 		our $cnt_error++;
 	}
 }
 sub WARN {
-	if (report("WARNING: $_[0]\n")) {
+	if (report("WARNING", $_[0])) {
 		our $clean = 0;
 		our $cnt_warn++;
 	}
-- 
1.8.3.1
