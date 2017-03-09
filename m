Received: from eggs.gnu.org ([2001:4830:134:3::10]:45380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cm2yU-0002Ui-7x
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cm2yQ-0002hN-Bn
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:39:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40101
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cm2yQ-0002hD-5y
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:39:38 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v29IcddU040163
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 13:39:36 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0b-001b2d01.pphosted.com with ESMTP id 292mrm8eay-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 13:39:36 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 9 Mar 2017 15:39:34 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v29IdObY33882228
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 15:39:32 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v29Id1MF022511
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 15:39:01 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Thu,  9 Mar 2017 15:38:36 -0300
In-Reply-To: <1489084718-15294-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1489084718-15294-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1489084718-15294-2-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu v2 1/3] risugen_ppc64: Load random 128-bit
 data to VSX registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 risugen_ppc64.pm | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/risugen_ppc64.pm b/risugen_ppc64.pm
index 341478c..45f7220 100644
--- a/risugen_ppc64.pm
+++ b/risugen_ppc64.pm
@@ -99,6 +99,29 @@ sub write_mov_ri64($$)
     insn32((0x3e << 26) | (20 << 21) | (1 << 16) | 0x10);
 }
 
+sub write_mov_ri128($$$$)
+{
+    my ($imhh, $imh, $iml, $imll) = @_;
+
+    # store the lowest 32 bits
+    write_mov_ri32(20, $imll);
+    # stw r20, 16(r1)
+    insn32((0x24 << 26) | (20 << 21) | (1 << 16) | 0x10);
+    # store the lower 32 bits
+    write_mov_ri32(20, $iml);
+    # stw r20, 20(r1)
+    insn32((0x24 << 26) | (20 << 21) | (1 << 16) | 0x14);
+    # store the higher 32 bits
+    write_mov_ri32(20, $imh);
+    # stw r20, 24(r1)
+    insn32((0x24 << 26) | (20 << 21) | (1 << 16) | 0x18);
+    # store the highest 32 bits
+    write_mov_ri32(20, $imhh);
+    # stw r20, 28(r1)
+    insn32((0x24 << 26) | (20 << 21) | (1 << 16) | 0x1c);
+
+}
+
 sub write_random_ppc64_fpdata()
 {
     for (my $i = 0; $i < 32; $i++) {
@@ -106,22 +129,16 @@ sub write_random_ppc64_fpdata()
         write_mov_ri64(rand(0xfffff), rand(0xfffff));
         # since the EA is r1+16, load such value in FP reg
         insn32((0x32 << 26) | ($i << 21) | (0x1 << 16) | 0x10);
-        insn32((0x39 << 26) | ($i << 21) | (0x1 << 16) | 0x12);
-
     }
 }
 
-sub write_random_ppc64_fpdata_i()
+sub write_random_ppc64_vsxdata()
 {
-    # get an space from the stack
-    insn32(0x3ac10020); # addi r22, r1, 32
-    insn32(0x3ee03ff0); # lis r23, 0x3ff0
-    insn32(0x3af70000); # addi r23, r23, 0
-    insn32(0xfaf60000); # std r23, 0(r22)
-
     for (my $i = 0; $i < 32; $i++) {
-        # lfd f$i, 0(r22)
-        insn32((0x32 << 26 | $i << 21 | 0x16 << 16));
+        # load a random doubleword value at r0
+        write_mov_ri128(rand(0xffff), rand(0xffff), rand(0xfffff), rand(0xfffff));
+        # load the 128-bit data in a vector register
+        insn32((0x3d << 26) | (($i >> 1) << 21) | (0x1 << 16) | (0x10 << 5) | (($i & 1) << 4) | 0x1);
     }
 }
 
@@ -172,6 +189,7 @@ sub write_random_register_data($)
 
     clear_vr_registers();
 
+    write_random_ppc64_vsxdata();
     if ($fp_enabled) {
         # load floating point / SIMD registers
         write_random_ppc64_fpdata();
-- 
2.7.4
