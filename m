Received: from eggs.gnu.org ([2001:4830:134:3::10]:35809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7m-0008G0-9o
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dSP7l-0001BQ-82
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:22 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dSP7l-0001AT-1r
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:48:21 -0400
Received: by mail-wm0-x22c.google.com with SMTP id w126so198103673wme.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:48:20 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  4 Jul 2017 15:48:55 +0100
Message-Id: <20170704144859.17644-8-alex.bennee@linaro.org>
In-Reply-To: <20170704144859.17644-1-alex.bennee@linaro.org>
References: <20170704144859.17644-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 07/11] risugen: support @GroupName in risu
 files
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

The existing pattern support is useful but it does get a little
tedious when faced with large groups of instructions. This introduces
the concept of a @GroupName which can be sprinkled in the risu
definition and is attached to all instructions following its
definition until the next group or an empty group "@" is specified.

It can be combined with the existing pattern support to do things
like:

  ./risugen --group AdvSIMDAcrossVector --not-pattern ".*_RES" aarch64.risu foo.bin

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risugen        | 15 +++++++++++++++
 risugen_arm.pm |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/risugen b/risugen
index 347cf12..97ffa83 100755
--- a/risugen
+++ b/risugen
@@ -30,7 +30,10 @@ my %insn_details;
 
 # The arch will be selected based on .mode directive defined in risu file.
 my $arch = "";
+# Current group, updated by @GroupName
+my $insn_group = "";
 
+my @group = ();                 # include groups
 my @pattern_re = ();            # include pattern
 my @not_pattern_re = ();        # exclude pattern
 
@@ -118,6 +121,11 @@ sub parse_config_file($)
             exit(1);
         }
 
+        if ($tokens[0] =~ /^@(.*)/ ) {
+            $insn_group = $1;
+            next;
+        }
+
         if ($tokens[0] =~ /^\./) {
             parse_risu_directive($file, $seen_pattern, @tokens);
             next;
@@ -235,6 +243,9 @@ sub parse_config_file($)
         $insnrec->{fixedbits} = $fixedbits;
         $insnrec->{fixedbitmask} = $fixedbitmask;
         $insnrec->{fields} = [ @fields ];
+        if (length $insn_group) {
+            $insnrec->{group} = $insn_group;
+        }
         $insn_details{$insnname} = $insnrec;
     }
     close(CFILE) or die "can't close $file: $!";
@@ -253,6 +264,7 @@ Valid options:
     --fpscr n    : set initial FPSCR (arm) or FPCR (aarch64) value (default is 0)
     --condprob p : [ARM only] make instructions conditional with probability p
                    (default is 0, ie all instructions are always executed)
+    --group name[,name..]: only use instructions in defined groups
     --pattern re[,re...] : only use instructions matching regular expression
                    Each re must match a full word (that is, we match on
                    the perl regex '\\b((re)|(re))\\b'). This means that
@@ -281,6 +293,7 @@ sub main()
     GetOptions( "help" => sub { usage(); exit(0); },
                 "numinsns=i" => \$numinsns,
                 "fpscr=o" => \$fpscr,
+                "group=s" => \@group,
                 "pattern=s" => \@pattern_re,
                 "not-pattern=s" => \@not_pattern_re,
                 "condprob=f" => sub {
@@ -295,6 +308,7 @@ sub main()
     # allow "--pattern re,re" and "--pattern re --pattern re"
     @pattern_re = split(/,/,join(',',@pattern_re));
     @not_pattern_re = split(/,/,join(',',@not_pattern_re));
+    @group = split(/,/,join(',',@group));
 
     if ($#ARGV != 1) {
         usage();
@@ -316,6 +330,7 @@ sub main()
         'numinsns' => $numinsns,
         'fp_enabled' => $fp_enabled,
         'outfile' => $outfile,
+        'group' => \@group,
         'pattern_re' => \@pattern_re,
         'not_pattern_re' => \@not_pattern_re,
         'details' => \%insn_details,
diff --git a/risugen_arm.pm b/risugen_arm.pm
index 1024660..8ad208a 100644
--- a/risugen_arm.pm
+++ b/risugen_arm.pm
@@ -895,6 +895,7 @@ sub write_test_code($$$$$$$$)
     my $fp_enabled = $params->{ 'fp_enabled' };
     my $outfile = $params->{ 'outfile' };
 
+    my @group = @{ $params->{ 'group' } };
     my @pattern_re = @{ $params->{ 'pattern_re' } };
     my @not_pattern_re = @{ $params->{ 'not_pattern_re' } };
     my %insn_details = %{ $params->{ 'details' } };
@@ -910,6 +911,12 @@ sub write_test_code($$$$$$$$)
 
     # Get a list of the insn keys which are permitted by the re patterns
     my @keys = sort keys %insn_details;
+    if (@group) {
+        my $re = join("|",@group);
+        @keys = grep {
+            defined($insn_details{$_}->{group}) &&
+                grep /$re/, $insn_details{$_}->{group}} @keys
+    }
     if (@pattern_re) {
         my $re = '\b((' . join(')|(',@pattern_re) . '))\b';
         @keys = grep /$re/, @keys;
-- 
2.13.0
