Received: from eggs.gnu.org ([209.51.188.92]:49039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gosNP-0003se-MD
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gosNO-0007sV-Nb
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:06:11 -0500
Date: Wed, 30 Jan 2019 17:06:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <da262783-d354-7e8a-e8d7-650f624066bb@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.9999.1901301655390.17768@zero.eik.bme.hu>
References: <20190129191746.14868-1-mark.cave-ayland@ilande.co.uk>
	<20190129191746.14868-3-mark.cave-ayland@ilande.co.uk>
	<6cb56e8a-384b-03b9-1e83-04bfe3157ee0@linaro.org>
	<cb9beaa4-7235-9d28-aac3-fdd55529e004@ilande.co.uk>
	<4c457307-939a-93c6-6f91-66e501d5d265@linaro.org>
	<da262783-d354-7e8a-e8d7-650f624066bb@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4 2/8] target/ppc: rework
 vmrg{l, h}{b, h, w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On Wed, 30 Jan 2019, Mark Cave-Ayland wrote:
> On 30/01/2019 12:51, Richard Henderson wrote:
>
>>
>> Why are you over-complicating things?  I thought I'd explicitly said this
>> twice, but perhaps not:
>>
>> Pass the symbol "half" directly to VMRG_DO:
>>
>> #define VMRG(suffix, element, access)          \
>>     VMRG_DO(mrgl##suffix, element, access, 0)  \
>>     VMRG_DO(mrgh##suffix, element, access, half)
>>
>> You do not need another conditional within VMRG_DO.
>
> I'm sorry - I think I got confused by your original macro definitions which used ofs
> as both the macro parameter and variable name, which is why I thought you wanted ofs
> passed in by value. Based upon the above I now have this which appears to work:
>
>
> #define VMRG_DO(name, element, access, sofs)                                 \
>    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)            \
>    {                                                                        \
>        ppc_avr_t result;                                                    \
>        int ofs, half = ARRAY_SIZE(r->element) / 2;                          \
>        int i;                                                               \
>                                                                             \
>        ofs = sofs;                                                          \

I think you don't need the ofs local variable, you can just use the macro 
parameter (in paranthesis but in this case that does not matter, just 
usual precaution in case expression is passed to macro instead of 
constant). This is a macro so it will be literal replace, that's the trick 
we were missing from Richard's suggestion I think so don't look at it as 
a function parameter.

Also I wonder if you really need the result local? Can't it just access 
the result via *r directly and save a copy at the end? (Although 
that probably would be optimised out by the compiler anyway.)

By the way, thanks a lot for doing this and sorry that my comment caused 
so much trouble but your benchmark has proven my suspicion that it would 
have been two times slower with your first version.

Regards,
BALATON Zoltan

>        for (i = 0; i < half; i++) {                                         \
>            result.access(i * 2 + 0) = a->access(i + ofs);                   \
>            result.access(i * 2 + 1) = b->access(i + ofs);                   \
>        }                                                                    \
>        *r = result;                                                         \
>    }
>
> #define VMRG(suffix, element, access)          \
>    VMRG_DO(mrgl##suffix, element, access, half)   \
>    VMRG_DO(mrgh##suffix, element, access, 0)
> VMRG(b, u8, VsrB)
> VMRG(h, u16, VsrH)
> VMRG(w, u32, VsrW)
> #undef VMRG_DO
> #undef VMRG
>
>
> Is this what you were intending? If this looks better then I'll resubmit a v5 later
> this evening.
>
>> Also, I'm pretty sure it's the "low" merge that wants the "ofs" to be non-zero,
>> since all of the Vsr* symbols implement big-endian indexing.
>
> I've just tried swapping them around as you suggested, but then all my OS X
> background fills appear with corrupted colors. So to the best of my knowledge without
> dumping the register contents directly, the above version with low = half and high =
> 0 still seems correct.
>
>
> ATB,
>
> Mark.
>
>
