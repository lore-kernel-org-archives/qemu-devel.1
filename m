Received: from eggs.gnu.org ([2001:4830:134:3::10]:34859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SO-0005ul-Vf
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SH-00007K-7h
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:28 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eC5SG-00006a-VB
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:21 -0500
Received: by mail-wr0-x244.google.com with SMTP id y9so12133703wrb.2
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:06:20 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Nov 2017 15:05:55 +0000
Message-Id: <20171107150558.22131-8-alex.bennee@linaro.org>
In-Reply-To: <20171107150558.22131-1-alex.bennee@linaro.org>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 07/10] risugen: add --sve support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Dave.Martin@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is similar to the approach used by the FP/simd data in so far as
we generate a block of random data and then load into it. As there are
no post-index SVE operations we need to emit an additional incp
instruction to generate our offset into the array.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risugen        |  3 +++
 risugen_arm.pm | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/risugen b/risugen
index aba4bb7..0ac8e86 100755
--- a/risugen
+++ b/risugen
@@ -317,6 +317,7 @@ sub main()
     my $condprob = 0;
     my $fpscr = 0;
     my $fp_enabled = 1;
+    my $sve_enabled = 1;
     my $big_endian = 0;
     my ($infile, $outfile);
 
@@ -334,6 +335,7 @@ sub main()
                 },
                 "be" => sub { $big_endian = 1; },
                 "no-fp" => sub { $fp_enabled = 0; },
+                "sve" => sub { $sve_enabled = 1; },
         ) or return 1;
     # allow "--pattern re,re" and "--pattern re --pattern re"
     @pattern_re = split(/,/,join(',',@pattern_re));
@@ -361,6 +363,7 @@ sub main()
         'fpscr' => $fpscr,
         'numinsns' => $numinsns,
         'fp_enabled' => $fp_enabled,
+        'sve_enabled' => $sve_enabled,
         'outfile' => $outfile,
         'details' => \%insn_details,
         'keys' => \@insn_keys,
diff --git a/risugen_arm.pm b/risugen_arm.pm
index 2f10d58..8d1e1fd 100644
--- a/risugen_arm.pm
+++ b/risugen_arm.pm
@@ -472,9 +472,47 @@ sub write_random_aarch64_fpdata()
     }
 }
 
-sub write_random_aarch64_regdata($)
+sub write_random_aarch64_svedata()
 {
-    my ($fp_enabled) = @_;
+    # Load SVE registers
+    my $align = 16;
+    my $vl = 16;                             # number of vqs
+    my $datalen = (32 * $vl * 16) + $align;
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
+        for (my $q = 0; $q < $vl; $q++) {
+            write_random_fpreg_var(4); # quad
+        }
+    }
+
+    # Reset all the predicate registers to all true
+    for (my $p = 0; $p < 16; $p++) {
+        insn32(0x2518e3e0 | $p);
+    }
+
+    # there is no post index load so we do this by hand
+    write_mov_ri(1, 0);
+    for (my $rt = 0; $rt <= 31; $rt++) {
+        # ld1d    z0.d, p0/z, [x0, x1, lsl #3]
+        insn32(0xa5e14000 | $rt);
+        # incp    x1, p0.d
+        insn32(0x25ec8801);
+    }
+}
+
+sub write_random_aarch64_regdata($$)
+{
+    my ($fp_enabled, $sve_enabled) = @_;
     # clear flags
     insn32(0xd51b421f);     # msr nzcv, xzr
 
@@ -483,6 +521,10 @@ sub write_random_aarch64_regdata($)
         write_random_aarch64_fpdata();
     }
 
+    if ($sve_enabled) {
+        write_random_aarch64_svedata();
+    }
+
     # general purpose registers
     for (my $i = 0; $i <= 30; $i++) {
         # TODO full 64 bit pattern instead of 32
@@ -490,12 +532,12 @@ sub write_random_aarch64_regdata($)
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
@@ -893,6 +935,7 @@ sub write_test_code($$$$$$$$)
     my $fpscr = $params->{ 'fpscr' };
     my $numinsns = $params->{ 'numinsns' };
     my $fp_enabled = $params->{ 'fp_enabled' };
+    my $sve_enabled = $params->{ 'sve_enabled' };
     my $outfile = $params->{ 'outfile' };
 
     my %insn_details = %{ $params->{ 'details' } };
@@ -918,7 +961,7 @@ sub write_test_code($$$$$$$$)
         write_memblock_setup();
     }
     # memblock setup doesn't clean its registers, so this must come afterwards.
-    write_random_register_data($fp_enabled);
+    write_random_register_data($fp_enabled, $sve_enabled);
     write_switch_to_test_mode();
 
     for my $i (1..$numinsns) {
@@ -930,7 +973,7 @@ sub write_test_code($$$$$$$$)
         # Rewrite the registers periodically. This avoids the tendency
         # for the VFP registers to decay to NaNs and zeroes.
         if ($periodic_reg_random && ($i % 100) == 0) {
-            write_random_register_data($fp_enabled);
+            write_random_register_data($fp_enabled, $sve_enabled);
             write_switch_to_test_mode();
         }
         progress_update($i);
-- 
2.14.2
