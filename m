Received: from eggs.gnu.org ([208.118.235.92]:46582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gcsr5-0007Fo-EJ
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gcsZN-0006oq-QA
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 08:52:59 -0500
References: <20181223113859.3675-1-mark.cave-ayland@ilande.co.uk>
	<20181223113859.3675-4-mark.cave-ayland@ilande.co.uk>
	<189db2ae-9eae-4cdf-d8d5-f7c4a82a6954@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <c974dc70-8c33-f84c-9b1e-746a46750d66@ilande.co.uk>
Date: Fri, 28 Dec 2018 13:46:23 +0000
MIME-Version: 1.0
In-Reply-To: <189db2ae-9eae-4cdf-d8d5-f7c4a82a6954@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] target/ppc: rework vmul{e, o}{s, u}{b,
 h, w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 25/12/2018 20:11, Richard Henderson wrote:

> On 12/23/18 10:38 PM, Mark Cave-Ayland wrote:
>> -#define VMUL_DO(name, mul_element, prod_element, cast, evenp)           \
>> +#define VMUL_DO_EVN(name, mul_element, mul_access, prod_access, cast)   \
>>      void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
>>      {                                                                   \
>>          int i;                                                          \
>>                                                                          \
>> +        for (i = 0; i < ARRAY_SIZE(r->mul_element); i += 2) {           \
>> +            r->prod_access(i >> 1) = (cast)a->mul_access(i) *           \
>> +                                     (cast)b->mul_access(i);            \
>> +        }                                                               \
>> +    }
>> +
>> +#define VMUL_DO_ODD(name, mul_element, mul_access, prod_access, cast)   \
>> +    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
>> +    {                                                                   \
>> +        int i;                                                          \
>> +                                                                        \
>> +        for (i = 0; i < ARRAY_SIZE(r->mul_element); i += 2) {           \
>> +            r->prod_access(i >> 1) = (cast)a->mul_access(i + 1) *       \
>> +                                     (cast)b->mul_access(i + 1);        \
>>          }                                                               \
>>      }
> 
> FWIW,
> 
>   for (i = odd; i < ARRAY_SIZE; i += 2) {
>     r->pacc(i >> 1) = (cast)a->macc(i) * b->macc(i);
>   }
> 
> is sufficient to unify these two.  But what you have isn't wrong.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Ah indeed that's quite neat! Thinking about it for a few days, I've decided to leave
it as-is for now, since it was useful to be able to test the odd/even variants
separately (as they were often used together in testing) and it's just that tiny bit
easier to relate to the ISA documentation.


ATB,

Mark.
