Received: from eggs.gnu.org ([2001:4830:134:3::10]:35250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDN-0003rp-Tt
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDL-0006c6-TD
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:33 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoSDL-0006bm-FQ
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:31 -0500
Received: by mail-wr0-x243.google.com with SMTP id z12so3285982wrg.4
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 03:05:31 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Feb 2018 11:05:03 +0000
Message-Id: <20180221110523.859-4-alex.bennee@linaro.org>
In-Reply-To: <20180221110523.859-1-alex.bennee@linaro.org>
References: <20180221110523.859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/22] fpu/softfloat-types: new header to
 prevent excessive re-builds
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

The main culprit here is bswap.h which pulled in softfloat.h so it
could use the types in its CPU_Float* and ldfl/stfql functions. As
bswap.h is very widely included this added a compile dependency every
time we touch softfloat.h. Move the typedefs for each float type into
their own file so we don't re-build the world every time we tweak the
main softfloat.h header.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
new file mode 100644
index 0000000000..8210a94ea1
--- /dev/null
+++ b/include/fpu/softfloat-types.h
@@ -0,0 +1,115 @@
+/*
+ * QEMU float support
+ *
+ * The code in this source file is derived from release 2a of the SoftFloat
+ * IEC/IEEE Floating-point Arithmetic Package. Those parts of the code (and
+ * some later contributions) are provided under that license, as detailed below.
+ * It has subsequently been modified by contributors to the QEMU Project,
+ * so some portions are provided under:
+ *  the SoftFloat-2a license
+ *  the BSD license
+ *  GPL-v2-or-later
+ *
+ * This header holds definitions for code that might be dealing with
+ * softfloat types but not need access to the actual library functions.
+ */
+/*
+===============================================================================
+This C header file is part of the SoftFloat IEC/IEEE Floating-point
+Arithmetic Package, Release 2a.
+
+Written by John R. Hauser.  This work was made possible in part by the
+International Computer Science Institute, located at Suite 600, 1947 Center
+Street, Berkeley, California 94704.  Funding was partially provided by the
+National Science Foundation under grant MIP-9311980.  The original version
+of this code was written as part of a project to build a fixed-point vector
+processor in collaboration with the University of California at Berkeley,
+overseen by Profs. Nelson Morgan and John Wawrzynek.  More information
+is available through the Web page `http://HTTP.CS.Berkeley.EDU/~jhauser/
+arithmetic/SoftFloat.html'.
+
+THIS SOFTWARE IS DISTRIBUTED AS IS, FOR FREE.  Although reasonable effort
+has been made to avoid it, THIS SOFTWARE MAY CONTAIN FAULTS THAT WILL AT
+TIMES RESULT IN INCORRECT BEHAVIOR.  USE OF THIS SOFTWARE IS RESTRICTED TO
+PERSONS AND ORGANIZATIONS WHO CAN AND WILL TAKE FULL RESPONSIBILITY FOR ANY
+AND ALL LOSSES, COSTS, OR OTHER PROBLEMS ARISING FROM ITS USE.
+
+Derivative works are acceptable, even for commercial purposes, so long as
+(1) they include prominent notice that the work is derivative, and (2) they
+include prominent notice akin to these four paragraphs for those parts of
+this code that are retained.
+
+===============================================================================
+*/
+
+/* BSD licensing:
+ * Copyright (c) 2006, Fabrice Bellard
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright notice,
+ * this list of conditions and the following disclaimer.
+ *
+ * 2. Redistributions in binary form must reproduce the above copyright notice,
+ * this list of conditions and the following disclaimer in the documentation
+ * and/or other materials provided with the distribution.
+ *
+ * 3. Neither the name of the copyright holder nor the names of its contributors
+ * may be used to endorse or promote products derived from this software without
+ * specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
+ * THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/* Portions of this work are licensed under the terms of the GNU GPL,
+ * version 2 or later. See the COPYING file in the top-level directory.
+ */
+
+#ifndef SOFTFLOAT_TYPES_H
+#define SOFTFLOAT_TYPES_H
+
+/*
+ * Software IEC/IEEE floating-point types.
+ */
+
+typedef uint16_t float16;
+typedef uint32_t float32;
+typedef uint64_t float64;
+#define float16_val(x) (x)
+#define float32_val(x) (x)
+#define float64_val(x) (x)
+#define make_float16(x) (x)
+#define make_float32(x) (x)
+#define make_float64(x) (x)
+#define const_float16(x) (x)
+#define const_float32(x) (x)
+#define const_float64(x) (x)
+typedef struct {
+    uint64_t low;
+    uint16_t high;
+} floatx80;
+#define make_floatx80(exp, mant) ((floatx80) { mant, exp })
+#define make_floatx80_init(exp, mant) { .low = mant, .high = exp }
+typedef struct {
+#ifdef HOST_WORDS_BIGENDIAN
+    uint64_t high, low;
+#else
+    uint64_t low, high;
+#endif
+} float128;
+#define make_float128(high_, low_) ((float128) { .high = high_, .low = low_ })
+#define make_float128_init(high_, low_) { .high = high_, .low = low_ }
+
+#endif /* SOFTFLOAT_TYPES_H */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 52af1412de..4e16e22e58 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -100,36 +100,7 @@ enum {
     float_relation_unordered =  2
 };
 
-/*----------------------------------------------------------------------------
-| Software IEC/IEEE floating-point types.
-*----------------------------------------------------------------------------*/
-typedef uint16_t float16;
-typedef uint32_t float32;
-typedef uint64_t float64;
-#define float16_val(x) (x)
-#define float32_val(x) (x)
-#define float64_val(x) (x)
-#define make_float16(x) (x)
-#define make_float32(x) (x)
-#define make_float64(x) (x)
-#define const_float16(x) (x)
-#define const_float32(x) (x)
-#define const_float64(x) (x)
-typedef struct {
-    uint64_t low;
-    uint16_t high;
-} floatx80;
-#define make_floatx80(exp, mant) ((floatx80) { mant, exp })
-#define make_floatx80_init(exp, mant) { .low = mant, .high = exp }
-typedef struct {
-#ifdef HOST_WORDS_BIGENDIAN
-    uint64_t high, low;
-#else
-    uint64_t low, high;
-#endif
-} float128;
-#define make_float128(high_, low_) ((float128) { .high = high_, .low = low_ })
-#define make_float128_init(high_, low_) { .high = high_, .low = low_ }
+#include "fpu/softfloat-types.h"
 
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE floating-point underflow tininess-detection mode.
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 09c78fd28a..3f28f661b1 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -1,7 +1,7 @@
 #ifndef BSWAP_H
 #define BSWAP_H
 
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-types.h"
 
 #ifdef CONFIG_MACHINE_BSWAP_H
 # include <sys/endian.h>
-- 
2.15.1
