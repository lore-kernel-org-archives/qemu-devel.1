Received: from eggs.gnu.org ([2001:4830:134:3::10]:59918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHoA9-0003nr-00
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHoA7-0007kQ-LX
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:51:17 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHoA7-0007j6-FM
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:51:15 -0500
Received: by mail-ot0-x244.google.com with SMTP id b54so15866172otd.8
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 01:51:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqEW202FqhrNpXOvWTT9s-H-ZGrmdAFTeynRc6VnOia6Uw@mail.gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-5-andrew.smirnov@gmail.com>
	<CAFEAcA9EhzPxayCGDOiM_6U9YSS6HK1gCgBroR=C1LM=H=FpQw@mail.gmail.com>
	<CAHQ1cqEW202FqhrNpXOvWTT9s-H-ZGrmdAFTeynRc6VnOia6Uw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 09:50:54 +0000
Message-ID: <CAFEAcA8UAD34yhcEAzkJ2xsop-UUntXJAREYREgFA7Pz5CMh6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 04/30] imx_fec: Use ENET_FTRL to
 determine truncation length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 22 November 2017 at 20:22, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> On Tue, Nov 21, 2017 at 9:31 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>>> Frame truncation length, TRUNC_FL, is determined by the contents of
>>> ENET_FTRL register, so convert the code to use it instead of a
>>> hardcoded constant.
>>>
>>> To avoid the case where TRUNC_FL is greater that ENET_MAX_FRAME_SIZE,
>>> increase the value of the latter to its theoretical maximum of 16K.

>>>
>>> +#define ENET_MAX_FRAME_SIZE    (1 << ENET_RCR_MAX_FL_LENGTH)
>>
>> This means we now have functions with 16K local array
>> variables on the stack, which seems like a bad idea.
>>
>
> Can't say I see a big difference between having a 2K vs 16K buffer on
> the stack, but regardless, I am not quite clear if you are not too hot
> about this patch and want me to drop it (I am fine with it) or do you
> want me to modify it to have the emulation layer allocate said 16K
> buffer on the heap instead of a stack?

To be clearer: 16K is too large a buffer to have on the stack;
2K is about as big as you want to go.
If you want to allow 16K packets then you need to avoid having
on-stack arrays of that length. (But you don't want to do a
heap allocation for every function call either.)

"look for and fix functions with arrays of 16K or more" is one
of our bite-sized-tasks for people who want to fix bugs:
https://wiki.qemu.org/Contribute/BiteSizedTasks#Large_frames

thanks
-- PMM
