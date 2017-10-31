Received: from eggs.gnu.org ([2001:4830:134:3::10]:59393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9Xwc-0000ek-JU
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9XwY-00073l-H1
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:10 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e9XwY-00072j-8B
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:06 -0400
Received: by mail-wm0-x242.google.com with SMTP id t139so23845224wmt.1
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 07:55:06 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 31 Oct 2017 14:54:43 +0000
Message-Id: <20171031145444.13766-7-alex.bennee@linaro.org>
In-Reply-To: <20171031145444.13766-1-alex.bennee@linaro.org>
References: <20171031145444.13766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 6/7] risugen: support @GroupName in risu
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
 README  | 10 ++++++++++
 risugen | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/README b/README
index 312e9cd..9946e6e 100644
--- a/README
+++ b/README
@@ -75,6 +75,10 @@ reads the configuration file arm.risu, and generates 10000 instructions
 based on the instruction patterns matching the regular expression
 "VQSHL.*imm.*". The resulting binary is written to vqshlimm.out.
 
+An alternative to using regular expression patterns is to use the
+--group specifier. This relies on the configuration file having been
+annotated with suitable @ markers.
+
 This binary can then be passed to the risu program, which is
 written in C. You need to run risu on both an ARM native target
 and on the program under test. The ARM native system is the 'master'
@@ -140,6 +144,12 @@ Lines starting with a '.' are directives to risu/risugen:
  * ".mode [thumb|arm]" specifies whether the file contains ARM
    or Thumb instructions; it must precede all instruction patterns.
 
+Lines starting with a '@' are a grouping directive. Instructions
+following will be assigned to a comma separated list of groups. The
+list of groups is reset at the next '@' directive which may be empty.
+This provides an alternative method to selecting instructions than RE
+patterns.
+
 Other lines are instruction patterns:
  insnname encodingname bitfield ... [ [ !blockname ] { blocktext } ]
 where each bitfield is either:
diff --git a/risugen b/risugen
index 8bfb0e9..aba4bb7 100755
--- a/risugen
+++ b/risugen
@@ -34,7 +34,10 @@ my @insn_keys;
 
 # The arch will be selected based on .mode directive defined in risu file.
 my $arch = "";
+# Current group, updated by @GroupName
+my $insn_group = "";
 
+my @group = ();                 # include groups
 my @pattern_re = ();            # include pattern
 my @not_pattern_re = ();        # exclude pattern
 
@@ -122,6 +125,11 @@ sub parse_config_file($)
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
@@ -239,6 +247,9 @@ sub parse_config_file($)
         $insnrec->{fixedbits} = $fixedbits;
         $insnrec->{fixedbitmask} = $fixedbitmask;
         $insnrec->{fields} = [ @fields ];
+        if (length $insn_group) {
+            $insnrec->{group} = $insn_group;
+        }
         $insn_details{$insnname} = $insnrec;
     }
     close(CFILE) or die "can't close $file: $!";
@@ -249,6 +260,12 @@ sub select_insn_keys ()
 {
     # Get a list of the insn keys which are permitted by the re patterns
     @insn_keys = sort keys %insn_details;
+    if (@group) {
+        my $re = join("|",@group);
+        @insn_keys = grep {
+            defined($insn_details{$_}->{group}) &&
+                grep /$re/, $insn_details{$_}->{group}} @insn_keys
+    }
     if (@pattern_re) {
         my $re = '\b((' . join(')|(',@pattern_re) . '))\b';
         @insn_keys = grep /$re/, @insn_keys;
@@ -277,6 +294,7 @@ Valid options:
     --fpscr n    : set initial FPSCR (arm) or FPCR (aarch64) value (default is 0)
     --condprob p : [ARM only] make instructions conditional with probability p
                    (default is 0, ie all instructions are always executed)
+    --group name[,name..]: only use instructions in defined groups
     --pattern re[,re...] : only use instructions matching regular expression
                    Each re must match a full word (that is, we match on
                    the perl regex '\\b((re)|(re))\\b'). This means that
@@ -305,6 +323,7 @@ sub main()
     GetOptions( "help" => sub { usage(); exit(0); },
                 "numinsns=i" => \$numinsns,
                 "fpscr=o" => \$fpscr,
+                "group=s" => \@group,
                 "pattern=s" => \@pattern_re,
                 "not-pattern=s" => \@not_pattern_re,
                 "condprob=f" => sub {
@@ -319,6 +338,7 @@ sub main()
     # allow "--pattern re,re" and "--pattern re --pattern re"
     @pattern_re = split(/,/,join(',',@pattern_re));
     @not_pattern_re = split(/,/,join(',',@not_pattern_re));
+    @group = split(/,/,join(',',@group));
 
     if ($#ARGV != 1) {
         usage();
-- 
2.14.2
