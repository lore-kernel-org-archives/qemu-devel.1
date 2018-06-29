Received: from eggs.gnu.org ([2001:4830:134:3::10]:39963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYpQU-0006Xl-4M
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYpQS-0006VE-VD
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:10:46 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:38609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYpQS-0006Tr-PO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:10:44 -0400
Received: by mail-ot0-x242.google.com with SMTP id w22-v6so9215588otk.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 02:10:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8MtK93KV5ZHchUP3H+bx4eANnjndU__xrGSBZDXsXnGQ@mail.gmail.com>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-2-richard.henderson@linaro.org>
	<CAFEAcA8MtK93KV5ZHchUP3H+bx4eANnjndU__xrGSBZDXsXnGQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 10:10:23 +0100
Message-ID: <CAFEAcA888_6QJCC2OTbdTg_9bVBC8dvu_zaDG63ZKv3R312+AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/6] target/arm: Fix SVE signed division vs
 x86 overflow exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 June 2018 at 09:29, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 29 June 2018 at 01:15, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> We already check for the same condition within the normal integer
>> sdiv and sdiv64 helpers.  Use a slightly different formation that
>> does not require deducing the expression type.
>>
>> Fixes: f97cfd596ed
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/sve_helper.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
>> index 790cbacd14..7d7fc90566 100644
>> --- a/target/arm/sve_helper.c
>> +++ b/target/arm/sve_helper.c
>> @@ -369,7 +369,13 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
>>  #define DO_MIN(N, M)  ((N) >= (M) ? (M) : (N))
>>  #define DO_ABD(N, M)  ((N) >= (M) ? (N) - (M) : (M) - (N))
>>  #define DO_MUL(N, M)  (N * M)
>> -#define DO_DIV(N, M)  (M ? N / M : 0)
>> +
>> +/* The zero divisor case is architectural; the -1 divisor case works
>> + * around the x86 INT_MIN / -1 overflow exception without having to
>> + * deduce the minimum integer for the type of the expression.
>> + */
>
> It works around INT_MIN / -1 being C undefined behaviour: the
> need to special-case this is not x86-specific... The required
> answer for Arm is just as architectural as the required answer
> for division-by-zero (which is also C UB).

Suggested revised comment text:

/* We must avoid the C undefined behaviour cases: division by
 * zero and signed division of INT_MIN by -1. Both of these
 * have architecturally defined required results for Arm.
 * We special case all signed divisions by -1 to avoid having
 * to deduce the minimum integer for the type involved.
 */

?

thanks
-- PMM
