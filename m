Received: from eggs.gnu.org ([2001:4830:134:3::10]:39834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eytDv-0006sD-Uh
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 01:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eytDs-0003oR-QG
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 01:57:16 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eytDs-0003n9-Jl
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 01:57:12 -0400
Date: Thu, 22 Mar 2018 01:57:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180322055710.GA22376@flamenco>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-9-git-send-email-cota@braap.org>
	<67b8c0f8-3fd9-ba7c-a666-d0715b5a3329@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b8c0f8-3fd9-ba7c-a666-d0715b5a3329@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 08/14] hostfloat: support float32/64
 addition and subtraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Thu, Mar 22, 2018 at 13:05:00 +0800, Richard Henderson wrote:
> On 03/22/2018 04:11 AM, Emilio G. Cota wrote:
> > +#define GEN_FPU_ADDSUB(add_name, sub_name, soft_t, host_t,              \
> > +                       host_abs_func, min_normal)                       \
> > +    static inline __attribute__((always_inline)) soft_t                 \
> > +    fpu_ ## soft_t ## _addsub(soft_t a, soft_t b, bool subtract,        \
> > +                              float_status *s)                          \
> > +    {                                                                   \
> > +        soft_t ## _input_flush2(&a, &b, s);                             \
> > +        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \
> > +                   (soft_t ## _is_normal(b) || soft_t ## _is_zero(b)) && \
> > +                   s->float_exception_flags & float_flag_inexact &&     \
> > +                   s->float_rounding_mode == float_round_nearest_even)) { \
> > +            host_t ha = soft_t ## _to_ ## host_t(a);                    \
> > +            host_t hb = soft_t ## _to_ ## host_t(b);                    \
> > +            host_t hr;                                                  \
> > +            soft_t r;                                                   \
> > +                                                                        \
> > +            if (subtract) {                                             \
> > +                hb = -hb;                                               \
> > +            }                                                           \
> > +            hr = ha + hb;                                               \
> > +            r = host_t ## _to_ ## soft_t(hr);                           \
> > +            if (unlikely(soft_t ## _is_infinity(r))) {                  \
> > +                s->float_exception_flags |= float_flag_overflow;        \
> > +            } else if (unlikely(host_abs_func(hr) <= min_normal)) {     \
> > +                goto soft;                                              \
> > +            }                                                           \
> > +            return r;                                                   \
> > +        }                                                               \
> > +    soft:                                                               \
> 
> Is there any especially good reason you want to not put this code into the
> normal softfloat function?  Does it really many any measurable difference at
> all to force this code to be inlined into a helper?

You mean to do this? (... or see below)

--- a/fpu/hostfloat.c
+++ b/fpu/hostfloat.c
@@ -97,7 +97,7 @@ GEN_INPUT_FLUSH(float64)

 #define GEN_FPU_ADDSUB(add_name, sub_name, soft_t, host_t,              \
                        host_abs_func, min_normal)                       \
-    static inline __attribute__((always_inline)) soft_t                 \
+    static soft_t                                                       \
     fpu_ ## soft_t ## _addsub(soft_t a, soft_t b, bool subtract,        \
                               float_status *s)                          \
     {                                                                   \

That slows add/sub dramatically, because addsub is not inlined into
float32_add and float32_sub (that's an extra function call plus an
extra branch per emulated op).

For x86_64-linux-user/qemu-x86_64 tests/fp-bench -o add, the above gives
- before: 188.06 MFlops
- after:  117.56 MFlops



... or did you miss that fpu_##soft_t##_addsub is only called by
soft_t ## _add / sub, which are standalone? That is:

+#define GEN_FPU_ADDSUB(add_name, sub_name, soft_t, host_t,              \
+                       host_abs_func, min_normal)                       \
(...)
+    soft_t add_name(soft_t a, soft_t b, float_status *status)           \
+    {                                                                   \
+        return fpu_ ## soft_t ## _addsub(a, b, false, status);          \
+    }                                                                   \
+                                                                        \
+    soft_t sub_name(soft_t a, soft_t b, float_status *status)           \
+    {                                                                   \
+        return fpu_ ## soft_t ## _addsub(a, b, true, status);           \
+    } 
+
+GEN_FPU_ADDSUB(float32_add, float32_sub, float32, float, fabsf, FLT_MIN)
+GEN_FPU_ADDSUB(float64_add, float64_sub, float64, double, fabs, DBL_MIN)
+#undef GEN_FPU_ADDSUB

Note that add/sub_name expand to float32/64_add/sub; I like having
the full names in the macro to ease grepping.

Thanks,

		E.
