Received: from eggs.gnu.org ([2001:4830:134:3::10]:41838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32ld-0002cy-Po
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lZ-0006bL-8Z
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:57 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:54683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32lZ-0006ak-2N
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:53 -0400
Received: by mail-wr0-x233.google.com with SMTP id o44so1427033wrf.11
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:24:52 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:17 +0100
Message-Id: <20171013162438.32458-10-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 09/30] softfloat: propagate signalling NaNs
 in MINMAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

While a comparison between a QNaN and a number will return the number
it is not the same with a signaling NaN. In this case the SNaN will
"win" and after potentially raising an exception it will be quietened.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 013b223947..6ab4b39c09 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
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
2.14.1
