Received: from eggs.gnu.org ([209.51.188.92]:58142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gopLO-0007dx-PW
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gopLN-0001lq-TO
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:51:54 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:44935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gopLN-0001lY-Ml
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:51:53 -0500
Received: by mail-oi1-x22d.google.com with SMTP id m6so19051908oig.11
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 04:51:53 -0800 (PST)
References: <20190129191746.14868-1-mark.cave-ayland@ilande.co.uk>
	<20190129191746.14868-3-mark.cave-ayland@ilande.co.uk>
	<6cb56e8a-384b-03b9-1e83-04bfe3157ee0@linaro.org>
	<cb9beaa4-7235-9d28-aac3-fdd55529e004@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4c457307-939a-93c6-6f91-66e501d5d265@linaro.org>
Date: Wed, 30 Jan 2019 04:51:49 -0800
MIME-Version: 1.0
In-Reply-To: <cb9beaa4-7235-9d28-aac3-fdd55529e004@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 1/29/19 9:10 PM, Mark Cave-Ayland wrote:
>> So... the point of "half" was to not replicate knowledge out to VMRG.
>> Just use
>>
>>     int i, half = ARRAY_SIZE(r->element) / 2;
>>     for (i = 0; i < half; i++) {
>>
>> within VMRG_DO.
> 
> Okay - I was a bit confused because in your example macro signature you
> added ofs which made me think you wanted its value to be determined outside,
> but nevermind.
> 
> What about the following instead? With high set as part of the macro then
> the initial assignment to ofs should be inlined accordingly at compile time:
> 
> #define VMRG_DO(name, element, access, high)                                 \
>     void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)            \
>     {                                                                        \
>         ppc_avr_t result;                                                    \
>         int ofs, half = ARRAY_SIZE(r->element) / 2;                          \
>         int i;                                                               \
>                                                                              \
>         if (high) {                                                          \
>             ofs = 0;                                                         \
>         } else {                                                             \
>             ofs = half;                                                      \
>         }                                                                    \

Why are you over-complicating things?  I thought I'd explicitly said this
twice, but perhaps not:

Pass the symbol "half" directly to VMRG_DO:

#define VMRG(suffix, element, access)          \
    VMRG_DO(mrgl##suffix, element, access, 0)  \
    VMRG_DO(mrgh##suffix, element, access, half)

You do not need another conditional within VMRG_DO.

Also, I'm pretty sure it's the "low" merge that wants the "ofs" to be non-zero,
since all of the Vsr* symbols implement big-endian indexing.


r~
