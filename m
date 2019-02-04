Received: from eggs.gnu.org ([209.51.188.92]:59288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqctM-0008Eo-Ig
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqctJ-0005TU-5M
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:58:23 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqctI-0005Rx-3P
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:58:20 -0500
Received: by mail-wr1-x441.google.com with SMTP id q15so3121898wro.12
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 03:58:19 -0800 (PST)
References: <20190128223118.5255-1-richard.henderson@linaro.org>
	<20190128223118.5255-6-richard.henderson@linaro.org>
	<CAFEAcA_DHJf6-ewYoNEWyF2VDF+n6W_DtMgqTNA==rEpDE0AMA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6e640e9a-13c0-17ce-1490-9f002b11a783@linaro.org>
Date: Mon, 4 Feb 2019 11:58:15 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_DHJf6-ewYoNEWyF2VDF+n6W_DtMgqTNA==rEpDE0AMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/12] target/arm: Cache the GP bit for
 a page in MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2/4/19 11:41 AM, Peter Maydell wrote:
> On Mon, 28 Jan 2019 at 22:31, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Caching the bit means that we will not have to re-walk the
>> page tables to look up the bit during translation.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/helper.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 6efe88a157..70277222da 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -10457,6 +10457,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>>      bool ttbr1_valid;
>>      uint64_t descaddrmask;
>>      bool aarch64 = arm_el_is_aa64(env, el);
>> +    bool guarded = false;
>>
>>      /* TODO:
>>       * This code does not handle the different format TCR for VTCR_EL2.
>> @@ -10629,6 +10630,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>>          }
>>          /* Merge in attributes from table descriptors */
>>          attrs |= nstable << 3; /* NS */
>> +        guarded |= extract64(descriptor, 50, 1);  /* GP */
> 
> Should just be "guarded =", as per previous discussion.
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Agreed.  Do you need a re-spin for this?


r~
