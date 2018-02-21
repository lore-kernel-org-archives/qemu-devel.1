Received: from eggs.gnu.org ([2001:4830:134:3::10]:35260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDP-0003sW-3c
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDJ-0006bI-06
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:35 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoSDI-0006ax-NU
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:28 -0500
Received: by mail-wr0-x242.google.com with SMTP id k9so3264670wre.9
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 03:05:28 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Feb 2018 11:05:02 +0000
Message-Id: <20180221110523.859-3-alex.bennee@linaro.org>
In-Reply-To: <20180221110523.859-1-alex.bennee@linaro.org>
References: <20180221110523.859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/22] include/fpu/softfloat: remove
 USE_SOFTFLOAT_STRUCT_TYPES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

It's not actively built and when enabled things fail to compile. I'm
not sure the type-checking is really helping here. Seeing as we "own"
our softfloat now lets remove the cruft.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index d5e99667b6..52af1412de 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -103,32 +103,6 @@ enum {
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE floating-point types.
 *----------------------------------------------------------------------------*/
-/* Use structures for soft-float types.  This prevents accidentally mixing
-   them with native int/float types.  A sufficiently clever compiler and
-   sane ABI should be able to see though these structs.  However
-   x86/gcc 3.x seems to struggle a bit, so leave them disabled by default.  */
-//#define USE_SOFTFLOAT_STRUCT_TYPES
-#ifdef USE_SOFTFLOAT_STRUCT_TYPES
-typedef struct {
-    uint16_t v;
-} float16;
-#define float16_val(x) (((float16)(x)).v)
-#define make_float16(x) __extension__ ({ float16 f16_val = {x}; f16_val; })
-#define const_float16(x) { x }
-typedef struct {
-    uint32_t v;
-} float32;
-/* The cast ensures an error if the wrong type is passed.  */
-#define float32_val(x) (((float32)(x)).v)
-#define make_float32(x) __extension__ ({ float32 f32_val = {x}; f32_val; })
-#define const_float32(x) { x }
-typedef struct {
-    uint64_t v;
-} float64;
-#define float64_val(x) (((float64)(x)).v)
-#define make_float64(x) __extension__ ({ float64 f64_val = {x}; f64_val; })
-#define const_float64(x) { x }
-#else
 typedef uint16_t float16;
 typedef uint32_t float32;
 typedef uint64_t float64;
@@ -141,7 +115,6 @@ typedef uint64_t float64;
 #define const_float16(x) (x)
 #define const_float32(x) (x)
 #define const_float64(x) (x)
-#endif
 typedef struct {
     uint64_t low;
     uint16_t high;
-- 
2.15.1
