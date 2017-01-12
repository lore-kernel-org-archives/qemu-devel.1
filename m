Received: from eggs.gnu.org ([2001:4830:134:3::10]:46025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUju-0002qG-S6
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjt-0006OW-5s
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:42 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:30 +1100
Message-Id: <20170112020327.24882-11-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/67] target-ppc: Implement bcdcfsq. instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

bcdcfsq.: Decimal convert from signed quadword. It is not possible
to convert values less than -10^31-1 or greater than 10^31-1 to be
represented in packed decimal format.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
[dwg: Corrected constant which should be 10^16-1 but was 10^17-1]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 +
 target/ppc/int_helper.c             | 38 +++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  7 +++++++
 3 files changed, 46 insertions(+)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3b26678..efb384a 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -382,6 +382,7 @@ DEF_HELPER_3(bcdcfn, i32, avr, avr, i32)
 DEF_HELPER_3(bcdctn, i32, avr, avr, i32)
 DEF_HELPER_3(bcdcfz, i32, avr, avr, i32)
 DEF_HELPER_3(bcdctz, i32, avr, avr, i32)
+DEF_HELPER_3(bcdcfsq, i32, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xssubdp, void, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 1667c94..e077251 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2874,6 +2874,44 @@ uint32_t helper_bcdctz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
+uint32_t helper_bcdcfsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+{
+    int i;
+    int cr = 0;
+    uint64_t lo_value;
+    uint64_t hi_value;
+    ppc_avr_t ret = { .u64 = { 0, 0 } };
+
+    if (b->s64[HI_IDX] < 0) {
+        lo_value = -b->s64[LO_IDX];
+        hi_value = ~b->u64[HI_IDX] + !lo_value;
+        bcd_put_digit(&ret, 0xD, 0);
+    } else {
+        lo_value = b->u64[LO_IDX];
+        hi_value = b->u64[HI_IDX];
+        bcd_put_digit(&ret, bcd_preferred_sgn(0, ps), 0);
+    }
+
+    if (divu128(&lo_value, &hi_value, 1000000000000000ULL) ||
+            lo_value > 9999999999999999ULL) {
+        cr = CRF_SO;
+    }
+
+    for (i = 1; i < 16; hi_value /= 10, i++) {
+        bcd_put_digit(&ret, hi_value % 10, i);
+    }
+
+    for (; i < 32; lo_value /= 10, i++) {
+        bcd_put_digit(&ret, lo_value % 10, i);
+    }
+
+    cr |= bcd_cmp_zero(&ret);
+
+    *r = ret;
+
+    return cr;
+}
+
 void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 7143eb3..36141e5 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -989,10 +989,14 @@ GEN_BCD2(bcdcfn)
 GEN_BCD2(bcdctn)
 GEN_BCD2(bcdcfz)
 GEN_BCD2(bcdctz)
+GEN_BCD2(bcdcfsq)
 
 static void gen_xpnd04_1(DisasContext *ctx)
 {
     switch (opc4(ctx->opcode)) {
+    case 2:
+        gen_bcdcfsq(ctx);
+        break;
     case 4:
         gen_bcdctz(ctx);
         break;
@@ -1014,6 +1018,9 @@ static void gen_xpnd04_1(DisasContext *ctx)
 static void gen_xpnd04_2(DisasContext *ctx)
 {
     switch (opc4(ctx->opcode)) {
+    case 2:
+        gen_bcdcfsq(ctx);
+        break;
     case 4:
         gen_bcdctz(ctx);
         break;
-- 
2.9.3
