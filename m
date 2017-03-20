Received: from eggs.gnu.org ([2001:4830:134:3::10]:41333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qs-0001rv-Eq
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Ql-00054A-PD
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Ql-000537-EF
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:39 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8YBx109652
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:38 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ak40pc5t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:38 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:37 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:15 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-52-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 51/81] tcg/aarch64: Fix tcg_out_movi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

There were some patterns, like 0x0000_ffff_ffff_00ff, for which we
would select to begin a multi-insn sequence with MOVN, but would
fail to set the 0x0000 lane back from 0xffff.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20161207180727.6286-3-rth@twiddle.net>
(cherry picked from commit 8cf9a3d3f7a4b95f33e0bda5416b9c93ec887dd3)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tcg/aarch64/tcg-target.inc.c | 57 +++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 6c68681..2d7cc35 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -581,11 +581,9 @@ static void tcg_out_logicali(TCGContext *s, AArch64Insn insn, TCGType ext,
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
                          tcg_target_long value)
 {
-    AArch64Insn insn;
     int i, wantinv, shift;
     tcg_target_long svalue = value;
     tcg_target_long ivalue = ~value;
-    tcg_target_long imask;
 
     /* For 32-bit values, discard potential garbage in value.  For 64-bit
        values within [2**31, 2**32-1], we can create smaller sequences by
@@ -631,42 +629,35 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
 
     /* Would it take fewer insns to begin with MOVN?  For the value and its
        inverse, count the number of 16-bit lanes that are 0.  */
-    for (i = wantinv = imask = 0; i < 64; i += 16) {
+    for (i = wantinv = 0; i < 64; i += 16) {
         tcg_target_long mask = 0xffffull << i;
-        if ((value & mask) == 0) {
-            wantinv -= 1;
-        }
-        if ((ivalue & mask) == 0) {
-            wantinv += 1;
-            imask |= mask;
-        }
+        wantinv -= ((value & mask) == 0);
+        wantinv += ((ivalue & mask) == 0);
     }
 
-    /* If we had more 0xffff than 0x0000, invert VALUE and use MOVN.  */
-    insn = I3405_MOVZ;
-    if (wantinv > 0) {
-        value = ivalue;
-        insn = I3405_MOVN;
-    }
-
-    /* Find the lowest lane that is not 0x0000.  */
-    shift = ctz64(value) & (63 & -16);
-    tcg_out_insn_3405(s, insn, type, rd, value >> shift, shift);
-
-    if (wantinv > 0) {
-        /* Re-invert the value, so MOVK sees non-inverted bits.  */
-        value = ~value;
-        /* Clear out all the 0xffff lanes.  */
-        value ^= imask;
-    }
-    /* Clear out the lane that we just set.  */
-    value &= ~(0xffffUL << shift);
-
-    /* Iterate until all lanes have been set, and thus cleared from VALUE.  */
-    while (value) {
+    if (wantinv <= 0) {
+        /* Find the lowest lane that is not 0x0000.  */
         shift = ctz64(value) & (63 & -16);
-        tcg_out_insn(s, 3405, MOVK, type, rd, value >> shift, shift);
+        tcg_out_insn(s, 3405, MOVZ, type, rd, value >> shift, shift);
+        /* Clear out the lane that we just set.  */
         value &= ~(0xffffUL << shift);
+        /* Iterate until all non-zero lanes have been processed.  */
+        while (value) {
+            shift = ctz64(value) & (63 & -16);
+            tcg_out_insn(s, 3405, MOVK, type, rd, value >> shift, shift);
+            value &= ~(0xffffUL << shift);
+        }
+    } else {
+        /* Like above, but with the inverted value and MOVN to start.  */
+        shift = ctz64(ivalue) & (63 & -16);
+        tcg_out_insn(s, 3405, MOVN, type, rd, ivalue >> shift, shift);
+        ivalue &= ~(0xffffUL << shift);
+        while (ivalue) {
+            shift = ctz64(ivalue) & (63 & -16);
+            /* Provide MOVK with the non-inverted value.  */
+            tcg_out_insn(s, 3405, MOVK, type, rd, ~(ivalue >> shift), shift);
+            ivalue &= ~(0xffffUL << shift);
+        }
     }
 }
 
-- 
2.7.4
