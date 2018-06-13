Received: from eggs.gnu.org ([2001:4830:134:3::10]:50431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5Jr-0002dW-OT
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5Jq-0005A2-Ht
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:11 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fT5Jq-00057n-9O
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:10 -0400
Received: by mail-wr0-x241.google.com with SMTP id e18-v6so2661475wrs.5
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 05:56:10 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 13 Jun 2018 13:55:47 +0100
Message-Id: <20180613125601.14371-9-alex.bennee@linaro.org>
In-Reply-To: <20180613125601.14371-1-alex.bennee@linaro.org>
References: <20180613125601.14371-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 08/22] risugen: Initialize sve
 predicates with random data
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

From: Richard Henderson <richard.henderson@linaro.org>

Using ptrue makes most of the uses of predicates trivial.
Therefore, initialize them to something interesting.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risugen_arm.pm | 48 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/risugen_arm.pm b/risugen_arm.pm
index bb3ee90..83e521d 100644
--- a/risugen_arm.pm
+++ b/risugen_arm.pm
@@ -174,6 +174,24 @@ sub write_sxt32($$)
     insn32(0x93407c00 | $rn << 5 | $rd);
 }
 
+sub write_add_rri($$$)
+{
+    my ($rd, $rn, $i) = @_;
+    my $sh;
+
+    die "write_add_rri: invalid operation for this arch.\n" if (!$is_aarch64);
+
+    if ($i >= 0 && $i < 0x1000) {
+        $sh = 0;
+    } elsif (($i & 0xfff) || $i >= 0x1000000) {
+        die "invalid immediate for this arch,\n";
+    } else {
+        $sh = 1;
+        $i >>= 12;
+    }
+    insn32(0x91000000 | ($rd << 0) | ($rn << 5) | ($i << 10) | ($sh << 22));
+}
+
 sub write_sub_rrr($$$)
 {
     my ($rd, $rn, $rm) = @_;
@@ -477,33 +495,35 @@ sub write_random_aarch64_svedata()
     # Load SVE registers
     my $align = 16;
     my $vq = 16;                             # quadwords per vector
-    my $datalen = (32 * $vq * 16) + $align;
-
-    write_pc_adr(0, (3 * 4) + ($align - 1)); # insn 1
-    write_align_reg(0, $align);              # insn 2
-    write_jump_fwd($datalen);                # insn 3
+    my $veclen = 32 * $vq * 16;
+    my $predlen = 16 * $vq * 2;
+    my $datalen = $veclen + $predlen;
 
-    # align safety
-    for (my $i = 0; $i < ($align / 4); $i++) {
-        # align with nops
-        insn32(0xd503201f);
-    };
+    write_pc_adr(0, 2 * 4);     # insn 1
+    write_jump_fwd($datalen);   # insn 2
 
     for (my $rt = 0; $rt <= 31; $rt++) {
         for (my $q = 0; $q < $vq; $q++) {
             write_random_fpreg_var(4); # quad
         }
     }
-
-    # Reset all the predicate registers to all true
-    for (my $p = 0; $p < 16; $p++) {
-        insn32(0x2518e3e0 | $p);
+    for (my $rt = 0; $rt <= 15; $rt++) {
+        for (my $q = 0; $q < $vq; $q++) {
+            insn16(rand(0xffff));
+        }
     }
 
     for (my $rt = 0; $rt <= 31; $rt++) {
         # ldr z$rt, [x0, #$rt, mul vl]
         insn32(0x85804000 + $rt + (($rt & 7) << 10) + (($rt & 0x18) << 13));
     }
+
+    write_add_rri(0, 0, $veclen);
+
+    for (my $rt = 0; $rt <= 15; $rt++) {
+        # ldr p$rt, [x0, #$pt, mul vl]
+        insn32(0x85800000 + $rt + (($rt & 7) << 10) + (($rt & 0x18) << 13));
+    }
 }
 
 sub write_random_aarch64_regdata($$)
-- 
2.17.1
