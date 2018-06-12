Received: from eggs.gnu.org ([2001:4830:134:3::10]:40791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQm-00045y-OQ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQi-0003My-Ts
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fSYQi-0003MY-P0
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 11 Jun 2018 21:49:00 -0400
Message-Id: <1528768140-17894-15-git-send-email-cota@braap.org>
In-Reply-To: <1528768140-17894-1-git-send-email-cota@braap.org>
References: <1528768140-17894-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 14/14] hardfloat: support float32/64
 comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Performance results for fp-bench:

1. Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
- before:
cmp-single: 113.01 MFlops
cmp-double: 115.54 MFlops
- after:
cmp-single: 527.83 MFlops
cmp-double: 457.21 MFlops

2. ARM Aarch64 A57 @ 2.4GHz
- before:
cmp-single: 39.32 MFlops
cmp-double: 39.80 MFlops
- after:
cmp-single: 162.74 MFlops
cmp-double: 167.08 MFlops

3. IBM POWER8E @ 2.1 GHz
- before:
cmp-single: 60.81 MFlops
cmp-double: 62.76 MFlops
- after:
cmp-single: 235.39 MFlops
cmp-double: 283.44 MFlops

Here using float{32,64}_is_any_nan is faster than using isnan
for all machines. On x86_64 the perf difference is just a few
percentage points, but on aarch64 we go from 117/119 to
164/169 MFlops for single/double precision, respectively.

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

Note that by not inlining the soft-fp primitives we end up
with a smaller softfloat.o--in particular, see the difference
for the softfloat.o built for fp-bench:

- before this series:
   text    data     bss     dec     hex filename
 103235       0       0  103235   19343 softfloat.o
- after:
   text    data     bss     dec     hex filename
  93369       0       0   93369   16cb9 softfloat.o

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f89e872..1cf74d1 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2671,28 +2671,74 @@ static int compare_floats(FloatParts a, FloatParts b, bool is_quiet,
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
+COMPARE(soft_float16_compare, , 16)
+COMPARE(soft_float32_compare, QEMU_SOFTFLOAT_ATTR, 32)
+COMPARE(soft_float64_compare, QEMU_SOFTFLOAT_ATTR, 64)
 
 #undef COMPARE
 
+int __attribute__((flatten))
+float16_compare(float16 a, float16 b, float_status *s)
+{
+    return soft_float16_compare(a, b, false, s);
+}
+
+int __attribute__((flatten))
+float16_compare_quiet(float16 a, float16 b, float_status *s)
+{
+    return soft_float16_compare(a, b, true, s);
+}
+
+#define GEN_FPU_COMPARE(name, quiet_name, soft_t, host_t)               \
+    static int                                                          \
+    fpu_ ## name(soft_t a, soft_t b, bool is_quiet, float_status *s)    \
+    {                                                                   \
+        host_t ha, hb;                                                  \
+                                                                        \
+        if (QEMU_NO_HARDFLOAT) {                                        \
+            return soft_ ## name(a, b, is_quiet, s);                    \
+        }                                                               \
+        soft_t ## _input_flush2(&a, &b, s);                             \
+        ha = soft_t ## _to_ ## host_t(a);                               \
+        hb = soft_t ## _to_ ## host_t(b);                               \
+        if (unlikely(soft_t ## _is_any_nan(a) ||                        \
+                     soft_t ## _is_any_nan(b))) {                       \
+            return soft_ ## name(a, b, is_quiet, s);                    \
+        }                                                               \
+        if (isgreater(ha, hb)) {                                        \
+            return float_relation_greater;                              \
+        }                                                               \
+        if (isless(ha, hb)) {                                           \
+            return float_relation_less;                                 \
+        }                                                               \
+        return float_relation_equal;                                    \
+    }                                                                   \
+                                                                        \
+    int __attribute__((flatten))                                        \
+    name(soft_t a, soft_t b, float_status *s)                           \
+    {                                                                   \
+        return fpu_ ## name(a, b, false, s);                            \
+    }                                                                   \
+                                                                        \
+    int __attribute__((flatten))                                        \
+    quiet_name(soft_t a, soft_t b, float_status *s)                     \
+    {                                                                   \
+        return fpu_ ## name(a, b, true, s);                             \
+    }
+
+GEN_FPU_COMPARE(float32_compare, float32_compare_quiet, float32, float)
+GEN_FPU_COMPARE(float64_compare, float64_compare_quiet, float64, double)
+#undef GEN_FPU_COMPARE
+
 /* Multiply A by 2 raised to the power N.  */
 static FloatParts scalbn_decomposed(FloatParts a, int n, float_status *s)
 {
-- 
2.7.4
