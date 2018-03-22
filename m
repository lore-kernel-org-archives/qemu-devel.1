Received: from eggs.gnu.org ([2001:4830:134:3::10]:48991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eytuW-0007EB-E9
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 02:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eytuS-0000z2-Ay
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 02:41:15 -0400
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233]:36679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eytuS-0000yB-5j
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 02:41:12 -0400
Received: by mail-it0-x233.google.com with SMTP id c1-v6so8828373itj.1
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 23:41:11 -0700 (PDT)
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-9-git-send-email-cota@braap.org>
	<67b8c0f8-3fd9-ba7c-a666-d0715b5a3329@linaro.org>
	<20180322055710.GA22376@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <959d13eb-498e-0bd6-2553-1b621a87f1bd@linaro.org>
Date: Thu, 22 Mar 2018 14:41:05 +0800
MIME-Version: 1.0
In-Reply-To: <20180322055710.GA22376@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 03/22/2018 01:57 PM, Emilio G. Cota wrote:
>> Is there any especially good reason you want to not put this code into the
>> normal softfloat function?  Does it really many any measurable difference at
>> all to force this code to be inlined into a helper?
> 
> You mean to do this? (... or see below)
> 
> --- a/fpu/hostfloat.c
> +++ b/fpu/hostfloat.c
> @@ -97,7 +97,7 @@ GEN_INPUT_FLUSH(float64)
> 
>  #define GEN_FPU_ADDSUB(add_name, sub_name, soft_t, host_t,              \
>                         host_abs_func, min_normal)                       \
> -    static inline __attribute__((always_inline)) soft_t                 \
> +    static soft_t                                                       \
>      fpu_ ## soft_t ## _addsub(soft_t a, soft_t b, bool subtract,        \
>                                float_status *s)                          \
>      {                                                                   \
> 
> That slows add/sub dramatically, because addsub is not inlined into
> float32_add and float32_sub (that's an extra function call plus an
> extra branch per emulated op).
> 
> For x86_64-linux-user/qemu-x86_64 tests/fp-bench -o add, the above gives
> - before: 188.06 MFlops
> - after:  117.56 MFlops

Well, not quite.  I meant putting all of the new code into softfloat.c, and not
attempting to inline any of it in target/cpu/foo_helper.c.

The best written target helpers currently simply tail-call to softfloat.c.
There are others that do so after minor argument adjustment.  For these, I have
had in my plans to rearrange things such that e.g. float32_add is called from
TCG directly, with no other function calls at all.

For targets that cannot do that, I simply cannot bring myself to care about the
final percentage points enough to want to introduce extra macros.

Another thought re all of the soft_is_normal || soft_is_zero checks that you're
performing.  I think it would be nice if we could work with
float*_unpack_canonical so that we don't have to duplicate work.  E.g.

/* Return true for float_class_normal && float_class_zero.  */
static inline bool is_finite(FloatClass c) { return c <= float_class_zero; }

float32 float32_add(float32 a, float32 b, float_status *s)
{
  FloatClass a_cls = float32_classify(a);
  FloatClass b_cls = float32_classify(b);

  if (is_finite(a_cls) && is_finite(b_cls) && ...) {
      /* do hardfp thing */
  }

  pa = float32_unpack(a, ca, s);
  pb = float32_unpack(b, cb, s);
  pr = addsub_floats(pa, pb, s, false);
  return float32_round_pack(pr, s);
}

Where float32_classify produces Normal/Zero/Inf/NaN and might avoid duplicate
work within float32_unpack.


r~
