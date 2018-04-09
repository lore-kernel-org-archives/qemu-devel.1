Received: from eggs.gnu.org ([2001:4830:134:3::10]:40089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f5f9N-0002sO-EL
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f5f9M-0007XG-B8
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:20:33 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180409103834.11285-1-peter.maydell@linaro.org>
	<1f4f8003-09ed-b2f7-5709-6b74c0fa2f7e@twiddle.net>
	<CAFEAcA-35aH7KnFK+vkSAWf0i2oz44E-ov1eP0+TUfpOxdYxxA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7c969999-7281-7f4c-5ad2-f72fde1b24c4@twiddle.net>
Date: Tue, 10 Apr 2018 08:20:21 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-35aH7KnFK+vkSAWf0i2oz44E-ov1eP0+TUfpOxdYxxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, alarson@ddci.com, qemu-stable <qemu-stable@nongnu.org>

On 04/10/2018 08:13 AM, Peter Maydell wrote:
> On 9 April 2018 at 23:09, Richard Henderson <rth@twiddle.net> wrote:
>> On 04/09/2018 08:38 PM, Peter Maydell wrote:
>>> +#if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
>>>      tcg_set_insn_param(s->insn_start, 2, syn);
>>> +#else
>>> +    /* tcg_gen_insn_start has split every target_ulong argument to
>>> +     * op_insn_start into two 32-bit arguments, so we want the low
>>> +     * half of the 3rd argument, which is at index 4.
>>> +     */
>>> +    tcg_set_insn_param(s->insn_start, 4, syn);
>>> +#endif
>>>
>>
>> Ouch, good catch.
>>
>> I think we should fix this in tcg_set_insn_param instead,
>> as several other targets are also affected by this.
> 
> Are they? My grep didn't find anybody else using
> tcg_set_insn_param() except the gen-icount.h code,
> which isn't using target_long arguments.

Ah, the s390 code I thought I remembered is still sitting on a branch.  I shall
have to revive that for the next devel cycle...

> If we can fix it in the tcg generic code instead that
> would be nicer than an ifdef here, though.

I am working on this now.


r~
