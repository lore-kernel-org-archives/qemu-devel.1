Received: from eggs.gnu.org ([2001:4830:134:3::10]:44177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cbjm8-0004EK-Lj
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cbjm4-000280-LV
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:08:20 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:56176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cbjm4-00026X-AM
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:08:16 -0500
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-3-laurent@vivier.eu>
	<CAFEAcA9dRrmY+86t6uzqnaRynvV4AW3vcCfaqRJKT1gt=E_OJg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1968e7c6-64d2-8582-b9ec-872b3276fd22@vivier.eu>
Date: Thu, 9 Feb 2017 09:07:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9dRrmY+86t6uzqnaRynvV4AW3vcCfaqRJKT1gt=E_OJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 02/16] softloat: disable
 floatx80_invalid_encoding() for m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andreas Schwab <schwab@linux-m68k.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Le 08/02/2017 à 23:58, Peter Maydell a écrit :
> On 7 February 2017 at 00:59, Laurent Vivier <laurent@vivier.eu> wrote:
>> According to the comment, this definition of invalid encoding is given
>> by intel developer's manual, and doesn't work with the behavior
>> of 680x0 FPU.
>>
>> CC: Andreas Schwab <schwab@linux-m68k.org>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  fpu/softfloat.c         | 31 +++++++++++++++++++++++++++++++
>>  include/fpu/softfloat.h | 15 ---------------
>>  2 files changed, 31 insertions(+), 15 deletions(-)
>>
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>> index c295f31..f95b19f 100644
>> --- a/fpu/softfloat.c
>> +++ b/fpu/softfloat.c
>> @@ -4799,6 +4799,37 @@ int float64_unordered_quiet(float64 a, float64 b, float_status *status)
>>  }
>>
>>  /*----------------------------------------------------------------------------
>> +| Return whether the given value is an invalid floatx80 encoding.
>> +| Invalid floatx80 encodings arise when the integer bit is not set, but
>> +| the exponent is not zero. The only times the integer bit is permitted to
>> +| be zero is in subnormal numbers and the value zero.
>> +| This includes what the Intel software developer's manual calls pseudo-NaNs,
>> +| pseudo-infinities and un-normal numbers. It does not include
>> +| pseudo-denormals, which must still be correctly handled as inputs even
>> +| if they are never generated as outputs.
>> +*----------------------------------------------------------------------------*/
>> +static inline bool floatx80_invalid_encoding(floatx80 a)
>> +{
>> +#if defined(TARGET_M68K)
>> +    /*-------------------------------------------------------------------------
>> +    |  M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL
>> +    |  1.6.2 Denormalized Numbers
>> +    |  Since the extended-precision data format has an explicit integer bit,
>> +    |  a number can be formatted with a nonzero exponent, less than the maximum
>> +    |  value, and a zero integer bit.  The IEEE 754 standard does not define a
>> +    |  zero integer bit. Such a number is an unnormalized number. Hardware does
>> +    |  not directly support denormalized and unnormalized numbers, but
>> +    |  implicitly supports them by trapping them as unimplemented data types,
>> +    |  allowing efficient conversion in software.
>> +    *------------------------------------------------------------------------*/
> 
> This comment says that numbers of the form that this function
> identifies (zero integer bit and nonzero exponent) are
> supposed to trap on m68k. That suggests that the target/m68k code
> is going to need to catch this case before it calls softfloat
> code. So (a) we don't care what the softfloat code does
> with these representations because they'll never get to it
> and (b) the m68k code could probably use floatx80_invalid_encoding()
> as a function to identify where it needs to trap, which it
> can't do if it's moved out of softfloat.h.
> 
> Either way this change doesn't seem right given what the
> comment describes...

Ok, so I think this functionality needs more work inside the 680x0 FPU
emulation. As the emulation can work without it, I'm going to remove it
from this series to rework it later.

Thanks,
Laurent
