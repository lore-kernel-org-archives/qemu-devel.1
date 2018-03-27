Received: from eggs.gnu.org ([2001:4830:134:3::10]:35792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFI-0007P9-83
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFE-0005OW-Vh
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0hFE-0005OJ-Pu
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 27 Mar 2018 01:34:00 -0400
Message-Id: <1522128840-498-15-git-send-email-cota@braap.org>
In-Reply-To: <1522128840-498-1-git-send-email-cota@braap.org>
References: <1522128840-498-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 14/14] hardfloat: support float32_to_float64
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

                             qemu-aarch64 SPEC06fp (test set) speedup over QEMU 4c2c1015905
                                     Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz
                                           error bars: 95% confidence interval

  6 +-+---+-----+-----+-----+----+-----+-----+-----+-----+-----+-----+-----+-----+-----+----+-----+-----+-----+---+-+
  5 +-+..........................+++..............................................................................+-+
  4 +-+...........................@@=+..............................................................+addsub       +-+
  3 +-+........+++++.+++++........@@=+............+++++...............+++........................+++++++++++      +-+
    |    +%@&+  |&&  %%@&+      +%%@= +%%&=++%%&= +%%&=              +++  +++++       ++++++%%@=++%%&= +%%&=  ++++  |
  2 +-+..+%@&++%%@&.+%%@&+$$%@=+#$%@=+#$%&=##$%&=*#$%&=.+%@&=...+==##%@&++%%@&+++++++$$%@=**$%@=*#$%&=*+f%&=##$@&=+-+
  1 +-+**#$@&**#%@&**#%@&**$%@=**$%@=**$%&=*#$%&=*#$%&**#$@&**#$@&**#%@&**#%@&**#%@=**$%@=**$%@=*#$%&=+sqr&=*#$@&=+-+
  0 +-+**#$@&**#%@&**#%@&**$%@=**$%@=**$%&=*#$%&=*#$%&**#$@&**#$@&**#%@&**#%@&**#%@=**$%@=**$%@=*#$%&=*+cm&=*#$@&=+-+
      416.game433.434.435.436.cac437.leslie444.447.de450.so453.454.ca459.GemsF465.ton470.lb48482.sph+f32f64ean

                                       qemu-aarch64 NBench score; higher is better
                                     Host: Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz

  16 +-+-------------------+---------------------+----------------------+---------------------+-------------------+-+
  14 +-+..........................................+++++++***............+++..+++++................................+-+
  12 +-+.........................................@@@@&&===+*............@@@&&&==**..................+before       +-+
  10 +-+.........................................@..@.&..=.*............@.@..&.=.*............@@@&&&==***ub       +-+
   8 +-+.....................................++++@..@.&..=.*............@.@..&.=.*............@+@..&+= +*ul       +-+
   6 +-+...................@@@@&&===**..++###$$$%%..@.&..=.*..***###$$++@.@..&.=.*.......$$$%%%.@..&+= +*iv       +-+
   4 +-+............###$$$%%..@.&..=.*..***.#..$.%..@.&..=.*..*+*..#+$%%%.@..&.=.*..***###+$++%.@..&+= +*ma       +-+
   2 +-+.........****.#..$.%..@.&..=.*..*.*.#..$.%..@.&..=.*..*.*..#.$..%.@..&.=.*..*.*..#.$..%.@..&+=+s*rt       +-+
   0 +-+---------****##$$$%%@@@&&===**--***##$$$%%@@@&&===**--***###$$%%%@@&&&==**--***###$$%%%@@&&&==***mp-------+-+
                    FOURIER            NEURAL NET       LU DECOMPOSITION                 gmean      +f32f64

Images in png: https://imgur.com/a/rkuZW

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2b86d73..d0f1f65 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3660,7 +3660,8 @@ float128 uint64_to_float128(uint64_t a, float_status *status)
 | Arithmetic.
 *----------------------------------------------------------------------------*/
 
-float64 float32_to_float64(float32 a, float_status *status)
+static float64 __attribute__((noinline))
+soft_float32_to_float64(float32 a, float_status *status)
 {
     flag aSign;
     int aExp;
@@ -3685,6 +3686,20 @@ float64 float32_to_float64(float32 a, float_status *status)
 
 }
 
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
+
 /*----------------------------------------------------------------------------
 | Returns the result of converting the single-precision floating-point value
 | `a' to the extended double-precision floating-point format.  The conversion
-- 
2.7.4
