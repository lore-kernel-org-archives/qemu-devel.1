Received: from eggs.gnu.org ([2001:4830:134:3::10]:53268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f64RU-0007dO-47
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f64RQ-0005F8-PK
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:20:56 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f64RQ-0005DA-Bi
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:20:52 -0400
Received: by mail-wm0-x229.google.com with SMTP id r131so742266wmb.2
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 18:20:52 -0700 (PDT)
References: <1522883475-27858-1-git-send-email-cota@braap.org>
	<1522883475-27858-2-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1522883475-27858-2-git-send-email-cota@braap.org>
Date: Wed, 11 Apr 2018 02:20:49 +0100
Message-ID: <874lki5yj2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/15] tests: add fp-test,
 a floating point test suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Emilio G. Cota <cota@braap.org> writes:

> This will allow us to run correctness tests against our
> FP implementation. The test can be run in two modes (called
> "testers"): host and soft. With the former we check the results
> and FP flags on the host machine against the model.
> With the latter we check QEMU's fpu primitives against the
> model. Note that in soft mode we are not instantiating any
> particular CPU (hence the HW_POISON_H hack to avoid macro poisoning);
> for that we need to run the test in host mode under QEMU.
<snip>

So with the attached patch and my proposed cross build we can now get:

02:15:54 [alex@zen:~/l/q/qemu.git] softfloat-fixes-for-2.12-v1 =C2=B1 find =
. -iname "fp-test" | xargs file
./ppc64-linux-user/tests/fp-test:      ELF 64-bit LSB executable, 64-bit Po=
werPC or cisco 7500, version 1 (GNU/Linux), statically linked, for GNU/Linu=
x 3.2.0, not stripped
./armeb-linux-user/tests/fp-test:      ELF 32-bit LSB executable, ARM, EABI=
5 version 1 (GNU/Linux), statically linked, for GNU/Linux 3.2.0, not stripp=
ed
./aarch64-linux-user/tests/fp-test:    ELF 64-bit LSB executable, ARM aarch=
64, version 1 (SYSV), statically linked, for GNU/Linux 3.7.0, not stripped
./i386-linux-user/tests/fp-test:       ELF 32-bit LSB executable, Intel 803=
86, version 1 (GNU/Linux), statically linked, for GNU/Linux 2.6.32, not str=
ipped
./arm-linux-user/tests/fp-test:        ELF 32-bit LSB executable, ARM, EABI=
5 version 1 (GNU/Linux), statically linked, for GNU/Linux 3.2.0, not stripp=
ed
./s390x-linux-user/tests/fp-test:      ELF 64-bit MSB executable, IBM S/390=
, version 1 (SYSV), statically linked, for GNU/Linux 3.2.0, not stripped
./aarch64_be-linux-user/tests/fp-test: ELF 64-bit LSB executable, ARM aarch=
64, version 1 (SYSV), statically linked, for GNU/Linux 3.7.0, not stripped
./tests/fp-test/fp-test:               ELF 64-bit LSB shared object, x86-64=
, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.=
so.2, for GNU/Linux 2.6.32, not stripped

But it did mean having to hack about a little, mainly to get rid of
glib.

--8<---------------cut here---------------start------------->8---
>From 04ed0d9f58f34aa51b9a8284514aab6e36a702b4 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>
Date: Wed, 11 Apr 2018 01:35:52 +0100
Subject: [PATCH] tests/tcg: add fp-test to per-guest tests
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The fp-test code was originally designed to be able to include
softfloat. However cross-compiling QEMU based code is harder than it
needs to be so hide softfloat stuff behind USE_SOFTFLOAT. We also need
to tweak:

  - manually include what we need
  - g_assert -> assert()
  - use libc hsearch instead of g_hash_table

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 tests/fp/fp-test.c | 148 ++++++++++++++++++++++++++++++++++++++++++-------=
----
 tests/tcg/Makefile |   3 ++
 2 files changed, 121 insertions(+), 30 deletions(-)

diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 27637c4617..4cee2a918c 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -6,12 +6,72 @@
  * License: GNU GPL, version 2 or later.
  *   See the COPYING file in the top-level directory.
  */
-#ifndef HW_POISON_H
-#error Must define HW_POISON_H to work around TARGET_* poisoning
-#endif
+
+/* If HW_POISON_H isn't defined then we aren't building against qemu's
+ * softfloat */
+#ifdef HW_POISON_H

 #include "qemu/osdep.h"
 #include "fpu/softfloat.h"
+#define USE_SOFTFLOAT 1
+
+#else /* else define what QEMU would have given us */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <string.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <assert.h>
+#include <errno.h>
+
+#include <search.h>
+
+/* See include/fpu/softfloat-types.h */
+enum {
+    float_tininess_after_rounding  =3D 0,
+    float_tininess_before_rounding =3D 1
+};
+
+enum {
+    float_round_nearest_even =3D 0,
+    float_round_down         =3D 1,
+    float_round_up           =3D 2,
+    float_round_to_zero      =3D 3,
+    float_round_ties_away    =3D 4,
+    float_round_to_odd       =3D 5,
+};
+
+enum {
+    float_flag_invalid   =3D  1,
+    float_flag_divbyzero =3D  4,
+    float_flag_overflow  =3D  8,
+    float_flag_underflow =3D 16,
+    float_flag_inexact   =3D 32,
+    float_flag_input_denormal =3D 64,
+    float_flag_output_denormal =3D 128
+};
+
+/* See include/compiler.h */
+#ifndef likely
+#if __GNUC__ < 3
+#define __builtin_expect(x, n) (x)
+#endif
+
+#define likely(x)   __builtin_expect(!!(x), 1)
+#define unlikely(x)   __builtin_expect(!!(x), 0)
+#endif
+
+#endif
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif

 #include <fenv.h>
 #include <math.h>
@@ -116,16 +176,18 @@ struct tester {
 struct whitelist {
     char **lines;
     size_t n;
-    GHashTable *ht;
+    struct hsearch_data ht;
 };

 static uint64_t test_stats[ERROR_MAX];
 static struct whitelist whitelist;
 static uint8_t default_exceptions;
 static bool die_on_error =3D true;
+#ifdef USE_SOFTFLOAT
 static struct float_status soft_status =3D {
     .float_detect_tininess =3D float_tininess_before_rounding,
 };
+#endif

 static inline float u64_to_float(uint64_t v)
 {
@@ -285,7 +347,7 @@ static enum error host_tester(struct test_op *t)
         float res;
         int i;

-        g_assert(ops[t->op].n_operands <=3D ARRAY_SIZE(in));
+        assert(ops[t->op].n_operands <=3D ARRAY_SIZE(in));
         for (i =3D 0; i < ops[t->op].n_operands; i++) {
             /* use the host's QNaN/SNaN patterns */
             if (t->operands[i].type =3D=3D OP_TYPE_QNAN) {
@@ -343,7 +405,7 @@ static enum error host_tester(struct test_op *t)
         double res;
         int i;

-        g_assert(ops[t->op].n_operands <=3D ARRAY_SIZE(in));
+        assert(ops[t->op].n_operands <=3D ARRAY_SIZE(in));
         for (i =3D 0; i < ops[t->op].n_operands; i++) {
             /* use the host's QNaN/SNaN patterns */
             if (t->operands[i].type =3D=3D OP_TYPE_QNAN) {
@@ -429,6 +491,8 @@ static enum error host_tester(struct test_op *t)
     return tester_check(t, res64, result_is_nan, flags);
 }

+#ifdef USE_SOFTFLOAT
+
 static enum error soft_tester(struct test_op *t)
 {
     float_status *s =3D &soft_status;
@@ -445,7 +509,7 @@ static enum error soft_tester(struct test_op *t)
         float32 res;
         int i;

-        g_assert(ops[t->op].n_operands <=3D ARRAY_SIZE(in));
+        assert(ops[t->op].n_operands <=3D ARRAY_SIZE(in));
         for (i =3D 0; i < ops[t->op].n_operands; i++) {
             *in[i] =3D t->operands[i].val;
         }
@@ -504,7 +568,7 @@ static enum error soft_tester(struct test_op *t)
         float64 *in[] =3D { &a, &b, &c };
         int i;

-        g_assert(ops[t->op].n_operands <=3D ARRAY_SIZE(in));
+        assert(ops[t->op].n_operands <=3D ARRAY_SIZE(in));
         for (i =3D 0; i < ops[t->op].n_operands; i++) {
             *in[i] =3D t->operands[i].val;
         }
@@ -585,6 +649,14 @@ static const struct tester valid_testers[] =3D {
         .func =3D host_tester,
     },
 };
+#else
+static const struct tester valid_testers[] =3D {
+    [0] =3D {
+        .name =3D "host",
+        .func =3D host_tester,
+    },
+};
+#endif
 static const struct tester *tester =3D &valid_testers[0];

 static int ibm_get_exceptions(const char *p, uint8_t *excp)
@@ -622,7 +694,7 @@ static uint64_t fp_choose(enum precision prec, uint64_t=
 f, uint64_t d)
     case PREC_DOUBLE:
         return d;
     default:
-        g_assert_not_reached();
+        assert(false);
     }
 }

@@ -756,7 +828,7 @@ ibm_fp_hex(const char *p, enum precision prec, struct o=
perand *ret)
         } else if (prec =3D=3D PREC_DOUBLE) {
             ret->val =3D double_to_u64(0.0);
         } else {
-            g_assert_not_reached();
+            assert(false);
         }
         return 0;
     } else if (!strcmp(p, "0x1")) {
@@ -765,7 +837,7 @@ ibm_fp_hex(const char *p, enum precision prec, struct o=
perand *ret)
         } else if (prec =3D=3D PREC_DOUBLE) {
             ret->val =3D double_to_u64(1.0);
         } else {
-            g_assert_not_reached();
+            assert(false);
         }
         return 0;
     }
@@ -915,10 +987,13 @@ static const struct input *input_type =3D &valid_inpu=
t_types[INPUT_FMT_IBM];

 static bool line_is_whitelisted(const char *line)
 {
-    if (whitelist.ht =3D=3D NULL) {
+    ENTRY e, *ep;
+
+    if (whitelist.ht.size =3D=3D 0) {
         return false;
     }
-    return !!g_hash_table_lookup(whitelist.ht, line);
+    e.key =3D line;
+    return hsearch_r(e, FIND, &ep, &whitelist.ht)=3D=3D0;
 }

 static void test_file(const char *filename)
@@ -958,7 +1033,7 @@ static void test_file(const char *filename)
                         filename, i);
                 break;
             default:
-                g_assert_not_reached();
+                assert(false);
             }
             fprintf(stderr, "%s", line);
             if (die_on_error) {
@@ -1007,23 +1082,32 @@ static void set_tester(const char *optarg)

 static void whitelist_add_line(const char *orig_line)
 {
-    char *line;
+    char *line =3D strdup(orig_line);
     bool inserted;
+    ENTRY e, *ep;
+    int r;

-    if (whitelist.ht =3D=3D NULL) {
-        whitelist.ht =3D g_hash_table_new(g_str_hash, g_str_equal);
+    if (whitelist.ht.size =3D=3D 0) {
+        if (!hcreate_r(4096, &whitelist.ht)) {
+            fprintf(stderr, "%s: error creating hash table\n", __func__);
+        }
     }
-    line =3D g_hash_table_lookup(whitelist.ht, orig_line);
-    if (unlikely(line !=3D NULL)) {
+
+    int hsearch_r(ENTRY item, ACTION action, ENTRY **retval,
+              struct hsearch_data *htab);
+
+    e.key =3D line;
+    r =3D hsearch_r(e, FIND, &ep, &whitelist.ht);
+    if (unlikely(r)) {
+        free(line);
         return;
     }
     whitelist.n++;
-    whitelist.lines =3D g_realloc_n(whitelist.lines, whitelist.n, sizeof(l=
ine));
-    line =3D strdup(orig_line);
+    whitelist.lines =3D realloc(whitelist.lines, (whitelist.n * sizeof(lin=
e)));
     whitelist.lines[whitelist.n - 1] =3D line;
-    /* if we pass key =3D=3D val GLib will not reserve space for the value=
 */
-    inserted =3D g_hash_table_insert(whitelist.ht, line, line);
-    g_assert(inserted);
+    e.data =3D line;
+    inserted =3D hsearch_r(e, ENTER, &ep, &whitelist.ht);
+    assert(inserted);
 }

 static void set_whitelist(const char *filename)
@@ -1061,18 +1145,20 @@ static void usage_complete(int argc, char *argv[])
 {
     fprintf(stderr, "Usage: %s [options] file1 [file2 ...]\n", argv[0]);
     fprintf(stderr, "options:\n");
-    fprintf(stderr, "  -a =3D Perform tininess detection after rounding "
-            "(soft tester only). Default: before\n");
     fprintf(stderr, "  -n =3D do not die on error. Default: dies on error\=
n");
     fprintf(stderr, "  -e =3D default exception flags (xiozu). Default: no=
ne\n");
     fprintf(stderr, "  -f =3D format of the input file(s). Default: %s\n",
             valid_input_types[0].name);
     fprintf(stderr, "  -t =3D tester. Default: %s\n", valid_testers[0].nam=
e);
     fprintf(stderr, "  -w =3D path to file with test cases to be whitelist=
ed\n");
+#ifdef USE_SOFTFLOAT
+    fprintf(stderr, "  -a =3D Perform tininess detection after rounding "
+            "(soft tester only). Default: before\n");
     fprintf(stderr, "  -z =3D flush inputs to zero (soft tester only). "
             "Default: disabled\n");
     fprintf(stderr, "  -Z =3D flush output to zero (soft tester only). "
             "Default: disabled\n");
+#endif
 }

 static void parse_opts(int argc, char *argv[])
@@ -1085,9 +1171,6 @@ static void parse_opts(int argc, char *argv[])
             return;
         }
         switch (c) {
-        case 'a':
-            soft_status.float_detect_tininess =3D float_tininess_after_rou=
nding;
-            break;
         case 'e':
             set_default_exceptions(optarg);
             break;
@@ -1106,15 +1189,20 @@ static void parse_opts(int argc, char *argv[])
         case 'w':
             set_whitelist(optarg);
             break;
+#ifdef USE_SOFTFLOAT
+        case 'a':
+            soft_status.float_detect_tininess =3D float_tininess_after_rou=
nding;
+            break;
         case 'z':
             soft_status.flush_inputs_to_zero =3D 1;
             break;
         case 'Z':
             soft_status.flush_to_zero =3D 1;
             break;
+#endif
         }
     }
-    g_assert_not_reached();
+    assert(false);
 }

 static uint64_t count_errors(void)
diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 2bba0d2a32..9c8011063e 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -24,6 +24,9 @@
 VPATH =3D $(SRC_PATH)/tests/tcg/multiarch
 TEST_SRCS =3D $(wildcard $(SRC_PATH)/tests/tcg/multiarch/*.c)

+VPATH     +=3D $(SRC_PATH)/tests/fp
+TEST_SRCS +=3D $(wildcard $(SRC_PATH)/tests/fp/*.c)
+
 VPATH     +=3D $(SRC_PATH)/tests/tcg/$(ARCH)
 TEST_SRCS +=3D $(wildcard $(SRC_PATH)/tests/tcg/$(ARCH)/*.c)

--
2.16.2
--8<---------------cut here---------------end--------------->8---




--
Alex Benn=C3=A9e
