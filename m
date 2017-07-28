Received: from eggs.gnu.org ([2001:4830:134:3::10]:36137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1db4sP-0006Bb-EA
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1db4sL-0000iC-Dw
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:00:21 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1db4sL-0000h1-6a
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:00:17 -0400
Received: by mail-wr0-x230.google.com with SMTP id k71so101283540wrc.2
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 06:00:16 -0700 (PDT)
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-13-alex.bennee@linaro.org>
	<4d6ac494-d606-ebaf-6498-7c526467ac62@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <4d6ac494-d606-ebaf-6498-7c526467ac62@twiddle.net>
Date: Fri, 28 Jul 2017 14:00:13 +0100
Message-ID: <87y3r8d8de.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> On 07/20/2017 05:04 AM, Alex Bennée wrote:
>> +static softfloat_flags softfloat_mapping_table[] = {
>> +    { float_flag_inexact  , softfloat_flag_inexact },
>> +    { float_flag_underflow, softfloat_flag_underflow },
>> +    { float_flag_overflow , softfloat_flag_overflow },
>> +    { float_flag_invalid  , softfloat_flag_invalid },
>> +};
>> +/* FIXME: 2a has no infinite flag */
>> +
>> +static uint8_t sync_softfloat_flags_from_2a(float_status *flags2a)
>> +{
>> +    uint8_t flags = flags2a->float_exception_flags;
>> +    int i;
>> +    if (flags) {
>> +        for (i = 0; i < ARRAY_SIZE(softfloat_mapping_table); i++) {
>> +            struct softfloat_flags *map = &softfloat_mapping_table[i];
>> +            if (flags & map->float2a_flag) {
>> +                softfloat_raiseFlags(map->float3c_flag);
>> +            }
>> +        }
>> +    } else {
>> +        softfloat_exceptionFlags = 0;
>> +    }
>> +
>> +    return softfloat_exceptionFlags;
>> +}
>> +
>
> For conversions like this IMO it's better to make the compiler do the
> work. C.f. target/alpha/fpu_helper.c and CONVERT_BIT.
>
> BTW, I think these TLS variables that softfloat3a are using are going
> to be a real problem.  It's one thing to do it temporarily like you
> are here, coordinating between 2a and 3c, but later, when the front
> end is fully converted?  That's just nonsense.
>
> Is it going to be worthwhile to significantly hack up the incoming sources?
>
> If so, then we might do something like this:  Given a 3c function foo,
>
>   T foo_st(T, T, float3a_status *) { ... }
>   T foo(T x, T y) { return foo_st(x, y, &tls_status); }
>
> And of course pack all of the relevant state into a struct then
>
>   #define softfloat_exceptionFlags tls_status.exceptionflags
>
> etc, instead of having individual tls variables.  This feels like
> something that we could push back upstream, assuming that upstream is
> active.

Another option which might be less invasive to the API (although
arguably a bit side-effecty) would be to make:

THREAD_LOCAL uint_fast8_t *softfloat_exceptionFlags;

And add a helper to de-reference softfloat_exceptionFlags when setting
them so that all the:

  softfloat_exceptionFlags |= softfloat_flag_inexact;

Become:

  softfloat_raiseException(softfloat_flag_inexect);

With something like:

void softfloat_raiseException(uint_fast8_t new)
{
        assert(softfloat_exceptionFlags);
        *softfloat_exceptionFlags |= new;
}

So new helpers could just do:

uint32_t HELPER(advsimd_foo)(uint32_t a, uint32_t b, void *fpstp)
{
    uint_fast8_t *old_fpst = softfloat_exceptionFlags;
    softfloat_exceptionFlags = (uint_fast8t *) fpstp;

    /* Do stuff */

    softfloat_exceptionFlags = old_fpst;
}

Unless there is code that directly fiddles the fpst bits in TCG I think
that should work well enough as any vCPU can only be doing one sort of
float at a time.

Anyway I guess this is all moot until we get an answer as to there being
an active upstream to push stuff back up to. I reached out yesterday
(https://github.com/ucb-bar/berkeley-softfloat-3/issues/5) so we'll see
if we get any feedback. Otherwise I'm minded to stick with 2a and just
implement the half-precision stuff there.


--
Alex Bennée
