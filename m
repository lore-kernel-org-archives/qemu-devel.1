Received: from eggs.gnu.org ([2001:4830:134:3::10]:38567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnQ-000689-1V
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnO-00069p-LD
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:15 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:43966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMnO-00068m-3p
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:14 -0400
Received: by mail-wr0-x241.google.com with SMTP id d2-v6so6830565wrm.10
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:12:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:50 +0100
Message-Id: <20180622141205.16306-8-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 07/22] risugen: add --sve support
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

This is similar to the approach used by the FP/simd data in so far as
we generate a block of random data and then load into it. The loading
is actually done by the current vector length but that is implicit in
the run anyway.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - only one SIMD/FP/SVE block as they alias
  - move efficient loading as suggested by Dave
---
 risugen        |  3 +++
 risugen_arm.pm | 56 ++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/risugen b/risugen
index 488d804..de3f5ea 100755
--- a/risugen
+++ b/risugen
@@ -319,6 +319,7 @@ sub main()
     my $condprob = 0;
     my $fpscr = 0;
     my $fp_enabled = 1;
+    my $sve_enabled = 1;
     my $big_endian = 0;
     my ($infile, $outfile);
 
@@ -336,6 +337,7 @@ sub main()
                 },
                 "be" => sub { $big_endian = 1; },
                 "no-fp" => sub { $fp_enabled = 0; },
+                "sve" => sub { $sve_enabled = 1; },
         ) or return 1;
     # allow "--pattern re,re" and "--pattern re --pattern re"
     @pattern_re = split(/,/,join(',',@pattern_re));
@@ -363,6 +365,7 @@ sub main()
         'fpscr' => $fpscr,
         'numinsns' => $numinsns,
         'fp_enabled' => $fp_enabled,
+        'sve_enabled' => $sve_enabled,
         'outfile' => $outfile,
         'details' => \%insn_details,
         'keys' => \@insn_keys,
diff --git a/risugen_arm.pm b/risugen_arm.pm
index 2f10d58..bb3ee90 100644
--- a/risugen_arm.pm
+++ b/risugen_arm.pm
@@ -472,14 +472,51 @@ sub write_random_aarch64_fpdata()
     }
 }
 
-sub write_random_aarch64_regdata($)
+sub write_random_aarch64_svedata()
 {
-    my ($fp_enabled) = @_;
+    # Load SVE registers
+    my $align = 16;
+    my $vq = 16;                             # quadwords per vector
+    my $datalen = (32 * $vq * 16) + $align;
+
+    write_pc_adr(0, (3 * 4) + ($align - 1)); # insn 1
+    write_align_reg(0, $align);              # insn 2
+    write_jump_fwd($datalen);                # insn 3
+
+    # align safety
+    for (my $i = 0; $i < ($align / 4); $i++) {
+        # align with nops
+        insn32(0xd503201f);
+    };
+
+    for (my $rt = 0; $rt <= 31; $rt++) {
+        for (my $q = 0; $q < $vq; $q++) {
+            write_random_fpreg_var(4); # quad
+        }
+    }
+
+    # Reset all the predicate registers to all true
+    for (my $p = 0; $p < 16; $p++) {
+        insn32(0x2518e3e0 | $p);
+    }
+
+    for (my $rt = 0; $rt <= 31; $rt++) {
+        # ldr z$rt, [x0, #$rt, mul vl]
+        insn32(0x85804000 + $rt + (($rt & 7) << 10) + (($rt & 0x18) << 13));
+    }
+}
+
+sub write_random_aarch64_regdata($$)
+{
+    my ($fp_enabled, $sve_enabled) = @_;
     # clear flags
     insn32(0xd51b421f);     # msr nzcv, xzr
 
-    if ($fp_enabled) {
-        # load floating point / SIMD registers
+    # Load floating point / SIMD registers
+    # (one or the other as they overlap)
+    if ($sve_enabled) {
+        write_random_aarch64_svedata();
+    } elsif ($fp_enabled) {
         write_random_aarch64_fpdata();
     }
 
@@ -490,12 +527,12 @@ sub write_random_aarch64_regdata($)
     }
 }
 
-sub write_random_register_data($)
+sub write_random_register_data($$)
 {
-    my ($fp_enabled) = @_;
+    my ($fp_enabled, $sve_enabled) = @_;
 
     if ($is_aarch64) {
-        write_random_aarch64_regdata($fp_enabled);
+        write_random_aarch64_regdata($fp_enabled, $sve_enabled);
     } else {
         write_random_arm_regdata($fp_enabled);
     }
@@ -893,6 +930,7 @@ sub write_test_code($$$$$$$$)
     my $fpscr = $params->{ 'fpscr' };
     my $numinsns = $params->{ 'numinsns' };
     my $fp_enabled = $params->{ 'fp_enabled' };
+    my $sve_enabled = $params->{ 'sve_enabled' };
     my $outfile = $params->{ 'outfile' };
 
     my %insn_details = %{ $params->{ 'details' } };
@@ -918,7 +956,7 @@ sub write_test_code($$$$$$$$)
         write_memblock_setup();
     }
     # memblock setup doesn't clean its registers, so this must come afterwards.
-    write_random_register_data($fp_enabled);
+    write_random_register_data($fp_enabled, $sve_enabled);
     write_switch_to_test_mode();
 
     for my $i (1..$numinsns) {
@@ -930,7 +968,7 @@ sub write_test_code($$$$$$$$)
         # Rewrite the registers periodically. This avoids the tendency
         # for the VFP registers to decay to NaNs and zeroes.
         if ($periodic_reg_random && ($i % 100) == 0) {
-            write_random_register_data($fp_enabled);
+            write_random_register_data($fp_enabled, $sve_enabled);
             write_switch_to_test_mode();
         }
         progress_update($i);
-- 
2.17.1
