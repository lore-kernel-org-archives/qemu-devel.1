Received: from eggs.gnu.org ([209.51.188.92]:45473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h0UqB-0004vp-B3
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h0UqA-0001qk-8m
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:23:55 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun,  3 Mar 2019 17:23:43 +0000
Message-Id: <20190303172343.13406-9-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 8/8] target/ppc: simplify get_cpu_vsrh() and
 get_cpu_vsrl() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

Now that the VSX registers are all in host endian order, there is no need to
go via different accessors depending upon the register number. Instead the
high and low parts can be accessed directly via vsrh_offset() and vsrl_offset()
accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate/vsx-impl.inc.c | 34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 7d02a235e7..43e97756a2 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1,49 +1,23 @@
 /***                           VSX extension                               ***/
 
-static inline void get_vsrl(TCGv_i64 dst, int n)
-{
-    tcg_gen_ld_i64(dst, cpu_env, vsrl_offset(n));
-}
-
-static inline void set_vsrl(int n, TCGv_i64 src)
-{
-    tcg_gen_st_i64(src, cpu_env, vsrl_offset(n));
-}
-
 static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
 {
-    if (n < 32) {
-        get_fpr(dst, n);
-    } else {
-        get_avr64(dst, n - 32, true);
-    }
+    tcg_gen_ld_i64(dst, cpu_env, vsrh_offset(n));
 }
 
 static inline void get_cpu_vsrl(TCGv_i64 dst, int n)
 {
-    if (n < 32) {
-        get_vsrl(dst, n);
-    } else {
-        get_avr64(dst, n - 32, false);
-    }
+    tcg_gen_ld_i64(dst, cpu_env, vsrl_offset(n));
 }
 
 static inline void set_cpu_vsrh(int n, TCGv_i64 src)
 {
-    if (n < 32) {
-        set_fpr(n, src);
-    } else {
-        set_avr64(n - 32, src, true);
-    }
+    tcg_gen_st_i64(src, cpu_env, vsrh_offset(n));
 }
 
 static inline void set_cpu_vsrl(int n, TCGv_i64 src)
 {
-    if (n < 32) {
-        set_vsrl(n, src);
-    } else {
-        set_avr64(n - 32, src, false);
-    }
+    tcg_gen_st_i64(src, cpu_env, vsrl_offset(n));
 }
 
 #define VSX_LOAD_SCALAR(name, operation)                      \
-- 
2.11.0
