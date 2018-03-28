Received: from eggs.gnu.org ([2001:4830:134:3::10]:53189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1B64-0000UE-Ki
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1B61-0003xO-Dp
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:26:36 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1B61-0003wp-2F
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 09:26:33 -0400
Received: by mail-wm0-x242.google.com with SMTP id r131so5279414wmb.2
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 06:26:32 -0700 (PDT)
References: <1522128840-498-1-git-send-email-cota@braap.org>
	<1522128840-498-10-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1522128840-498-10-git-send-email-cota@braap.org>
Date: Wed, 28 Mar 2018 14:26:30 +0100
Message-ID: <87in9g8h6h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/14] hardfloat: support float32/64
 multiplication
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

> Performance results for fp-bench run under aarch64-linux-user
> on an Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz host:
>
> - before:
> mul-single: 88.37 MFlops
> mul-double: 85.55 MFlops
>
> - after:
> mul-single: 115.06 MFlops
> mul-double: 124.67 MFlops
>
> - w/ both using float32/64_is_normal etc.:
> mul-single: 113.49 MFlops
> mul-double: 113.46 MFlops
>
> - w/ both using fpclassify etc.:
> mul-single: 105.70 MFlops
> mul-double: 127.69 MFlops
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  fpu/softfloat.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 73 insertions(+), 4 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index e0ab0ca..9739a86 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1044,8 +1044,8 @@ float16 __attribute__((flatten)) float16_mul(float1=
6 a, float16 b,
>      return float16_round_pack_canonical(pr, status);
>  }
>
> -float32 __attribute__((flatten)) float32_mul(float32 a, float32 b,
> -                                             float_status *status)
> +static float32 __attribute__((flatten, noinline))
> +soft_float32_mul(float32 a, float32 b, float_status *status)
>  {
>      FloatParts pa =3D float32_unpack_canonical(a, status);
>      FloatParts pb =3D float32_unpack_canonical(b, status);
> @@ -1054,8 +1054,8 @@ float32 __attribute__((flatten)) float32_mul(float3=
2 a, float32 b,
>      return float32_round_pack_canonical(pr, status);
>  }
>
> -float64 __attribute__((flatten)) float64_mul(float64 a, float64 b,
> -                                             float_status *status)
> +static float64 __attribute__((flatten, noinline))
> +soft_float64_mul(float64 a, float64 b, float_status *status)
>  {
>      FloatParts pa =3D float64_unpack_canonical(a, status);
>      FloatParts pb =3D float64_unpack_canonical(b, status);
> @@ -1064,6 +1064,75 @@ float64 __attribute__((flatten)) float64_mul(float=
64 a, float64 b,
>      return float64_round_pack_canonical(pr, status);
>  }
>
> +#define GEN_FPU_MUL(name, soft_t, host_t, host_abs_func, min_normal)    \
> +    soft_t name(soft_t a, soft_t b, float_status *s)                    \
> +    {                                                                   \
> +        soft_t ## _input_flush2(&a, &b, s);                             \
> +        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) &&=
 \
> +                   (soft_t ## _is_normal(b) || soft_t ## _is_zero(b)) &&=
 \
> +                   s->float_exception_flags & float_flag_inexact &&     \
> +                   s->float_rounding_mode =3D=3D float_round_nearest_eve=
n)) { \
> +            if (soft_t ## _is_zero(a) || soft_t ## _is_zero(b)) {       \
> +                bool signbit =3D soft_t ## _is_neg(a) ^ soft_t ## _is_ne=
g(b); \
> +                                                                        \
> +                return soft_t ## _set_sign(soft_t ## _zero, signbit);   \
> +            } else {                                                    \
> +                host_t ha =3D soft_t ## _to_ ## host_t(a);              =
  \
> +                host_t hb =3D soft_t ## _to_ ## host_t(b);              =
  \
> +                host_t hr =3D ha * hb;                                  =
  \
> +                soft_t r =3D host_t ## _to_ ## soft_t(hr);              =
  \
> +                                                                        \
> +                if (unlikely(soft_t ## _is_infinity(r))) {              \
> +                    s->float_exception_flags |=3D float_flag_overflow;  =
  \
> +                } else if (unlikely(host_abs_func(hr) <=3D min_normal)) =
{ \
> +                    goto soft;                                          \
> +                }                                                       \
> +                return r;                                               \
> +            }                                                           \
> +        }                                                               \
> +    soft:                                                               \
> +        return soft_ ## soft_t ## _mul(a, b, s);                        \
> +    }
> +

OK I've had a bit more of a play and I think we can drop the macro abuse
and have common wrappers for the host_fpu. We don't want to intermingle
with the soft float slow path to stop the compiler adding overhead. We
also need a wrapper for each float size and op count due to differences
in the classify functions. However the boiler plate is pretty common and
where there are differences the compiler is smart enough to fix it.

See branch:
https://github.com/stsquad/qemu/tree/hostfloat/common-fpu-wrapper

I keep the numbers for add/sub and doubled the speed of float32_mul on
my box, without any macros ;-)

Full patch inline:

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d0f1f65c12..89217b5e67 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -879,56 +879,72 @@ soft_float64_sub(float64 a, float64 b, float_status *=
status)
     return float64_round_pack_canonical(pr, status);
 }

-#define GEN_FPU_ADDSUB(add_name, sub_name, soft_t, host_t,              \
-                       host_abs_func, min_normal)                       \
-    static inline __attribute__((always_inline)) soft_t                 \
-    fpu_ ## soft_t ## _addsub(soft_t a, soft_t b, bool subtract,        \
-                              float_status *s)                          \
-    {                                                                   \
-        soft_t ## _input_flush2(&a, &b, s);                             \
-        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \
-                   (soft_t ## _is_normal(b) || soft_t ## _is_zero(b)) && \
-                   s->float_exception_flags & float_flag_inexact &&     \
-                   s->float_rounding_mode =3D=3D float_round_nearest_even)=
) { \
-            host_t ha =3D soft_t ## _to_ ## host_t(a);                    \
-            host_t hb =3D soft_t ## _to_ ## host_t(b);                    \
-            host_t hr;                                                  \
-            soft_t r;                                                   \
-                                                                        \
-            if (subtract) {                                             \
-                hb =3D -hb;                                               \
-            }                                                           \
-            hr =3D ha + hb;                                               \
-            r =3D host_t ## _to_ ## soft_t(hr);                           \
-            if (unlikely(soft_t ## _is_infinity(r))) {                  \
-                s->float_exception_flags |=3D float_flag_overflow;        \
-            } else if (unlikely(host_abs_func(hr) <=3D min_normal) &&     \
-                       !(soft_t ## _is_zero(a) &&                       \
-                         soft_t ## _is_zero(b))) {                      \
-                goto soft;                                              \
-            }                                                           \
-            return r;                                                   \
-        }                                                               \
-    soft:                                                               \
-        if (subtract) {                                                 \
-            return soft_ ## soft_t ## _sub(a, b, s);                    \
-        } else {                                                        \
-            return soft_ ## soft_t ## _add(a, b, s);                    \
-        }                                                               \
-    }                                                                   \
-                                                                        \
-    soft_t add_name(soft_t a, soft_t b, float_status *status)           \
-    {                                                                   \
-        return fpu_ ## soft_t ## _addsub(a, b, false, status);          \
-    }                                                                   \
-                                                                        \
-    soft_t sub_name(soft_t a, soft_t b, float_status *status)           \
-    {                                                                   \
-        return fpu_ ## soft_t ## _addsub(a, b, true, status);           \
+/* Host FPU wrappers for float32_2op
+ *
+ * We will attempt to shortcut via the FPU when:
+ *  - inputs are normal
+ *  - INEXACT is already set
+ *  - rounding mode matches host (round_nearest_even)
+ * We will use the result if
+ *  - the result in INF (setting flag)
+ *  - result is hasn't maxed out
+ *  - inputs where both zero
+ *
+ * Otherwise we continue to the softfloat implementation
+ */
+
+typedef float (fpu_2op)(float a, float b, bool *nocheck);
+typedef float32 (soft_2op)(float32 a, float32 b, float_status *s);
+
+static inline __attribute__((always_inline)) float32
+fpu_float32_2op(float32 a, float32 b, fpu_2op *op, soft_2op *sop, float_st=
atus *s)
+{
+    float32_input_flush2(&a, &b, s);
+
+    if (likely((float32_is_normal(a) || float32_is_zero(a)) &&
+              (float32_is_normal(b) || float32_is_zero(b)) &&
+              s->float_exception_flags & float_flag_inexact &&
+              s->float_rounding_mode =3D=3D float_round_nearest_even)) {
+
+            bool nocheck =3D false;
+            float hr =3D op(float32_to_float(a), float32_to_float(b), &noc=
heck);
+            float32 r =3D float_to_float32(hr);
+
+            if (nocheck) {
+                return r;
+            }
+
+            if (unlikely(float32_is_infinity(r))) {
+                s->float_exception_flags |=3D float_flag_overflow;
+            } else if (unlikely(fabsf(hr) <=3D FLT_MIN) &&
+                       !(float32_is_zero(a) && float32_is_zero(b))) {
+                return sop(a, b, s);
+            }
+            return r;
     }

-GEN_FPU_ADDSUB(float32_add, float32_sub, float32, float, fabsf, FLT_MIN)
-#undef GEN_FPU_ADDSUB
+    return sop(a, b, s);
+}
+
+/* Wrap add/sub float32 */
+
+static float fpu_add32(float a, float b, bool *nocheck) {
+    return a + b;
+}
+
+static float fpu_sub32(float a, float b, bool *nocheck) {
+    return a - b;
+}
+
+float32 float32_add(float32 a, float32 b, float_status *status)
+{
+    return fpu_float32_2op(a, b, fpu_add32, soft_float32_add, status);
+}
+
+float32 float32_sub(float32 a, float32 b, float_status *status)
+{
+    return fpu_float32_2op(a, b, fpu_sub32, soft_float32_sub, status);
+}

 #define GEN_FPU_ADDSUB(add_name, sub_name, soft_t, host_t,              \
                        host_abs_func, min_normal)                       \
@@ -1064,38 +1080,23 @@ soft_float64_mul(float64 a, float64 b, float_status=
 *status)
     return float64_round_pack_canonical(pr, status);
 }

-#define GEN_FPU_MUL(name, soft_t, host_t, host_abs_func, min_normal)    \
-    soft_t name(soft_t a, soft_t b, float_status *s)                    \
-    {                                                                   \
-        soft_t ## _input_flush2(&a, &b, s);                             \
-        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \
-                   (soft_t ## _is_normal(b) || soft_t ## _is_zero(b)) && \
-                   s->float_exception_flags & float_flag_inexact &&     \
-                   s->float_rounding_mode =3D=3D float_round_nearest_even)=
) { \
-            if (soft_t ## _is_zero(a) || soft_t ## _is_zero(b)) {       \
-                bool signbit =3D soft_t ## _is_neg(a) ^ soft_t ## _is_neg(=
b); \
-                                                                        \
-                return soft_t ## _set_sign(soft_t ## _zero, signbit);   \
-            } else {                                                    \
-                host_t ha =3D soft_t ## _to_ ## host_t(a);                \
-                host_t hb =3D soft_t ## _to_ ## host_t(b);                \
-                host_t hr =3D ha * hb;                                    \
-                soft_t r =3D host_t ## _to_ ## soft_t(hr);                \
-                                                                        \
-                if (unlikely(soft_t ## _is_infinity(r))) {              \
-                    s->float_exception_flags |=3D float_flag_overflow;    \
-                } else if (unlikely(host_abs_func(hr) <=3D min_normal)) { \
-                    goto soft;                                          \
-                }                                                       \
-                return r;                                               \
-            }                                                           \
-        }                                                               \
-    soft:                                                               \
-        return soft_ ## soft_t ## _mul(a, b, s);                        \
+static float fpu_mul32(float a, float b, bool *nocheck) {
+
+    if (float32_is_zero(a) || float32_is_zero(b)) {
+        bool signbit =3D float32_is_neg(a) ^ float32_is_neg(b);
+        *nocheck =3D true;
+        return float32_set_sign((0), signbit);
+    } else {
+        float ha =3D float32_to_float(a);
+        float hb =3D float32_to_float(b);
+        float hr =3D ha * hb;
+        return hr;
     }
+}

-GEN_FPU_MUL(float32_mul, float32, float, fabsf, FLT_MIN)
-#undef GEN_FPU_MUL
+float32 __attribute__((flatten)) float32_mul(float32 a, float32 b, float_s=
tatus *s) {
+    return fpu_float32_2op(a, b, fpu_mul32, soft_float32_mul, s);
+}

 #define GEN_FPU_MUL(name, soft_t, host_t, host_abs_func, min_normal)    \
     soft_t name(soft_t a, soft_t b, float_status *s)                    \


--
Alex Benn=C3=A9e
