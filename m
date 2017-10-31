Received: from eggs.gnu.org ([2001:4830:134:3::10]:59345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9XwZ-0000ak-H9
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9XwX-000739-T6
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:07 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e9XwX-00072T-Jn
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:05 -0400
Received: by mail-wm0-x244.google.com with SMTP id y83so23682205wmc.4
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 07:55:05 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 31 Oct 2017 14:54:42 +0000
Message-Id: <20171031145444.13766-6-alex.bennee@linaro.org>
In-Reply-To: <20171031145444.13766-1-alex.bennee@linaro.org>
References: <20171031145444.13766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 5/7] risugen/risugen_$arch: factor out
 instruction selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This moves the instruction selection to the common code and passes a
list of selection keys to write_test_code instead. This will allow us
to add selection features to the common code later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risugen          | 29 +++++++++++++++++++++++++++--
 risugen_arm.pm   | 18 +-----------------
 risugen_m68k.pm  | 18 +-----------------
 risugen_ppc64.pm | 18 +-----------------
 4 files changed, 30 insertions(+), 53 deletions(-)

diff --git a/risugen b/risugen
index 347cf12..8bfb0e9 100755
--- a/risugen
+++ b/risugen
@@ -26,7 +26,11 @@ use FindBin;
 use lib "$FindBin::Bin";
 use risugen_common;
 
+# insn_details is the full set of instruction definitions whereas
+# insn_keys is array of (potentially filtered) keys to index into the
+# insn_details hash.
 my %insn_details;
+my @insn_keys;
 
 # The arch will be selected based on .mode directive defined in risu file.
 my $arch = "";
@@ -240,6 +244,26 @@ sub parse_config_file($)
     close(CFILE) or die "can't close $file: $!";
 }
 
+# Select a subset of instructions based on our filter preferences
+sub select_insn_keys ()
+{
+    # Get a list of the insn keys which are permitted by the re patterns
+    @insn_keys = sort keys %insn_details;
+    if (@pattern_re) {
+        my $re = '\b((' . join(')|(',@pattern_re) . '))\b';
+        @insn_keys = grep /$re/, @insn_keys;
+    }
+    # exclude any specifics
+    if (@not_pattern_re) {
+        my $re = '\b((' . join(')|(',@not_pattern_re) . '))\b';
+        @insn_keys = grep !/$re/, @insn_keys;
+    }
+    if (!@insn_keys) {
+        print STDERR "No instruction patterns available! (bad config file or --pattern argument?)\n";
+        exit(1);
+    }
+}
+
 sub usage()
 {
     print <<EOT;
@@ -306,6 +330,8 @@ sub main()
 
     parse_config_file($infile);
 
+    select_insn_keys();
+
     my @full_arch = split(/\./, $arch);
     my $module = "risugen_$full_arch[0]";
     load $module, qw/write_test_code/;
@@ -316,9 +342,8 @@ sub main()
         'numinsns' => $numinsns,
         'fp_enabled' => $fp_enabled,
         'outfile' => $outfile,
-        'pattern_re' => \@pattern_re,
-        'not_pattern_re' => \@not_pattern_re,
         'details' => \%insn_details,
+        'keys' => \@insn_keys,
         'arch' => $full_arch[0],
         'subarch' => $full_arch[1] || '',
         'bigendian' => $big_endian
diff --git a/risugen_arm.pm b/risugen_arm.pm
index 1024660..2f10d58 100644
--- a/risugen_arm.pm
+++ b/risugen_arm.pm
@@ -895,9 +895,8 @@ sub write_test_code($$$$$$$$)
     my $fp_enabled = $params->{ 'fp_enabled' };
     my $outfile = $params->{ 'outfile' };
 
-    my @pattern_re = @{ $params->{ 'pattern_re' } };
-    my @not_pattern_re = @{ $params->{ 'not_pattern_re' } };
     my %insn_details = %{ $params->{ 'details' } };
+    my @keys = @{ $params->{ 'keys' } };
 
     open_bin($outfile);
 
@@ -908,21 +907,6 @@ sub write_test_code($$$$$$$$)
     # TODO better random number generator?
     srand(0);
 
-    # Get a list of the insn keys which are permitted by the re patterns
-    my @keys = sort keys %insn_details;
-    if (@pattern_re) {
-        my $re = '\b((' . join(')|(',@pattern_re) . '))\b';
-        @keys = grep /$re/, @keys;
-    }
-    # exclude any specifics
-    if (@not_pattern_re) {
-        my $re = '\b((' . join(')|(',@not_pattern_re) . '))\b';
-        @keys = grep !/$re/, @keys;
-    }
-    if (!@keys) {
-        print STDERR "No instruction patterns available! (bad config file or --pattern argument?)\n";
-        exit(1);
-    }
     print "Generating code using patterns: @keys...\n";
     progress_start(78, $numinsns);
 
diff --git a/risugen_m68k.pm b/risugen_m68k.pm
index 74e4937..7d62b13 100644
--- a/risugen_m68k.pm
+++ b/risugen_m68k.pm
@@ -160,9 +160,8 @@ sub write_test_code($)
     my $numinsns = $params->{ 'numinsns' };
     my $outfile = $params->{ 'outfile' };
 
-    my @pattern_re = @{ $params->{ 'pattern_re' } };
-    my @not_pattern_re = @{ $params->{ 'not_pattern_re' } };
     my %insn_details = %{ $params->{ 'details' } };
+    my @keys = @{ $params->{ 'keys' } };
 
     # Specify the order to use for insn32() and insn16() writes.
     set_endian(1);
@@ -176,21 +175,6 @@ sub write_test_code($)
     # TODO better random number generator?
     srand(0);
 
-    # Get a list of the insn keys which are permitted by the re patterns
-    my @keys = sort keys %insn_details;
-    if (@pattern_re) {
-        my $re = '\b((' . join(')|(',@pattern_re) . '))\b';
-        @keys = grep /$re/, @keys;
-    }
-    # exclude any specifics
-    if (@not_pattern_re) {
-        my $re = '\b((' . join(')|(',@not_pattern_re) . '))\b';
-        @keys = grep !/$re/, @keys;
-    }
-    if (!@keys) {
-        print STDERR "No instruction patterns available! (bad config file or --pattern argument?)\n";
-        exit(1);
-    }
     print "Generating code using patterns: @keys...\n";
     progress_start(78, $numinsns);
 
diff --git a/risugen_ppc64.pm b/risugen_ppc64.pm
index c0e71cf..b241172 100644
--- a/risugen_ppc64.pm
+++ b/risugen_ppc64.pm
@@ -371,9 +371,8 @@ sub write_test_code($)
     my $fp_enabled = $params->{ 'fp_enabled' };
     my $outfile = $params->{ 'outfile' };
 
-    my @pattern_re = @{ $params->{ 'pattern_re' } };
-    my @not_pattern_re = @{ $params->{ 'not_pattern_re' } };
     my %insn_details = %{ $params->{ 'details' } };
+    my @keys = @{ $params->{ 'keys' } };
 
     if ($params->{ 'bigendian' } eq 1) {
         set_endian(1);
@@ -388,21 +387,6 @@ sub write_test_code($)
     # TODO better random number generator?
     srand(0);
 
-    # Get a list of the insn keys which are permitted by the re patterns
-    my @keys = sort keys %insn_details;
-    if (@pattern_re) {
-        my $re = '\b((' . join(')|(',@pattern_re) . '))\b';
-        @keys = grep /$re/, @keys;
-    }
-    # exclude any specifics
-    if (@not_pattern_re) {
-        my $re = '\b((' . join(')|(',@not_pattern_re) . '))\b';
-        @keys = grep !/$re/, @keys;
-    }
-    if (!@keys) {
-        print STDERR "No instruction patterns available! (bad config file or --pattern argument?)\n";
-        exit(1);
-    }
     print "Generating code using patterns: @keys...\n";
     progress_start(78, $numinsns);
 
-- 
2.14.2
