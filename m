Received: from eggs.gnu.org ([2001:4830:134:3::10]:47470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9AE0-0004jG-Ql
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ADl-0004sm-6F
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:48 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9ADk-0004nF-Ib
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:33 -0400
Received: by mail-wr0-x243.google.com with SMTP id f14-v6so14431610wre.4
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 07:07:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:46 +0100
Message-Id: <20180419135901.30035-29-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 28/43] tests/tcg/aarch64: add fcvt test
 cases for AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This runs through the usual float to float conversions and crucially
also runs with ARM Alternative Half Precision Format.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |    8 +
 tests/tcg/aarch64/fcvt.c          |  260 ++++++
 tests/tcg/aarch64/fcvt.out        | 1305 +++++++++++++++++++++++++++++
 tests/tcg/arm/Makefile.target     |    4 +-
 4 files changed, 1576 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/fcvt.c
 create mode 100644 tests/tcg/aarch64/fcvt.out

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 4ac8fbe73f..26be1c58ef 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -2,4 +2,12 @@
 #
 # AArch64 specific tweaks
 
+AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
+VPATH 		+= $(AARCH64_SRC)
+
+# we don't build any of the ARM tests
+AARCH64_TESTS=$(filter-out $(ARM_TESTS), $(TESTS))
+AARCH64_TESTS+=fcvt
+TESTS:=$(AARCH64_TESTS)
+
 fcvt: LDFLAGS+=-lm
diff --git a/tests/tcg/aarch64/fcvt.c b/tests/tcg/aarch64/fcvt.c
new file mode 100644
index 0000000000..e8d322e0bd
--- /dev/null
+++ b/tests/tcg/aarch64/fcvt.c
@@ -0,0 +1,260 @@
+/*
+ * Test Floating Point Conversion
+ */
+
+#include <stdio.h>
+#include <inttypes.h>
+#include <math.h>
+#include <float.h>
+#include <fenv.h>
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static char flag_str[256];
+
+static char *get_flag_state(int flags)
+{
+    if (flags) {
+        snprintf(flag_str, sizeof(flag_str), "%s %s %s %s %s",
+                 flags & FE_OVERFLOW ? "OVERFLOW" : "",
+                 flags & FE_UNDERFLOW ? "UNDERFLOW" : "",
+                 flags & FE_DIVBYZERO ? "DIV0" : "",
+                 flags & FE_INEXACT ? "INEXACT" : "",
+                 flags & FE_INVALID ? "INVALID" : "");
+    } else {
+        snprintf(flag_str, sizeof(flag_str), "OK");
+    }
+
+    return flag_str;
+}
+
+static void print_double_number(int i, double num)
+{
+    uint64_t double_as_hex = *(uint64_t *) &num;
+    int flags = fetestexcept(FE_ALL_EXCEPT);
+    char *fstr = get_flag_state(flags);
+
+    printf("%02d DOUBLE: %02.20e / %#020lx  (%#x => %s)\n",
+           i, num, double_as_hex, flags, fstr);
+}
+
+static void print_single_number(int i, float num)
+{
+    uint32_t single_as_hex = *(uint32_t *) &num;
+    int flags = fetestexcept(FE_ALL_EXCEPT);
+    char *fstr = get_flag_state(flags);
+
+    printf("%02d SINGLE: %02.20e / %#010x  (%#x => %s)\n",
+           i, num, single_as_hex, flags, fstr);
+}
+
+static void print_half_number(int i, uint16_t num)
+{
+    int flags = fetestexcept(FE_ALL_EXCEPT);
+    char *fstr = get_flag_state(flags);
+
+    printf("%02d   HALF: %#04x  (%#x => %s)\n",
+           i, num, flags, fstr);
+}
+
+float single_numbers[] = { -FLT_MAX, -FLT_MIN,
+                           0.0,
+                           FLT_MIN,
+                           1.0, 2.0,
+                           M_E, M_PI,
+                           0x9EA82A22,
+                           0xAB98FBA8,
+                           FLT_MAX };
+
+static void convert_single_to_half(void)
+{
+    int i;
+
+    printf("Converting single-precision to half-precision\n");
+
+    for (i = 0; i < ARRAY_SIZE(single_numbers); ++i) {
+        float input = single_numbers[i];
+        uint16_t output;
+
+        feclearexcept(FE_ALL_EXCEPT);
+
+        print_single_number(i, input);
+        asm("fcvt %h0, %d1" : "=w" (output) : "x" (input));
+        print_half_number(i, output);
+    }
+}
+
+static void convert_single_to_double(void)
+{
+    int i;
+
+    printf("Converting single-precision to double-precision\n");
+
+    for (i = 0; i < ARRAY_SIZE(single_numbers); ++i) {
+        float input = single_numbers[i];
+        uint64_t output;
+
+        feclearexcept(FE_ALL_EXCEPT);
+
+        print_single_number(i, input);
+        asm("fcvt %h0, %d1" : "=w" (output) : "x" (input));
+        print_double_number(i, output);
+    }
+}
+
+double double_numbers[] = { -DBL_MAX,
+                            -2.0, -1.0,
+                            -DBL_MIN,
+                            0.0,
+                            DBL_MIN,
+                            1.0, 2.0,
+                            M_E, M_PI,
+                            0x9EA82A2287680UL,
+                            0xAB98FBA843210UL,
+                            DBL_MAX };
+
+static void convert_double_to_half(void)
+{
+    int i;
+
+    printf("Converting double-precision to half-precision\n");
+
+    for (i = 0; i < ARRAY_SIZE(single_numbers); ++i) {
+        double input = double_numbers[i];
+        uint16_t output;
+
+        feclearexcept(FE_ALL_EXCEPT);
+
+        print_double_number(i, input);
+
+        /* as we don't have _Float16 support */
+        asm("fcvt %h0, %d1" : "=w" (output) : "x" (input));
+        print_half_number(i, output);
+    }
+}
+
+static void convert_double_to_single(void)
+{
+    int i;
+
+    printf("Converting double-precision to single-precision\n");
+
+    for (i = 0; i < ARRAY_SIZE(single_numbers); ++i) {
+        double input = double_numbers[i];
+        uint32_t output;
+
+        feclearexcept(FE_ALL_EXCEPT);
+
+        print_double_number(i, input);
+
+        asm("fcvt %s0, %d1" : "=w" (output) : "x" (input));
+
+        print_single_number(i, output);
+    }
+}
+
+/* no handy defines for these numbers */
+uint16_t half_numbers[] = {
+    0xffff, /* -NaN / AHP -Max */
+    0xfcff, /* -NaN / AHP */
+    0xfc01, /* -NaN / AHP */
+    0xfc00, /* -Inf */
+    0xfbff, /* -Max */
+    0xc000, /* -2 */
+    0xbc00, /* -1 */
+    0x8001, /* -MIN subnormal */
+    0x8000, /* -0 */
+    0x0000, /* +0 */
+    0x0001, /* MIN subnormal */
+    0x3c00, /* 1 */
+    0x7bff, /* Max */
+    0x7c00, /* Inf */
+    0x7c01, /* NaN / AHP */
+    0x7cff, /* NaN / AHP */
+    0x7fff, /* NaN / AHP +Max*/
+};
+
+static void convert_half_to_double(void)
+{
+    int i;
+
+    printf("Converting half-precision to double-precision\n");
+
+    for (i = 0; i < ARRAY_SIZE(half_numbers); ++i) {
+        uint16_t input = half_numbers[i];
+        double output;
+
+        feclearexcept(FE_ALL_EXCEPT);
+
+        print_half_number(i, input);
+        asm("fcvt %d0, %h1" : "=w" (output) : "x" (input));
+        print_double_number(i, output);
+    }
+}
+
+static void convert_half_to_single(void)
+{
+    int i;
+
+    printf("Converting half-precision to single-precision\n");
+
+    for (i = 0; i < ARRAY_SIZE(half_numbers); ++i) {
+        uint16_t input = half_numbers[i];
+        float output;
+
+        feclearexcept(FE_ALL_EXCEPT);
+
+        print_half_number(i, input);
+        asm("fcvt %s0, %h1" : "=w" (output) : "x" (input));
+        print_single_number(i, output);
+    }
+}
+
+typedef struct {
+    int flag;
+    char *desc;
+} float_mapping;
+
+float_mapping round_flags[] = {
+    { FE_TONEAREST, "to nearest" },
+    { FE_UPWARD, "upwards" },
+    { FE_DOWNWARD, "downwards" },
+    { FE_TOWARDZERO, "to zero" }
+};
+
+int main(int argc, char *argv[argc])
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(round_flags); ++i) {
+        fesetround(round_flags[i].flag);
+        printf("### Rounding %s\n", round_flags[i].desc);
+        convert_single_to_half();
+        convert_single_to_double();
+        convert_double_to_half();
+        convert_double_to_single();
+        convert_half_to_single();
+        convert_half_to_double();
+    }
+
+    /* And now with ARM alternative FP16 */
+    asm("msr fpsr, x1\n\t"
+        "orr x1, x1, %[flags]\n\t"
+        "mrs x1, fpsr\n\t"
+        : /* no output */ : [flags] "n" (1 << 26) : "x1" );
+
+    printf("#### Enabling ARM Alternative Half Precision\n");
+
+    for (i = 0; i < ARRAY_SIZE(round_flags); ++i) {
+        fesetround(round_flags[i].flag);
+        printf("### Rounding %s\n", round_flags[i].desc);
+        convert_single_to_half();
+        convert_single_to_double();
+        convert_double_to_half();
+        convert_double_to_single();
+        convert_half_to_single();
+        convert_half_to_double();
+    }
+
+    return 0;
+}
diff --git a/tests/tcg/aarch64/fcvt.out b/tests/tcg/aarch64/fcvt.out
new file mode 100644
index 0000000000..48e62ac955
--- /dev/null
+++ b/tests/tcg/aarch64/fcvt.out
@@ -0,0 +1,1305 @@
+### Rounding to nearest
+Converting single-precision to half-precision
+00 SINGLE: -3.40282346638528859812e+38 / 0xff7fffff  (0 => OK)
+00   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750797e-38 / 0x80800000  (0 => OK)
+01   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02   HALF: 0000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750797e-38 / 0x00800000  (0 => OK)
+03   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324219e+00 / 0x40490fdb  (0 => OK)
+07   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859812e+38 / 0x7f7fffff  (0 => OK)
+10   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting single-precision to double-precision
+00 SINGLE: -3.40282346638528859812e+38 / 0xff7fffff  (0 => OK)
+00 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750797e-38 / 0x80800000  (0 => OK)
+01 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750797e-38 / 0x00800000  (0 => OK)
+03 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324219e+00 / 0x40490fdb  (0 => OK)
+07 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859812e+38 / 0x7f7fffff  (0 => OK)
+10 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting double-precision to half-precision
+00 DOUBLE: -1.79769313486231570815e+308 / 0x00ffefffffffffffff  (0 => OK)
+00   HALF: 0x0000fc00  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01   HALF: 0x0000c000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02   HALF: 0x0000bc00  (0 => OK)
+03 DOUBLE: -2.22507385850720138309e-308 / 0x008010000000000000  (0 => OK)
+03   HALF: 0x00008000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04   HALF: 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138309e-308 / 0x000010000000000000  (0 => OK)
+05   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06   HALF: 0x00003c00  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07   HALF: 0x00004000  (0 => OK)
+08 DOUBLE: 2.71828182845904509080e+00 / 0x004005bf0a8b145769  (0 => OK)
+08   HALF: 0x00004170  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311600e+00 / 0x00400921fb54442d18  (0 => OK)
+09   HALF: 0x00004248  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10   HALF: 0x00007c00  (0x14 => OVERFLOW   INEXACT )
+Converting double-precision to single-precision
+00 DOUBLE: -1.79769313486231570815e+308 / 0x00ffefffffffffffff  (0 => OK)
+00 SINGLE: 4.28657868800000000000e+09 / 0x4f7f8000  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01 SINGLE: 3.22122547200000000000e+09 / 0x4f400000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02 SINGLE: 3.21283686400000000000e+09 / 0x4f3f8000  (0 => OK)
+03 DOUBLE: -2.22507385850720138309e-308 / 0x008010000000000000  (0 => OK)
+03 SINGLE: 2.14748364800000000000e+09 / 0x4f000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138309e-308 / 0x000010000000000000  (0 => OK)
+05 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06 SINGLE: 1.06535321600000000000e+09 / 0x4e7e0000  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07 SINGLE: 1.07374182400000000000e+09 / 0x4e800000  (0 => OK)
+08 DOUBLE: 2.71828182845904509080e+00 / 0x004005bf0a8b145769  (0 => OK)
+08 SINGLE: 1.07675456000000000000e+09 / 0x4e805bf1  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311600e+00 / 0x00400921fb54442d18  (0 => OK)
+09 SINGLE: 1.07853004800000000000e+09 / 0x4e809220  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10 SINGLE: 1.49518131200000000000e+09 / 0x4eb23d50  (0x10 =>    INEXACT )
+Converting half-precision to single-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+Converting half-precision to double-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+### Rounding upwards
+Converting single-precision to half-precision
+00 SINGLE: -3.40282346638528859811e+38 / 0xff7fffff  (0 => OK)
+00   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750796e-38 / 0x80800000  (0 => OK)
+01   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02   HALF: 0000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750797e-38 / 0x00800000  (0 => OK)
+03   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324219e+00 / 0x40490fdb  (0 => OK)
+07   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859812e+38 / 0x7f7fffff  (0 => OK)
+10   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+Converting single-precision to double-precision
+00 SINGLE: -3.40282346638528859811e+38 / 0xff7fffff  (0 => OK)
+00 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750796e-38 / 0x80800000  (0 => OK)
+01 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750797e-38 / 0x00800000  (0 => OK)
+03 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324219e+00 / 0x40490fdb  (0 => OK)
+07 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859812e+38 / 0x7f7fffff  (0 => OK)
+10 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting double-precision to half-precision
+00 DOUBLE: -1.79769313486231570814e+308 / 0x00ffefffffffffffff  (0 => OK)
+00   HALF: 0x0000fbff  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01   HALF: 0x0000c000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02   HALF: 0x0000bc00  (0 => OK)
+03 DOUBLE: -2.22507385850720138309e-308 / 0x008010000000000000  (0 => OK)
+03   HALF: 0x00008000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04   HALF: 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138310e-308 / 0x000010000000000000  (0 => OK)
+05   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06   HALF: 0x00003c00  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07   HALF: 0x00004000  (0 => OK)
+08 DOUBLE: 2.71828182845904509080e+00 / 0x004005bf0a8b145769  (0 => OK)
+08   HALF: 0x00004170  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311600e+00 / 0x00400921fb54442d18  (0 => OK)
+09   HALF: 0x00004249  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10   HALF: 0x00007c00  (0x14 => OVERFLOW   INEXACT )
+Converting double-precision to single-precision
+00 DOUBLE: -1.79769313486231570814e+308 / 0x00ffefffffffffffff  (0 => OK)
+00 SINGLE: 4.28657868800000000000e+09 / 0x4f7f8000  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01 SINGLE: 3.22122547200000000000e+09 / 0x4f400000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02 SINGLE: 3.21283686400000000000e+09 / 0x4f3f8000  (0 => OK)
+03 DOUBLE: -2.22507385850720138309e-308 / 0x008010000000000000  (0 => OK)
+03 SINGLE: 2.14748364800000000000e+09 / 0x4f000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138310e-308 / 0x000010000000000000  (0 => OK)
+05 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06 SINGLE: 1.06535321600000000000e+09 / 0x4e7e0000  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07 SINGLE: 1.07374182400000000000e+09 / 0x4e800000  (0 => OK)
+08 DOUBLE: 2.71828182845904509080e+00 / 0x004005bf0a8b145769  (0 => OK)
+08 SINGLE: 1.07675456000000000000e+09 / 0x4e805bf1  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311600e+00 / 0x00400921fb54442d18  (0 => OK)
+09 SINGLE: 1.07853004800000000000e+09 / 0x4e809220  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10 SINGLE: 1.49518144000000000000e+09 / 0x4eb23d51  (0x10 =>    INEXACT )
+Converting half-precision to single-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+Converting half-precision to double-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+### Rounding downwards
+Converting single-precision to half-precision
+00 SINGLE: -3.40282346638528859812e+38 / 0xff7fffff  (0 => OK)
+00   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750797e-38 / 0x80800000  (0 => OK)
+01   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02   HALF: 0000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750796e-38 / 0x00800000  (0 => OK)
+03   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324218e+00 / 0x40490fdb  (0 => OK)
+07   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859811e+38 / 0x7f7fffff  (0 => OK)
+10   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting single-precision to double-precision
+00 SINGLE: -3.40282346638528859812e+38 / 0xff7fffff  (0 => OK)
+00 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750797e-38 / 0x80800000  (0 => OK)
+01 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750796e-38 / 0x00800000  (0 => OK)
+03 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324218e+00 / 0x40490fdb  (0 => OK)
+07 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859811e+38 / 0x7f7fffff  (0 => OK)
+10 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting double-precision to half-precision
+00 DOUBLE: -1.79769313486231570815e+308 / 0x00ffefffffffffffff  (0 => OK)
+00   HALF: 0x0000fc00  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01   HALF: 0x0000c000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02   HALF: 0x0000bc00  (0 => OK)
+03 DOUBLE: -2.22507385850720138310e-308 / 0x008010000000000000  (0 => OK)
+03   HALF: 0x00008001  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04   HALF: 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138309e-308 / 0x000010000000000000  (0 => OK)
+05   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06   HALF: 0x00003c00  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07   HALF: 0x00004000  (0 => OK)
+08 DOUBLE: 2.71828182845904509079e+00 / 0x004005bf0a8b145769  (0 => OK)
+08   HALF: 0x0000416f  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311599e+00 / 0x00400921fb54442d18  (0 => OK)
+09   HALF: 0x00004248  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10   HALF: 0x00007bff  (0x14 => OVERFLOW   INEXACT )
+Converting double-precision to single-precision
+00 DOUBLE: -1.79769313486231570815e+308 / 0x00ffefffffffffffff  (0 => OK)
+00 SINGLE: 4.28657868800000000000e+09 / 0x4f7f8000  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01 SINGLE: 3.22122547200000000000e+09 / 0x4f400000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02 SINGLE: 3.21283686400000000000e+09 / 0x4f3f8000  (0 => OK)
+03 DOUBLE: -2.22507385850720138310e-308 / 0x008010000000000000  (0 => OK)
+03 SINGLE: 2.14748364800000000000e+09 / 0x4f000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138309e-308 / 0x000010000000000000  (0 => OK)
+05 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06 SINGLE: 1.06535321600000000000e+09 / 0x4e7e0000  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07 SINGLE: 1.07374182400000000000e+09 / 0x4e800000  (0 => OK)
+08 DOUBLE: 2.71828182845904509079e+00 / 0x004005bf0a8b145769  (0 => OK)
+08 SINGLE: 1.07675443200000000000e+09 / 0x4e805bf0  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311599e+00 / 0x00400921fb54442d18  (0 => OK)
+09 SINGLE: 1.07852992000000000000e+09 / 0x4e80921f  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10 SINGLE: 1.49518131200000000000e+09 / 0x4eb23d50  (0x10 =>    INEXACT )
+Converting half-precision to single-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+Converting half-precision to double-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+### Rounding to zero
+Converting single-precision to half-precision
+00 SINGLE: -3.40282346638528859811e+38 / 0xff7fffff  (0 => OK)
+00   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750796e-38 / 0x80800000  (0 => OK)
+01   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02   HALF: 0000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750796e-38 / 0x00800000  (0 => OK)
+03   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324218e+00 / 0x40490fdb  (0 => OK)
+07   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859811e+38 / 0x7f7fffff  (0 => OK)
+10   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting single-precision to double-precision
+00 SINGLE: -3.40282346638528859811e+38 / 0xff7fffff  (0 => OK)
+00 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750796e-38 / 0x80800000  (0 => OK)
+01 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750796e-38 / 0x00800000  (0 => OK)
+03 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324218e+00 / 0x40490fdb  (0 => OK)
+07 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859811e+38 / 0x7f7fffff  (0 => OK)
+10 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting double-precision to half-precision
+00 DOUBLE: -1.79769313486231570814e+308 / 0x00ffefffffffffffff  (0 => OK)
+00   HALF: 0x0000fbff  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01   HALF: 0x0000c000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02   HALF: 0x0000bc00  (0 => OK)
+03 DOUBLE: -2.22507385850720138309e-308 / 0x008010000000000000  (0 => OK)
+03   HALF: 0x00008000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04   HALF: 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138309e-308 / 0x000010000000000000  (0 => OK)
+05   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06   HALF: 0x00003c00  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07   HALF: 0x00004000  (0 => OK)
+08 DOUBLE: 2.71828182845904509079e+00 / 0x004005bf0a8b145769  (0 => OK)
+08   HALF: 0x0000416f  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311599e+00 / 0x00400921fb54442d18  (0 => OK)
+09   HALF: 0x00004248  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10   HALF: 0x00007bff  (0x14 => OVERFLOW   INEXACT )
+Converting double-precision to single-precision
+00 DOUBLE: -1.79769313486231570814e+308 / 0x00ffefffffffffffff  (0 => OK)
+00 SINGLE: 4.28657843200000000000e+09 / 0x4f7f7fff  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01 SINGLE: 3.22122547200000000000e+09 / 0x4f400000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02 SINGLE: 3.21283686400000000000e+09 / 0x4f3f8000  (0 => OK)
+03 DOUBLE: -2.22507385850720138309e-308 / 0x008010000000000000  (0 => OK)
+03 SINGLE: 2.14748364800000000000e+09 / 0x4f000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138309e-308 / 0x000010000000000000  (0 => OK)
+05 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06 SINGLE: 1.06535321600000000000e+09 / 0x4e7e0000  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07 SINGLE: 1.07374182400000000000e+09 / 0x4e800000  (0 => OK)
+08 DOUBLE: 2.71828182845904509079e+00 / 0x004005bf0a8b145769  (0 => OK)
+08 SINGLE: 1.07675443200000000000e+09 / 0x4e805bf0  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311599e+00 / 0x00400921fb54442d18  (0 => OK)
+09 SINGLE: 1.07852992000000000000e+09 / 0x4e80921f  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10 SINGLE: 1.49518131200000000000e+09 / 0x4eb23d50  (0x10 =>    INEXACT )
+Converting half-precision to single-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+Converting half-precision to double-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+#### Enabling ARM Alternative Half Precision
+### Rounding to nearest
+Converting single-precision to half-precision
+00 SINGLE: -3.40282346638528859812e+38 / 0xff7fffff  (0 => OK)
+00   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750797e-38 / 0x80800000  (0 => OK)
+01   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02   HALF: 0000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750797e-38 / 0x00800000  (0 => OK)
+03   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324219e+00 / 0x40490fdb  (0 => OK)
+07   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859812e+38 / 0x7f7fffff  (0 => OK)
+10   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting single-precision to double-precision
+00 SINGLE: -3.40282346638528859812e+38 / 0xff7fffff  (0 => OK)
+00 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750797e-38 / 0x80800000  (0 => OK)
+01 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750797e-38 / 0x00800000  (0 => OK)
+03 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324219e+00 / 0x40490fdb  (0 => OK)
+07 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859812e+38 / 0x7f7fffff  (0 => OK)
+10 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting double-precision to half-precision
+00 DOUBLE: -1.79769313486231570815e+308 / 0x00ffefffffffffffff  (0 => OK)
+00   HALF: 0x0000fc00  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01   HALF: 0x0000c000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02   HALF: 0x0000bc00  (0 => OK)
+03 DOUBLE: -2.22507385850720138309e-308 / 0x008010000000000000  (0 => OK)
+03   HALF: 0x00008000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04   HALF: 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138309e-308 / 0x000010000000000000  (0 => OK)
+05   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06   HALF: 0x00003c00  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07   HALF: 0x00004000  (0 => OK)
+08 DOUBLE: 2.71828182845904509080e+00 / 0x004005bf0a8b145769  (0 => OK)
+08   HALF: 0x00004170  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311600e+00 / 0x00400921fb54442d18  (0 => OK)
+09   HALF: 0x00004248  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10   HALF: 0x00007c00  (0x14 => OVERFLOW   INEXACT )
+Converting double-precision to single-precision
+00 DOUBLE: -1.79769313486231570815e+308 / 0x00ffefffffffffffff  (0 => OK)
+00 SINGLE: 4.28657868800000000000e+09 / 0x4f7f8000  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01 SINGLE: 3.22122547200000000000e+09 / 0x4f400000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02 SINGLE: 3.21283686400000000000e+09 / 0x4f3f8000  (0 => OK)
+03 DOUBLE: -2.22507385850720138309e-308 / 0x008010000000000000  (0 => OK)
+03 SINGLE: 2.14748364800000000000e+09 / 0x4f000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138309e-308 / 0x000010000000000000  (0 => OK)
+05 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06 SINGLE: 1.06535321600000000000e+09 / 0x4e7e0000  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07 SINGLE: 1.07374182400000000000e+09 / 0x4e800000  (0 => OK)
+08 DOUBLE: 2.71828182845904509080e+00 / 0x004005bf0a8b145769  (0 => OK)
+08 SINGLE: 1.07675456000000000000e+09 / 0x4e805bf1  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311600e+00 / 0x00400921fb54442d18  (0 => OK)
+09 SINGLE: 1.07853004800000000000e+09 / 0x4e809220  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10 SINGLE: 1.49518131200000000000e+09 / 0x4eb23d50  (0x10 =>    INEXACT )
+Converting half-precision to single-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+Converting half-precision to double-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+### Rounding upwards
+Converting single-precision to half-precision
+00 SINGLE: -3.40282346638528859811e+38 / 0xff7fffff  (0 => OK)
+00   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750796e-38 / 0x80800000  (0 => OK)
+01   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02   HALF: 0000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750797e-38 / 0x00800000  (0 => OK)
+03   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324219e+00 / 0x40490fdb  (0 => OK)
+07   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859812e+38 / 0x7f7fffff  (0 => OK)
+10   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+Converting single-precision to double-precision
+00 SINGLE: -3.40282346638528859811e+38 / 0xff7fffff  (0 => OK)
+00 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750796e-38 / 0x80800000  (0 => OK)
+01 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750797e-38 / 0x00800000  (0 => OK)
+03 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324219e+00 / 0x40490fdb  (0 => OK)
+07 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859812e+38 / 0x7f7fffff  (0 => OK)
+10 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting double-precision to half-precision
+00 DOUBLE: -1.79769313486231570814e+308 / 0x00ffefffffffffffff  (0 => OK)
+00   HALF: 0x0000fbff  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01   HALF: 0x0000c000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02   HALF: 0x0000bc00  (0 => OK)
+03 DOUBLE: -2.22507385850720138309e-308 / 0x008010000000000000  (0 => OK)
+03   HALF: 0x00008000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04   HALF: 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138310e-308 / 0x000010000000000000  (0 => OK)
+05   HALF: 0x00000001  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06   HALF: 0x00003c00  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07   HALF: 0x00004000  (0 => OK)
+08 DOUBLE: 2.71828182845904509080e+00 / 0x004005bf0a8b145769  (0 => OK)
+08   HALF: 0x00004170  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311600e+00 / 0x00400921fb54442d18  (0 => OK)
+09   HALF: 0x00004249  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10   HALF: 0x00007c00  (0x14 => OVERFLOW   INEXACT )
+Converting double-precision to single-precision
+00 DOUBLE: -1.79769313486231570814e+308 / 0x00ffefffffffffffff  (0 => OK)
+00 SINGLE: 4.28657868800000000000e+09 / 0x4f7f8000  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01 SINGLE: 3.22122547200000000000e+09 / 0x4f400000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02 SINGLE: 3.21283686400000000000e+09 / 0x4f3f8000  (0 => OK)
+03 DOUBLE: -2.22507385850720138309e-308 / 0x008010000000000000  (0 => OK)
+03 SINGLE: 2.14748364800000000000e+09 / 0x4f000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138310e-308 / 0x000010000000000000  (0 => OK)
+05 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06 SINGLE: 1.06535321600000000000e+09 / 0x4e7e0000  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07 SINGLE: 1.07374182400000000000e+09 / 0x4e800000  (0 => OK)
+08 DOUBLE: 2.71828182845904509080e+00 / 0x004005bf0a8b145769  (0 => OK)
+08 SINGLE: 1.07675456000000000000e+09 / 0x4e805bf1  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311600e+00 / 0x00400921fb54442d18  (0 => OK)
+09 SINGLE: 1.07853004800000000000e+09 / 0x4e809220  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10 SINGLE: 1.49518144000000000000e+09 / 0x4eb23d51  (0x10 =>    INEXACT )
+Converting half-precision to single-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+Converting half-precision to double-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+### Rounding downwards
+Converting single-precision to half-precision
+00 SINGLE: -3.40282346638528859812e+38 / 0xff7fffff  (0 => OK)
+00   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750797e-38 / 0x80800000  (0 => OK)
+01   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02   HALF: 0000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750796e-38 / 0x00800000  (0 => OK)
+03   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324218e+00 / 0x40490fdb  (0 => OK)
+07   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859811e+38 / 0x7f7fffff  (0 => OK)
+10   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting single-precision to double-precision
+00 SINGLE: -3.40282346638528859812e+38 / 0xff7fffff  (0 => OK)
+00 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750797e-38 / 0x80800000  (0 => OK)
+01 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750796e-38 / 0x00800000  (0 => OK)
+03 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324218e+00 / 0x40490fdb  (0 => OK)
+07 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859811e+38 / 0x7f7fffff  (0 => OK)
+10 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting double-precision to half-precision
+00 DOUBLE: -1.79769313486231570815e+308 / 0x00ffefffffffffffff  (0 => OK)
+00   HALF: 0x0000fc00  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01   HALF: 0x0000c000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02   HALF: 0x0000bc00  (0 => OK)
+03 DOUBLE: -2.22507385850720138310e-308 / 0x008010000000000000  (0 => OK)
+03   HALF: 0x00008001  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04   HALF: 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138309e-308 / 0x000010000000000000  (0 => OK)
+05   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06   HALF: 0x00003c00  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07   HALF: 0x00004000  (0 => OK)
+08 DOUBLE: 2.71828182845904509079e+00 / 0x004005bf0a8b145769  (0 => OK)
+08   HALF: 0x0000416f  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311599e+00 / 0x00400921fb54442d18  (0 => OK)
+09   HALF: 0x00004248  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10   HALF: 0x00007bff  (0x14 => OVERFLOW   INEXACT )
+Converting double-precision to single-precision
+00 DOUBLE: -1.79769313486231570815e+308 / 0x00ffefffffffffffff  (0 => OK)
+00 SINGLE: 4.28657868800000000000e+09 / 0x4f7f8000  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01 SINGLE: 3.22122547200000000000e+09 / 0x4f400000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02 SINGLE: 3.21283686400000000000e+09 / 0x4f3f8000  (0 => OK)
+03 DOUBLE: -2.22507385850720138310e-308 / 0x008010000000000000  (0 => OK)
+03 SINGLE: 2.14748364800000000000e+09 / 0x4f000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138309e-308 / 0x000010000000000000  (0 => OK)
+05 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06 SINGLE: 1.06535321600000000000e+09 / 0x4e7e0000  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07 SINGLE: 1.07374182400000000000e+09 / 0x4e800000  (0 => OK)
+08 DOUBLE: 2.71828182845904509079e+00 / 0x004005bf0a8b145769  (0 => OK)
+08 SINGLE: 1.07675443200000000000e+09 / 0x4e805bf0  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311599e+00 / 0x00400921fb54442d18  (0 => OK)
+09 SINGLE: 1.07852992000000000000e+09 / 0x4e80921f  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10 SINGLE: 1.49518131200000000000e+09 / 0x4eb23d50  (0x10 =>    INEXACT )
+Converting half-precision to single-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+Converting half-precision to double-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+### Rounding to zero
+Converting single-precision to half-precision
+00 SINGLE: -3.40282346638528859811e+38 / 0xff7fffff  (0 => OK)
+00   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750796e-38 / 0x80800000  (0 => OK)
+01   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02   HALF: 0000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750796e-38 / 0x00800000  (0 => OK)
+03   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324218e+00 / 0x40490fdb  (0 => OK)
+07   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859811e+38 / 0x7f7fffff  (0 => OK)
+10   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting single-precision to double-precision
+00 SINGLE: -3.40282346638528859811e+38 / 0xff7fffff  (0 => OK)
+00 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+01 SINGLE: -1.17549435082228750796e-38 / 0x80800000  (0 => OK)
+01 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+02 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+02 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+03 SINGLE: 1.17549435082228750796e-38 / 0x00800000  (0 => OK)
+03 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 SINGLE: 1.00000000000000000000e+00 / 0x3f800000  (0 => OK)
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+05 SINGLE: 2.00000000000000000000e+00 / 0x40000000  (0 => OK)
+05 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 SINGLE: 2.71828174591064453125e+00 / 0x402df854  (0 => OK)
+06 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+07 SINGLE: 3.14159274101257324218e+00 / 0x40490fdb  (0 => OK)
+07 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+08 SINGLE: 2.66182092800000000000e+09 / 0x4f1ea82a  (0 => OK)
+08 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+09 SINGLE: 2.87892992000000000000e+09 / 0x4f2b98fc  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+10 SINGLE: 3.40282346638528859811e+38 / 0x7f7fffff  (0 => OK)
+10 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0x18 =>  UNDERFLOW  INEXACT )
+Converting double-precision to half-precision
+00 DOUBLE: -1.79769313486231570814e+308 / 0x00ffefffffffffffff  (0 => OK)
+00   HALF: 0x0000fbff  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01   HALF: 0x0000c000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02   HALF: 0x0000bc00  (0 => OK)
+03 DOUBLE: -2.22507385850720138309e-308 / 0x008010000000000000  (0 => OK)
+03   HALF: 0x00008000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04   HALF: 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138309e-308 / 0x000010000000000000  (0 => OK)
+05   HALF: 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06   HALF: 0x00003c00  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07   HALF: 0x00004000  (0 => OK)
+08 DOUBLE: 2.71828182845904509079e+00 / 0x004005bf0a8b145769  (0 => OK)
+08   HALF: 0x0000416f  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311599e+00 / 0x00400921fb54442d18  (0 => OK)
+09   HALF: 0x00004248  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10   HALF: 0x00007bff  (0x14 => OVERFLOW   INEXACT )
+Converting double-precision to single-precision
+00 DOUBLE: -1.79769313486231570814e+308 / 0x00ffefffffffffffff  (0 => OK)
+00 SINGLE: 4.28657843200000000000e+09 / 0x4f7f7fff  (0x14 => OVERFLOW   INEXACT )
+01 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+01 SINGLE: 3.22122547200000000000e+09 / 0x4f400000  (0 => OK)
+02 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+02 SINGLE: 3.21283686400000000000e+09 / 0x4f3f8000  (0 => OK)
+03 DOUBLE: -2.22507385850720138309e-308 / 0x008010000000000000  (0 => OK)
+03 SINGLE: 2.14748364800000000000e+09 / 0x4f000000  (0x18 =>  UNDERFLOW  INEXACT )
+04 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+04 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0 => OK)
+05 DOUBLE: 2.22507385850720138309e-308 / 0x000010000000000000  (0 => OK)
+05 SINGLE: 0.00000000000000000000e+00 / 0000000000  (0x18 =>  UNDERFLOW  INEXACT )
+06 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+06 SINGLE: 1.06535321600000000000e+09 / 0x4e7e0000  (0 => OK)
+07 DOUBLE: 2.00000000000000000000e+00 / 0x004000000000000000  (0 => OK)
+07 SINGLE: 1.07374182400000000000e+09 / 0x4e800000  (0 => OK)
+08 DOUBLE: 2.71828182845904509079e+00 / 0x004005bf0a8b145769  (0 => OK)
+08 SINGLE: 1.07675443200000000000e+09 / 0x4e805bf0  (0x10 =>    INEXACT )
+09 DOUBLE: 3.14159265358979311599e+00 / 0x00400921fb54442d18  (0 => OK)
+09 SINGLE: 1.07852992000000000000e+09 / 0x4e80921f  (0x10 =>    INEXACT )
+10 DOUBLE: 2.79112157760473600000e+15 / 0x004323d5054450ed00  (0 => OK)
+10 SINGLE: 1.49518131200000000000e+09 / 0x4eb23d50  (0x10 =>    INEXACT )
+Converting half-precision to single-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
+Converting half-precision to double-precision
+00   HALF: 0x0000ffff  (0 => OK)
+00 DOUBLE: -nan / 0x00fffffc0000000000  (0 => OK)
+01   HALF: 0x0000fcff  (0 => OK)
+01 DOUBLE: -nan / 0x00fffbfc0000000000  (0x1 =>     INVALID)
+02   HALF: 0x0000fc01  (0 => OK)
+02 DOUBLE: -nan / 0x00fff8040000000000  (0x1 =>     INVALID)
+03   HALF: 0x0000fc00  (0 => OK)
+03 DOUBLE: -inf / 0x00fff0000000000000  (0 => OK)
+04   HALF: 0x0000fbff  (0 => OK)
+04 DOUBLE: -6.55040000000000000000e+04 / 0x00c0effc0000000000  (0 => OK)
+05   HALF: 0x0000c000  (0 => OK)
+05 DOUBLE: -2.00000000000000000000e+00 / 0x00c000000000000000  (0 => OK)
+06   HALF: 0x0000bc00  (0 => OK)
+06 DOUBLE: -1.00000000000000000000e+00 / 0x00bff0000000000000  (0 => OK)
+07   HALF: 0x00008001  (0 => OK)
+07 DOUBLE: -5.96046447753906250000e-08 / 0x00be70000000000000  (0 => OK)
+08   HALF: 0x00008000  (0 => OK)
+08 DOUBLE: -0.00000000000000000000e+00 / 0x008000000000000000  (0 => OK)
+09   HALF: 0000000000  (0 => OK)
+09 DOUBLE: 0.00000000000000000000e+00 / 00000000000000000000  (0 => OK)
+10   HALF: 0x00000001  (0 => OK)
+10 DOUBLE: 5.96046447753906250000e-08 / 0x003e70000000000000  (0 => OK)
+11   HALF: 0x00003c00  (0 => OK)
+11 DOUBLE: 1.00000000000000000000e+00 / 0x003ff0000000000000  (0 => OK)
+12   HALF: 0x00007bff  (0 => OK)
+12 DOUBLE: 6.55040000000000000000e+04 / 0x0040effc0000000000  (0 => OK)
+13   HALF: 0x00007c00  (0 => OK)
+13 DOUBLE: inf / 0x007ff0000000000000  (0 => OK)
+14   HALF: 0x00007c01  (0 => OK)
+14 DOUBLE: nan / 0x007ff8040000000000  (0x1 =>     INVALID)
+15   HALF: 0x00007cff  (0 => OK)
+15 DOUBLE: nan / 0x007ffbfc0000000000  (0x1 =>     INVALID)
+16   HALF: 0x00007fff  (0 => OK)
+16 DOUBLE: nan / 0x007ffffc0000000000  (0 => OK)
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index be9d3fb4a1..f1c7ec46b5 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -8,7 +8,9 @@ ARM_SRC=$(SRC_PATH)/tests/tcg/arm
 # Set search path for all sources
 VPATH 		+= $(ARM_SRC)
 
-TESTS += hello-arm test-arm-iwmmxt
+ARM_TESTS=hello-arm test-arm-iwmmxt
+
+TESTS += $(ARM_TESTS)
 
 hello-arm: CFLAGS+=-marm -ffreestanding
 hello-arm: LDFLAGS+=-nostdlib
-- 
2.17.0
