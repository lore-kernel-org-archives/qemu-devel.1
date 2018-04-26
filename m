Received: from eggs.gnu.org ([2001:4830:134:3::10]:39169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBoCX-0004ov-7z
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 17:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBoCW-0002Ku-8x
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 17:13:13 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:37714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fBoCW-0002Kk-2R
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 17:13:12 -0400
Received: by mail-pg0-x230.google.com with SMTP id a13so12406965pgu.4
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 14:13:12 -0700 (PDT)
References: <20180426154035.16155-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b71bbb8a-07de-8e00-e703-c149018c53ee@linaro.org>
Date: Thu, 26 Apr 2018 11:13:06 -1000
MIME-Version: 1.0
In-Reply-To: <20180426154035.16155-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] softfloat: re-factor float to float
 conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>

On 04/26/2018 05:40 AM, Alex Bennée wrote:
> +    bool arm_hp = !ieee && (src_sz == 16);

Surely you should be testing the destination format.
The float16_unpack_canonical step should be handling
the (non-)special cases to get into FloatParts.

It would probably be better to invert the parameter to be arm_hp rather than
ieee; that way you don't need to test the format; it'll be implied.

> +        /* Our only option now is to "re-pack" the NaN. As the
> +         * canonilization process doesn't mess with fraction bits for
> +         * NaNs we do it all here
> +         */
> +        switch (src_sz) {
> +        case 64:
> +            break;
> +        case 32:
> +            a.frac = deposit64(0, 29, 22, extract64(a.frac, 0, 22));
> +            break;
> +        case 16:
> +            a.frac = deposit64(0, 42, 9, extract64(a.frac, 0, 9));
> +            break;
> +        default:
> +            g_assert_not_reached();
> +            break;
> +        }
> +
> +        /* Get all the frac bits we need with MSB set */

This is assuming QNaN has MSB set.  We also support SNaN with MSB set.

> +        switch (dst_sz) {
> +        case 64:
> +            a.frac = (1ULL << 51) | extract64(a.frac, 0, 51);
> +            break;
> +        case 32:
> +            a.frac = (1 << 22) | extract64(a.frac, 29, 22);
> +            break;
> +        case 16:
> +            a.frac = (1 << 9) | extract64(a.frac, 42, 9);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +            break;
> +        }

This would be better with

  a.frac = a.frac << (64 - src->frac_size) >> (64 - dst->frac_size);
  a.cls = float_class_msnan;

which has no such magic numbers.

> +    } else if (a.cls == float_class_inf && arm_hp) {
> +        /* FPProcessException(FPExc_InvalidOp, fpcr); */
> +        s->float_exception_flags |= float_flag_invalid;
> +        /* Alt HP returns result = sign:Ones(M-1) - faking qnan
> +         * forces round_canonical to use frac for the final bits
> +         */
> +        a.cls = float_class_qnan;
> +        a.frac = -1;

Wow, that's... ugly.  I would really prefer that you put the correct values
into the structure.

You'll need to pass ieee into float16_round_pack_canonical anyway, since
otherwise you'll get the wrong results for e.g. 1.111p31 (overflows to inf with
ieee hp; representable with armhp).


r~
