Received: from eggs.gnu.org ([2001:4830:134:3::10]:35950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS6ky-000800-1F
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS6ku-0004UF-TI
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:11:36 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:32886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS6ku-0004U0-NI
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:11:32 -0400
Received: by mail-qk0-x232.google.com with SMTP id v143so68957671qkb.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 12:11:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170703162328.24474-1-laurent@vivier.eu>
	<20170703162328.24474-3-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <255de989-982c-273e-55d1-0940a60169c2@twiddle.net>
Date: Mon, 3 Jul 2017 12:11:25 -0700
MIME-Version: 1.0
In-Reply-To: <20170703162328.24474-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] target/m68k: add FPU trigonometric
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 07/03/2017 09:23 AM, Laurent Vivier wrote:
> +long double floatx80_to_ldouble(floatx80 val)
> +{
> +    long double mantissa;
> +    int32_t exp;
> +    uint8_t sign;
> +
> +    if (floatx80_is_infinity(val)) {
> +        if (floatx80_is_neg(val)) {
> +            return -__builtin_infl();
> +        }
> +        return __builtin_infl();

Better is the C99 INFINITY macro.

> +    }
> +    if (floatx80_is_any_nan(val)) {
> +        char low[20];
> +        sprintf(low, "0x%016"PRIx64, val.low);
> +        return nanl(low);

I think it would be better to avoid playing with nan payloads.

If you want to handle nans properly, I think you should provide a completely 
separate path through each user of floatx80_to_ldouble that avoids calling the 
libm function entirely.  And, more importantly, avoids the ldouble_to_floatx80 
call as well.

One possibly arrangement would be

	bool floatx80_to_ldouble(long double *out, floatx80 val)
	{
	  if (floatx80_is_any_nan(val)) {
	    *out = NAN;
	    return false;
	  }
           if (floatx80_is_infinity(val)) {
	    ...
	  } else {
	    ...
	  }
	  return true;
	}

   long double d;
   if (floatx80_to_ldouble(&d, val))) {
     d = sinl(d);
     val = ldouble_to_floatx80(d, status);
   } else {
     status->float_exception_flags |= float_flag_invalid;
     val = floatx80_default_nan(status);
   }

Failing that, just use the C99 NAN macro.

> +static floatx80 ldouble_to_floatx80(long double val, float_status *status)
> +{
> +    floatx80 res;
> +    long double mantissa;
> +    int exp;
> +
> +    if (isinf(val)) {
> +        res = floatx80_infinity;
> +        if (isinf(val) < 0) {

C99 isinf is merely boolean.  You want signbit for the second test.

> +    if (isnan(val)) {
> +        res.high = floatx80_default_nan(NULL).high;
> +        res.low = *(uint64_t *)&val; /* FIXME */
> +        return res;
> +    }

Likewise I'm uncomfortable with nan payloads.

You're not handling -0.0.  Perhaps

	switch (fpclassifyl(val)) {
	case FP_NAN:
	    res = floatx80_default_nan(status);
             break;
	case FP_INF:
	    res = floatx80_infinity;
	    break;
	case FP_ZERO:
	    res = floatx80_zero;
	    break;
	default:
	    // frexpl et al.
	}
	if (signbit(val)) {
	    res = floatx80_chs(res);
	}

is a better arrangement.

> +    mantissa = frexpl(val, &exp);
> +    res.high = exp + 0x3ffe;

Must be careful here: when long double = float128, this can either underflow or 
overflow.  Perhaps check for this and maybe even set the appropriate float_flag 
in status when it happens?

If you have gcc compile farm access, try gcc112 (power8 ppc64le host).

> +    res.low = (uint64_t)ldexpl(mantissa, 64);
> +
> +    return floatx80_round(res, status);

There may also be bits left over with float128, which means that rounding may 
be off.  But I think perhaps we don't really care *that* much about last-bit 
accuracy when it comes to these non-arithmetic insns.

> +    d = logl(floatx80_to_ldouble(val->d) + 1.0);

log1pl, which is important for actually computing values near 1.


r~
