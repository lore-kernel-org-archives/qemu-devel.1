Received: from eggs.gnu.org ([2001:4830:134:3::10]:55707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD89-0003H1-Po
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD88-0004NW-LG
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:45 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:38164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD88-0004Mk-Dl
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:44 -0400
Received: by mail-wr0-x230.google.com with SMTP id f21so15630498wrf.5
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:12:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:24 +0100
Message-Id: <20170720150426.12393-22-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 21/23] fpu/softfloat2a: propagate
 signalling NaNs in MINMAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

While a comparison between a QNaN and a number will return the number
it is not the same with a signaling NaN. In this case the SNaN will
"win" and after potentially raising an exception it will be quietened.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat2a/softfloat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat2a/softfloat.c b/fpu/softfloat2a/softfloat.c
index 67115298bd..5e918cc208 100644
--- a/fpu/softfloat2a/softfloat.c
+++ b/fpu/softfloat2a/softfloat.c
@@ -7684,6 +7684,7 @@ int float128_compare_quiet(float128 a, float128 b, float_status *status)
  * minnum() and maxnum() functions. These are similar to the min()
  * and max() functions but if one of the arguments is a QNaN and
  * the other is numerical then the numerical argument is returned.
+ * SNaNs will get quietened before being returned.
  * minnum() and maxnum correspond to the IEEE 754-2008 minNum()
  * and maxNum() operations. min() and max() are the typical min/max
  * semantics provided by many CPUs which predate that specification.
@@ -7704,11 +7705,14 @@ static inline float ## s float ## s ## _minmax(float ## s a, float ## s b,     \
     if (float ## s ## _is_any_nan(a) ||                                 \
         float ## s ## _is_any_nan(b)) {                                 \
         if (isieee) {                                                   \
-            if (float ## s ## _is_quiet_nan(a, status) &&               \
+            if (float ## s ## _is_signaling_nan(a, status) ||           \
+                float ## s ## _is_signaling_nan(b, status)) {           \
+                propagateFloat ## s ## NaN(a, b, status);               \
+            } else  if (float ## s ## _is_quiet_nan(a, status) &&       \
                 !float ## s ##_is_any_nan(b)) {                         \
                 return b;                                               \
             } else if (float ## s ## _is_quiet_nan(b, status) &&        \
-                       !float ## s ## _is_any_nan(a)) {                \
+                       !float ## s ## _is_any_nan(a)) {                 \
                 return a;                                               \
             }                                                           \
         }                                                               \
-- 
2.13.0
