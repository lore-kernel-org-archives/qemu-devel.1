Received: from eggs.gnu.org ([2001:4830:134:3::10]:41765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYfNY-0003ba-8W
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYfNU-0004h2-VP
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:27:04 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fYfNU-0004bh-KA
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:27:00 -0400
References: <20180626165658.31394-1-peter.maydell@linaro.org>
	<20180626165658.31394-24-peter.maydell@linaro.org>
	<50e46f22-1e3d-10ce-5b5b-a10af49a95f1@vivier.eu>
	<CAFEAcA8141WC556H1fZLM4AEaz62o4qb7JOOVB-+75N9vugi+g@mail.gmail.com>
	<a46a8b06-c780-0c22-b9f7-8eaae73dd26d@vivier.eu>
	<CAFEAcA8gKWG9O7rjhC1+n_Bqce+CGQvUEiM+mc7wu-1C7no2ug@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <489d8470-c12f-a441-4e87-b2b3013a3ab8@vivier.eu>
Date: Fri, 29 Jun 2018 00:26:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8gKWG9O7rjhC1+n_Bqce+CGQvUEiM+mc7wu-1C7no2ug@mail.gmail.com>
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

Le 28/06/2018 à 22:05, Peter Maydell a écrit :
> On 28 June 2018 at 20:23, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 28/06/2018 à 15:23, Peter Maydell a écrit :
>>> On 28 June 2018 at 14:03, Laurent Vivier <laurent@vivier.eu> wrote:
>>>> Le 26/06/2018 à 18:56, Peter Maydell a écrit :
>>>>> Add support for MMU protection regions that are smaller than
>>>>> TARGET_PAGE_SIZE. We do this by marking the TLB entry for those
>>>>> pages with a flag TLB_RECHECK. This flag causes us to always
>>>>> take the slow-path for accesses. In the slow path we can then
>>>>> special case them to always call tlb_fill() again, so we have
>>>>> the correct information for the exact address being accessed.
>>>>>
>>>>> This change allows us to handle reading and writing from small
>>>>> regions; we cannot deal with execution from the small region.
>>>>>
>>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>>> Message-id: 20180620130619.11362-2-peter.maydell@linaro.org
>>>>> ---
>>>>>  accel/tcg/softmmu_template.h |  24 ++++---
>>>>>  include/exec/cpu-all.h       |   5 +-
>>>>>  accel/tcg/cputlb.c           | 131 +++++++++++++++++++++++++++++------
>>>>>  3 files changed, 130 insertions(+), 30 deletions(-)
>>>>
>>>> This patch breaks Quadra 800 emulation, any idea why?
>>>>
>>>> ABCFGHIJK
>>>> qemu: fatal: Unable to handle guest executing from RAM within a small
>>>> MPU region at 0x0014cb5a
>>>
>>> Hmm, that shouldn't happen unless your target code was
>>> incorrectly returning a too-small page size. (I say
>>> "incorrectly" because before this patchseries that was
>>> unsupported and would have had weird effects depending on
>>> exactly what the order of guest accesses to the page was.)
>>>
>>> You could look at whether the m68k code is calling tlb_set_page()
>>> with a wrong page_size value and why that happens. You can
>>> get back the old behaviour by having your code do
>>>    if (page_size < TARGET_PAGE_SIZE) {
>>>        page_size = TARGET_PAGE_SIZE;
>>>    }
>>>
>>> but that is definitely a bit of a hack.
>>
>> Thank you to have had a look at this.
>>
>> I've added traces and tlb_set_page() is always called with page_size ==
>> TARGET_PAGE_SIZE.
>>
>> m68k linux kernel always use 4 kB page that is the value of
>> TARGET_PAGE_SIZE.
>> 68040 MMU can also use 8 kB page, but in our case it doesn't (and of
>> course 8 kB > TARGET_PAGE_SIZE).
> 
>> I'm not aware of subpage in m68k MMU. but we have TLB entries that are
>> separated between code and data: does it change something in your code?
>> Accessing an address as a data access and then as an instruction access
>> could appear like a TLB_RECHECK?
> 
> If you never pass a page_size < TARGET_PAGE_SIZE to
> tlb_set_page() then we should never mark anything as TLB_RECHECK:
> the theory was no behaviour change for the currently-being-used case.
> 
> Do you have a repro case (images, command line) that I can
> use to investigate ?
- checkout the branch q800-dev-part1 from
  git://github.com/vivier/qemu-m68k.git

- configure and build

 './configure' '--target-list=m68k-softmmu' '--enable-debug' \
               '--enable-debug-tcg' '--enable-debug-info'

  my gcc is from Fedora 27, version 7.3.1 20180303 (Red Hat 7.3.1-5)

- get the kernel from the debian installer:

wget
https://cdimage.debian.org/mirror/cdimage/ports/9.0/m68k/iso-cd/debian-9.0-m68k-NETINST-1.iso

guestfish --add debian-9.0-m68k-NETINST-1.iso --ro \
          --mount /dev/sda:/ <<_EOF_
copy-out /install/kernels/vmlinux-4.15.0-2-m68k .
_EOF_

- and run

./m68k-softmmu/qemu-system-m68k -M q800 \
    -serial none -serial mon:stdio \
    -kernel vmlinux-4.15.0-2-m68k \
    -nographic

ABCFGHIJK
qemu: fatal: Unable to handle guest executing from RAM within a small
MPU region at 0x0029bb2c
D0 = 003ca111   A0 = 003ca111   F0 = 7fff ffffffffffffffff  (         nan)
D1 = 00000000   A1 = 0000000a   F1 = 7fff ffffffffffffffff  (         nan)
D2 = 00000000   A2 = 00395314   F2 = 7fff ffffffffffffffff  (         nan)
D3 = 00000001   A3 = 003ca110   F3 = 7fff ffffffffffffffff  (         nan)
D4 = 000003e0   A4 = 003ca4e8   F4 = 7fff ffffffffffffffff  (         nan)
D5 = 00393fc8   A5 = 0033d77b   F5 = 7fff ffffffffffffffff  (         nan)
D6 = 003ca108   A6 = 00393fc4   F6 = 7fff ffffffffffffffff  (         nan)
D7 = 00000002   A7 = 00393ef8   F7 = 7fff ffffffffffffffff  (         nan)
PC = 0029bb2c   SR = 2700 T:0 I:7 SI -----
FPSR = 00000000 ---- -------- -----  FPCR = 0000 X RN --------
  A7(MSP) = 00000000   A7(USP) = 00000000 ->A7(ISP) = 00393f68
VBR = 0x003bfce8
SFC = 5 DFC 5
SSW 00000000 TCR 00008000 URP 00000000 SRP 00001000
DTTR0/1: 00000000/f807a040 ITTR0/1: 00000000/f807a040
MMUSR 00000000, fault at 00000000
Aborted (core dumped)

Thanks,
Laurent
