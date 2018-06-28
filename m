Received: from eggs.gnu.org ([2001:4830:134:3::10]:57922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYcWS-0001Kp-6j
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYcWP-0001ES-0h
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:24:04 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fYcWO-0001Ax-Ll
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:24:00 -0400
References: <20180626165658.31394-1-peter.maydell@linaro.org>
	<20180626165658.31394-24-peter.maydell@linaro.org>
	<50e46f22-1e3d-10ce-5b5b-a10af49a95f1@vivier.eu>
	<CAFEAcA8141WC556H1fZLM4AEaz62o4qb7JOOVB-+75N9vugi+g@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a46a8b06-c780-0c22-b9f7-8eaae73dd26d@vivier.eu>
Date: Thu, 28 Jun 2018 21:23:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8141WC556H1fZLM4AEaz62o4qb7JOOVB-+75N9vugi+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 23/32] tcg: Support MMU protection regions
 smaller than TARGET_PAGE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Le 28/06/2018 à 15:23, Peter Maydell a écrit :
> On 28 June 2018 at 14:03, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 26/06/2018 à 18:56, Peter Maydell a écrit :
>>> Add support for MMU protection regions that are smaller than
>>> TARGET_PAGE_SIZE. We do this by marking the TLB entry for those
>>> pages with a flag TLB_RECHECK. This flag causes us to always
>>> take the slow-path for accesses. In the slow path we can then
>>> special case them to always call tlb_fill() again, so we have
>>> the correct information for the exact address being accessed.
>>>
>>> This change allows us to handle reading and writing from small
>>> regions; we cannot deal with execution from the small region.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Message-id: 20180620130619.11362-2-peter.maydell@linaro.org
>>> ---
>>>  accel/tcg/softmmu_template.h |  24 ++++---
>>>  include/exec/cpu-all.h       |   5 +-
>>>  accel/tcg/cputlb.c           | 131 +++++++++++++++++++++++++++++------
>>>  3 files changed, 130 insertions(+), 30 deletions(-)
>>
>> This patch breaks Quadra 800 emulation, any idea why?
>>
>> ABCFGHIJK
>> qemu: fatal: Unable to handle guest executing from RAM within a small
>> MPU region at 0x0014cb5a
> 
> Hmm, that shouldn't happen unless your target code was
> incorrectly returning a too-small page size. (I say
> "incorrectly" because before this patchseries that was
> unsupported and would have had weird effects depending on
> exactly what the order of guest accesses to the page was.)
> 
> You could look at whether the m68k code is calling tlb_set_page()
> with a wrong page_size value and why that happens. You can
> get back the old behaviour by having your code do
>    if (page_size < TARGET_PAGE_SIZE) {
>        page_size = TARGET_PAGE_SIZE;
>    }
> 
> but that is definitely a bit of a hack.

Thank you to have had a look at this.

I've added traces and tlb_set_page() is always called with page_size ==
TARGET_PAGE_SIZE.

m68k linux kernel always use 4 kB page that is the value of
TARGET_PAGE_SIZE.
68040 MMU can also use 8 kB page, but in our case it doesn't (and of
course 8 kB > TARGET_PAGE_SIZE).

> Does the m68k MMU let you specify permissions and mappings
> for sub-page sizes ?

I'm not aware of subpage in m68k MMU. but we have TLB entries that are
separated between code and data: does it change something in your code?
Accessing an address as a data access and then as an instruction access
could appear like a TLB_RECHECK?

> I do notice an oddity:
> in m68k_cpu_handle_mmu_fault() we call get_physical_address()
> but then ignore the page_size it returns when we call tlb_set_page()
> and instead use TARGET_PAGE_SIZE. But in the ptest helper function
> we use the page_size from get_physical_address() directly.
> Are these bits of code deliberately different?

I remember I had problem to make this to work. But I think  you're
right, it should be page_size everywhere. But I guess it's not the cause
of my problem (I tried :) )...

> In fact it's not clear to me at all that PTEST should be
> updating the QEMU TLB: it only needs to update the MMU
> status registers. (The 68030 manual I have says that in
> hardware PTEST doesn't update the ATC, which is the h/w
> equivalent to doing a TLB update.)

In QEMU, we emulate for the moment the 68040 MMU, and PTEST for 68040 is
not defined as the one for 68030.

For 68040, we have:

"A matching entry in the address translation cache (data or instruction)
specified by the function code will be flushed by PTEST. Completion of
PTEST results in the creation of a new address translation cache entry"

Thanks,
Laurent
