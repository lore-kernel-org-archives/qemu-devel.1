Received: from eggs.gnu.org ([2001:4830:134:3::10]:58567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYHEq-0003Ny-OW
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYHEn-0007xx-HX
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:35:56 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-13-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4d6ac494-d606-ebaf-6498-7c526467ac62@twiddle.net>
Date: Thu, 20 Jul 2017 09:35:40 -1000
MIME-Version: 1.0
In-Reply-To: <20170720150426.12393-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 12/23]
 target/arm/translate-a64.c: add FP16 FAGCT to AdvSIMD 3 Same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 07/20/2017 05:04 AM, Alex Bennée wrote:
> +static softfloat_flags softfloat_mapping_table[] = {
> +    { float_flag_inexact  , softfloat_flag_inexact },
> +    { float_flag_underflow, softfloat_flag_underflow },
> +    { float_flag_overflow , softfloat_flag_overflow },
> +    { float_flag_invalid  , softfloat_flag_invalid },
> +};
> +/* FIXME: 2a has no infinite flag */
> +
> +static uint8_t sync_softfloat_flags_from_2a(float_status *flags2a)
> +{
> +    uint8_t flags = flags2a->float_exception_flags;
> +    int i;
> +    if (flags) {
> +        for (i = 0; i < ARRAY_SIZE(softfloat_mapping_table); i++) {
> +            struct softfloat_flags *map = &softfloat_mapping_table[i];
> +            if (flags & map->float2a_flag) {
> +                softfloat_raiseFlags(map->float3c_flag);
> +            }
> +        }
> +    } else {
> +        softfloat_exceptionFlags = 0;
> +    }
> +
> +    return softfloat_exceptionFlags;
> +}
> +

For conversions like this IMO it's better to make the compiler do the work. 
C.f. target/alpha/fpu_helper.c and CONVERT_BIT.

BTW, I think these TLS variables that softfloat3a are using are going to be a 
real problem.  It's one thing to do it temporarily like you are here, 
coordinating between 2a and 3c, but later, when the front end is fully 
converted?  That's just nonsense.

Is it going to be worthwhile to significantly hack up the incoming sources?

If so, then we might do something like this:  Given a 3c function foo,

   T foo_st(T, T, float3a_status *) { ... }
   T foo(T x, T y) { return foo_st(x, y, &tls_status); }

And of course pack all of the relevant state into a struct then

   #define softfloat_exceptionFlags tls_status.exceptionflags

etc, instead of having individual tls variables.  This feels like something 
that we could push back upstream, assuming that upstream is active.


r~
