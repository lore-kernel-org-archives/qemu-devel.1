Received: from eggs.gnu.org ([2001:4830:134:3::10]:48126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYB-0003gS-SS
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFY9-00088R-NO
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:19 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFY9-00086Q-D6
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:17 -0500
Received: by mail-wr0-x22b.google.com with SMTP id m5so14558495wrg.1
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:46:17 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:46:06 +0000
Message-Id: <20180223154613.2096-2-alex.bennee@linaro.org>
In-Reply-To: <20180223154613.2096-1-alex.bennee@linaro.org>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/8] risugen: support @GroupName in risu
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The existing pattern support is useful but it does get a little
tedious when faced with large groups of instructions. This introduces
the concept of a @GroupName which can be sprinkled in the risu
definition and is attached to all instructions following its
definition until the next group or an empty group "@" is specified.

It can be combined with the existing pattern support to do things
like:

  ./risugen --group AdvSIMDAcrossVector --not-pattern ".*_RES" aarch64.risu foo.bin

Multiple groups will further restrict the set, so for example:

  ./risugen --group v8.2,Cryptographic aarch64.risu v8.2-crypto.bin

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 README  | 10 ++++++++++
 risugen | 24 +++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/README b/README
index e90d33c..35e8b29 100644
--- a/README
+++ b/README
@@ -81,6 +81,10 @@ reads the configuration file arm.risu, and generates 10000 instructions
 based on the instruction patterns matching the regular expression
 "VQSHL.*imm.*". The resulting binary is written to vqshlimm.out.
 
+An alternative to using regular expression patterns is to use the
+--group specifier. This relies on the configuration file having been
+annotated with suitable @ markers.
+
 This binary can then be passed to the risu program, which is
 written in C. You need to run risu on both an ARM native target
 and on the program under test. The ARM native system is the 'master'
@@ -146,6 +150,12 @@ Lines starting with a '.' are directives to risu/risugen:
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
index 8bfb0e9..488d804 100755
--- a/risugen
+++ b/risugen
@@ -20,6 +20,7 @@ use Getopt::Long;
 use Data::Dumper;
 use Module::Load;
 use Text::Balanced qw { extract_bracketed extract_multiple };
+use List::Compare::Functional qw( get_intersection );
 # Make sure we can find the per-CPU-architecture modules in the
 # same directory as this script.
 use FindBin;
@@ -34,7 +35,10 @@ my @insn_keys;
 
 # The arch will be selected based on .mode directive defined in risu file.
 my $arch = "";
+# Current groups, updated by @GroupName
+my @insn_groups;
 
+my @groups = ();                # include groups
 my @pattern_re = ();            # include pattern
 my @not_pattern_re = ();        # exclude pattern
 
@@ -122,6 +126,11 @@ sub parse_config_file($)
             exit(1);
         }
 
+        if ($tokens[0] =~ /^@(.*)/ ) {
+            @insn_groups = split(/,/, $1);
+            next;
+        }
+
         if ($tokens[0] =~ /^\./) {
             parse_risu_directive($file, $seen_pattern, @tokens);
             next;
@@ -239,6 +248,9 @@ sub parse_config_file($)
         $insnrec->{fixedbits} = $fixedbits;
         $insnrec->{fixedbitmask} = $fixedbitmask;
         $insnrec->{fields} = [ @fields ];
+        if (@insn_groups) {
+            $insnrec->{groups} = [ @insn_groups ];
+        }
         $insn_details{$insnname} = $insnrec;
     }
     close(CFILE) or die "can't close $file: $!";
@@ -247,8 +259,15 @@ sub parse_config_file($)
 # Select a subset of instructions based on our filter preferences
 sub select_insn_keys ()
 {
-    # Get a list of the insn keys which are permitted by the re patterns
     @insn_keys = sort keys %insn_details;
+    # Limit insn keys to those in all reqested @groups
+    if (@groups) {
+        @insn_keys = grep {
+            defined($insn_details{$_}->{groups}) &&
+                scalar @groups == get_intersection([$insn_details{$_}->{groups}, \@groups])
+        } @insn_keys
+    }
+    # Get a list of the insn keys which are permitted by the re patterns
     if (@pattern_re) {
         my $re = '\b((' . join(')|(',@pattern_re) . '))\b';
         @insn_keys = grep /$re/, @insn_keys;
@@ -277,6 +296,7 @@ Valid options:
     --fpscr n    : set initial FPSCR (arm) or FPCR (aarch64) value (default is 0)
     --condprob p : [ARM only] make instructions conditional with probability p
                    (default is 0, ie all instructions are always executed)
+    --group name[,name..]: only use instructions in all defined groups
     --pattern re[,re...] : only use instructions matching regular expression
                    Each re must match a full word (that is, we match on
                    the perl regex '\\b((re)|(re))\\b'). This means that
@@ -305,6 +325,7 @@ sub main()
     GetOptions( "help" => sub { usage(); exit(0); },
                 "numinsns=i" => \$numinsns,
                 "fpscr=o" => \$fpscr,
+                "group=s" => \@groups,
                 "pattern=s" => \@pattern_re,
                 "not-pattern=s" => \@not_pattern_re,
                 "condprob=f" => sub {
@@ -319,6 +340,7 @@ sub main()
     # allow "--pattern re,re" and "--pattern re --pattern re"
     @pattern_re = split(/,/,join(',',@pattern_re));
     @not_pattern_re = split(/,/,join(',',@not_pattern_re));
+    @groups = split(/,/,join(',',@groups));
 
     if ($#ARGV != 1) {
         usage();
-- 
2.15.1
