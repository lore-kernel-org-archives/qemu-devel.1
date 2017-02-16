Received: from eggs.gnu.org ([2001:4830:134:3::10]:36242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceB9g-0006oh-07
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceB9f-0000C6-9i
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:46:44 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ceB9f-0000Bx-2R
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:46:43 -0500
Received: by mail-pg0-x243.google.com with SMTP id 204so403736pge.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 17:46:42 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-16-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ca2f9cdf-c18c-bc8a-05a7-05b1d9748a48@twiddle.net>
Date: Thu, 16 Feb 2017 12:46:35 +1100
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-16-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 15/16] target-m68k: add more FPU
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

On 02/07/2017 11:59 AM, Laurent Vivier wrote:
> +static long double floatx80_to_ldouble(floatx80 val)
> +{
> +    if (floatx80_is_infinity(val)) {
> +            if (floatx80_is_neg(val)) {
> +                    return -__builtin_infl();
> +            }
> +            return __builtin_infl();
> +    }
> +    if (floatx80_is_any_nan(val)) {
> +            char low[20];
> +            sprintf(low, "0x%016"PRIx64, val.low);
> +
> +            return nanl(low);
> +    }
> +
> +    return *(long double *)&val;
> +}

This doesn't work except for x86 host.

You ought to extract the mantissa, convert the 64-bit value to long-double, and 
use ldexpl to scale the result for the exponent.

Similarly converting the other way use frexpl and ldexpl.


r~
