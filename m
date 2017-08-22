Received: from eggs.gnu.org ([2001:4830:134:3::10]:41501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dk4gb-0003mH-Pv
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dk4ga-0006db-U7
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:37:21 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:37670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dk4ga-0006d1-N2
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:37:20 -0400
Received: by mail-wr0-x235.google.com with SMTP id z91so116976961wrc.4
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 01:37:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <aa6caac1-e06c-9e1c-2aba-18d672fafb55@amsat.org>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-5-git-send-email-peter.maydell@linaro.org>
	<50d6ba4d-cfa3-5b5f-5da1-dca2326d4f5d@amsat.org>
	<c38728a0-da49-635e-2954-1030b223e3c9@linaro.org>
	<CAFEAcA_nPya92Vatwt7RiZnhKTH4_GKypSrX_KgPj3GitxV0Tg@mail.gmail.com>
	<CAFEAcA97eXYPABgaE8Y_+EkWscR7CCH2WUHoM7ttZ6gVWQrqxw@mail.gmail.com>
	<aa6caac1-e06c-9e1c-2aba-18d672fafb55@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 09:36:59 +0100
Message-ID: <CAFEAcA9Ci+0cjFORmzL7-73Jj4pm4jST3iEbXmHjXuPyiyt03g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 22 August 2017 at 04:45, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> On 08/17/2017 07:25 AM, Peter Maydell wrote:
>>
>> On 5 August 2017 at 11:13, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>> So, this question (should we have a board flag to disable reporting
>> of tx failures to the CPU hook, or use unimplemented_device as a
>> sort of background region) seems to be the main unanswered question
>> for this series. I think (as outlined above) that the board flag
>> is simpler and safer; are people happy for me to put this series
>> in target-arm.next with that approach, or should I rethink this bit?
>
> As remarked previously in this thread, the current QEMU behavior on
> transaction error isn't always matching real hardware.
> Matching correctly throwing errors is likely to break various
> current users.

Yes, hence this patchseries keeping the wrong but back compatible
behaviour...

> If we are worried about being backward compatible, defaulting background
> region to unimp() won't throw any transaction error.

As I said, it will, for the cases of device model directly
returning a MEMTX_ERROR, or a transaction dispatched to
a memory region whose MemoryRegionOps valid settings
prohibit it (eg byte accesses to a word-access-only device), etc.
The only simple way to guarantee that we don't generate exceptions
on transaction errors is to cause the hook not to be called
(or to have the hook decide to do nothing, I suppose).

> I'm somehow afraid that "ignore_memory_transaction_failures" ends up like
> the "cannot_instantiate_with_device_add_yet" flag - a hard to remove klud=
ge
> outliving his purpose.

I agree that it's going to be around for a long time, possibly
forever, but that's life when we have so many old boards.
Any approach we take is almost certainly going to be hanging
around forever.

> Anyway I'm not unhappy with this approach, but I'd be very happy to have
> unimp() covering the whole background region.

I think this would be a reasonable approach for converting
boards away from this ignore_memory_transaction_failures hook
on a board-by-board basis but you'd still want to test some
common guest software for each conversion.

thanks
-- PMM
