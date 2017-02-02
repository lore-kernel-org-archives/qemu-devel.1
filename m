Received: from eggs.gnu.org ([2001:4830:134:3::10]:50988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jc-00075A-Po
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9ja-0003TI-UX
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:04 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:13:09 +1100
Message-Id: <20170202051445.5735-12-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 011/107] target-ppc: Implement bcdctsq.
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

bcdctsq.: Decimal convert to signed quadword. It is possible to
convert packed decimal values to signed quadwords.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 +
 target/ppc/int_helper.c             | 40 +++++++++++++++++++++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  7 +++++++
 3 files changed, 48 insertions(+)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index ec5ccbe..daf5a6e 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -378,6 +378,7 @@ DEF_HELPER_3(bcdctn, i32, avr, avr, i32)
 DEF_HELPER_3(bcdcfz, i32, avr, avr, i32)
 DEF_HELPER_3(bcdctz, i32, avr, avr, i32)
 DEF_HELPER_3(bcdcfsq, i32, avr, avr, i32)
+DEF_HELPER_3(bcdctsq, i32, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xssubdp, void, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index a809482..fa7cfdd 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2880,6 +2880,46 @@ uint32_t helper_bcdcfsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     return cr;
 }
 
+uint32_t helper_bcdctsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+{
+    uint8_t i;
+    int cr;
+    uint64_t carry;
+    uint64_t unused;
+    uint64_t lo_value;
+    uint64_t hi_value = 0;
+    int sgnb = bcd_get_sgn(b);
+    int invalid = (sgnb == 0);
+
+    lo_value = bcd_get_digit(b, 31, &invalid);
+    for (i = 30; i > 0; i--) {
+        mulu64(&lo_value, &carry, lo_value, 10ULL);
+        mulu64(&hi_value, &unused, hi_value, 10ULL);
+        lo_value += bcd_get_digit(b, i, &invalid);
+        hi_value += carry;
+
+        if (unlikely(invalid)) {
+            break;
+        }
+    }
+
+    if (sgnb == -1) {
+        r->s64[LO_IDX] = -lo_value;
+        r->s64[HI_IDX] = ~hi_value + !r->s64[LO_IDX];
+    } else {
+        r->s64[LO_IDX] = lo_value;
+        r->s64[HI_IDX] = hi_value;
+    }
+
+    cr = bcd_cmp_zero(b);
+
+    if (unlikely(invalid)) {
+        cr = CRF_SO;
+    }
+
+    return cr;
+}
+
 void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 36141e5..1579b58 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -990,10 +990,14 @@ GEN_BCD2(bcdctn)
 GEN_BCD2(bcdcfz)
 GEN_BCD2(bcdctz)
 GEN_BCD2(bcdcfsq)
+GEN_BCD2(bcdctsq)
 
 static void gen_xpnd04_1(DisasContext *ctx)
 {
     switch (opc4(ctx->opcode)) {
+    case 0:
+        gen_bcdctsq(ctx);
+        break;
     case 2:
         gen_bcdcfsq(ctx);
         break;
@@ -1018,6 +1022,9 @@ static void gen_xpnd04_1(DisasContext *ctx)
 static void gen_xpnd04_2(DisasContext *ctx)
 {
     switch (opc4(ctx->opcode)) {
+    case 0:
+        gen_bcdctsq(ctx);
+        break;
     case 2:
         gen_bcdcfsq(ctx);
         break;
-- 
2.9.3
