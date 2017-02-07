Received: from eggs.gnu.org ([2001:4830:134:3::10]:60103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cbAab-0004tP-Ub
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cbAaX-0001Tq-PM
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:05 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:56465)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cbAaX-0001S4-Dz
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:01 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  7 Feb 2017 19:33:52 +0100
Message-Id: <20170207183356.17840-2-laurent@vivier.eu>
In-Reply-To: <20170207183356.17840-1-laurent@vivier.eu>
References: <20170207183356.17840-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/5] m68k: implement risugen module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

---
 risugen_m68k.pm | 295 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 295 insertions(+)
 create mode 100644 risugen_m68k.pm

diff --git a/risugen_m68k.pm b/risugen_m68k.pm
new file mode 100644
index 0000000..a9a4341
--- /dev/null
+++ b/risugen_m68k.pm
@@ -0,0 +1,295 @@
+#!/usr/bin/perl -w
+###############################################################################
+# Copyright (c) 2016 Laurent Vivier
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+###############################################################################
+
+
+# risugen -- generate a test binary file for use with risu
+# See 'risugen --help' for usage information.
+package risugen_m68k;
+
+use strict;
+use warnings;
+
+require Exporter;
+
+our @ISA    = qw(Exporter);
+our @EXPORT = qw(write_test_code);
+
+my $periodic_reg_random = 1;
+
+my $bytecount;
+#
+# Maximum alignment restriction permitted for a memory op.
+my $MAXALIGN = 64;
+
+sub open_bin
+{
+    my ($fname) = @_;
+    open(BIN, ">", $fname) or die "can't open %fname: $!";
+    $bytecount = 0;
+}
+
+sub close_bin
+{
+    close(BIN) or die "can't close output file: $!";
+}
+
+sub insn32($)
+{
+    my ($insn) = @_;
+    print BIN pack("N", $insn);
+    $bytecount += 4;
+}
+
+sub insn16($)
+{
+    my ($insn) = @_;
+    print BIN pack("n", $insn);
+    $bytecount += 2;
+}
+
+sub write_risuop($)
+{
+    my ($op) = @_;
+    insn32(0x4afc7000 | $op);
+}
+
+sub write_mov_ccr($)
+{
+    my ($imm) = @_;
+    insn16(0x44fc);
+    insn16($imm);
+}
+
+sub write_movb_di($$)
+{
+    my ($r, $imm) = @_;
+
+    # move.b #imm,%dr
+    insn16(0x103c | ($r << 9));
+    insn16($imm)
+}
+
+sub write_mov_di($$)
+{
+    my ($r, $imm) = @_;
+
+    # move.l #imm,%dr
+    insn16(0x203c | ($r << 9));
+    insn32($imm)
+}
+
+sub write_mov_ai($$)
+{
+    my ($r, $imm) = @_;
+
+    # movea.l #imm,%ar
+    insn16(0x207c | ($r << 9));
+    insn32($imm)
+}
+
+sub write_mov_ri($$)
+{
+    my ($r, $imm) = @_;
+
+    if ($r < 8) {
+        write_mov_di($r, $imm);
+    } else {
+        write_mov_ai($r - 8, $imm);
+    }
+}
+
+sub write_random_regdata()
+{
+    # general purpose registers (except A6 (FP) and A7 (SP))
+    for (my $i = 0; $i < 14; $i++) {
+        write_mov_ri($i, rand(0xffffffff));
+    }
+    # initialize condition register
+    write_mov_ccr(rand(0x10000));
+}
+
+my $OP_COMPARE = 0;        # compare registers
+my $OP_TESTEND = 1;        # end of test, stop
+my $OP_SETMEMBLOCK = 2;    # r0 is address of memory block (8192 bytes)
+my $OP_GETMEMBLOCK = 3;    # add the address of memory block to r0
+my $OP_COMPAREMEM = 4;     # compare memory block
+
+sub write_random_register_data()
+{
+    write_random_regdata();
+    write_risuop($OP_COMPARE);
+}
+
+sub eval_with_fields($$$$$) {
+    # Evaluate the given block in an environment with Perl variables
+    # set corresponding to the variable fields for the insn.
+    # Return the result of the eval; we die with a useful error
+    # message in case of syntax error.
+    my ($insnname, $insn, $rec, $blockname, $block) = @_;
+    my $evalstr = "{ ";
+    for my $tuple (@{ $rec->{fields} }) {
+        my ($var, $pos, $mask) = @$tuple;
+        my $val = ($insn >> $pos) & $mask;
+        $evalstr .= "my (\$$var) = $val; ";
+    }
+    $evalstr .= $block;
+    $evalstr .= "}";
+    my $v = eval $evalstr;
+    if ($@) {
+        print "Syntax error detected evaluating $insnname $blockname string:\n$block\n$@";
+        exit(1);
+    }
+    return $v;
+}
+
+sub gen_one_insn($$)
+{
+    # Given an instruction-details array, generate an instruction
+    my $constraintfailures = 0;
+
+    INSN: while(1) {
+        my ($forcecond, $rec) = @_;
+        my $insn = int(rand(0xffffffff));
+        my $insnname = $rec->{name};
+        my $insnwidth = $rec->{width};
+        my $fixedbits = $rec->{fixedbits};
+        my $fixedbitmask = $rec->{fixedbitmask};
+        my $constraint = $rec->{blocks}{"constraints"};
+        my $memblock = $rec->{blocks}{"memory"};
+
+        $insn &= ~$fixedbitmask;
+        $insn |= $fixedbits;
+
+        for my $tuple (@{ $rec->{fields} }) {
+            my ($var, $pos, $mask) = @$tuple;
+            my $val = ($insn >> $pos) & $mask;
+            # Check constraints here:
+            # not allowed to use or modify sp (A7) or fp (A6)
+            next INSN if ($var =~ /^A/ && (($val == 6) || ($val == 7)));
+        }
+        if (defined $constraint) {
+            # user-specified constraint: evaluate in an environment
+            # with variables set corresponding to the variable fields.
+            my $v = eval_with_fields($insnname, $insn, $rec, "constraints", $constraint);
+            if (!$v) {
+                $constraintfailures++;
+                if ($constraintfailures > 10000) {
+                    print "10000 consecutive constraint failures for $insnname constraints string:\n$constraint\n";
+                    exit (1);
+                }
+                next INSN;
+            }
+        }
+
+        # OK, we got a good one
+        $constraintfailures = 0;
+
+        insn16($insn >> 16);
+        if ($insnwidth == 32) {
+            insn16($insn & 0xffff);
+        }
+
+        return;
+    }
+}
+
+my $lastprog;
+my $proglen;
+my $progmax;
+
+sub progress_start($$)
+{
+    ($proglen, $progmax) = @_;
+    $proglen -= 2; # allow for [] chars
+    $| = 1;        # disable buffering so we can see the meter...
+    print "[" . " " x $proglen . "]\r";
+    $lastprog = 0;
+}
+
+sub progress_update($)
+{
+    # update the progress bar with current progress
+    my ($done) = @_;
+    my $barlen = int($proglen * $done / $progmax);
+    if ($barlen != $lastprog) {
+        $lastprog = $barlen;
+        print "[" . "-" x $barlen . " " x ($proglen - $barlen) . "]\r";
+    }
+}
+
+sub progress_end()
+{
+    print "[" . "-" x $proglen . "]\n";
+    $| = 0;
+}
+
+sub write_test_code($)
+{
+    my ($params) = @_;
+
+    my $condprob = $params->{ 'condprob' };
+    my $numinsns = $params->{ 'numinsns' };
+    my $outfile = $params->{ 'outfile' };
+
+    my @pattern_re = @{ $params->{ 'pattern_re' } };
+    my @not_pattern_re = @{ $params->{ 'not_pattern_re' } };
+    my %insn_details = %{ $params->{ 'details' } };
+
+    open_bin($outfile);
+
+    # convert from probability that insn will be conditional to
+    # probability of forcing insn to unconditional
+    $condprob = 1 - $condprob;
+
+    # TODO better random number generator?
+    srand(0);
+
+    # Get a list of the insn keys which are permitted by the re patterns
+    my @keys = sort keys %insn_details;
+    if (@pattern_re) {
+        my $re = '\b((' . join(')|(',@pattern_re) . '))\b';
+        @keys = grep /$re/, @keys;
+    }
+    # exclude any specifics
+    if (@not_pattern_re) {
+        my $re = '\b((' . join(')|(',@not_pattern_re) . '))\b';
+        @keys = grep !/$re/, @keys;
+    }
+    if (!@keys) {
+        print STDERR "No instruction patterns available! (bad config file or --pattern argument?)\n";
+        exit(1);
+    }
+    print "Generating code using patterns: @keys...\n";
+    progress_start(78, $numinsns);
+
+    if (grep { defined($insn_details{$_}->{blocks}->{"memory"}) } @keys) {
+        write_memblock_setup();
+    }
+
+    # memblock setup doesn't clean its registers, so this must come afterwards.
+    write_random_register_data();
+
+    for my $i (1..$numinsns) {
+        my $insn_enc = $keys[int rand (@keys)];
+        my $forcecond = (rand() < $condprob) ? 1 : 0;
+        gen_one_insn($forcecond, $insn_details{$insn_enc});
+        write_risuop($OP_COMPARE);
+        # Rewrite the registers periodically. This avoids the tendency
+        # for the VFP registers to decay to NaNs and zeroes.
+        if ($periodic_reg_random && ($i % 100) == 0) {
+            write_random_register_data();
+        }
+        progress_update($i);
+    }
+    write_risuop($OP_TESTEND);
+    progress_end();
+    close_bin();
+}
+
+1;
-- 
2.9.3
