Received: from eggs.gnu.org ([2001:4830:134:3::10]:46370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fb7pt-0004p7-Vz
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fb7pq-0000d5-0k
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:14:29 -0400
Received: from steffen-goertz.de ([88.198.119.201]:54414)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fb7pp-0000cb-MC
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:14:25 -0400
References: <20180626093204.27612-1-contrib@steffen-goertz.de>
	<20180627094456.GB4325@stefanha-x1.localdomain>
	<CAFEAcA-j8z4TLN=Qo82JicSQ_=YnJnGjAoLiMOnyfmd1QtQo7w@mail.gmail.com>
	<20180703093113.GF16791@stefanha-x1.localdomain>
	<CAFEAcA-_LjPDWpVPt1mfGA815ur_6i_MjBMtFLqohFCaO0R9Uw@mail.gmail.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <9419467c-62a0-2bbc-1685-7eb9e3f40845@steffen-goertz.de>
Date: Thu, 5 Jul 2018 19:14:23 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-_LjPDWpVPt1mfGA815ur_6i_MjBMtFLqohFCaO0R9Uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>

Hello Peter,

thank you for your very elaborate remarks!
>  [ CPU ] -+- [ NVM, either FICR, UICR or CODE ]
>           |      |
>           \- [ NVMC ]
>=20
> where the CPU can talk to either the NVMC or the NVMs, and the
> NVMC also has a control connection to the NVM. (See the block
> diagram in the nRF51 manual.)
>=20
> The behaviour this allows is:
>=20
>  * the CPU can directly read and execute from the NVMs (which it
>    can see in its address space at 0x00000000, 0x10000000, 0x10001000)
>  * the NVMC controls whether the CPU can write to the NVMs. If the
>    NVMC CONFIG register permits writes then the CPU writes directly
>    to the mapped NVMs, and gets the usual flash-memory behaviour that
>    writes can turn 1s to 0s but not 0s to 1s.
>  * the NVMC also has support for performing erases of either pages
>    or entire NVMs (which writes them to all-1s)
>=20
> My suggestion for the best way to model this is:
>=20
>  * the NVMs are (sysbus) devices which expose a MemoryRegion which
>    they have created with memory_region_init_rom_device().
>    MRs of this sort can be directly read (from a ram block), but
>    writes always go via a MemoryRegionOps write function. This
>    will let us do fast execution and reading, but catch writes so
>    we can make them behave correctly (be forbidden, not allow
>    writing of 0->1, etc).

In the latest revision of my NVMC model i included the FICR/UICR as
sysbus devices which expose a memory region using
memory_region_init_device. I can change this using init_rom_device for
performance. Furthermore i will add the CODE device.

I would like to provide all four devices (NVMC, CODE, FICR, UICR) from
one module and rename nrf51_nvmc.[ch] to nrf51_nvm.[ch]. Is this
acceptable or would you rather prefer three modules?

>  * the NVMs should implement a QOM interface that defines
>    how we model the "control connection" from the NVMC --
>    basically this will have some methods for "erase all",
>    "erase this page", and "set the writes permitted flag".
>  * the NVMC should have QOM link properties for its NVMCs, and
>    the SoC code sets those link properties to pointers to the
>    NVMCs
>  * the NVMC implements an ordinary IO MemoryRegion for its
>    register interface; guest writes to the registers may cause
>    it to tell the NVMs what to do by calling methods on the
>    NVMs (which it has pointers to via the link properties)
>  * the SoC code maps the NVMs and the NVMC's registers into
>    the right places in its address space

Thank you for these remarks, i will follow them.

Steffen
