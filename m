Received: from eggs.gnu.org ([209.51.188.92]:34105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gugss-00038O-EJ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gugsn-00008B-QY
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:02:41 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gugsg-0008Pm-6Z
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:02:32 -0500
Received: by mail-pg1-x541.google.com with SMTP id s198so5082090pgs.2
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 09:02:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Feb 2019 09:02:25 -0800
Message-Id: <20190215170225.15537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2] softfloat: Support float_round_to_odd more
 places
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, alex.bennee@linaro.org

Previously this was only supported for roundAndPackFloat64.

New support in round_canonical, round_to_int, float128_round_to_int,
roundAndPackFloat32, roundAndPackInt32, roundAndPackInt64,
roundAndPackUint64.  This does not include any of the floatx80 routines,
as we do not have users for that rounding mode there.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Convert float128_round_to_int as well.  Add fp-test support.
---
 fpu/softfloat.c    | 64 ++++++++++++++++++++++++++++++++++++++++++----
 tests/fp/fp-test.c | 43 ++++++++++++++++++++++++-------
 2 files changed, 93 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9132d7a0b0..76132d4cd5 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -696,6 +696,7 @@ static FloatParts sf_canonicalize(FloatParts part, const FloatFmt *parm,
 static FloatParts round_canonical(FloatParts p, float_status *s,
                                   const FloatFmt *parm)
 {
+    const uint64_t frac_lsb = parm->frac_lsb;
     const uint64_t frac_lsbm1 = parm->frac_lsbm1;
     const uint64_t round_mask = parm->round_mask;
     const uint64_t roundeven_mask = parm->roundeven_mask;
@@ -731,6 +732,10 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
             inc = p.sign ? round_mask : 0;
             overflow_norm = !p.sign;
             break;
+        case float_round_to_odd:
+            overflow_norm = true;
+            inc = frac & frac_lsb ? 0 : round_mask;
+            break;
         default:
             g_assert_not_reached();
         }
@@ -778,9 +783,14 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
             shift64RightJamming(frac, 1 - exp, &frac);
             if (frac & round_mask) {
                 /* Need to recompute round-to-even.  */
-                if (s->float_rounding_mode == float_round_nearest_even) {
+                switch (s->float_rounding_mode) {
+                case float_round_nearest_even:
                     inc = ((frac & roundeven_mask) != frac_lsbm1
                            ? frac_lsbm1 : 0);
+                    break;
+                case float_round_to_odd:
+                    inc = frac & frac_lsb ? 0 : round_mask;
+                    break;
                 }
                 flags |= float_flag_inexact;
                 frac += inc;
@@ -1988,6 +1998,9 @@ static FloatParts round_to_int(FloatParts a, int rmode,
             case float_round_down:
                 one = a.sign;
                 break;
+            case float_round_to_odd:
+                one = true;
+                break;
             default:
                 g_assert_not_reached();
             }
@@ -2021,6 +2034,9 @@ static FloatParts round_to_int(FloatParts a, int rmode,
             case float_round_down:
                 inc = a.sign ? rnd_mask : 0;
                 break;
+            case float_round_to_odd:
+                inc = a.frac & frac_lsb ? 0 : rnd_mask;
+                break;
             default:
                 g_assert_not_reached();
             }
@@ -3314,6 +3330,9 @@ static int32_t roundAndPackInt32(flag zSign, uint64_t absZ, float_status *status
     case float_round_down:
         roundIncrement = zSign ? 0x7f : 0;
         break;
+    case float_round_to_odd:
+        roundIncrement = absZ & 0x80 ? 0 : 0x7f;
+        break;
     default:
         abort();
     }
@@ -3368,6 +3387,9 @@ static int64_t roundAndPackInt64(flag zSign, uint64_t absZ0, uint64_t absZ1,
     case float_round_down:
         increment = zSign && absZ1;
         break;
+    case float_round_to_odd:
+        increment = !(absZ0 & 1) && absZ1;
+        break;
     default:
         abort();
     }
@@ -3424,6 +3446,9 @@ static int64_t roundAndPackUint64(flag zSign, uint64_t absZ0,
     case float_round_down:
         increment = zSign && absZ1;
         break;
+    case float_round_to_odd:
+        increment = !(absZ0 & 1) && absZ1;
+        break;
     default:
         abort();
     }
@@ -3526,6 +3551,8 @@ static float32 roundAndPackFloat32(flag zSign, int zExp, uint32_t zSig,
     case float_round_down:
         roundIncrement = zSign ? 0x7f : 0;
         break;
+    case float_round_to_odd:
+        roundIncrement = zSig & 0x80 ? 0 : 0x7f;
     default:
         abort();
         break;
@@ -3536,8 +3563,10 @@ static float32 roundAndPackFloat32(flag zSign, int zExp, uint32_t zSig,
              || (    ( zExp == 0xFD )
                   && ( (int32_t) ( zSig + roundIncrement ) < 0 ) )
            ) {
+            bool overflow_to_inf = roundingMode != float_round_to_odd &&
+                                   roundIncrement != 0;
             float_raise(float_flag_overflow | float_flag_inexact, status);
-            return packFloat32( zSign, 0xFF, - ( roundIncrement == 0 ));
+            return packFloat32(zSign, 0xFF, -!overflow_to_inf);
         }
         if ( zExp < 0 ) {
             if (status->flush_to_zero) {
@@ -3555,6 +3584,13 @@ static float32 roundAndPackFloat32(flag zSign, int zExp, uint32_t zSig,
             if (isTiny && roundBits) {
                 float_raise(float_flag_underflow, status);
             }
+            if (roundingMode == float_round_to_odd) {
+                /*
+                 * For round-to-odd case, the roundIncrement depends on
+                 * zSig which just changed.
+                 */
+                roundIncrement = zSig & 0x80 ? 0 : 0x7f;
+            }
         }
     }
     if (roundBits) {
@@ -6958,6 +6994,15 @@ float128 float128_round_to_int(float128 a, float_status *status)
                 add128(z.high, z.low, 0, roundBitsMask, &z.high, &z.low);
             }
             break;
+        case float_round_to_odd:
+            /*
+             * Note that if lastBitMask == 0, the last bit is the lsb
+             * of high, and roundBitsMask == -1.
+             */
+            if ((lastBitMask ? z.low & lastBitMask : z.high & 1) == 0) {
+                add128(z.high, z.low, 0, roundBitsMask, &z.high, &z.low);
+            }
+            break;
         default:
             abort();
         }
@@ -6969,7 +7014,7 @@ float128 float128_round_to_int(float128 a, float_status *status)
             status->float_exception_flags |= float_flag_inexact;
             aSign = extractFloat128Sign( a );
             switch (status->float_rounding_mode) {
-             case float_round_nearest_even:
+            case float_round_nearest_even:
                 if (    ( aExp == 0x3FFE )
                      && (   extractFloat128Frac0( a )
                           | extractFloat128Frac1( a ) )
@@ -6982,14 +7027,17 @@ float128 float128_round_to_int(float128 a, float_status *status)
                     return packFloat128(aSign, 0x3FFF, 0, 0);
                 }
                 break;
-             case float_round_down:
+            case float_round_down:
                 return
                       aSign ? packFloat128( 1, 0x3FFF, 0, 0 )
                     : packFloat128( 0, 0, 0, 0 );
-             case float_round_up:
+            case float_round_up:
                 return
                       aSign ? packFloat128( 1, 0, 0, 0 )
                     : packFloat128( 0, 0x3FFF, 0, 0 );
+
+            case float_round_to_odd:
+                return packFloat128(aSign, 0x3FFF, 0, 0);
             }
             return packFloat128( aSign, 0, 0, 0 );
         }
@@ -7022,6 +7070,12 @@ float128 float128_round_to_int(float128 a, float_status *status)
                 z.high += roundBitsMask;
             }
             break;
+        case float_round_to_odd:
+            if ((z.high & lastBitMask) == 0) {
+                z.high |= (a.low != 0);
+                z.high += roundBitsMask;
+            }
+            break;
         default:
             abort();
         }
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 2a35ef601d..471adb862d 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -125,17 +125,42 @@ static void not_implemented(void)
 
 static bool blacklisted(unsigned op, int rmode)
 {
-    /* odd has only been implemented for a few 128-bit ops */
+    /* odd has not been implemented for any 80-bit ops */
     if (rmode == softfloat_round_odd) {
         switch (op) {
-        case F128_ADD:
-        case F128_SUB:
-        case F128_MUL:
-        case F128_DIV:
-        case F128_TO_F64:
-        case F128_SQRT:
-            return false;
-        default:
+        case EXTF80_TO_UI32:
+        case EXTF80_TO_UI64:
+        case EXTF80_TO_I32:
+        case EXTF80_TO_I64:
+        case EXTF80_TO_UI32_R_MINMAG:
+        case EXTF80_TO_UI64_R_MINMAG:
+        case EXTF80_TO_I32_R_MINMAG:
+        case EXTF80_TO_I64_R_MINMAG:
+        case EXTF80_TO_F16:
+        case EXTF80_TO_F32:
+        case EXTF80_TO_F64:
+        case EXTF80_TO_F128:
+        case EXTF80_ROUNDTOINT:
+        case EXTF80_ADD:
+        case EXTF80_SUB:
+        case EXTF80_MUL:
+        case EXTF80_DIV:
+        case EXTF80_REM:
+        case EXTF80_SQRT:
+        case EXTF80_EQ:
+        case EXTF80_LE:
+        case EXTF80_LT:
+        case EXTF80_EQ_SIGNALING:
+        case EXTF80_LE_QUIET:
+        case EXTF80_LT_QUIET:
+        case UI32_TO_EXTF80:
+        case UI64_TO_EXTF80:
+        case I32_TO_EXTF80:
+        case I64_TO_EXTF80:
+        case F16_TO_EXTF80:
+        case F32_TO_EXTF80:
+        case F64_TO_EXTF80:
+        case F128_TO_EXTF80:
             return true;
         }
     }
-- 
2.17.2
