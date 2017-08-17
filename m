Received: from eggs.gnu.org ([2001:4830:134:3::10]:33780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1diHzz-0006SX-Id
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1diHzy-0005GA-Pa
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:25:59 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:37105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1diHzy-0005Fn-In
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:25:58 -0400
Received: by mail-wr0-x22a.google.com with SMTP id z91so30201846wrc.4
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 03:25:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_nPya92Vatwt7RiZnhKTH4_GKypSrX_KgPj3GitxV0Tg@mail.gmail.com>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-5-git-send-email-peter.maydell@linaro.org>
	<50d6ba4d-cfa3-5b5f-5da1-dca2326d4f5d@amsat.org>
	<c38728a0-da49-635e-2954-1030b223e3c9@linaro.org>
	<CAFEAcA_nPya92Vatwt7RiZnhKTH4_GKypSrX_KgPj3GitxV0Tg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Aug 2017 11:25:36 +0100
Message-ID: <CAFEAcA97eXYPABgaE8Y_+EkWscR7CCH2WUHoM7ttZ6gVWQrqxw@mail.gmail.com>
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 5 August 2017 at 11:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 4 August 2017 at 20:23, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 08/04/2017 11:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Since create_unimplemented_device() register overlapped with low priori=
ty, why
>>> not register it as default device directly, over the whole address spac=
e?
>>
>> That's a good suggestion.  It makes more sense to me than adding a flag =
on the
>> MachineClass.
>
> Yeah, I did think about implementing it that way, but...
>
> That wouldn't handle the case of a device model directly
> returning a MEMTX_ERROR, or a transaction dispatched to
> a memory region whose MemoryRegionOps valid settings
> prohibit it (eg byte accesses to a word-access-only device),
> or accesses to a MemoryRegion that was created by passing
> a NULL MemoryRegionOps pointer to memory_region_init_io
> (I dunno why you'd do that but some code does).
>
> In short, there are lots of ways the memory subsystem might
> end up returning a transaction error -- this mechanism
> ensures that none of them start generating exceptions
> when they previously did not, and is (I hope) easy to
> review in the sense of being sure that it does what it
> intends to do without the need to audit a lot of corner
> cases.

So, this question (should we have a board flag to disable reporting
of tx failures to the CPU hook, or use unimplemented_device as a
sort of background region) seems to be the main unanswered question
for this series. I think (as outlined above) that the board flag
is simpler and safer; are people happy for me to put this series
in target-arm.next with that approach, or should I rethink this bit?

thanks
-- PMM
