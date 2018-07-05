Received: from eggs.gnu.org ([2001:4830:134:3::10]:35878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb7ED-00007Z-4v
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb7EC-00063d-4N
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:35:33 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb7EB-00062m-S1
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:35:32 -0400
Received: by mail-oi0-x241.google.com with SMTP id w126-v6so18047354oie.7
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:35:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703093113.GF16791@stefanha-x1.localdomain>
References: <20180626093204.27612-1-contrib@steffen-goertz.de>
	<20180627094456.GB4325@stefanha-x1.localdomain>
	<CAFEAcA-j8z4TLN=Qo82JicSQ_=YnJnGjAoLiMOnyfmd1QtQo7w@mail.gmail.com>
	<20180703093113.GF16791@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 17:35:09 +0100
Message-ID: <CAFEAcA-_LjPDWpVPt1mfGA815ur_6i_MjBMtFLqohFCaO0R9Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2] arm: Add NRF51 SOC non-volatile memory
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>

On 3 July 2018 at 10:31, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Jul 02, 2018 at 01:18:35PM +0100, Peter Maydell wrote:
>> It's not clear to me what this device is doing with its
>> AddressSpace, though; comments that went into more detail
>> about what the device is and what the "memory" property is
>> for might help.
>
> I understand this issue now.  It's the same as qtest.
>
> This device is only visible from cpu->as, it's not visible from
> address_space_memory (system_memory).
>
> The NVMC needs access to the SoC's flash memory region, and that's what
> mr/as achieve here.  I agree that comments explaining the purpose of
> mr/as would be useful.

I've fished out a copy of the NRF51 datasheet, which helps.
Roughly, what we have is:

 [ CPU ] -+- [ NVM, either FICR, UICR or CODE ]
          |      |
          \- [ NVMC ]

where the CPU can talk to either the NVMC or the NVMs, and the
NVMC also has a control connection to the NVM. (See the block
diagram in the nRF51 manual.)

The behaviour this allows is:

 * the CPU can directly read and execute from the NVMs (which it
   can see in its address space at 0x00000000, 0x10000000, 0x10001000)
 * the NVMC controls whether the CPU can write to the NVMs. If the
   NVMC CONFIG register permits writes then the CPU writes directly
   to the mapped NVMs, and gets the usual flash-memory behaviour that
   writes can turn 1s to 0s but not 0s to 1s.
 * the NVMC also has support for performing erases of either pages
   or entire NVMs (which writes them to all-1s)

My suggestion for the best way to model this is:

 * the NVMs are (sysbus) devices which expose a MemoryRegion which
   they have created with memory_region_init_rom_device().
   MRs of this sort can be directly read (from a ram block), but
   writes always go via a MemoryRegionOps write function. This
   will let us do fast execution and reading, but catch writes so
   we can make them behave correctly (be forbidden, not allow
   writing of 0->1, etc).
 * the NVMs should implement a QOM interface that defines
   how we model the "control connection" from the NVMC --
   basically this will have some methods for "erase all",
   "erase this page", and "set the writes permitted flag".
 * the NVMC should have QOM link properties for its NVMCs, and
   the SoC code sets those link properties to pointers to the
   NVMCs
 * the NVMC implements an ordinary IO MemoryRegion for its
   register interface; guest writes to the registers may cause
   it to tell the NVMs what to do by calling methods on the
   NVMs (which it has pointers to via the link properties)
 * the SoC code maps the NVMs and the NVMC's registers into
   the right places in its address space

There's nothing here that requires extra functionality from
core QEMU code, but on the other hand it is quite complicated,
so you might prefer to start by modelling the NVMs as plain
ROM MRs (ie never-writable) and the NVMC as a register interface
which just complains (LOG_UNIMP) if the guest tries to enable
writes or erases, plus a comment giving a sketch of the
design changes needed to add write/erase support later.
(I would prefer that to the code in this patch which implements
erases by writing to a single passed-in memory region which
covers the whole address space.)

thanks
-- PMM
