Received: from eggs.gnu.org ([2001:4830:134:3::10]:47177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dgGiu-0004NG-NV
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 16:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dgGit-0005Tj-JR
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 16:40:00 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <abdfeb96-6c04-66cb-44fe-a964beb901c3@linaro.org>
References: <cover.1502474835.git.alistair.francis@xilinx.com>
	<2fbcf76e4ff63d8527edd3662342948276e2cd37.1502474835.git.alistair.francis@xilinx.com>
	<de3609ba-241a-6df8-b5c3-30eb4535735e@linaro.org>
	<CAKmqyKPLJpv79Dv77t8m2q-pFOBg3u4hDmcz5Wk2t+tt+bT8UA@mail.gmail.com>
	<fb2b501e-21b0-f711-19f5-a3087b6007f3@linaro.org>
	<CAKmqyKOCAS1=WPFwBUXwTve1T_VZsQKJdT=15CPRoHSs-eEhDw@mail.gmail.com>
	<abdfeb96-6c04-66cb-44fe-a964beb901c3@linaro.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 11 Aug 2017 13:39:25 -0700
Message-ID: <CAKmqyKM1p2-9roBs1Lh-7UUvQ+JGW4LWTPbLJ=VWzae2Q2s4uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 3/3] target/arm: Correct exclusive store
 return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@gmail.com>

On Fri, Aug 11, 2017 at 1:38 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 08/11/2017 01:29 PM, Alistair Francis wrote:
>> On Fri, Aug 11, 2017 at 1:24 PM, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> On 08/11/2017 01:13 PM, Alistair Francis wrote:
>>>>>> +            tcg_gen_ext_i64(val, val, memop);
>>>>>
>>>>> What is this addition intended to accomplish?  Because of the position within
>>>>> the code, you know that memop contains MO_64, so that this is a no-op.
>>>>
>>>> This is when size == 2 so it's a 32bit operation so memop contains MO_32.
>>>
>>> It's a paired 32-bit operation, so we're operating on a 64-bit quantity.  So
>>> extending from 32-bits would be actively wrong.
>>
>> From what I can see though, the 32bit memop is carried into the
>> tcg_gen_atomic_cmpxchg_i64() call so the value returned to tmp is
>> masked by the 32bit operation.
>>
>> Is passing down MO_32 into tcg_gen_atomic_cmpxchg_i64() wrong then as
>> it ends up as a 64-bit operation?
>
> If we're passing MO_32 down to cmpxchg_i64 for this case, you have indeed found
> a bug.  I'll investigate this further on Monday.

Maybe that is why I'm seeing these failures. I'll have a look as well
to see if this fixes my problems.

Thanks,
Alistair

>
>
> r~
>
