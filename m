Received: from eggs.gnu.org ([2001:4830:134:3::10]:38653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnS-0006Bq-Vp
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnR-0006CD-Km
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:18 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMnR-0006BR-6E
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:17 -0400
Received: by mail-wr0-x243.google.com with SMTP id p12-v6so5237988wrn.11
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:12:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:53 +0100
Message-Id: <20180622141205.16306-11-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 10/22] risugen: add reg_plus_imm_pl and
 reg_plus_imm_vl address helpers
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risugen_arm.pm | 126 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/risugen_arm.pm b/risugen_arm.pm
index 485e94e..696bf5f 100644
--- a/risugen_arm.pm
+++ b/risugen_arm.pm
@@ -306,6 +306,52 @@ sub write_mov_ri($$)
     }
 }
 
+sub write_addpl_rri($$$)
+{
+    my ($rd, $rn, $imm) = @_;
+    die "write_addpl: invalid operation for this arch.\n" if (!$is_aarch64);
+
+    insn32(0x04605000 | ($rn << 16) | (($imm & 0x3f) << 5) | $rd);
+}
+
+sub write_addvl_rri($$$)
+{
+    my ($rd, $rn, $imm) = @_;
+    die "write_addvl: invalid operation for this arch.\n" if (!$is_aarch64);
+
+    insn32(0x04205000 | ($rn << 16) | (($imm & 0x3f) << 5) | $rd);
+}
+
+sub write_rdvl_ri($$)
+{
+    my ($rd, $imm) = @_;
+    die "write_rdvl: invalid operation for this arch.\n" if (!$is_aarch64);
+
+    insn32(0x04bf5000 | (($imm & 0x3f) << 5) | $rd);
+}
+
+sub write_madd_rrrr($$$$)
+{
+    my ($rd, $rn, $rm, $ra) = @_;
+    die "write_madd: invalid operation for this arch.\n" if (!$is_aarch64);
+
+    insn32(0x9b000000 | ($rm << 16) | ($ra << 10) | ($rn << 5) | $rd);
+}
+
+sub write_msub_rrrr($$$$)
+{
+    my ($rd, $rn, $rm, $ra) = @_;
+    die "write_msub: invalid operation for this arch.\n" if (!$is_aarch64);
+
+    insn32(0x9b008000 | ($rm << 16) | ($ra << 10) | ($rn << 5) | $rd);
+}
+
+sub write_mul_rrr($$$)
+{
+    my ($rd, $rn, $rm) = @_;
+    write_madd_rrrr($rd, $rn, $rm, 31);
+}
+
 # write random fp value of passed precision (1=single, 2=double, 4=quad)
 sub write_random_fpreg_var($)
 {
@@ -767,6 +813,86 @@ sub reg_plus_imm($$@)
     return $base;
 }
 
+sub reg_plus_imm_pl($$@)
+{
+    # Handle reg + immediate addressing mode
+    my ($base, $imm, @trashed) = @_;
+    if ($imm == 0) {
+        return reg($base, @trashed);
+    }
+    write_get_offset();
+
+    # Now r0 is the address we want to do the access to,
+    # so set the basereg by doing the inverse of the
+    # addressing mode calculation, ie base = r0 - imm
+    #
+    # Note that addpl has a 6-bit immediate, but ldr has a 9-bit
+    # immediate, so we need to be able to support larger immediates.
+
+    if (-$imm >= -32 && -$imm <= 31) {
+        write_addpl_rri($base, 0, -$imm);
+    } else {
+        # We borrow r1 and r2 as a temporaries (not a problem
+        # as long as we don't leave anything in a register
+        # which depends on the location of the memory block)
+        write_mov_ri(1, 0);
+        write_mov_ri(2, $imm);
+        write_addpl_rri(1, 1, 1);
+        write_msub_rrrr($base, 1, 2, 0);
+    }
+    if (grep $_ == $base, @trashed) {
+        return -1;
+    }
+    return $base;
+}
+
+sub reg_plus_imm_vl($$@)
+{
+    # The usual address formulation is
+    #   elements = VL DIV esize
+    #   mbytes = msize DIV 8
+    #   addr = base + imm * elements * mbytes
+    # Here we compute
+    #   scale = log2(esize / msize)
+    #   base + (imm * VL) >> scale
+    my ($base, $imm, $scale, @trashed) = @_;
+    if ($imm == 0) {
+        return reg($base, @trashed);
+    }
+    write_get_offset();
+
+    # Now r0 is the address we want to do the access to,
+    # so set the basereg by doing the inverse of the
+    # addressing mode calculation, ie base = r0 - imm
+    #
+    # Note that rdvl/addvl have a 6-bit immediate, but ldr has a 9-bit
+    # immediate, so we need to be able to support larger immediates.
+
+    use integer;
+    my $mul = 1 << $scale;
+    my $imm_div = $imm / $mul;
+
+    if ($imm == $imm_div * $mul && -$imm_div >= -32 && -$imm_div <= 31) {
+        write_addvl_rri($base, 0, -$imm_div);
+    } elsif ($imm >= -32 && $imm <= 31) {
+        write_rdvl_ri(1, $imm);
+        write_sub_rrrs($base, 0, 1, $SHIFT_ASR, $scale);
+    } else {
+        write_rdvl_ri(1, 1);
+        write_mov_ri(2, $imm);
+        if ($scale == 0) {
+            write_msub_rrrr($base, 1, 2, 0);
+        } else {
+            write_mul_rrr(1, 1, 2);
+            write_sub_rrrs($base, 0, 1, $SHIFT_ASR, $scale);
+        }
+    }
+    if (grep $_ == $base, @trashed) {
+        return -1;
+    }
+    return $base;
+}
+
 sub reg_minus_imm($$@)
 {
     my ($base, $imm, @trashed) = @_;
-- 
2.17.1
