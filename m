Received: from eggs.gnu.org ([209.51.188.92]:44131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gooFr-0000Q0-Vg
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gooFr-0008EN-5b
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:42:07 -0500
Date: Wed, 30 Jan 2019 12:42:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <cb9beaa4-7235-9d28-aac3-fdd55529e004@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.9999.1901301236220.42161@zero.eik.bme.hu>
References: <20190129191746.14868-1-mark.cave-ayland@ilande.co.uk>
	<20190129191746.14868-3-mark.cave-ayland@ilande.co.uk>
	<6cb56e8a-384b-03b9-1e83-04bfe3157ee0@linaro.org>
	<cb9beaa4-7235-9d28-aac3-fdd55529e004@ilande.co.uk>
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
> On 29/01/2019 23:05, Richard Henderson wrote:
>
>> On 1/29/19 11:17 AM, Mark Cave-Ayland wrote:
>>> +#define VMRG_DO(name, element, access, ofs)                             \
>>>      void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
>>>      {                                                                   \
>>>          ppc_avr_t result;                                               \
>>>          int i;                                                          \
>>>                                                                          \
>>> +        for (i = 0; i < ARRAY_SIZE(r->element) / 2; i++) {              \
>>> +            result.access(i * 2 + 0) = a->access(i + ofs);              \
>>> +            result.access(i * 2 + 1) = b->access(i + ofs);              \
>>>          }                                                               \
>>>          *r = result;                                                    \
>>>      }
>>> +
>>> +#define VMRG(suffix, element, access, half)        \
>>> +    VMRG_DO(mrgl##suffix, element, access, half)   \
>>> +    VMRG_DO(mrgh##suffix, element, access, 0)
>>> +VMRG(b, u8, VsrB, 8)
>>> +VMRG(h, u16, VsrH, 4)
>>> +VMRG(w, u32, VsrW, 2)
>>
>> So... the point of "half" was to not replicate knowledge out to VMRG.
>> Just use
>>
>>     int i, half = ARRAY_SIZE(r->element) / 2;
>>     for (i = 0; i < half; i++) {
>>
>> within VMRG_DO.
>
> Okay - I was a bit confused because in your example macro signature you added ofs
> which made me think you wanted its value to be determined outside, but never mind.
>
> What about the following instead? With high set as part of the macro then the initial
> assignment to ofs should be inlined accordingly at compile time:
>
>
> #define VMRG_DO(name, element, access, high)                                 \
>    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)            \
>    {                                                                        \
>        ppc_avr_t result;                                                    \
>        int ofs, half = ARRAY_SIZE(r->element) / 2;                          \
>        int i;                                                               \
>                                                                             \
>        if (high) {                                                          \
>            ofs = 0;                                                         \
>        } else {                                                             \
>            ofs = half;                                                      \
>        }                                                                    \

This could be also written as:

int i, half = ARRAY_SIZE(r->element) / 2;                            \
int ofs = (high ? 0 : half);                                         \

to save a few lines but it depends on personal taste which one is more 
readable for someone.

Regards,
BALATON Zoltan

>                                                                             \
>        for (i = 0; i < half; i++) {                                         \
>            result.access(i * 2 + 0) = a->access(i + ofs);                   \
>            result.access(i * 2 + 1) = b->access(i + ofs);                   \
>        }                                                                    \
>        *r = result;                                                         \
>    }
>
> #define VMRG(suffix, element, access)          \
>    VMRG_DO(mrgl##suffix, element, access, 0)  \
>    VMRG_DO(mrgh##suffix, element, access, 1)
> VMRG(b, u8, VsrB)
> VMRG(h, u16, VsrH)
> VMRG(w, u32, VsrW)
> #undef VMRG_DO
> #undef VMRG
> #undef VMRG
>
>
> ATB,
>
> Mark.
>
>
