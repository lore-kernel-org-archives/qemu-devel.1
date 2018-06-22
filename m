Received: from eggs.gnu.org ([2001:4830:134:3::10]:38594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnQ-00068q-R9
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnP-0006Aj-Or
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:16 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:40645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMnP-00069y-II
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:15 -0400
Received: by mail-wm0-x234.google.com with SMTP id n5-v6so2762645wmc.5
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:12:15 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:52 +0100
Message-Id: <20180622141205.16306-10-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 09/22] risugen: use fewer insns for
 aarch64 immediate load
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
 risugen_arm.pm | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/risugen_arm.pm b/risugen_arm.pm
index 83e521d..485e94e 100644
--- a/risugen_arm.pm
+++ b/risugen_arm.pm
@@ -261,15 +261,13 @@ sub write_mov_rr($$)
 
 sub write_mov_ri16($$$)
 {
-    # Write 16 bits of immediate to register, using either MOVW or MOVT
+    # Write 16 bits of immediate to register.
     my ($rd, $imm, $is_movt) = @_;
-    die "write_mov_ri16: immediate $imm out of range\n" if (($imm & 0xffff0000) != 0);
 
-    if ($is_aarch64) {
-        # Use MOVZ 0x52800000. is_movt means MOVK of high bits */
-        insn32(0xd2800000 | ($is_movt << 29) | ($is_movt ? 16 << 17 : 0) | ($imm << 5) | $rd);
+    die "write_mov_ri16: invalid operation for this arch.\n" if ($is_aarch64);
+    die "write_mov_ri16: immediate $imm out of range\n" if (($imm & 0xffff0000) != 0);
 
-    } elsif ($is_thumb) {
+    if ($is_thumb) {
         # enc T3
         my ($imm4, $i, $imm3, $imm8) = (($imm & 0xf000) >> 12,
                                         ($imm & 0x0800) >> 11,
@@ -287,16 +285,24 @@ sub write_mov_ri16($$$)
 
 sub write_mov_ri($$)
 {
-    # We always use a MOVW/MOVT pair, for simplicity.
-    # on aarch64, we use a MOVZ/MOVK pair.
     my ($rd, $imm) = @_;
-    write_mov_ri16($rd, ($imm & 0xffff), 0);
     my $highhalf = ($imm >> 16) & 0xffff;
-    write_mov_ri16($rd, $highhalf, 1) if $highhalf;
 
-    if ($is_aarch64 && $imm < 0) {
-        # sign extend to allow small negative imm constants
-        write_sxt32($rd, $rd);
+    if ($is_aarch64) {
+        if ($imm < 0) {
+            # MOVN
+            insn32(0x92800000 | ((~$imm & 0xffff) << 5) | $rd);
+            # MOVK, LSL 16
+            insn32(0xf2a00000 | ($highhalf << 5) | $rd) if $highhalf != 0xffff;
+        } else {
+            # MOVZ
+            insn32(0x52800000 | (($imm & 0xffff) << 5) | $rd);
+            # MOVK, LSL 16
+            insn32(0xf2a00000 | ($highhalf << 5) | $rd) if $highhalf != 0;
+        }
+    } else {
+        write_mov_ri16($rd, ($imm & 0xffff), 0);
+        write_mov_ri16($rd, $highhalf, 1) if $highhalf;
     }
 }
 
-- 
2.17.1
