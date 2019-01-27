Received: from eggs.gnu.org ([209.51.188.92]:55689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gnmDr-0003TY-NE
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 10:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gnmDq-0000j0-AW
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 10:19:47 -0500
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
	<20190127090306.30826-3-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1901271251060.35973@zero.eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3dc12858-4254-9da1-7eb2-309948d0d376@ilande.co.uk>
Date: Sun, 27 Jan 2019 15:19:33 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1901271251060.35973@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 2/8] target/ppc: rework
 vmrg{l, h}{b, h, w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 27/01/2019 12:07, BALATON Zoltan wrote:

> On Sun, 27 Jan 2019, Mark Cave-Ayland wrote:
>> The current implementations make use of the endian-specific macros MRGLO/MRGHI
>> and also reference HI_IDX and LO_IDX directly to calculate array offsets.
>>
>> Rework the implementation to use the Vsr* macros so that these per-endian
>> references can be removed.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>> target/ppc/int_helper.c | 52 ++++++++++++++++++++++++-------------------------
>> 1 file changed, 25 insertions(+), 27 deletions(-)
>>
>> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
>> index 598731d47a..f084a706ee 100644
>> --- a/target/ppc/int_helper.c
>> +++ b/target/ppc/int_helper.c
>> @@ -976,43 +976,41 @@ void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t
>> *b, ppc_avr_t *c)
>>     }
>> }
>>
>> -#define VMRG_DO(name, element, highp)                                   \
>> +#define VMRG_DOLO(name, element, access)                                \
>>     void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
>>     {                                                                   \
>>         ppc_avr_t result;                                               \
>>         int i;                                                          \
>> -        size_t n_elems = ARRAY_SIZE(r->element);                        \
>> +        int m = ARRAY_SIZE(r->element) - 1;                             \
>>                                                                         \
>> -        for (i = 0; i < n_elems / 2; i++) {                             \
>> -            if (highp) {                                                \
>> -                result.element[i*2+HI_IDX] = a->element[i];             \
>> -                result.element[i*2+LO_IDX] = b->element[i];             \
>> -            } else {                                                    \
>> -                result.element[n_elems - i * 2 - (1 + HI_IDX)] =        \
>> -                    b->element[n_elems - i - 1];                        \
>> -                result.element[n_elems - i * 2 - (1 + LO_IDX)] =        \
>> -                    a->element[n_elems - i - 1];                        \
>> -            }                                                           \
>> +        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
> 
> Isn't this a performance hit? You seem to do twice as many iterations now:
> 
> - before, the loop was to ARRAY_SIZE/2 and was called twice so it executed ARRAY_SIZE
> times
> 
> - after you have a loop to ARRAY_SIZE but still called twice so it executes
> 2*ARRAY_SIZE times
> 
> Or do I miss something? If these are replaced with hardware vector instructions at
> the end then it may not matter to those who have CPU with needed vector instructions
> but for others this may be slower than the previous hand optimised version. But I
> haven't tested it, just guessing.

One point to clarify here is that the HI and LO variants of vmrg{l,h}{b,h,w} are
separate instructions, so the input elements are being iterated over once, both
before and after the patch.

Simplifying the patch down then effectively what happens is that the patch has
changed the merge implementation from:

    for (i = 0; i < ARRAY_SIZE / 2; i++) {
        result[f(2 * i)] = a->element[g(i)];
        result[f(2 * i + 1)] = b->element[g(i)];
    }

to:

    for (i = 0; i < ARRAY_SIZE; i++) {
        result[f(i)] = (i & 1) ? a->element[g(i)] : b->element[g(i)];
    }

So you're still calculating the same number of result elements, even though the loop
executes twice as many times.

Could this make the loop slower? I certainly haven't noticed any obvious performance
difference during testing (OS X uses merge quite a bit for display rendering), and
I'd hope that with a good compiler and modern branch prediction then any effect here
would be negligible.


ATB,

Mark.
