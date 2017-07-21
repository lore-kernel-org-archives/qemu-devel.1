Received: from eggs.gnu.org ([2001:4830:134:3::10]:47068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYYKJ-0005nX-Es
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYYKF-0002Oc-11
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:50:43 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:32891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYYKE-0002NP-Ho
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:50:38 -0400
Received: by mail-wr0-x231.google.com with SMTP id v105so52548327wrb.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 06:50:36 -0700 (PDT)
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-13-alex.bennee@linaro.org>
	<4d6ac494-d606-ebaf-6498-7c526467ac62@twiddle.net>
	<87tw266rm3.fsf@linaro.org>
	<20170721132140.xy2uqronprhzjiga@aurel32.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170721132140.xy2uqronprhzjiga@aurel32.net>
Date: Fri, 21 Jul 2017 14:50:33 +0100
Message-ID: <87mv7x7vbq.fsf@linaro.org>
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
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Richard Henderson <rth@twiddle.net>, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org


Aurelien Jarno <aurelien@aurel32.net> writes:

> On 2017-07-21 10:56, Alex Bennée wrote:
>>
>> Richard Henderson <rth@twiddle.net> writes:
>>
>> > On 07/20/2017 05:04 AM, Alex Bennée wrote:
>> >> +static softfloat_flags softfloat_mapping_table[] = {
>> >> +    { float_flag_inexact  , softfloat_flag_inexact },
>> >> +    { float_flag_underflow, softfloat_flag_underflow },
>> >> +    { float_flag_overflow , softfloat_flag_overflow },
>> >> +    { float_flag_invalid  , softfloat_flag_invalid },
>> >> +};
>> >> +/* FIXME: 2a has no infinite flag */
>> >> +
>> >> +static uint8_t sync_softfloat_flags_from_2a(float_status *flags2a)
>> >> +{
>> >> +    uint8_t flags = flags2a->float_exception_flags;
>> >> +    int i;
>> >> +    if (flags) {
>> >> +        for (i = 0; i < ARRAY_SIZE(softfloat_mapping_table); i++) {
>> >> +            struct softfloat_flags *map = &softfloat_mapping_table[i];
>> >> +            if (flags & map->float2a_flag) {
>> >> +                softfloat_raiseFlags(map->float3c_flag);
>> >> +            }
>> >> +        }
>> >> +    } else {
>> >> +        softfloat_exceptionFlags = 0;
>> >> +    }
>> >> +
>> >> +    return softfloat_exceptionFlags;
>> >> +}
>> >> +
>> >
>> > For conversions like this IMO it's better to make the compiler do the
>> > work. C.f. target/alpha/fpu_helper.c and CONVERT_BIT.
>>
>> Cool, I'll look at that.
>>
>> > BTW, I think these TLS variables that softfloat3a are using are going
>> > to be a real problem.  It's one thing to do it temporarily like you
>> > are here, coordinating between 2a and 3c, but later, when the front
>> > end is fully converted?  That's just nonsense.
>>
>> Wouldn't the other option to be to drop float_status out of the guests
>> CPUEnv and grab it from the TLS variable instead? Of course all guests
>> would need to be MTTCG enabled for that to work.
>
> As said in another email, some architectures actually use more than one
> float_status. We therefore need to implement a solution like the one
> proposed by Richard.

Ahh you mean more than one float_status for a given vCPU context?

--
Alex Bennée
