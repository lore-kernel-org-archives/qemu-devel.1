Received: from eggs.gnu.org ([2001:4830:134:3::10]:42864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whitebox@nefkom.net>) id 1ceJ9a-00011G-J4
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whitebox@nefkom.net>) id 1ceJ9V-0005Mw-KL
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:19:10 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:37084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <whitebox@nefkom.net>) id 1ceJ9V-0005KK-Dj
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:19:05 -0500
From: Andreas Schwab <schwab@linux-m68k.org>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-16-laurent@vivier.eu>
	<ca2f9cdf-c18c-bc8a-05a7-05b1d9748a48@twiddle.net>
Date: Thu, 16 Feb 2017 11:18:52 +0100
In-Reply-To: <ca2f9cdf-c18c-bc8a-05a7-05b1d9748a48@twiddle.net> (Richard
	Henderson's message of "Thu, 16 Feb 2017 12:46:35 +1100")
Message-ID: <87poiiv3oz.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Richard Henderson <rth@twiddle.net>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On Feb 16 2017, Richard Henderson <rth@twiddle.net> wrote:

> On 02/07/2017 11:59 AM, Laurent Vivier wrote:
>> +static long double floatx80_to_ldouble(floatx80 val)
>> +{
>> +    if (floatx80_is_infinity(val)) {
>> +            if (floatx80_is_neg(val)) {
>> +                    return -__builtin_infl();
>> +            }
>> +            return __builtin_infl();
>> +    }
>> +    if (floatx80_is_any_nan(val)) {
>> +            char low[20];
>> +            sprintf(low, "0x%016"PRIx64, val.low);
>> +
>> +            return nanl(low);
>> +    }
>> +
>> +    return *(long double *)&val;
>> +}
>
> This doesn't work except for x86 host.

Not even then.

> You ought to extract the mantissa, convert the 64-bit value to
> long-double, and use ldexpl to scale the result for the exponent.
>
> Similarly converting the other way use frexpl and ldexpl.

There is no guarantee that the host long double has the same range and
precision as floatx80.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
