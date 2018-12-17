Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqbL-0002Y7-92
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqaB-0000DI-1b
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:57:09 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gYqaA-0000CE-3Q
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:57:06 -0500
Received: by mail-wm1-x341.google.com with SMTP id y185so4430730wmd.1
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 02:57:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Dec 2018 10:56:50 +0000
Message-Id: <20181217105650.27361-16-alex.bennee@linaro.org>
In-Reply-To: <20181217105650.27361-1-alex.bennee@linaro.org>
References: <20181217105650.27361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 15/15] hardfloat: implement float32/64
 comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: "Emilio G. Cota" <cota@braap.org>

Performance results for fp-bench:

Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
- before:
cmp-single: 110.98 MFlops
cmp-double: 107.12 MFlops
- after:
cmp-single: 506.28 MFlops
cmp-double: 524.77 MFlops

Note that flattening both eq and eq_signaling versions
would give us extra performance (695v506, 615v524 Mflops
for single/double, respectively) but this would emit two
essentially identical functions for each eq/signaling pair,
which is a waste.

Aggregate performance improvement for the last few patches:
[ all charts in png: https://imgur.com/a/4yV8p ]

1. Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz

                   qemu-aarch64 NBench score; higher is better
                 Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz

  16 +-+-----------+-------------+----===-------+---===-------+-----------+-+
  14 +-+..........................@@@&&.=.......@@@&&.=...................+-+
  12 +-+..........................@.@.&.=.......@.@.&.=.....+befor===     +-+
  10 +-+..........................@.@.&.=.......@.@.&.=.....+ad@@&& =     +-+
   8 +-+.......................$$$%.@.&.=.......@.@.&.=.....+  @@u& =     +-+
   6 +-+............@@@&&=+***##.$%.@.&.=***##$$%+@.&.=..###$$%%@i& =     +-+
   4 +-+.......###$%%.@.&=.*.*.#.$%.@.&.=*.*.#.$%.@.&.=+**.#+$ +@m& =     +-+
   2 +-+.....***.#$.%.@.&=.*.*.#.$%.@.&.=*.*.#.$%.@.&.=.**.#+$+sqr& =     +-+
   0 +-+-----***##$%%@@&&=-***##$$%@@&&==***##$$%@@&&==-**##$$%+cmp==-----+-+
            FOURIER    NEURAL NELU DECOMPOSITION         gmean

                              qemu-aarch64 SPEC06fp (test set) speedup over QEMU 4c2c1015905
                                      Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
                                            error bars: 95% confidence interval

  4.5 +-+---+-----+----+-----+-----+-&---+-----+----+-----+-----+-----+----+-----+-----+-----+-----+----+-----+---+-+
    4 +-+..........................+@@+...........................................................................+-+
  3.5 +-+..............%%@&.........@@..............%%@&............................................+++dsub       +-+
  2.5 +-+....&&+.......%%@&.......+%%@..+%%&+..@@&+.%%@&....................................+%%&+.+%@&++%%@&      +-+
    2 +-+..+%%&..+%@&+.%%@&...+++..%%@...%%&.+$$@&..%%@&..%%@&.......+%%&+.%%@&+......+%%@&.+%%&++$$@&++d%@&  %%@&+-+
  1.5 +-+**#$%&**#$@&**#%@&**$%@**#$%@**#$%&**#$@&**$%@&*#$%@**#$%@**#$%&**#%@&**$%@&*#$%@**#$%&**#$@&*+f%@&**$%@&+-+
  0.5 +-+**#$%&**#$@&**#%@&**$%@**#$%@**#$%&**#$@&**$%@&*#$%@**#$%@**#$%&**#%@&**$%@&*#$%@**#$%&**#$@&+sqr@&**$%@&+-+
    0 +-+**#$%&**#$@&**#%@&**$%@**#$%@**#$%&**#$@&**$%@&*#$%@**#$%@**#$%&**#%@&**$%@&*#$%@**#$%&**#$@&*+cmp&**$%@&+-+
  410.bw416.gam433.434.z435.436.cac437.lesli444.447.de450.so453454.ca459.GemsF465.tont470.lb4482.sphinxgeomean

2. Host: ARM Aarch64 A57 @ 2.4GHz

                    qemu-aarch64 NBench score; higher is better
                 Host: Applied Micro X-Gene, Aarch64 A57 @ 2.4 GHz

    5 +-+-----------+-------------+-------------+-------------+-----------+-+
  4.5 +-+........................................@@@&==...................+-+
  3 4 +-+..........................@@@&==........@.@&.=.....+before       +-+
    3 +-+..........................@.@&.=........@.@&.=.....+ad@@@&==     +-+
  2.5 +-+.....................##$$%%.@&.=........@.@&.=.....+  @m@& =     +-+
    2 +-+............@@@&==.***#.$.%.@&.=.***#$$%%.@&.=.***#$$%%d@& =     +-+
  1.5 +-+.....***#$$%%.@&.=.*.*#.$.%.@&.=.*.*#.$.%.@&.=.*.*#+$ +f@& =     +-+
  0.5 +-+.....*.*#.$.%.@&.=.*.*#.$.%.@&.=.*.*#.$.%.@&.=.*.*#+$+sqr& =     +-+
    0 +-+-----***#$$%%@@&==-***#$$%%@@&==-***#$$%%@@&==-***#$$%+cmp==-----+-+
             FOURIER    NEURAL NLU DECOMPOSITION         gmean

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index fbd66fd8dc..59eac97d10 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2903,28 +2903,109 @@ static int compare_floats(FloatParts a, FloatParts b, bool is_quiet,
     }
 }
 
-#define COMPARE(sz)                                                     \
-int float ## sz ## _compare(float ## sz a, float ## sz b,               \
-                            float_status *s)                            \
+#define COMPARE(name, attr, sz)                                         \
+static int attr                                                         \
+name(float ## sz a, float ## sz b, bool is_quiet, float_status *s)      \
 {                                                                       \
     FloatParts pa = float ## sz ## _unpack_canonical(a, s);             \
     FloatParts pb = float ## sz ## _unpack_canonical(b, s);             \
-    return compare_floats(pa, pb, false, s);                            \
-}                                                                       \
-int float ## sz ## _compare_quiet(float ## sz a, float ## sz b,         \
-                                  float_status *s)                      \
-{                                                                       \
-    FloatParts pa = float ## sz ## _unpack_canonical(a, s);             \
-    FloatParts pb = float ## sz ## _unpack_canonical(b, s);             \
-    return compare_floats(pa, pb, true, s);                             \
+    return compare_floats(pa, pb, is_quiet, s);                         \
 }
 
-COMPARE(16)
-COMPARE(32)
-COMPARE(64)
+COMPARE(soft_f16_compare, QEMU_FLATTEN, 16)
+COMPARE(soft_f32_compare, QEMU_SOFTFLOAT_ATTR, 32)
+COMPARE(soft_f64_compare, QEMU_SOFTFLOAT_ATTR, 64)
 
 #undef COMPARE
 
+int float16_compare(float16 a, float16 b, float_status *s)
+{
+    return soft_f16_compare(a, b, false, s);
+}
+
+int float16_compare_quiet(float16 a, float16 b, float_status *s)
+{
+    return soft_f16_compare(a, b, true, s);
+}
+
+static int QEMU_FLATTEN
+f32_compare(float32 xa, float32 xb, bool is_quiet, float_status *s)
+{
+    union_float32 ua, ub;
+
+    ua.s = xa;
+    ub.s = xb;
+
+    if (QEMU_NO_HARDFLOAT) {
+        goto soft;
+    }
+
+    float32_input_flush2(&ua.s, &ub.s, s);
+    if (isgreaterequal(ua.h, ub.h)) {
+        if (isgreater(ua.h, ub.h)) {
+            return float_relation_greater;
+        }
+        return float_relation_equal;
+    }
+    if (likely(isless(ua.h, ub.h))) {
+        return float_relation_less;
+    }
+    /* The only condition remaining is unordered.
+     * Fall through to set flags.
+     */
+ soft:
+    return soft_f32_compare(ua.s, ub.s, is_quiet, s);
+}
+
+int float32_compare(float32 a, float32 b, float_status *s)
+{
+    return f32_compare(a, b, false, s);
+}
+
+int float32_compare_quiet(float32 a, float32 b, float_status *s)
+{
+    return f32_compare(a, b, true, s);
+}
+
+static int QEMU_FLATTEN
+f64_compare(float64 xa, float64 xb, bool is_quiet, float_status *s)
+{
+    union_float64 ua, ub;
+
+    ua.s = xa;
+    ub.s = xb;
+
+    if (QEMU_NO_HARDFLOAT) {
+        goto soft;
+    }
+
+    float64_input_flush2(&ua.s, &ub.s, s);
+    if (isgreaterequal(ua.h, ub.h)) {
+        if (isgreater(ua.h, ub.h)) {
+            return float_relation_greater;
+        }
+        return float_relation_equal;
+    }
+    if (likely(isless(ua.h, ub.h))) {
+        return float_relation_less;
+    }
+    /* The only condition remaining is unordered.
+     * Fall through to set flags.
+     */
+ soft:
+    return soft_f64_compare(ua.s, ub.s, is_quiet, s);
+}
+
+int float64_compare(float64 a, float64 b, float_status *s)
+{
+    return f64_compare(a, b, false, s);
+}
+
+int float64_compare_quiet(float64 a, float64 b, float_status *s)
+{
+    return f64_compare(a, b, true, s);
+}
+
 /* Multiply A by 2 raised to the power N.  */
 static FloatParts scalbn_decomposed(FloatParts a, int n, float_status *s)
 {
-- 
2.17.1
