Received: from eggs.gnu.org ([2001:4830:134:3::10]:42235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpvF-0003r7-B6
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpvC-0000ET-5D
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cZpvB-0000E8-Ri
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:50 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1428cWU085105
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 21:17:48 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28cyk3tygd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 21:17:48 -0500
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Sat, 4 Feb 2017 00:17:45 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 4903C1DC0054
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 21:17:43 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v142HgjV37224528
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:42 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v142HgQn012034
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:42 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Sat,  4 Feb 2017 00:17:19 -0200
In-Reply-To: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1486174642-14883-5-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 4/7] risu_ppc64le: implement FP random
 data for test improvement
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

This commit replaces the simple FP data written for tests for a
randomically generated one. This functionality stores the same data in
FP register and VSX[VRB+32] registers.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 risugen_ppc64.pm | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/risugen_ppc64.pm b/risugen_ppc64.pm
index 561c17b..8e323a2 100644
--- a/risugen_ppc64.pm
+++ b/risugen_ppc64.pm
@@ -100,8 +100,39 @@ sub write_mov_ri($$)
     }
 }
 
+sub write_mov_ri64($$)
+{
+    my ($imh, $iml) = @_;
+
+    # number of bit to shift
+    write_mov_ri16(19, 31);
+    # load the highest 32 bits
+    write_mov_ri32(20, $iml);
+    # shift left 32 bits (sld r20, r20, r19
+    insn32((0x1f << 26) | (20 << 21) | (20 << 16) | (19 << 11) | 0x36);
+    # write the lowest 32bits
+    write_mov_ri32(21, $imh);
+    # or r20, r20, r21
+    insn32((0x1f << 26) | (20 << 21) | (20 << 16) | (21 << 11) | 0x378);
+
+    # std r20, 16(r1)
+    insn32((0x3e << 26) | (20 << 21) | (1 << 16) | 0x10);
+}
+
 sub write_random_ppc64_fpdata()
 {
+    for (my $i = 0; $i < 32; $i++) {
+        # load a random doubleword value at r0
+        write_mov_ri64(rand(0xfffff), rand(0xfffff));
+        # since the EA is r1+16, load such value in FP reg
+        insn32((0x32 << 26) | ($i << 21) | (0x1 << 16) | 0x10);
+        insn32((0x39 << 26) | ($i << 21) | (0x1 << 16) | 0x12);
+
+    }
+}
+
+sub write_random_ppc64_fpdata_i()
+{
     # get an space from the stack
     insn32(0x3ac10020); # addi r22, r1, 32
     insn32(0x3ee03ff0); # lis r23, 0x3ff0
-- 
2.7.4
