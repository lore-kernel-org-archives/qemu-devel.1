Received: from eggs.gnu.org ([2001:4830:134:3::10]:51189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPXBe-0006eH-By
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPXBd-0006l2-49
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:16:14 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:34582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPXBc-0006kE-Ul
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:16:13 -0500
Received: by mail-ua0-x236.google.com with SMTP id 34so370316094uac.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 08:16:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJCa63pARSvbQKytpAUFpZdACALpT+xaQV4UOEOnavJgg@mail.gmail.com>
References: <20170105225210.GA5235@octofox.metropolis>
	<CAFEAcA-mQPT=pSNTfLqrvuBNX9QYggiMwyoHitV1c5LCVZv-2Q@mail.gmail.com>
	<CAMo8BfJCa63pARSvbQKytpAUFpZdACALpT+xaQV4UOEOnavJgg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 16:15:51 +0000
Message-ID: <CAFEAcA-DEBi1nxwAasCUd3c6kcC6CmEXwRSFg+22N+GJ_YKe=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu-softmmu aborted with "Bad ram pointer"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 6 January 2017 at 15:24, Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Fri, Jan 6, 2017 at 2:23 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 5 January 2017 at 22:52, Max Filippov <jcmvbkbc@gmail.com> wrote:
>>> Hello,
>>>
>>> debugging XIP kernel running directly from CFI FLASH I've got to a point
>>> where QEMU aborts with the message "Bad ram pointer 0xbb4".
>>>
>>> It turns out that that happens when QEMU tries to translate code from FLASH
>>> immediately after the kernel has written to the FLASH address range:
>>> writing to FLASH address range turns off romd_mode of its memory region:
>>
>> This sounds like
>> https://lists.nongnu.org/archive/html/qemu-devel/2016-08/msg03273.html
>
> Right. Strange that I haven't found it...
>
>> It's a bug that we fail with this unhelpful message and abort,
>> but the fix to the bug would only cause us to print the more
>> useful "can't execute from a device" instead. You can't
>> execute from a ROM that's not in ROMD mode, I'm afraid.
>
> Yes, aborting is my main concern.
> Shouldn't we do something like the following?
>
> diff --git a/exec.c b/exec.c
> index 8d4bb0e..d3f1818 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -381,7 +381,8 @@ static MemoryRegionSection
> *phys_page_find(PhysPageEntry lp, hwaddr addr,
>
>  bool memory_region_is_unassigned(MemoryRegion *mr)
>  {
> -    return mr != &io_mem_rom && mr != &io_mem_notdirty && !mr->rom_device
> +    return mr != &io_mem_rom && mr != &io_mem_notdirty
> +        && !(mr->rom_device && mr->romd_mode)
>          && mr != &io_mem_watch;
>  }

I think the problem here is that we're trying to put too
many things into the same get_page_addr_code() condition.
There are two cases here:
 (1) we tried to execute from a memory address where there
     is genuinely no assigned device: we should invoke the
     CPU's do_unassigned_access hook, which will probably
     cause an exception
 (2) we tried to execute from a memory address where there
     is something there, but it's a device (or in this
     case a ROM not in ROMD mode): real hardware would make
     some attempt at executing whatever rubbish the device
     returned, but we will report_bad_exec() and exit.

But we use the same "if (memory_region_is_unassigned())"
conditional for both things. The function name suggests
it checks for case (1) but the actual code is checking
for case (2) (but forgetting rom-not-in-romd), and the
calling code is using it for both (1) and (2) simultaneously...

I think the unassigned-access code is a bit conceptually
broken and in need of a redesign, which is one reason
I've never tried to implement the hook for ARM...

thanks
-- PMM
