Received: from eggs.gnu.org ([2001:4830:134:3::10]:39844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dkykA-0007c6-SS
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 16:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dkyk6-0002An-4f
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 16:28:46 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:33742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dkyk5-0002AG-TK
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 16:28:42 -0400
Received: by mail-pg0-x230.google.com with SMTP id t3so3139800pgt.0
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 13:28:40 -0700 (PDT)
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-5-git-send-email-peter.maydell@linaro.org>
	<50d6ba4d-cfa3-5b5f-5da1-dca2326d4f5d@amsat.org>
	<c38728a0-da49-635e-2954-1030b223e3c9@linaro.org>
	<CAFEAcA_nPya92Vatwt7RiZnhKTH4_GKypSrX_KgPj3GitxV0Tg@mail.gmail.com>
	<CAFEAcA97eXYPABgaE8Y_+EkWscR7CCH2WUHoM7ttZ6gVWQrqxw@mail.gmail.com>
	<aa6caac1-e06c-9e1c-2aba-18d672fafb55@amsat.org>
	<CAFEAcA9Ci+0cjFORmzL7-73Jj4pm4jST3iEbXmHjXuPyiyt03g@mail.gmail.com>
	<CAFEAcA_rSqsrfd_qJijtPFRe1qKEA=JiyHE+3J5atAgxAX8NBg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c31cb6e9-8b50-3b4a-ab1a-27632d516c9f@linaro.org>
Date: Thu, 24 Aug 2017 13:28:33 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rSqsrfd_qJijtPFRe1qKEA=JiyHE+3J5atAgxAX8NBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 22 August 2017 at 09:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 August 2017 at 04:45, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> If we are worried about being backward compatible, defaulting background
>> region to unimp() won't throw any transaction error.
>
> As I said, it will, for the cases of device model directly
> returning a MEMTX_ERROR, or a transaction dispatched to
> a memory region whose MemoryRegionOps valid settings
> prohibit it (eg byte accesses to a word-access-only device), etc.
> The only simple way to guarantee that we don't generate exceptions
> on transaction errors is to cause the hook not to be called
> (or to have the hook decide to do nothing, I suppose).
>
>> I'm somehow afraid that "ignore_memory_transaction_failures" ends up like
>> the "cannot_instantiate_with_device_add_yet" flag - a hard to remove kludge
>> outliving his purpose.
>
> I agree that it's going to be around for a long time, possibly
> forever, but that's life when we have so many old boards.
> Any approach we take is almost certainly going to be hanging
> around forever.
>
>> Anyway I'm not unhappy with this approach, but I'd be very happy to have
>> unimp() covering the whole background region.
>
> I think this would be a reasonable approach for converting
> boards away from this ignore_memory_transaction_failures hook
> on a board-by-board basis but you'd still want to test some
> common guest software for each conversion.

Peter and I had a chat on IRC about this.

While I think the background region idea is tempting, it does nothing to help
legacy boards once devices start signaling their own errors.  Therefore some
sort of flag is the only reasonable solution.


r~
