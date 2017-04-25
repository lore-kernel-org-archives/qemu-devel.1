Received: from eggs.gnu.org ([2001:4830:134:3::10]:61000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r38-000603-4T
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r34-0005iU-2p
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:21:58 -0400
Received: from mail-it0-x232.google.com ([2607:f8b0:4001:c0b::232]:38290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d2r33-0005iD-RX
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:21:54 -0400
Received: by mail-it0-x232.google.com with SMTP id f187so6600013ite.1
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 20:21:53 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <25595416-4E28-4276-AC25-9E62D30D9B74@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 24 Apr 2017 23:21:39 -0400
Subject: [Qemu-devel] [PATCH 5/9] Add risugen_ppc.pm file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Add the risugen_ppc.pm file. It is used to generate the instructions  
that risu
runs.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
  risugen_ppc.pm | 744 +++++++++++++++++++++++++++++++++++++++++++++++ 
++++++++++
  1 file changed, 744 insertions(+)
  create mode 100644 risugen_ppc.pm

diff --git a/risugen_ppc.pm b/risugen_ppc.pm
new file mode 100644
index 0000000..2faae81
--- /dev/null
+++ b/risugen_ppc.pm
@@ -0,0 +1,744 @@
+#!/usr/bin/perl -w
+####################################################################### 
########
+# File: risugen_ppc.pm
+# Date: 4-14-2017
+# Description: Perl module for generating PowerPC instructions with  
risugen.
+# Based on Jose Ricardo Ziviani (IBM) - ppc64 implementation
+####################################################################### 
########
+
+# risugen -- generate a test binary file for use with risu
+# See 'risugen --help' for usage information.
+package risugen_ppc;
+
+use strict;
+use warnings;
+use bigint;
+use risugen_common;
+
+require Exporter;
+
+our @ISA    = qw(Exporter);
+our @EXPORT = qw(write_test_code);
+
+# Has all debug messages printed if set to 1
+my $debug = 0;
+
+# First available slot in the stack
+my $available_stack_slot = 40;
+
+my $OP_COMPARE = 0;        # compare registers
+my $OP_TESTEND = 1;        # end of test, stop
+
+# prints debugging information if DEBUG is set to 1
+sub debug_print {
+    if ($debug == 1) {
+        my $test = sprintf(shift, @_);
+        print $test;
+    }
+}
+
+# setup the environment for a memory access involving two registers
+# first input: general purpose register rA
+# second input: general purpose register rB
+sub reg_plus_reg($$)
+{
+    my ($rA, $rB) = @_;
+    my $value;
+    my $low_bits;
+    my $high_bits;
+
+    $value = rand();
+
+    # Has to be loaded like this because we can't just load a 32 bit  
value
+    $low_bits = $value & 0xffff;
+    $high_bits = $value >> 16;
+
+    # Add a value into the expected memory location
+    write_lis(10, $high_bits);              # lis r10, $high_bits
+    write_ori(10, 10, $low_bits);           # ori r10, r10, $low_bits
+    write_stw(10, $available_stack_slot);   # stw r10,  
$available_stack_slot(r1)
+
+    # setup the two registers to find the memory location
+    write_mr($rA, 1);                       # mr $rA, r1
+    write_li($rB, $available_stack_slot);   # li $rB,  
$available_stack_slot
+    return $rA;
+}
+
+# Handle register + immediate addressing mode
+# first input: base register
+# second input: immediate value (offset)
+sub reg_plus_imm($$)
+{
+    my ($base_register, $number) = @_;
+
+    # load a random floating point value into memory
+    my $float_value = rand();
+    my $ieee_value = convert_to_IEEE($float_value);
+    my $ieee_high_bits; # the upper 16 bits of $ieee_value
+    my $ieee_low_bits;  # the lower 16 bits of $ieee_value
+
+    $ieee_high_bits = $ieee_value >> 16;
+    $ieee_low_bits = $ieee_value & 0xffff;
+    write_lis(10, $ieee_high_bits);       # lis r10, $ieee_high_bits
+    write_ori(10, 10, $ieee_low_bits);    # ori r10, r10,  
$ieee_low_bits
+    write_stw(10, $number);               # stw r10, $number(r1)
+    write_mr($base_register, 1);          # mr $base_register, r1
+    return $base_register;
+}
+
+# convert float value to IEEE 754
+# input: floating point value (e.g. 1.23)
+# output: IEEE 754 single precision value
+sub convert_to_IEEE($)
+{
+    my $float_value = $_[0];
+    my $ieee_value = unpack "L", pack "f", $float_value;
+    return $ieee_value;
+}
+
+# returns a random double precision IEEE 754 value
+# output: 64 bit number
+sub get_random_IEEE_double_value()
+{
+    my @number_array = (0x40273333333333330, 0x405EDCCCCCCCCCCD,
+                        0x40700A6666666666, 0x412E240CA45A1CAC,
+                        0x407C3E8F5C28F5C3, 0x408DBF189374BC6A);
+    my $size_of_array = scalar @number_array;
+    my $index = int rand($size_of_array);
+    return $number_array[$index];
+}
+
+# writes ppc assembly code to load a IEEE 754 double value
+# input one: general purpose register number
+# input two: immediate value (offset)
+# output: IEEE 754 double value
+sub load_double_float_imm($$)
+{
+    my ($rA, $number) = @_;
+
+    my $ieee_double;   # ieee 754 double float value
+    my $ieee_high_bits; # the upper 16 bits of $ieee_double
+    my $ieee_low_bits;  # the lower 16 bits of $ieee_double
+    my $higher_32_bits;
+    my $lower_32_bits;
+
+    $ieee_double = get_random_IEEE_double_value();
+
+    # loading a 64 bit double value is going to take some work
+
+    # load the higher 32 bits
+    $higher_32_bits = $ieee_double >> 32;  # push the lower 32 bits out
+    $ieee_high_bits = $higher_32_bits >> 16;
+    $ieee_low_bits = $higher_32_bits & 0xffff;
+    write_lis(10, $ieee_high_bits);       # lis r10, $ieee_high_bits
+    write_ori(10, 10, $ieee_low_bits);    # ori r10, r10,  
$ieee_low_bits
+    write_stw(10, $number);               # stw r10, $number(r1)
+
+    # load the lower 32 bits
+    $lower_32_bits = $ieee_double & 0xffffffff;
+    $ieee_high_bits = $lower_32_bits >> 16;
+    $ieee_low_bits = $lower_32_bits & 0xffff;
+    write_lis(10, $ieee_high_bits);       # lis r10, $ieee_high_bits
+    write_ori(10, 10, $ieee_low_bits);    # ori r10, r10,  
$ieee_low_bits
+    write_stw(10, $number + 4);           # stw r10, $number+4 (r1)
+
+    write_mr($rA, 1);                     # mr $rA, r1
+    return $rA;
+}
+
+
+# writes ppc assembly code to load a IEEE 754 double value into memory
+# input one: general purpose register number
+# input two: general purpose register number
+# output: IEEE 754 double value
+sub load_double_float_indexed($$)
+{
+    my ($rA, $rB) = @_;
+
+    my $ieee_double;   # ieee 754 double float value
+    my $ieee_high_bits; # the upper 16 bits of $ieee_double
+    my $ieee_low_bits;  # the lower 16 bits of $ieee_double
+    my $higher_32_bits;
+    my $lower_32_bits;
+
+    $ieee_double = get_random_IEEE_double_value();
+
+    # loading a 64 bit double value is going to take some work
+
+    # load the higher 32 bits
+    $higher_32_bits = $ieee_double >> 32;  # push the lower 32 bits out
+    $ieee_high_bits = $higher_32_bits >> 16;
+    $ieee_low_bits = $higher_32_bits & 0xffff;
+    write_lis(10, $ieee_high_bits);         # lis r10, $ieee_high_bits
+    write_ori(10, 10, $ieee_low_bits);      # ori r10, r10,  
$ieee_low_bits
+    write_stw(10, $available_stack_slot);   # stw r10,  
$available_stack_slot(r1)
+
+    # load the lower 32 bits
+    $lower_32_bits = $ieee_double & 0xffffffff;
+    $ieee_high_bits = $lower_32_bits >> 16;
+    $ieee_low_bits = $lower_32_bits & 0xffff;
+    write_lis(10, $ieee_high_bits);             # lis r10,  
$ieee_high_bits
+    write_ori(10, 10, $ieee_low_bits);          # ori r10, r10,  
$ieee_low_bits
+    write_stw(10, $available_stack_slot + 4);   # stw r10,  
($available_stack_slot + 4)(r1)
+
+    # setup the registers' value
+    write_li($rB, $available_stack_slot);       # li $rB,  
$available_stack_slot
+    write_mr($rA, 1);                           # mr $rA, r1
+    return $rA;
+}
+
+# Setup a testing environment for an instruction that
+# requires a double precision floating point value in a float register
+# input: floating point register number
+sub load_double_float_to_reg($)
+{
+    my ($fD) = @_;
+    my $ieee_double;   # ieee 754 double float value
+    my $ieee_high_bits; # the upper 16 bits of $ieee_double
+    my $ieee_low_bits;  # the lower 16 bits of $ieee_double
+    my $higher_32_bits;
+    my $lower_32_bits;
+
+    $ieee_double = get_random_IEEE_double_value();
+
+    # loading a 64 bit double value is going to take some work
+
+    # load the higher 32 bits
+    $higher_32_bits = $ieee_double >> 32;   # push the lower 32 bits  
out
+    $ieee_high_bits = $higher_32_bits >> 16;
+    $ieee_low_bits = $higher_32_bits & 0xffff;
+    write_lis(10, $ieee_high_bits);         # lis r10, $ieee_high_bits
+    write_ori(10, 10, $ieee_low_bits);      # ori r10, r10,  
$ieee_low_bits
+    write_stw(10, $available_stack_slot);   # stw r10,  
$available_stack_slot(r1)
+
+    # load the lower 32 bits
+    $lower_32_bits = $ieee_double & 0xffffffff;
+    $ieee_high_bits = $lower_32_bits >> 16;
+    $ieee_low_bits = $lower_32_bits & 0xffff;
+    write_lis(10, $ieee_high_bits);             # lis r10,  
$ieee_high_bits
+    write_ori(10, 10, $ieee_low_bits);          # ori r10, r10,  
$ieee_low_bits
+    write_stw(10, $available_stack_slot + 4);   # stw r10,  
($available_stack_slot + 4)(r1)
+
+    write_lfd($fD, $available_stack_slot);      # lfd $fD,  
$available_stack_slot(r1)
+    return -1;
+}
+
+# Setup a testing environment for an instruction that requires
+# a single precision floating point value in a float register
+# input: floating point register number
+sub load_single_float_to_reg($)
+{
+    my ($fD) = @_;
+
+    # load a random single precision floating point value into memory
+    my $float_value = rand();
+    my $ieee_value = convert_to_IEEE($float_value);
+    my $ieee_high_bits; # the upper 16 bits of $ieee_value
+    my $ieee_low_bits;  # the lower 16 bits of $ieee_value
+
+    $ieee_high_bits = $ieee_value >> 16;
+    $ieee_low_bits = $ieee_value & 0xffff;
+    write_lis(10, $ieee_high_bits);         # lis r10, $ieee_high_bits
+    write_ori(10, 10, $ieee_low_bits);      # ori r10, r10,  
$ieee_low_bits
+    write_stw(10, $available_stack_slot);   # stw r10,  
$available_stack_slot(r1)
+    write_lfs($fD, $available_stack_slot);  # lfs $fD,  
$available_stack_slot(r1)
+
+    return -1;  # this just says not not clean up any register
+}
+
+# Compiles the instructions
+# input: hash
+sub gen_one_insn($)
+{
+    # Given an instruction-details array, generate an instruction
+    my $constraintfailures = 0;
+
+    INSN: while(1) {
+        my ($rec) = @_;
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
+        if (defined $constraint) {
+            # user-specified constraint: evaluate in an environment
+            # with variables set corresponding to the variable fields.
+            my $v = eval_with_fields($insnname, $insn, $rec,  
"constraints", $constraint);
+            if (!$v) {
+                $constraintfailures++;
+                if ($constraintfailures > 10000) {
+                    print "10000 consecutive constraint failures for  
$insnname constraints string:\n$constraint\n";
+                    exit (1);
+                }
+                next INSN;
+            }
+        }
+
+        # OK, we got a good one
+        $constraintfailures = 0;
+
+        my $basereg;    # The GPR that is used to calculate the load  
address
+
+        if (defined $memblock) {
+            # This is a load or store. We simply evaluate the block,
+            # which is expected to be a call to a function which emits
+            # the code to set up the base register and returns the
+            # number of the base register.
+
+            $basereg = eval_with_fields($insnname, $insn, $rec,  
"memory", $memblock);
+        }
+
+        debug_print("0x%x ; %s encoding\n", $insn, $insnname);
+        insn32($insn);
+
+        if (defined $memblock && $basereg >= 0) {
+            # cleanup any updated register
+            write_li($basereg, 0);
+        }
+
+        return;
+    }
+}
+
+# writes the instruction that signals risu
+# input: the signal
+sub write_risuop($)
+{
+    # instr with bits (28:27) == 0 0 are UNALLOCATED
+    my ($op) = @_;
+    debug_print("0x%x ; risu request\n", 0x00005af0 | $op);
+    insn32(0x00005af0 | $op);
+}
+
+# write the addi instruction
+# first input: destination register
+# second input: source register
+# third input: number
+sub write_addi($$$)
+{
+    my ($rD, $rA, $number) = @_;
+
+    debug_print("addi r%d, r%d, %d\n", $rD, $rA, $number);
+    # addi rD, rA, number
+    insn32((0xe << 26) | ($rD << 21) | ($rA << 16) | ($number &  
0xffff));
+}
+
+# writes the mr instruction
+# first input: destination register
+# second input: source register
+sub write_mr($$)
+{
+    my ($rD, $rS) = @_;
+    my $mr_encoding = 31; # it is really a mnemonic for 'or'
+    my $Rc = 0;
+
+    debug_print("mr r%d, r%d\n", $rD, $rS);
+    insn32($mr_encoding << 26 | $rS << 21 | $rD << 16 | $rS << 11 |  
444 << 1 | $Rc);
+}
+
+# writes a stb instruction
+# first input: register number
+# second input: offset from stack pointer
+sub write_stb($$)
+{
+    my ($rS, $offset) = @_;
+    my $stb_encoding = 38;
+    my $stack_pointer = 1;  # r1 is the stack pointer
+    debug_print("stb r$rS, $offset(r1)\n");
+    insn32($stb_encoding << 26 | $rS << 21 | $stack_pointer << 16 |  
$offset);
+}
+
+# writes a stw instruction
+# first input: register number
+# second input: offset from stack pointer
+sub write_stw($$)
+{
+    my ($rS, $offset) = @_;
+    my $stw_encoding = 36;
+    my $stack_pointer = 1;  # r1 is the stack pointer
+    debug_print("stw r$rS, $offset(r1)\n");
+    insn32($stw_encoding << 26 | $rS << 21 | $stack_pointer << 16 |  
$offset);
+}
+
+# writes a lfs instruction
+# first input: floating point register number
+# second input: offset from stack pointer
+sub write_lfs($$)
+{
+    my ($fD, $offset) = @_;
+    my $lfs_encoding = 48;
+    my $stack_pointer = 1; # r1 is the stack pointer
+    debug_print("lfs f$fD, $offset(r1)\n");
+    insn32($lfs_encoding << 26 | $fD << 21 | $stack_pointer << 16 |  
$offset);
+}
+
+# writes a lfd instruction
+# first input: floating point register number
+# second input: offset value
+sub write_lfd($$)
+{
+    my ($fD, $offset) = @_;
+    my $lfd_encoding = 50;
+    my $stack_pointer = 1; # r1 is the stack pointer
+    debug_print("lfd f$fD, $offset(r$stack_pointer)\n");
+    insn32($lfd_encoding << 26 | $fD << 21 | $stack_pointer << 16 |  
$offset);
+}
+
+# write the "li rx, value" instruction
+# first input: the register number
+# second input: the value
+sub write_li($$)
+{
+    my ($rD, $value) = @_;
+    debug_print("li r%d, 0x%x\n", $rD, $value);
+    insn32(0xe << 26 | $rD << 21 | $value);
+}
+
+# writes the lis instruction
+# first input: register number
+# second input: value
+sub write_lis($$)
+{
+    my ($register, $value) = @_;
+    my $lis_encoding = 15;
+    debug_print("lis r%d, 0x%x\n", $register, $value);
+    insn32($lis_encoding << 26 | $register << 21 | 0 << 16 | $value);
+}
+
+# writes the ori instruction
+# first input: destination register
+# second input: source register
+# third input: number
+sub write_ori($$$)
+{
+    my ($dest_reg, $source_reg, $number) = @_;
+    my $ori_encoding = 24;
+    debug_print("ori r%d, r%d, 0x%x\n", $dest_reg, $source_reg,  
$number);
+    insn32($ori_encoding << 26 | $dest_reg << 21 | $source_reg << 16  
| $number);
+}
+
+# writes the mtfsb0 instruction
+# input: fpscr field number
+sub write_mtfsb0($)
+{
+    my $mtfsb0_encoding = 63;
+    my $crbD = $_[0];
+    my $Rc = 0;
+    debug_print("mtfsb0 %d\n", $crbD);
+    insn32($mtfsb0_encoding << 26 | $crbD << 21 | 70 << 1 | $Rc);
+}
+
+# writes the mtfsb1 instruction
+# input: fpscr field number
+sub write_mtfsb1($)
+{
+    my $mtfsb1_encoding = 63;
+    my $crbD = $_[0];
+    my $Rc = 0;
+    debug_print("mtfsb1 %d\n", $crbD);
+    insn32($mtfsb1_encoding << 26 | $crbD << 21 | 38 << 1 | $Rc);
+}
+
+# writes the mtxer instruction
+# first input: source register
+sub write_mtxer($)
+{
+    my ($rS) = @_;
+    my $mtspr_encoding = 31;   # mtxer is really mtspr
+    my $spr = 16;
+    my $raw_encoding;
+
+    debug_print("mtxer r%d\n", $rS);
+    $raw_encoding = $mtspr_encoding << 26 | $rS << 21 | $spr << 12 |  
467 << 1 | 0;
+    insn32($raw_encoding);
+}
+
+# writes the mtcrf instruction
+# first input: condition register mask
+# second input: source register
+sub write_mtcrf($$)
+{
+    my ($CRM, $rS) = @_;
+    my $mtcrf_encoding = 31;
+    debug_print("mtcrf %d, r%d\n", $CRM, $rS);
+    insn32($mtcrf_encoding << 26 | $rS << 21 | $CRM << 12 | 144 << 1);
+}
+
+# setup the testing environment for the lmw instruction
+# first input: general purpose register number
+# second input: general purpose regiser number
+# third input: immediate value
+# ouptut: general purpose register number
+sub setup_lmw_test($$$)
+{
+    my ($rD, $rA, $imm) = @_;
+    for(my $i = 0; $i < (32 - $rD); $i++) {
+        write_li(10, $i);                   # li r10, $i
+        write_stw(10, $imm + ($i * 4));     # stw r10, ($imm + $i *  
4)(r1)
+    }
+    write_mr($rA, 1);                       # mr $rA, r1
+    debug_print("lmw r$rD, $imm(r$rA)\n");
+    return $rA;
+}
+
+# setup the testing environment for the lswi instruction
+# first input: general purpose register number
+# second input: general purpose register number
+# third input: number of bytes to load
+# output: general purpose register number
+sub setup_lswi_test($$$)
+{
+    my ($rD, $rA, $NB) = @_;
+    my $imm;
+
+    write_lis(10, 0xabcd);                      # lis r10, 0x6861
+    write_ori(10, 10, 0xef12);                  # ori r10, r10, 0x636B
+
+    # fill the memory with $NB bytes of data
+    for(my $i = 0; $i < $NB; $i++) {
+        $imm = $available_stack_slot + $i * 4;
+        write_stw(10, $imm);                        # stw r10, $imm(r1)
+    }
+    write_mr($rA, 1);                               # mr $rA, r1
+    write_addi($rA, $rA, $available_stack_slot);    # addi $rA, $rA,  
$available_stack_slot
+    debug_print("lswi r$rD, r$rA, $NB\n");
+    return $rA;
+}
+
+# setup the testing environment for the lswx instruction
+# first input: general purpose register number
+# second input: general purpose register number
+# third input: general purpose register number
+# output: general purpose register number
+sub setup_lswx_test($$$)
+{
+    my ($rD, $rA, $rB) = @_;
+    my $bytes_per_register = 4;   # four bytes can fit in one  
general purpose register
+    my $num_gpr = 32;   # the number of general purpose registers
+
+    # This prevents LSWX from wrapping around and loading r0
+    my $num_bytes = int rand(64);
+    if (($num_bytes/$bytes_per_register) > ($num_gpr - $rD)) {
+        $num_bytes = ($num_gpr - $rD) * $bytes_per_register;
+    }
+
+    # Prevent registers rA and rB from being in the loading path
+
+    my $regA = 0;
+    my $regB = 0;
+    my $closest_register;
+    my $overlap;
+
+    # determine distance from register rD
+    if ($rA - $rD > 0) {
+        $regA = $rA;
+    }
+
+    if ($rB - $rD > 0) {
+        $regB = $rB;
+    }
+
+    # both rA and rB are in the load path
+    if ($regA > 0 && $regB > 0) {
+        # find the register closest to rD
+        $closest_register = ($regA < $regB) ? $regA : $regB;
+    }
+
+    # only rA is in the load path
+    elsif ($regA != 0 && $regB == 0) {
+        $closest_register = $regA;
+    }
+
+    # only rB is in the load path
+    elsif ($regA == 0 && $regB != 0) {
+        $closest_register = $regB;
+    }
+
+    # no register is in the load path
+    else {
+        $closest_register = -1;
+    }
+
+    # calculate new safe value for num_bytes
+    if ($closest_register != -1 && $num_bytes >= ($closest_register  
- $rD) * $bytes_per_register) {
+        $num_bytes = ($closest_register - $rD) * $bytes_per_register;
+    }
+
+    write_li(10, $num_bytes);                            # li r10,  
$num_bytes
+    write_mtxer(10);                                     # mtxer r10
+
+    # Fill memory with values
+    for(my $i = 0; $i < $num_bytes; $i++) {
+        write_li(10, $i + 1);                            # li r10,  
($i+1)
+        write_stb(10, $available_stack_slot + $i);       # stb r10,  
($available_stack_slot + $i)(r1)
+    }
+
+    write_mr($rA, 1);                                    # mr $rA, r1
+    write_li($rB, $available_stack_slot);                # li $rB,  
$available_stack_slot
+
+    debug_print("lswx r$rD, r$rA, r$rB ; xer:$num_bytes\n");
+
+    return $rA;
+}
+
+# writes the code that sets the general purpose registers
+sub write_init_gpr_code()
+{
+    # Set the general purpose registers to a value.
+    # Register r1 is the stack pointer.
+    # It is left alone.
+    for (my $i = 0; $i < 32; $i++) {
+        if ($i == 1) {
+            next;
+        }
+        write_li($i, $i + 1);
+    }
+}
+
+# set the initial value to all floating point registers
+sub write_init_float_registers_code()
+{
+    my $value = 1.1;
+    my $ieee_value;
+    my $ieee_high_bits; # the upper 16 bits of $ieee_value
+    my $ieee_low_bits;  # the lower 16 bits of $ieee_value
+
+    for(my $i = 0; $i < 32; $i++) {
+        $ieee_value = convert_to_IEEE($value + $i);
+        $ieee_high_bits = $ieee_value >> 16;
+        $ieee_low_bits = $ieee_value & 0xffff;
+        write_lis(10, $ieee_high_bits);         # lis r10,  
$ieee_high_bits
+        write_ori(10, 10, $ieee_low_bits);      # ori r10, r10,  
$ieee_low_bits
+        write_stw(10, $available_stack_slot);   # stw r10,  
$available_stack_slot(r1)
+        write_lfs($i, $available_stack_slot);   # lfs fD,  
$available_stack_slot(r1)
+    }
+}
+
+# set the fpscr to the requested value
+# input: value
+sub write_init_fpscr_code($)
+{
+    my ($value) = @_;
+    my $num_fpscr_fields = 32;
+
+    for (my $i = 0; $i < $num_fpscr_fields; $i++) {
+        if (($value >> $i) & 0x1) {
+            write_mtfsb1($i);
+        }
+        else {
+            write_mtfsb0($i);
+        }
+    }
+}
+
+# sets the xer register to zero
+sub write_init_xer_code()
+{
+    my $rS = 10;
+    my $value = 0;
+    write_li($rS, $value);
+    write_mtxer($rS);
+}
+
+# sets the lr to zero
+sub write_init_lr_code()
+{
+    my $rS = 10;
+    my $value = 0;
+    write_li($rS, $value);
+    debug_print("mtlr r%d\n", $rS);
+    insn32(0x7d4803a6);
+}
+
+# set the ctr to zero
+sub write_init_ctr_code()
+{
+    my $rS = 10;
+    my $value = 0;
+    write_li($rS, $value);
+    debug_print("mtctr r%d\n", $rS);
+    insn32(0x7d4903a6);
+}
+
+
+# set the condition register to zero
+sub write_init_cr_code()
+{
+    my $r10 = 10;
+    my $value = 0;
+    my $CRM = 0xff;
+    write_li($r10, $value);
+    write_mtcrf($CRM, $r10);
+}
+
+# This is called by the risugen program.
+# Execution starts here.
+# input: hash
+sub write_test_code($)
+{
+    my ($params) = @_;
+    my $numinsns = $params->{ 'numinsns' };
+    my $fp_enabled = $params->{ 'fp_enabled' };
+    my $outfile = $params->{ 'outfile' };
+    my $fpscr = $params->{ 'fpscr' };
+    my @pattern_re = @{ $params->{ 'pattern_re' } };
+    my @not_pattern_re = @{ $params->{ 'not_pattern_re' } };
+    my %insn_details = %{ $params->{ 'details' } };
+
+    set_endian(1);   # Set to big endian
+    open_bin($outfile);
+    srand();
+
+    # Get a list of the insn keys which are permitted by the re  
patterns
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
+        print STDERR "No instruction patterns available! (bad config  
file or --pattern argument?)\n";
+        exit(1);
+    }
+    print "Generating code using patterns: @keys...\n";
+    progress_start(78, $numinsns);
+
+    # initialize all the UISA registers
+    write_init_gpr_code();
+
+    if ($fp_enabled) {
+        write_init_float_registers_code();
+        write_init_fpscr_code($fpscr);
+    }
+
+    write_init_xer_code();
+    write_init_lr_code();
+    write_init_ctr_code();
+    write_init_cr_code();
+    write_risuop($OP_COMPARE);
+
+    for my $i (1..$numinsns) {
+        my $insn_enc = $keys[int rand (@keys)];
+        #dump_insn_details($insn_enc, $insn_details{$insn_enc});
+        gen_one_insn($insn_details{$insn_enc});
+        write_risuop($OP_COMPARE);
+      if ($debug != 1) {
+          progress_update($i);
+      }
+    }
+    write_risuop($OP_TESTEND);
+    progress_end();
+    close_bin();
+}
+
+1;
-- 
2.10.2
