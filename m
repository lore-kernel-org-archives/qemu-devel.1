Received: from eggs.gnu.org ([2001:4830:134:3::10]:41171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dVRnD-0004oi-HC
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dVRn9-0000nm-EF
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:15:43 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dVRn8-0000n5-SZ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:15:39 -0400
Received: by mail-it0-f67.google.com with SMTP id o202so4657164itc.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 17:15:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <507fef62-746c-703e-6b91-5becd7456d9d@twiddle.net>
References: <20170712221414.3867-1-bobby.prani@gmail.com>
	<507fef62-746c-703e-6b91-5becd7456d9d@twiddle.net>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 12 Jul 2017 20:14:07 -0400
Message-ID: <CAJhHMCDAXopimU1t0w=a9MCYTN87cQPA3zEx3z11oURcTYBr_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg/aarch64: Use ADR for shorter jumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On Wed, Jul 12, 2017 at 7:08 PM, Richard Henderson <rth@twiddle.net> wrote:
> On 07/12/2017 12:14 PM, Pranith Kumar wrote:
>>
>> Use ADR instruction for shorter jumps.
>>
>> I was going through rth's email and realized that I should have done
>> this the first time.
>>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>> ---
>>   tcg/aarch64/tcg-target.inc.c | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
>> index 04bc369a92..5121ebc1a1 100644
>> --- a/tcg/aarch64/tcg-target.inc.c
>> +++ b/tcg/aarch64/tcg-target.inc.c
>> @@ -886,12 +886,16 @@ void aarch64_tb_set_jmp_target(uintptr_t jmp_addr,
>> uintptr_t addr)
>>           i1 = I3206_B | ((offset >> 2) & 0x3ffffff);
>>           i2 = NOP;
>>       } else {
>> -        offset = (addr >> 12) - (jmp_addr >> 12);
>> +        if (offset == sextract64(offset, 0, 21)) {
>> +            i1 = I3406_ADR;
>> +            i2 = NOP;
>> +        } else {
>
>
> This is dead code because it is covered by the direct jump above.
> B has a 26-bit range, whereas ADR has a 21-bit range.

Hmm, yep. And I guess it doesn't make sense to use ADR for short jumps
because this will be a 2 instruction jump vs 1 instruction for direct
branch.

Thanks,
-- 
Pranith
