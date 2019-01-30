Received: from eggs.gnu.org ([209.51.188.92]:50658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gouZz-0004Tj-1O
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:27:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gouZy-00074x-28
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:27:19 -0500
References: <20190129191746.14868-1-mark.cave-ayland@ilande.co.uk>
	<20190129191746.14868-3-mark.cave-ayland@ilande.co.uk>
	<6cb56e8a-384b-03b9-1e83-04bfe3157ee0@linaro.org>
	<cb9beaa4-7235-9d28-aac3-fdd55529e004@ilande.co.uk>
	<4c457307-939a-93c6-6f91-66e501d5d265@linaro.org>
	<da262783-d354-7e8a-e8d7-650f624066bb@ilande.co.uk>
	<b0e32c84-5513-e9ba-1841-c02a56f9a059@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b6dfb464-9fd9-d082-c1b0-c0225a206606@ilande.co.uk>
Date: Wed, 30 Jan 2019 18:26:59 +0000
MIME-Version: 1.0
In-Reply-To: <b0e32c84-5513-e9ba-1841-c02a56f9a059@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 2/8] target/ppc: rework vmrg{l, h}{b, h,
 w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 30/01/2019 15:31, Richard Henderson wrote:

>> I'm sorry - I think I got confused by your original macro definitions which used ofs
>> as both the macro parameter and variable name, which is why I thought you wanted ofs
>> passed in by value. Based upon the above I now have this which appears to work:
>>
>>
>> #define VMRG_DO(name, element, access, sofs)                                 \
>>     void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)            \
>>     {                                                                        \
>>         ppc_avr_t result;                                                    \
>>         int ofs, half = ARRAY_SIZE(r->element) / 2;                          \
>>         int i;                                                               \
>>                                                                              \
>>         ofs = sofs;                                                          \
> 
> What is this variable and assignment for?
> What does it accomplish?

Sigh. So I thought this was required because of the "int ofs" declaration above which
I was under the impression came from one of your previous emails. But in fact it was
me that introduced this earlier before I realised this morning that in fact the
preprocessor can do all the work.

>>         for (i = 0; i < half; i++) {                                         \
>>             result.access(i * 2 + 0) = a->access(i + ofs);                   \
>>             result.access(i * 2 + 1) = b->access(i + ofs);                   \
>>         }                                                                    \
>>         *r = result;                                                         \
>>     }
>>
>> #define VMRG(suffix, element, access)          \
>>     VMRG_DO(mrgl##suffix, element, access, half)   \
>>     VMRG_DO(mrgh##suffix, element, access, 0)
>> VMRG(b, u8, VsrB)
>> VMRG(h, u16, VsrH)
>> VMRG(w, u32, VsrW)
>> #undef VMRG_DO
>> #undef VMRG
>>
>>
>> Is this what you were intending? If this looks better then I'll resubmit a v5 later
>> this evening.
>>
>>> Also, I'm pretty sure it's the "low" merge that wants the "ofs" to be non-zero,
>>> since all of the Vsr* symbols implement big-endian indexing.
>>
>> I've just tried swapping them around as you suggested, but then all my OS X
>> background fills appear with corrupted colors. So to the best of my knowledge without
>> dumping the register contents directly, the above version with low = half and high =
>> 0 still seems correct.
> 
> That is exactly what I said, still quoted above.
> It is not what you had written in the previous version.

Yes indeed, you are right that was a simple cut and paste error from where I was
testing both variants and pasted the wrong one into the email. Below is the hopefully
final version which I've just tested here against OS X:


#define VMRG_DO(name, element, access, ofs)                                  \
    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)            \
    {                                                                        \
        ppc_avr_t result;                                                    \
        int i, half = ARRAY_SIZE(r->element) / 2;                            \
                                                                             \
        for (i = 0; i < half; i++) {                                         \
            result.access(i * 2 + 0) = a->access(i + ofs);                   \
            result.access(i * 2 + 1) = b->access(i + ofs);                   \
        }                                                                    \
        *r = result;                                                         \
    }

#define VMRG(suffix, element, access)          \
    VMRG_DO(mrgl##suffix, element, access, half)   \
    VMRG_DO(mrgh##suffix, element, access, 0)
VMRG(b, u8, VsrB)
VMRG(h, u16, VsrH)
VMRG(w, u32, VsrW)
#undef VMRG_DO
#undef VMRG


ATB,

Mark.
