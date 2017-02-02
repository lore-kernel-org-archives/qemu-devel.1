Received: from eggs.gnu.org ([2001:4830:134:3::10]:51130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jg-0007AH-Kf
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9je-0003X7-7T
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:08 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:13:11 +1100
Message-Id: <20170202051445.5735-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 013/107] target-ppc: Implement bcdsetsgn.
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

bcdsetsgn.: Decimal set sign. This instruction copies the register
value to the result register but adjust the signal according to
the preferred sign value.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 +
 target/ppc/int_helper.c             | 19 +++++++++++++++++++
 target/ppc/translate/vmx-impl.inc.c |  8 ++++++++
 3 files changed, 28 insertions(+)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 7957633..de515ea 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -380,6 +380,7 @@ DEF_HELPER_3(bcdctz, i32, avr, avr, i32)
 DEF_HELPER_3(bcdcfsq, i32, avr, avr, i32)
 DEF_HELPER_3(bcdctsq, i32, avr, avr, i32)
 DEF_HELPER_4(bcdcpsgn, i32, avr, avr, avr, i32)
+DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
 
 DEF_HELPER_2(xsadddp, void, env, i32)
 DEF_HELPER_2(xssubdp, void, env, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 61762ee..00d04c1 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2943,6 +2943,25 @@ uint32_t helper_bcdcpsgn(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     return bcd_cmp_zero(r);
 }
 
+uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
+{
+    int i;
+    int invalid = 0;
+    int sgnb = bcd_get_sgn(b);
+
+    *r = *b;
+    bcd_put_digit(r, bcd_preferred_sgn(sgnb, ps), 0);
+
+    for (i = 1; i < 32; i++) {
+        bcd_get_digit(b, i, &invalid);
+        if (unlikely(invalid)) {
+            return CRF_SO;
+        }
+    }
+
+    return bcd_cmp_zero(r);
+}
+
 void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index c14b666..b188e60 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -991,6 +991,7 @@ GEN_BCD2(bcdcfz)
 GEN_BCD2(bcdctz)
 GEN_BCD2(bcdcfsq)
 GEN_BCD2(bcdctsq)
+GEN_BCD2(bcdsetsgn)
 GEN_BCD(bcdcpsgn);
 
 static void gen_xpnd04_1(DisasContext *ctx)
@@ -1014,6 +1015,9 @@ static void gen_xpnd04_1(DisasContext *ctx)
     case 7:
         gen_bcdcfn(ctx);
         break;
+    case 31:
+        gen_bcdsetsgn(ctx);
+        break;
     default:
         gen_invalid(ctx);
         break;
@@ -1038,12 +1042,16 @@ static void gen_xpnd04_2(DisasContext *ctx)
     case 7:
         gen_bcdcfn(ctx);
         break;
+    case 31:
+        gen_bcdsetsgn(ctx);
+        break;
     default:
         gen_invalid(ctx);
         break;
     }
 }
 
+
 GEN_VXFORM_DUAL(vsubcuw, PPC_ALTIVEC, PPC_NONE, \
                 xpnd04_1, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_DUAL(vsubsws, PPC_ALTIVEC, PPC_NONE, \
-- 
2.9.3
