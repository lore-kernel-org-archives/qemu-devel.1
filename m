Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CF2C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDA520692
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 13:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnsOclHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDA520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8lyu-0007yg-JE
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 09:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8lxM-0006DS-V5
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8lxL-0001lc-Ek
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:49:48 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8lxL-0001lJ-86
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 09:49:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 7so2877923wme.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7YFyCFnEnXMppX1+jC2RkPxJ3ZwHqSp7QupFrR4do2M=;
 b=GnsOclHOv4rQ6l9qwhLRQGp4t7KyyYFSebn6SuTDngKZfHfUwhVgXLv0s0IKeWuncy
 iWEenN/W0sWLwkQs9GvWFIMJV5j5xDkNa3JfAk4gAbTgDHjJ2BN/InFykhPkcP8IVAbI
 aTDRN2MB0szg1Lb9AXgOrOtPoX9XamK2Dn3/l3cZThHSExOJt4F4V/8zBasCEbwT58DH
 9JcZRMKTP0fRYrhM/AnvMto10HZ2qMkR8QaxC9Q25kQvMAM7QacOpYhFRu8Mb1x+jy4A
 FCDGYqrmFy+3uyRDVoiIA3R/NHd9oYPtOHhDlto+HNOlPzFQeeuv15xGatBnm7Z0xF4O
 BTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7YFyCFnEnXMppX1+jC2RkPxJ3ZwHqSp7QupFrR4do2M=;
 b=S+Scb1I45cMJezUS56pQUCAVBWJRHPDdTXT5ABLm4CpEtawfwUKOBibeMPhp72WIYO
 pon8w65QP09wcPAyd5fmk+m3iU6iu8knjJxFqyUzyAEUVuH5/mnS+qrZG3Xq4IXPAy36
 u/WobK8UCxdAOlmTY0GrcrEkwANWSBPqTkK4K75gLkvidAg6j/w2v69FiI0cFowyBukx
 0lGfQ0xPnSYwLRHxL1xCxNs2UEvMgPjQ1fH6iwudN4tjdXQg1jnFovCwuj2/2BMkt109
 cD8SlHx35grPFWBwiFvgWdWSUX6fso5s8tHBo5kXXjFU1BAn6h0Tf9KP/FRsz5tAutAY
 Uxvw==
X-Gm-Message-State: APjAAAVgGMe0RPHO/J/kEn91pP+bKEQx9CSQzjuw2DBJ6SgBwWM0jWF3
 OFKhI7IaVEmG/7bV8xkR8Gz59gsmh9s=
X-Google-Smtp-Source: APXvYqwI4QoNNUI5eXuIwk9fsjC4+IftNQ/hkfHNCjON6UcyJqsebivS+wUjM2Tg28alzOV4gmdlLg==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr3323289wmi.133.1568382585944; 
 Fri, 13 Sep 2019 06:49:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d9sm35578274wrf.62.2019.09.13.06.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 06:49:45 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BE7721FF87;
 Fri, 13 Sep 2019 14:49:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 14:49:34 +0100
Message-Id: <20190913134935.29696-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PATCH] tests/tcg: add float_madds test to multiarch
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 1841592@bugs.launchpad.net, richard.henderson@linaro.org, pc@us.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a generic floating point multiply and accumulate test for
single precision floating point values. I've split of the common float
functions into a helper library so additional tests can use the same
common code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/Makefile.target |   7 +-
 tests/tcg/multiarch/float_helpers.c | 208 ++++++++++++++++++++++++++++
 tests/tcg/multiarch/float_helpers.h |  26 ++++
 tests/tcg/multiarch/float_madds.c   |  78 +++++++++++
 4 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/float_helpers.c
 create mode 100644 tests/tcg/multiarch/float_helpers.h
 create mode 100644 tests/tcg/multiarch/float_madds.c

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 657a04f802d..0446b75c456 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -10,12 +10,17 @@ MULTIARCH_SRC=$(SRC_PATH)/tests/tcg/multiarch
 # Set search path for all sources
 VPATH 		+= $(MULTIARCH_SRC)
 MULTIARCH_SRCS   =$(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
-MULTIARCH_TESTS  =$(MULTIARCH_SRCS:.c=)
+MULTIARCH_TESTS  =$(filter-out float_helpers, $(MULTIARCH_SRCS:.c=))
 
 #
 # The following are any additional rules needed to build things
 #
 
+
+float_madds: LDFLAGS+=-lm
+float_madds: float_madds.c float_helpers.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -O2 $< $(MULTIARCH_SRC)/float_helpers.c -o $@ $(LDFLAGS)
+
 testthread: LDFLAGS+=-lpthread
 
 # We define the runner for test-mmap after the individual
diff --git a/tests/tcg/multiarch/float_helpers.c b/tests/tcg/multiarch/float_helpers.c
new file mode 100644
index 00000000000..481d8d33317
--- /dev/null
+++ b/tests/tcg/multiarch/float_helpers.c
@@ -0,0 +1,208 @@
+/*
+ * Common Float Helpers
+ *
+ * This contains a series of useful utility routines and a set of
+ * floating point constants useful for exercising the edge cases in
+ * floating point tests.
+ *
+ * Copyright (c) 2019 Linaro
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+/* we want additional float type definitions */
+#define __STDC_WANT_IEC_60559_BFP_EXT__
+#define __STDC_WANT_IEC_60559_TYPES_EXT__
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <inttypes.h>
+#include <math.h>
+#include <float.h>
+#include <fenv.h>
+
+#include "float_helpers.h"
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+/*
+ * Half Precision Numbers
+ *
+ * Not yet well standardised so we return a plain uint16_t for now.
+ */
+
+/* no handy defines for these numbers */
+static uint16_t f16_numbers[] = {
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
+const int num_f16 = ARRAY_SIZE(f16_numbers);
+
+uint16_t get_f16(int i) {
+    return f16_numbers[i % num_f16];
+}
+
+/* only display as hex */
+char *fmt_16(uint16_t num) {
+    char *fmt;
+    asprintf(&fmt, "f16 %#04x", num);
+    return fmt;
+}
+
+/*
+ * Single Precision Numbers
+ */
+
+#ifndef SNANF
+/* Signaling NaN macros, if supported.  */
+# if __GNUC_PREREQ(3, 3)
+#  define SNANF (__builtin_nansf (""))
+#  define SNAN (__builtin_nans (""))
+#  define SNANL (__builtin_nansl (""))
+# endif
+#endif
+
+static float f32_numbers[] = {
+    -SNANF,
+    -NAN,
+    -INFINITY,
+    -FLT_MAX,
+    -1.111E+31,
+    -1.111E+30,
+    -1.08700982e-12,
+    -1.78051176e-20,
+    -FLT_MIN,
+    0.0,
+    FLT_MIN,
+    2.98023224e-08,
+    5.96046E-8, /* min positive FP16 subnormal */
+    6.09756E-5, /* max subnormal FP16 */
+    6.10352E-5, /* min positive normal FP16 */
+    1.0,
+    1.0009765625, /* smallest float after 1.0 FP16 */
+    2.0,
+    M_E, M_PI,
+    65503.0,
+    65504.0, /* max FP16 */
+    65505.0,
+    131007.0,
+    131008.0, /* max AFP */
+    131009.0,
+    1.111E+30,
+    FLT_MAX,
+    INFINITY,
+    NAN,
+    SNANF
+};
+
+const int num_f32 = ARRAY_SIZE(f32_numbers);
+
+float get_f32(int i) {
+    return f32_numbers[i % num_f32];
+}
+
+char *fmt_f32(float num) {
+    uint32_t single_as_hex = *(uint32_t *) &num;
+    char *fmt;
+    asprintf(&fmt, "f32 %02.20e / %#010x", num, single_as_hex);
+    return fmt;
+}
+
+
+/* This allows us to initialise some doubles as pure hex */
+typedef union {
+    double d;
+    uint64_t h;
+} test_doubles;
+
+static test_doubles f64_numbers[] = {
+    {SNAN},
+    {-NAN},
+    {-INFINITY},
+    {-DBL_MAX},
+    {-FLT_MAX-1.0},
+    {-FLT_MAX},
+    {-1.111E+31},
+    {-1.111E+30}, /* half prec */
+    {-2.0}, {-1.0},
+    {-DBL_MIN},
+    {-FLT_MIN},
+    {0.0},
+    {FLT_MIN},
+    {2.98023224e-08},
+    {5.96046E-8}, /* min positive FP16 subnormal */
+    {6.09756E-5}, /* max subnormal FP16 */
+    {6.10352E-5}, /* min positive normal FP16 */
+    {1.0},
+    {1.0009765625}, /* smallest float after 1.0 FP16 */
+    {DBL_MIN},
+    {1.3789972848607228e-308},
+    {1.4914738736681624e-308},
+    {1.0}, {2.0},
+    {M_E}, {M_PI},
+    {65503.0},
+    {65504.0}, /* max FP16 */
+    {65505.0},
+    {131007.0},
+    {131008.0}, /* max AFP */
+    {131009.0},
+    {.h = 0x41dfffffffc00000 }, /* to int = 0x7fffffff */
+    {FLT_MAX},
+    {FLT_MAX + 1.0},
+    {DBL_MAX},
+    {INFINITY},
+    {NAN},
+    {.h = 0x7ff0000000000001}, /* SNAN */
+    {SNAN},
+};
+
+const int num_f64 = ARRAY_SIZE(f64_numbers);
+
+double get_f64(int i) {
+    return f64_numbers[i % num_f64].d;
+}
+
+char *fmt_f64(double num) {
+    uint64_t double_as_hex = *(uint64_t *) &num;
+    char *fmt;
+    asprintf(&fmt, "f64 %02.20e / %#020" PRIx64, num, double_as_hex);
+    return fmt;
+}
+
+/*
+ * Float flags
+ */
+char *fmt_flags(void)
+{
+    int flags = fetestexcept(FE_ALL_EXCEPT);
+    char *fmt;
+
+    if (flags) {
+        asprintf(&fmt, "%s%s%s%s%s",
+                 flags & FE_OVERFLOW ? "OVERFLOW " : "",
+                 flags & FE_UNDERFLOW ? "UNDERFLOW " : "",
+                 flags & FE_DIVBYZERO ? "DIV0 " : "",
+                 flags & FE_INEXACT ? "INEXACT " : "",
+                 flags & FE_INVALID ? "INVALID" : "");
+    } else {
+        asprintf(&fmt, "OK");
+    }
+
+    return fmt;
+}
diff --git a/tests/tcg/multiarch/float_helpers.h b/tests/tcg/multiarch/float_helpers.h
new file mode 100644
index 00000000000..4a1e2f3853a
--- /dev/null
+++ b/tests/tcg/multiarch/float_helpers.h
@@ -0,0 +1,26 @@
+/*
+ * Common Float Helpers
+ *
+ * Copyright (c) 2019 Linaro
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+#include <inttypes.h>
+
+/* Number of constants in each table */
+extern const int num_f16;
+extern const int num_f32;
+extern const int num_f64;
+
+/* Accessor helpers */
+uint16_t get_f16(int i); /* use _Float16 when we can */
+float    get_f32(int i);
+double   get_f64(int i);
+
+/* Return format strings, free after use */
+char * fmt_f16(uint16_t);
+char * fmt_f32(float);
+char * fmt_f64(double);
+/* exception flags */
+char * fmt_flags(void);
diff --git a/tests/tcg/multiarch/float_madds.c b/tests/tcg/multiarch/float_madds.c
new file mode 100644
index 00000000000..bc11eea9084
--- /dev/null
+++ b/tests/tcg/multiarch/float_madds.c
@@ -0,0 +1,78 @@
+/*
+ * Fused Multiply Add (Single)
+ *
+ * Copyright (c) 2019 Linaro
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <math.h>
+#include <float.h>
+#include <fenv.h>
+
+#include "float_helpers.h"
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
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
+void print_result(float a, float b, float c, float r)
+{
+    char *a_fmt, *b_fmt, *c_fmt, *r_fmt, *flag_fmt;
+
+    a_fmt = fmt_f32(a);
+    b_fmt = fmt_f32(b);
+    c_fmt = fmt_f32(c);
+    r_fmt = fmt_f32(r);
+    flag_fmt = fmt_flags();
+
+    printf("%s * %s + %s = %s  (%s)\n",
+           a_fmt, b_fmt, c_fmt, r_fmt, flag_fmt);
+
+    free(a_fmt);
+    free(b_fmt);
+    free(c_fmt);
+    free(r_fmt);
+    free(flag_fmt);
+}
+
+
+int main(int argc, char *argv[argc])
+{
+    int i, j, k, l;
+    float a, b, c, r;
+
+    for (i = 0; i < ARRAY_SIZE(round_flags); ++i) {
+        fesetround(round_flags[i].flag);
+        printf("### Rounding %s\n", round_flags[i].desc);
+        for (j = 0; j < num_f32; j += 3) {
+            for (k = 1; k < num_f32; k += 3 ) {
+                for (l = 2; l < num_f32; l += 3) {
+                    a = get_f32(j);
+                    b = get_f32(k);
+                    c = get_f32(l);
+                    feclearexcept(FE_ALL_EXCEPT);
+
+                    /* must be built with -O2 to generate fused op */
+                    r = a * b + c;
+
+                    print_result(a, b, c, r);
+                }
+            }
+        }
+    }
+
+    return 0;
+}
-- 
2.20.1


