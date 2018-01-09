Received: from eggs.gnu.org ([2001:4830:134:3::10]:51332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvj-0006ZI-UO
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvg-0006G7-Nt
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:22:59 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:47022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYsvg-0006DR-H0
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:22:56 -0500
Received: by mail-wr0-x243.google.com with SMTP id g21so8109291wrb.13
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:22:56 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:34 +0000
Message-Id: <20180109122252.17670-3-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/20] include/fpu/softfloat: remove
 USE_SOFTFLOAT_STRUCT_TYPES
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

It's not actively built and when enabled things fail to compile. I'm
not sure the type-checking is really helping here. Seeing as we "own"
our softfloat now lets remove the cruft.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/fpu/softfloat.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

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
