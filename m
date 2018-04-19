Received: from eggs.gnu.org ([2001:4830:134:3::10]:52860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ANb-0004qA-P3
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ANV-0006AR-RJ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:43 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:39272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9ANV-00069c-Gf
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:37 -0400
Received: by mail-wr0-x242.google.com with SMTP id q3-v6so4491709wrj.6
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 07:17:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:59:01 +0100
Message-Id: <20180419135901.30035-44-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 43/43] tests: fp-test add fcvt support
 (!INCOMPLETE WIP)
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

This adds support for the various FOO-to-BAR conversions to fp-test.
It also defines PREC_HALF although currently that is not used and will
need compile time detection for _Float16 support.

I've added a small test file for testing against regressions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/fp/fp-test.c                    | 535 +++++++++++++++++++++++---
 tests/fp/qemu/regression-tests.fptest |   7 +
 2 files changed, 479 insertions(+), 63 deletions(-)
 create mode 100644 tests/fp/qemu/regression-tests.fptest

diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 27db552160..320da2398a 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -38,15 +38,167 @@ struct input {
 };
 
 enum precision {
+    PREC_HALF,
     PREC_FLOAT,
     PREC_DOUBLE,
     PREC_QUAD,
+    /* Integers */
+    PREC_INT16,
+    PREC_INT32,
+    PREC_INT64,
+    PREC_UINT16,
+    PREC_UINT32,
+    PREC_UINT64,
+    /* Float to Float conversions */
+    PREC_HALF_TO_FLOAT,
+    PREC_HALF_TO_DOUBLE,
+    PREC_FLOAT_TO_HALF,
     PREC_FLOAT_TO_DOUBLE,
+    PREC_DOUBLE_TO_HALF,
+    PREC_DOUBLE_TO_FLOAT,
+    /* Float to Int conversions */
+    PREC_HALF_TO_INT16,
+    PREC_HALF_TO_INT32,
+    PREC_HALF_TO_INT64,
+    PREC_FLOAT_TO_INT16,
+    PREC_FLOAT_TO_INT32,
+    PREC_FLOAT_TO_INT64,
+    PREC_DOUBLE_TO_INT16,
+    PREC_DOUBLE_TO_INT32,
+    PREC_DOUBLE_TO_INT64,
+    /* Float to unsigned int conversions */
+    PREC_HALF_TO_UINT16,
+    PREC_HALF_TO_UINT32,
+    PREC_HALF_TO_UINT64,
+    PREC_FLOAT_TO_UINT16,
+    PREC_FLOAT_TO_UINT32,
+    PREC_FLOAT_TO_UINT64,
+    PREC_DOUBLE_TO_UINT16,
+    PREC_DOUBLE_TO_UINT32,
+    PREC_DOUBLE_TO_UINT64,
+    /* Int to float conversions */
+    PREC_INT16_TO_HALF,
+    PREC_INT16_TO_FLOAT,
+    PREC_INT16_TO_DOUBLE,
+    PREC_INT32_TO_HALF,
+    PREC_INT32_TO_FLOAT,
+    PREC_INT32_TO_DOUBLE,
+    PREC_INT64_TO_HALF,
+    PREC_INT64_TO_FLOAT,
+    PREC_INT64_TO_DOUBLE,
+    /* Unsigned int to float conversions */
+    PREC_UINT16_TO_HALF,
+    PREC_UINT16_TO_FLOAT,
+    PREC_UINT16_TO_DOUBLE,
+    PREC_UINT32_TO_HALF,
+    PREC_UINT32_TO_FLOAT,
+    PREC_UINT32_TO_DOUBLE,
+    PREC_UINT64_TO_HALF,
+    PREC_UINT64_TO_FLOAT,
+    PREC_UINT64_TO_DOUBLE,
 };
 
+static enum precision get_input_prec(enum precision prec)
+{
+    /* Map conversions to input precision */
+    if (prec >= PREC_HALF_TO_FLOAT) {
+        switch (prec) {
+        case PREC_HALF_TO_FLOAT:
+        case PREC_HALF_TO_DOUBLE:
+        case PREC_HALF_TO_INT16:
+        case PREC_HALF_TO_INT32:
+        case PREC_HALF_TO_INT64:
+        case PREC_HALF_TO_UINT16:
+        case PREC_HALF_TO_UINT32:
+        case PREC_HALF_TO_UINT64:
+            return PREC_HALF;
+        case PREC_FLOAT_TO_HALF:
+        case PREC_FLOAT_TO_DOUBLE:
+        case PREC_FLOAT_TO_INT16:
+        case PREC_FLOAT_TO_INT32:
+        case PREC_FLOAT_TO_INT64:
+        case PREC_FLOAT_TO_UINT16:
+        case PREC_FLOAT_TO_UINT32:
+        case PREC_FLOAT_TO_UINT64:
+            return PREC_FLOAT;
+        case PREC_DOUBLE_TO_HALF:
+        case PREC_DOUBLE_TO_FLOAT:
+        case PREC_DOUBLE_TO_INT16:
+        case PREC_DOUBLE_TO_INT32:
+        case PREC_DOUBLE_TO_INT64:
+        case PREC_DOUBLE_TO_UINT16:
+        case PREC_DOUBLE_TO_UINT32:
+        case PREC_DOUBLE_TO_UINT64:
+            return PREC_DOUBLE;
+        default:
+            assert(false);
+        }
+    }
+
+    return prec;
+}
+
+static enum precision get_output_prec(enum precision prec)
+{
+    /* Map conversions to input precision */
+    if (prec >= PREC_HALF_TO_FLOAT) {
+        switch (prec) {
+        case PREC_FLOAT_TO_HALF:
+        case PREC_DOUBLE_TO_HALF:
+        case PREC_INT16_TO_HALF:
+        case PREC_INT32_TO_HALF:
+        case PREC_INT64_TO_HALF:
+        case PREC_UINT16_TO_HALF:
+        case PREC_UINT32_TO_HALF:
+        case PREC_UINT64_TO_HALF:
+            return PREC_HALF;
+        case PREC_HALF_TO_FLOAT:
+        case PREC_DOUBLE_TO_FLOAT:
+            return PREC_FLOAT;
+        case PREC_HALF_TO_DOUBLE:
+        case PREC_FLOAT_TO_DOUBLE:
+            return PREC_DOUBLE;
+        case PREC_HALF_TO_INT16:
+        case PREC_FLOAT_TO_INT16:
+        case PREC_DOUBLE_TO_INT16:
+            return PREC_INT16;
+        case PREC_HALF_TO_INT32:
+        case PREC_FLOAT_TO_INT32:
+        case PREC_DOUBLE_TO_INT32:
+            return PREC_INT32;
+        case PREC_HALF_TO_INT64:
+        case PREC_FLOAT_TO_INT64:
+        case PREC_DOUBLE_TO_INT64:
+            return PREC_INT64;
+        case PREC_HALF_TO_UINT16:
+        case PREC_FLOAT_TO_UINT16:
+        case PREC_DOUBLE_TO_UINT16:
+            return PREC_UINT16;
+        case PREC_HALF_TO_UINT32:
+        case PREC_FLOAT_TO_UINT32:
+        case PREC_DOUBLE_TO_UINT32:
+            return PREC_UINT32;
+        case PREC_HALF_TO_UINT64:
+        case PREC_FLOAT_TO_UINT64:
+        case PREC_DOUBLE_TO_UINT64:
+            return PREC_UINT64;
+        default:
+            assert(false);
+        }
+    }
+
+    return prec;
+}
+
+typedef struct {
+    char *opstr;
+    enum precision prec;
+} map_to_prec;
+
 struct op_desc {
     const char * const name;
     int n_operands;
+    map_to_prec *decode_tbl;
 };
 
 enum op {
@@ -62,9 +214,46 @@ enum op {
     OP_ABS,
     OP_IS_NAN,
     OP_IS_INF,
-    OP_FLOAT_TO_DOUBLE,
+    /* All above are conversions */
+    OP_FLOAT_TO_FLOAT,
+    OP_FLOAT_TO_INT,
+    OP_FLOAT_TO_UINT,
+    OP_INT_TO_FLOAT,
+    OP_UINT_TO_FLOAT
 };
 
+map_to_prec float_to_float[] = { {"b16b32", PREC_HALF_TO_FLOAT},
+                                 {"b16b64", PREC_HALF_TO_DOUBLE},
+                                 {"b32b16", PREC_FLOAT_TO_HALF},
+                                 {"b32b64", PREC_FLOAT_TO_DOUBLE},
+                                 {"b64b16", PREC_DOUBLE_TO_HALF},
+                                 {"b64b32", PREC_DOUBLE_TO_FLOAT},
+                                 { NULL, 0} };
+
+map_to_prec float_to_int[] = { {"b16b16", PREC_HALF_TO_INT16},
+                               {"b16b32", PREC_HALF_TO_INT16},
+                               {"b16b64", PREC_HALF_TO_INT16},
+                               {"b32b16", PREC_FLOAT_TO_INT16},
+                               {"b32b32", PREC_FLOAT_TO_INT32},
+                               {"b32b64", PREC_FLOAT_TO_INT64},
+                               {"b64b16", PREC_DOUBLE_TO_INT16},
+                               {"b64b32", PREC_DOUBLE_TO_INT32},
+                               {"b64b64", PREC_DOUBLE_TO_INT64},
+                               { NULL, 0} };
+
+static enum precision decode_map_table(map_to_prec *tbl, char *opstr)
+{
+    while (tbl->opstr) {
+        if (strncmp(tbl->opstr, opstr, strlen(tbl->opstr)) == 0) {
+            return tbl->prec;
+        }
+        tbl++;
+    }
+
+    /* lookup failed */
+    assert(false);
+}
+
 static const struct op_desc ops[] = {
     [OP_ADD] =       { "+", 2 },
     [OP_SUB] =       { "-", 2 },
@@ -78,7 +267,11 @@ static const struct op_desc ops[] = {
     [OP_ABS] =       { "A", 1 },
     [OP_IS_NAN] =    { "?N", 1 },
     [OP_IS_INF] =    { "?i", 1 },
-    [OP_FLOAT_TO_DOUBLE] = { "cff", 1 },
+    [OP_FLOAT_TO_FLOAT] = { "cff", 1, float_to_float },
+    [OP_FLOAT_TO_INT] = { "cfi", 1, float_to_int },
+    [OP_FLOAT_TO_UINT] = { "cfu", 1 },
+    [OP_INT_TO_FLOAT] = { "cif", 1 },
+    [OP_UINT_TO_FLOAT] = { "cuf", 1 },
 };
 
 /*
@@ -269,6 +462,159 @@ static enum error tester_check(const struct test_op *t, uint64_t res64,
     return err;
 }
 
+static float get_float(struct operand op)
+{
+    switch (op.type) {
+    case OP_TYPE_QNAN:
+        return __builtin_nanf("");
+    case OP_TYPE_SNAN:
+        return __builtin_nansf("");
+    default:
+        return u64_to_float(op.val);
+    }
+}
+
+static double get_double(struct operand op)
+{
+    switch (op.type) {
+    case OP_TYPE_QNAN:
+        return __builtin_nanf("");
+    case OP_TYPE_SNAN:
+        return __builtin_nansf("");
+    default:
+        return u64_to_double(op.val);
+    }
+}
+
+static enum error host_tester_cff(struct test_op *t)
+{
+    float in32, res32;
+    double in64, res64;
+    bool result_is_nan;
+    uint8_t flags = 0;
+
+    assert(t->op == OP_FLOAT_TO_FLOAT);
+
+    switch (t->prec) {
+    case PREC_HALF_TO_FLOAT:
+    case PREC_HALF_TO_DOUBLE:
+        return ERROR_NOT_HANDLED;
+    case PREC_FLOAT_TO_HALF:
+        return ERROR_NOT_HANDLED;
+    case PREC_FLOAT_TO_DOUBLE:
+    {
+        in32 = get_float(t->operands[0]);
+        t->expected_result.val = double_to_u64(get_double(t->expected_result));
+        res64 = (double) in32;
+        break;
+    }
+    case PREC_DOUBLE_TO_HALF:
+        return ERROR_NOT_HANDLED;
+    case PREC_DOUBLE_TO_FLOAT:
+        in64 = get_double(t->operands[0]);
+        t->expected_result.val = float_to_u64(get_float(t->expected_result));
+        res32 = (float) in64;
+        break;
+    default:
+        return ERROR_NOT_HANDLED;
+    }
+
+    flags = host_get_exceptions();
+
+    switch (t->prec) {
+    case PREC_HALF_TO_DOUBLE:
+    case PREC_FLOAT_TO_DOUBLE:
+        result_is_nan = isnan(res64);
+        return tester_check(t, res64, result_is_nan, flags);
+    case PREC_HALF_TO_FLOAT:
+    case PREC_DOUBLE_TO_FLOAT:
+        result_is_nan = isnan(res32);
+        return tester_check(t, res32, result_is_nan, flags);
+    default:
+        assert(false);
+    }
+
+    return ERROR_NOT_HANDLED;
+}
+
+static enum error host_tester_cfi(struct test_op *t)
+{
+    uint8_t flags = 0;
+    float in32;
+    double in64;
+    uint64_t res;
+
+    assert(t->op == OP_FLOAT_TO_INT || t->op == OP_FLOAT_TO_UINT);
+
+    switch (get_input_prec(t->prec)) {
+    case PREC_HALF:
+        return ERROR_NOT_HANDLED;
+    case PREC_FLOAT:
+        in32 = get_float(t->operands[0]);
+        break;
+    case PREC_DOUBLE:
+        in64 = get_double(t->operands[0]);
+        break;
+    default:
+        assert(false);
+    }
+
+
+    switch (t->prec) {
+    case PREC_HALF_TO_INT16:
+    case PREC_HALF_TO_INT32:
+    case PREC_HALF_TO_INT64:
+        return ERROR_NOT_HANDLED;
+    case PREC_FLOAT_TO_INT16:
+    {
+        int16_t oi16 = (int16_t) in32;
+        res = (uint64_t) oi16;
+        break;
+    }
+    case PREC_FLOAT_TO_INT32:
+    {
+        int32_t oi32 = (int32_t) in32;
+        res = (uint64_t) oi32;
+        break;
+    }
+    case PREC_FLOAT_TO_INT64:
+    {
+        int64_t oi64 = (int64_t) in32;
+        res = (uint64_t) oi64;
+        break;
+    }
+    case PREC_DOUBLE_TO_INT16:
+    {
+        int16_t oi16 = (int16_t) in64;
+        res = (uint64_t) oi16;
+        break;
+    }
+    case PREC_DOUBLE_TO_INT32:
+    {
+        int32_t oi32 = (int32_t) in64;
+        res = (uint64_t) oi32;
+        break;
+    }
+    case PREC_DOUBLE_TO_INT64:
+    {
+        int64_t oi64 = (int64_t) in64;
+        res = (uint64_t) oi64;
+        break;
+    }
+    default:
+        assert(false);
+    }
+
+    flags = host_get_exceptions();
+
+    return tester_check(t, res, false, flags);
+}
+
+static enum error host_tester_cif(struct test_op *t)
+{
+    return ERROR_NOT_HANDLED;
+}
+
 static enum error host_tester(struct test_op *t)
 {
     uint64_t res64;
@@ -280,6 +626,20 @@ static enum error host_tester(struct test_op *t)
         host_set_exceptions(default_exceptions);
     }
 
+    /* Handle conversions first */
+    switch (t->op) {
+    case OP_FLOAT_TO_FLOAT:
+        return host_tester_cff(t);
+    case OP_FLOAT_TO_INT:
+    case OP_FLOAT_TO_UINT:
+        return host_tester_cfi(t);
+    case OP_INT_TO_FLOAT:
+    case OP_UINT_TO_FLOAT:
+        return host_tester_cif(t);
+    default:
+        break;
+    }
+
     if (t->prec == PREC_FLOAT) {
         float a, b, c;
         float *in[] = { &a, &b, &c };
@@ -396,40 +756,68 @@ static enum error host_tester(struct test_op *t)
         flags = host_get_exceptions();
         res64 = double_to_u64(res);
         result_is_nan = isnan(res);
-    } else if (t->prec == PREC_FLOAT_TO_DOUBLE) {
-        float a;
-        double res;
-
-        if (t->operands[0].type == OP_TYPE_QNAN) {
-            a = __builtin_nanf("");
-        } else if (t->operands[0].type == OP_TYPE_SNAN) {
-            a = __builtin_nansf("");
-        } else {
-            a = u64_to_float(t->operands[0].val);
-        }
-
-        if (t->expected_result.type == OP_TYPE_QNAN) {
-            t->expected_result.val = double_to_u64(__builtin_nan(""));
-        } else if (t->expected_result.type == OP_TYPE_SNAN) {
-            t->expected_result.val = double_to_u64(__builtin_nans(""));
-        }
-
-        switch (t->op) {
-        case OP_FLOAT_TO_DOUBLE:
-            res = a;
-            break;
-        default:
-            return ERROR_NOT_HANDLED;
-        }
-        flags = host_get_exceptions();
-        res64 = double_to_u64(res);
-        result_is_nan = isnan(res);
     } else {
         return ERROR_NOT_HANDLED; /* XXX */
     }
     return tester_check(t, res64, result_is_nan, flags);
 }
 
+static enum error soft_tester_cff(struct test_op *t, float_status *s)
+{
+    float in32, res32;
+    double in64, res64;
+    bool result_is_nan;
+
+    assert(t->op == OP_FLOAT_TO_FLOAT);
+
+    switch (t->prec) {
+    case PREC_HALF_TO_FLOAT:
+    case PREC_HALF_TO_DOUBLE:
+        return ERROR_NOT_HANDLED;
+    case PREC_FLOAT_TO_HALF:
+        return ERROR_NOT_HANDLED;
+    case PREC_FLOAT_TO_DOUBLE:
+    {
+        in32 = get_float(t->operands[0]);
+        t->expected_result.val = double_to_u64(get_double(t->expected_result));
+        res64 = float32_to_float64(in32, s);
+        break;
+    }
+    case PREC_DOUBLE_TO_HALF:
+        return ERROR_NOT_HANDLED;
+    case PREC_DOUBLE_TO_FLOAT:
+        in64 = get_double(t->operands[0]);
+        t->expected_result.val = float_to_u64(get_float(t->expected_result));
+        res32 = float64_to_float32(in64, s);
+        break;
+    default:
+        return ERROR_NOT_HANDLED;
+    }
+
+    switch (t->prec) {
+    case PREC_HALF_TO_DOUBLE:
+    case PREC_FLOAT_TO_DOUBLE:
+        result_is_nan = isnan(res64);
+        return tester_check(t, res64, result_is_nan, s->float_exception_flags);
+    case PREC_HALF_TO_FLOAT:
+    case PREC_DOUBLE_TO_FLOAT:
+        result_is_nan = isnan(res32);
+        return tester_check(t, res32, result_is_nan, s->float_exception_flags);
+    default:
+        assert(false);
+    }
+}
+
+static enum error soft_tester_cfi(struct test_op *t, float_status *s)
+{
+    return ERROR_NOT_HANDLED;
+}
+
+static enum error soft_tester_cif(struct test_op *t, float_status *s)
+{
+    return ERROR_NOT_HANDLED;
+}
+
 static enum error soft_tester(struct test_op *t)
 {
     float_status *s = &soft_status;
@@ -440,6 +828,20 @@ static enum error soft_tester(struct test_op *t)
     s->float_rounding_mode = t->round;
     s->float_exception_flags = default_exceptions;
 
+    /* Handle conversions first */
+    switch (t->op) {
+    case OP_FLOAT_TO_FLOAT:
+        return soft_tester_cff(t, s);
+    case OP_FLOAT_TO_INT:
+    case OP_FLOAT_TO_UINT:
+        return soft_tester_cfi(t, s);
+    case OP_INT_TO_FLOAT:
+    case OP_UINT_TO_FLOAT:
+        return soft_tester_cif(t, s);
+    default:
+        break;
+    }
+
     if (t->prec == PREC_FLOAT) {
         float32 a, b, c;
         float32 *in[] = { &a, &b, &c };
@@ -558,17 +960,6 @@ static enum error soft_tester(struct test_op *t)
             return ERROR_NOT_HANDLED;
         }
         result_is_nan = isnan(*(double *)&res64);
-    } else if (t->prec == PREC_FLOAT_TO_DOUBLE) {
-        float32 a = t->operands[0].val;
-
-        switch (t->op) {
-        case OP_FLOAT_TO_DOUBLE:
-            res64 = float32_to_float64(a, s);
-            break;
-        default:
-            return ERROR_NOT_HANDLED;
-        }
-        result_is_nan = isnan(*(double *)&res64);
     } else {
         return ERROR_NOT_HANDLED; /* XXX */
     }
@@ -752,23 +1143,41 @@ ibm_fp_hex(const char *p, enum precision prec, struct operand *ret)
             return 0;
         }
         return 0;
-    } else if (!strcmp(p, "0x0")) {
-        if (prec == PREC_FLOAT) {
-            ret->val = float_to_u64(0.0);
-        } else if (prec == PREC_DOUBLE) {
-            ret->val = double_to_u64(0.0);
-        } else {
-            assert(false);
+    } else if (strncmp("0x", p, 2) == 0) {
+        unsigned long long result;
+        char *end;
+
+        result = strtoull(p, &end, 16);
+        if (result == 0 && end == p) {
+            /* not a number */
+            return 1;
+        } else if (result == ULLONG_MAX && errno) {
+            /* value does not fit in unsigned long long */
+            return 1;
+        } else if (*end) {
+            /* began with a number but has junk left over at the end */
+            return 1;
         }
-        return 0;
-    } else if (!strcmp(p, "0x1")) {
-        if (prec == PREC_FLOAT) {
-            ret->val = float_to_u64(1.0);
-        } else if (prec == PREC_DOUBLE) {
-            ret->val = double_to_u64(1.0);
-        } else {
+
+        switch (prec) {
+        case PREC_FLOAT:
+            ret->val = float_to_u64(result);
+            break;
+        case PREC_DOUBLE:
+            ret->val = double_to_u64(result);
+            break;
+        case PREC_INT16:
+        case PREC_INT32:
+        case PREC_INT64:
+        case PREC_UINT16:
+        case PREC_UINT32:
+        case PREC_UINT64:
+            ret->val = result;
+            break;
+        default:
             assert(false);
         }
+
         return 0;
     }
     return 1;
@@ -814,11 +1223,14 @@ static enum error ibm_test_line(const char *line)
     if (unlikely(strlen(p) < 4)) {
         return ERROR_INPUT;
     }
-    if (strcmp("b32b64cff", p) == 0) {
-        t.prec = PREC_FLOAT_TO_DOUBLE;
+    /* Conversions are of the form bXXbYYcZZ */
+    if (p[0] == 'b' && p[3] == 'b' && p[6] == 'c') {
         if (find_op(&p[6], &t.op)) {
+            fprintf(stderr, "%s: unhandled conversion %s\n", __func__, p);
             return ERROR_NOT_HANDLED;
         }
+        assert(ops[t.op].decode_tbl);
+        t.prec = decode_map_table(ops[t.op].decode_tbl, p);
     } else {
         if (strncmp("b32", p, 3) == 0) {
             t.prec = PREC_FLOAT;
@@ -855,9 +1267,7 @@ static enum error ibm_test_line(const char *line)
     }
 
     for (i = 0; i < ops[t.op].n_operands; i++) {
-        enum precision prec = t.prec == PREC_FLOAT_TO_DOUBLE ?
-            PREC_FLOAT : t.prec;
-
+        enum precision prec = get_input_prec(t.prec);
         p = s[field++];
         if (ibm_fp_hex(p, prec, &t.operands[i])) {
             return ERROR_INPUT;
@@ -873,8 +1283,7 @@ static enum error ibm_test_line(const char *line)
     if (unlikely(strcmp("#", p) == 0)) {
         t.expected_result_is_valid = false;
     } else {
-        enum precision prec = t.prec == PREC_FLOAT_TO_DOUBLE ?
-            PREC_DOUBLE : t.prec;
+        enum precision prec = get_output_prec(t.prec);
 
         if (ibm_fp_hex(p, prec, &t.expected_result)) {
             return ERROR_INPUT;
@@ -943,7 +1352,7 @@ static void test_file(const char *filename)
         enum error err;
 
         i++;
-        if (unlikely(line_is_whitelisted(line))) {
+        if (whitelist.n > 0 && unlikely(line_is_whitelisted(line))) {
             test_stats[ERROR_WHITELISTED]++;
             continue;
         }
diff --git a/tests/fp/qemu/regression-tests.fptest b/tests/fp/qemu/regression-tests.fptest
new file mode 100644
index 0000000000..a105d3aa44
--- /dev/null
+++ b/tests/fp/qemu/regression-tests.fptest
@@ -0,0 +1,7 @@
+QEMU Floating point regression tests
+------------------------------------
+
+b32b32cfi =0 -Inf -> 0xffffffff80000000 i
+b32b32cfi =0 +Inf -> 0xffffffff80000000 i
+b32b64cfi =0 -Inf -> 0x8000000000000000 i
+b32b64cfi =0 +Inf -> 0x8000000000000000 i
-- 
2.17.0
