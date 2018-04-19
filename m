Received: from eggs.gnu.org ([2001:4830:134:3::10]:34610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9DSf-0000n8-Lg
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9DSa-00013x-3j
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:35:09 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9DSZ-00013o-V1
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:35:04 -0400
Received: by mail-oi0-x241.google.com with SMTP id e11-v6so5585229oii.11
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 10:35:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c97f1392-570c-b3a2-1a2f-a223349b965e@linaro.org>
References: <20180417221246.14672-1-richard.henderson@linaro.org>
	<CAFEAcA-auT4gVS0boZcFxeNuf-6x4u_wfochb9bqwKmryjtsUA@mail.gmail.com>
	<c97f1392-570c-b3a2-1a2f-a223349b965e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Apr 2018 18:34:42 +0100
Message-ID: <CAFEAcA8R9nSGaXb8SGQ-RZqOBgJ6ysVaDEc8MV80SJGGfVaj+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.13] tcg: Allow wider vectors for cmp
 and mul
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

On 19 April 2018 at 18:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 04/19/2018 12:17 AM, Peter Maydell wrote:
>> On 17 April 2018 at 23:12, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> In db432672, we allow wide inputs for operations such as add.
>>> However, in 212be173 and 3774030a we didn't do the same for
>>> compare and multiply.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> Can we hit these asserts in the uses of tcg_gen_mul_vec
>> and tcg_gen_cmp_vec currently in the aarch64 frontend, or
>> is this only a problem for the not-yet-landed SVE code?
>
> Only sve code -- it requires a VQ that is not a power of 2, e.g. 3.
>
>> I notice that do_shifti() also has a
>>     tcg_debug_assert(at->base_type == type);
>> Is that assert correct, or should it also be changed to >= ?
>
> I think that one is correct.  This assert is hit for something like
>
>         mul     z3, z2, z1[0]
>
> where we dup the scalar to our widest host vector width and then multiply.  In
> the case of VQ=3, the dup might be to v256, one v256 multiply, and one v128
> multiply.

Cool. In that case

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
