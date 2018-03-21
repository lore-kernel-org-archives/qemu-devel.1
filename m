Received: from eggs.gnu.org ([2001:4830:134:3::10]:42176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5W-0002A3-06
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5S-00010L-EX
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5S-000108-9k
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:49 -0400
Message-Id: <1521663109-32262-15-git-send-email-cota@braap.org>
In-Reply-To: <1521663109-32262-1-git-send-email-cota@braap.org>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 14/14] hostfloat: support float32_to_float64
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

Performance improvement for SPEC06fp for the last few commits:

                               qemu-aarch64 SPEC06fp (test set) speedup over QEMU f6d81cdec8
                                      Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
                                            error bars: 95% confidence interval

    5 +-+---+-----+----+-----+-----+-----+-----+----+-----+-----+-----+----+-----+-----+-----+-----+----+-----+---+-+
  4.5 +-+..........................+&&+...........................................................................+-+
  3.5 +-+................+++.......@@&...............+++............................................+++dsub       +-+
  2 3 +-+....+++.++++++%%&=+......+@@&....+++...==+..&&=..........................................++&=+++++++     +-+
    2 +-+..%%@&+.%%@=++%%&=.......+%@&..%%@&+.%%@=++%%&=.++&&+.......++&=+.+++++.......+&&=.%%@&+.%%@= +%%@=++%%&=+-+
  1.5 +-+++$%@&+#$%@=+#$%&=##$%&**#$@&**#%@&**$%@=**$%&=##%@&**#+&&**#%@=**$%@=+++&&=##$@&**#%@&**#%@=*+f%@=*#$%&=+-+
  0 1 +-+**#%@&**$%@=**$%&=*#$%&**#$@&**#%@&**$%@=**$%&=*#$@&**#$@&**#%@=**$%@=*#$%&=*#$@&**#%@&**#%@=+sqr@=*#$%&=+-+
    0 +-+**#%@&**$%@=**$%&=*#$%&**#$@&**#%@&**$%@=**$%&=*#$@&**#$@&**#%@=**$%@=*#$%&=*#$@&**#%@&**#%@=*+cmp=*#$%&=+-+
  410.bw416.gam433.434.z435.436.cac437.lesli444.447.de450.so453454.ca459.GemsF465.tont470.lb4482.sph+f32f64ean
  png: https://imgur.com/5BErNz7

That is, a final geomean speedup of 2.21X.

The floating point workloads from nbench show similar improvements:

                                       qemu-aarch64 NBench score; higher is better
                                     Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz

  16 +-+-------------------+---------------------+----------------------+---------------------+-------------------+-+
  14 +-+..............................................====**............@@@&&&==**................................+-+
  12 +-+.........................................@@@@&&..=.*............@.@..&.=.*..................+before       +-+
  10 +-+.........................................@..@.&..=.*............@.@..&.=.*............@@@&&&==***ub       +-+
   8 +-+....................................$$$$%%..@.&..=.*............@.@..&.=.*............@.@..&+= +*ul       +-+
   6 +-+...................@@@@&&===**..***##..$.%..@.&..=.*..++####$$%%%.@..&.=.*....####$$%%%.@..&+= +*iv       +-+
   4 +-+............###$$$%%..@.&..=.*..*+*.#..$.%..@.&..=.*..***..#.$..%.@..&.=.*..***..#.$..%.@..&+= +*ma       +-+
   2 +-+.........****.#..$.%..@.&..=.*..*.*.#..$.%..@.&..=.*..*.*..#.$..%.@..&.=.*..*.*..#.$..%.@..&+=+s*rt       +-+
   0 +-+---------****##$$$%%@@@&&===**--***##$$$%%@@@&&===**--***###$$%%%@@&&&==**--***###$$%%%@@&&&==***mp-------+-+
                    FOURIER            NEURAL NET       LU DECOMPOSITION                 gmean      +f32f64
  png: https://imgur.com/KjLHumh

That is, a ~2.6X speedup. [error bars here are just the standard deviation of
just a few measurements; this explains the noisy results.]

Results for the i386 target are very similar; the only major
difference is that they're much more sensitive to the multiplication
optimization, since the i386 target does not currently use floatX_muladd
(aka fma).

Below are the x86_64 SPEC06fp results, although note that they are from
a development branch, so each bar does not match the patches in this,
and the final numbers might be slightly different from those you'd
get with these patches.

                               qemu-x86_64 SPEC06fp (train set) speedup over QEMU f6d81cdec8
                                      Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
                                            error bars: 95% confidence interval

    4 +-+---+-----+----+-----+-----+%%---+-----+----+-----+-----+-----+----+-----+-----+-----+-----+----+-----+---+-+
  3.5 +-+..........................$$%............................................................................+-+
    3 +-+............**$$$......+**#$%............**$$++..................................+add+sub++%%+sq+++      +-+
  2.5 +-+..+++.**##$%**#+$%......**#$%..+$$%..++%%**#$%%.............+++.**#$$%........$$%+**$$%+###$%is#$$%  $$%%+-+
  1.5 +-+***#$%**.#$%**#.$%..$$%+**#$%***#$%**##$%**#$.%**#$%+++$$%***#$%**#+$%..$$++**#$%+fas$%path$%ul(0$%**#$ %+-+
    1 +-+*+*#$%**+#$%**#+$%**#$%+**#$%*+*#$%**+#$%**#$+%**#$%-**#$%*+*#$%**#+$%**#$%%**#$%+**+f%2 to %4+div%**#$+%+-+
  0.5 +-+*.*#$%**.#$%**#.$%**#$%.**#$%*.*#$%**.#$%**#$.%**#$%.**#$%*.*#$%**#.$%**#$.%**#$%.**#$%**.#$%**#.$%**#$.%+-+
    0 +-+***#$%**##$%**#$$%**#$%-**#$%***#$%**##$%**#$%%**#$%-**#$%***#$%**#$$%**#$%%**#$%-**#$%**##$%**#$$%**#$%%+-+
  410.bw416.gam433.434.z435.436.cac437.lesli444.447.de450.so453454.ca459.GemsF465.tont470.lb4482.sphinxgeomean
  png: https://imgur.com/MfvTb3H

Two points are worth mentioning:

- Special-casing 0-inputs for multiplication pays off handsomely (the same
  thing happens for FMA for targets that use it). I was surprised to
  see that some benchmarks (e.g. GemsFDTD) compute >99% of their
  multiplications with at least one operand being Zero (and this is
  without flush-to-zero!).

- Avoiding comparisons via the host FPU (i.e. using soft_t ## _is_normal()
  instead of glibc's isnormal()) gives a small speedup.

Finally, the same results using native execution time as the baseline,
where we plot the slowdown instead of the speedup.
We bring down the slowdown of SPEC06fp w.r.t. native from ~21X to ~10X:

                         qemu-x86_64 SPEC06fp (train set) slowdown over native (lower is better)
                                     Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
                                           error bars: 95% confidence interval

  90 +-+---+-----+-----+----+-----+-----+-----+-----+-----+----+-----+-----+-----+-----+-----+----+-----+-----+---+-+
  80 +-+.......................+**................................................................................+-+
  70 +-+........................**........................................................+          before       +-+
  50 +-+........................**........................................................+add+sub+mul+sqrt       +-+
  40 +-+......+++...............**................................+++.....................+  +integer isinf       +-+
  30 +-+**+...**+...............**#$%@**.........**+..............+**++.............**+...+fast path mul(0++**    +-+
  10 +-+**#$%@**#$%@**$$@@**#$%@**#$%@**#$%**#$%+**#$%@**#$%@**#$%+**#$%@**#$%@*#$%@**#$%@**#+f@2 to @4+div@**#$%@+-+
   0 +-+**#$%@**#$%@**#$%@**#$%@**#$%@**#$%**#$%@**#$%@**#$%@**#$%@**#$%@**#$%@*#$%@**#$%@**#$%@**#$%@**#$%@**#$%@+-+
 410.bw416.game433434.z435.436.cac437.leslie444.447.d450.so453.454.ca459.GemsF465.tont470.l48482.sphinxgeomean
  png: https://imgur.com/iTmVkJL

All png's shown above can be found here: https://imgur.com/a/YSxxR

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/hostfloat.h |  2 ++
 include/fpu/softfloat.h |  2 +-
 fpu/hostfloat.c         | 14 ++++++++++++++
 fpu/softfloat.c         |  2 +-
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/fpu/hostfloat.h b/include/fpu/hostfloat.h
index aa555f6..79e9b6c 100644
--- a/include/fpu/hostfloat.h
+++ b/include/fpu/hostfloat.h
@@ -29,4 +29,6 @@ float64 float64_sqrt(float64 a, float_status *status);
 int float64_compare(float64 a, float64 b, float_status *s);
 int float64_compare_quiet(float64 a, float64 b, float_status *s);
 
+float64 float32_to_float64(float32, float_status *status);
+
 #endif /* HOSTFLOAT_H */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index cb57942..b0a4d75 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -334,7 +334,7 @@ int64_t float32_to_int64(float32, float_status *status);
 uint64_t float32_to_uint64(float32, float_status *status);
 uint64_t float32_to_uint64_round_to_zero(float32, float_status *status);
 int64_t float32_to_int64_round_to_zero(float32, float_status *status);
-float64 float32_to_float64(float32, float_status *status);
+float64 soft_float32_to_float64(float32, float_status *status);
 floatx80 float32_to_floatx80(float32, float_status *status);
 float128 float32_to_float128(float32, float_status *status);
 
diff --git a/fpu/hostfloat.c b/fpu/hostfloat.c
index 139e419..b635839 100644
--- a/fpu/hostfloat.c
+++ b/fpu/hostfloat.c
@@ -326,3 +326,17 @@ GEN_FPU_SQRT(float64_sqrt, float64, double, sqrt)
 GEN_FPU_COMPARE(float32_compare, float32, float)
 GEN_FPU_COMPARE(float64_compare, float64, double)
 #undef GEN_FPU_COMPARE
+
+float64 float32_to_float64(float32 a, float_status *status)
+{
+    if (likely(float32_is_normal(a))) {
+        float f = *(float *)&a;
+        double r = f;
+
+        return *(float64 *)&r;
+    } else if (float32_is_zero(a)) {
+        return float64_set_sign(float64_zero, float32_is_neg(a));
+    } else {
+        return soft_float32_to_float64(a, status);
+    }
+}
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 1a32216..cf8d6ec 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3149,7 +3149,7 @@ float128 uint64_to_float128(uint64_t a, float_status *status)
 | Arithmetic.
 *----------------------------------------------------------------------------*/
 
-float64 float32_to_float64(float32 a, float_status *status)
+float64 soft_float32_to_float64(float32 a, float_status *status)
 {
     flag aSign;
     int aExp;
-- 
2.7.4
