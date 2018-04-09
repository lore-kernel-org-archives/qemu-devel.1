Received: from eggs.gnu.org ([2001:4830:134:3::10]:36174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5f2V-0007fs-6h
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5f2U-0003SO-4E
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:13:27 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:38513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5f2T-0003S8-VW
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:13:26 -0400
Received: by mail-ot0-x22f.google.com with SMTP id o9-v6so10496256otj.5
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 15:13:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1f4f8003-09ed-b2f7-5709-6b74c0fa2f7e@twiddle.net>
References: <20180409103834.11285-1-peter.maydell@linaro.org>
	<1f4f8003-09ed-b2f7-5709-6b74c0fa2f7e@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Apr 2018 23:13:05 +0100
Message-ID: <CAFEAcA-35aH7KnFK+vkSAWf0i2oz44E-ov1eP0+TUfpOxdYxxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] target/arm: Don't corrupt
 insn_start arguments on 32-bit hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, alarson@ddci.com, qemu-stable <qemu-stable@nongnu.org>

On 9 April 2018 at 23:09, Richard Henderson <rth@twiddle.net> wrote:
> On 04/09/2018 08:38 PM, Peter Maydell wrote:
>> +#if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
>>      tcg_set_insn_param(s->insn_start, 2, syn);
>> +#else
>> +    /* tcg_gen_insn_start has split every target_ulong argument to
>> +     * op_insn_start into two 32-bit arguments, so we want the low
>> +     * half of the 3rd argument, which is at index 4.
>> +     */
>> +    tcg_set_insn_param(s->insn_start, 4, syn);
>> +#endif
>>
>
> Ouch, good catch.
>
> I think we should fix this in tcg_set_insn_param instead,
> as several other targets are also affected by this.

Are they? My grep didn't find anybody else using
tcg_set_insn_param() except the gen-icount.h code,
which isn't using target_long arguments.

If we can fix it in the tcg generic code instead that
would be nicer than an ifdef here, though.

thanks
-- PMM
