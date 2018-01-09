Received: from eggs.gnu.org ([2001:4830:134:3::10]:51445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvp-0006ed-8C
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvn-0006d8-Ow
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:05 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYsvn-0006aT-Hf
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:03 -0500
Received: by mail-wr0-x241.google.com with SMTP id w50so4697081wrc.11
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:23:03 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:39 +0000
Message-Id: <20180109122252.17670-8-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/20] fpu/softfloat: propagate signalling
 NaNs in MINMAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

While a comparison between a QNaN and a number will return the number
it is not the same with a signaling NaN. In this case the SNaN will
"win" and after potentially raising an exception it will be quietened.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - added return for propageFloat
---
 fpu/softfloat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3a4ab1355f..44c043924e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7683,6 +7683,7 @@ int float128_compare_quiet(float128 a, float128 b, float_status *status)
  * minnum() and maxnum() functions. These are similar to the min()
  * and max() functions but if one of the arguments is a QNaN and
  * the other is numerical then the numerical argument is returned.
+ * SNaNs will get quietened before being returned.
  * minnum() and maxnum correspond to the IEEE 754-2008 minNum()
  * and maxNum() operations. min() and max() are the typical min/max
  * semantics provided by many CPUs which predate that specification.
@@ -7703,11 +7704,14 @@ static inline float ## s float ## s ## _minmax(float ## s a, float ## s b,     \
     if (float ## s ## _is_any_nan(a) ||                                 \
         float ## s ## _is_any_nan(b)) {                                 \
         if (isieee) {                                                   \
-            if (float ## s ## _is_quiet_nan(a, status) &&               \
+            if (float ## s ## _is_signaling_nan(a, status) ||           \
+                float ## s ## _is_signaling_nan(b, status)) {           \
+                return propagateFloat ## s ## NaN(a, b, status);        \
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
2.15.1
