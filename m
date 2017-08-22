Received: from eggs.gnu.org ([2001:4830:134:3::10]:50655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk08n-0003Kb-Uq
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk08j-0003bz-2J
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:46:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-5-git-send-email-peter.maydell@linaro.org>
	<50d6ba4d-cfa3-5b5f-5da1-dca2326d4f5d@amsat.org>
	<c38728a0-da49-635e-2954-1030b223e3c9@linaro.org>
	<CAFEAcA_nPya92Vatwt7RiZnhKTH4_GKypSrX_KgPj3GitxV0Tg@mail.gmail.com>
	<CAFEAcA97eXYPABgaE8Y_+EkWscR7CCH2WUHoM7ttZ6gVWQrqxw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aa6caac1-e06c-9e1c-2aba-18d672fafb55@amsat.org>
Date: Tue, 22 Aug 2017 00:45:59 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA97eXYPABgaE8Y_+EkWscR7CCH2WUHoM7ttZ6gVWQrqxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/8] boards.h: Define new flag
 ignore_memory_transaction_failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 08/17/2017 07:25 AM, Peter Maydell wrote:
> On 5 August 2017 at 11:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 4 August 2017 at 20:23, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> On 08/04/2017 11:09 AM, Philippe Mathieu-Daudé wrote:
>>>> Since create_unimplemented_device() register overlapped with low priority, why
>>>> not register it as default device directly, over the whole address space?
>>>
>>> That's a good suggestion.  It makes more sense to me than adding a flag on the
>>> MachineClass.
>>
>> Yeah, I did think about implementing it that way, but...
>>
>> That wouldn't handle the case of a device model directly
>> returning a MEMTX_ERROR, or a transaction dispatched to
>> a memory region whose MemoryRegionOps valid settings
>> prohibit it (eg byte accesses to a word-access-only device),
>> or accesses to a MemoryRegion that was created by passing
>> a NULL MemoryRegionOps pointer to memory_region_init_io
>> (I dunno why you'd do that but some code does).
>>
>> In short, there are lots of ways the memory subsystem might
>> end up returning a transaction error -- this mechanism
>> ensures that none of them start generating exceptions
>> when they previously did not, and is (I hope) easy to
>> review in the sense of being sure that it does what it
>> intends to do without the need to audit a lot of corner
>> cases.
> 
> So, this question (should we have a board flag to disable reporting
> of tx failures to the CPU hook, or use unimplemented_device as a
> sort of background region) seems to be the main unanswered question
> for this series. I think (as outlined above) that the board flag
> is simpler and safer; are people happy for me to put this series
> in target-arm.next with that approach, or should I rethink this bit?
As remarked previously in this thread, the current QEMU behavior on 
transaction error isn't always matching real hardware.
Matching correctly throwing errors is likely to break various current users.

If we are worried about being backward compatible, defaulting background 
region to unimp() won't throw any transaction error.

Since the default is no transaction error, users who expect hardware 
error can implement the correct behavior, per region/bus transaction errors.

I'm somehow afraid that "ignore_memory_transaction_failures" ends up 
like the "cannot_instantiate_with_device_add_yet" flag - a hard to 
remove kludge outliving his purpose.

Anyway I'm not unhappy with this approach, but I'd be very happy to have 
unimp() covering the whole background region.

Regards,

Phil.
