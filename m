Received: from eggs.gnu.org ([2001:4830:134:3::10]:37874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddw5J-0006ls-1V
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 06:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddw5H-00018F-UO
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 06:13:29 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ddw5H-00016Z-Nc
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 06:13:27 -0400
Received: by mail-wm0-x22d.google.com with SMTP id t201so36067919wmt.0
	for <qemu-devel@nongnu.org>; Sat, 05 Aug 2017 03:13:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c38728a0-da49-635e-2954-1030b223e3c9@linaro.org>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-5-git-send-email-peter.maydell@linaro.org>
	<50d6ba4d-cfa3-5b5f-5da1-dca2326d4f5d@amsat.org>
	<c38728a0-da49-635e-2954-1030b223e3c9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Aug 2017 11:13:04 +0100
Message-ID: <CAFEAcA_nPya92Vatwt7RiZnhKTH4_GKypSrX_KgPj3GitxV0Tg@mail.gmail.com>
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

On 4 August 2017 at 20:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 08/04/2017 11:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since create_unimplemented_device() register overlapped with low priorit=
y, why
>> not register it as default device directly, over the whole address space=
?
>
> That's a good suggestion.  It makes more sense to me than adding a flag o=
n the
> MachineClass.

Yeah, I did think about implementing it that way, but...

That wouldn't handle the case of a device model directly
returning a MEMTX_ERROR, or a transaction dispatched to
a memory region whose MemoryRegionOps valid settings
prohibit it (eg byte accesses to a word-access-only device),
or accesses to a MemoryRegion that was created by passing
a NULL MemoryRegionOps pointer to memory_region_init_io
(I dunno why you'd do that but some code does).

In short, there are lots of ways the memory subsystem might
end up returning a transaction error -- this mechanism
ensures that none of them start generating exceptions
when they previously did not, and is (I hope) easy to
review in the sense of being sure that it does what it
intends to do without the need to audit a lot of corner
cases.

thanks
-- PMM
