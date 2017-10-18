Received: from eggs.gnu.org ([2001:4830:134:3::10]:34946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e4qvL-0002Vh-CG
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e4qvH-0008O2-AO
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:10:27 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:51994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e4qvH-0008Lp-12
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:10:23 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 599FAB78BD
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 18:10:21 +0200 (CEST)
References: <20171013142852.916-1-clg@kaod.org>
	<20171013142852.916-2-clg@kaod.org>
	<CAFEAcA-gYYbQu-Nuds3E0Aw7j0OdD5_ySm=EdMb1_FzxEoMTBQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8ded3a0e-f7da-00cd-3abd-7d4bb22a5016@kaod.org>
Date: Wed, 18 Oct 2017 18:10:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-gYYbQu-Nuds3E0Aw7j0OdD5_ySm=EdMb1_FzxEoMTBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/6] aspeed: add support for the
 witherspoon-bmc board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/17/2017 05:39 PM, Peter Maydell wrote:
> On 13 October 2017 at 15:28, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>> The Witherspoon boards are OpenPOWER system hosting POWER9 Processors.
>> Let's add support for their BMC including a couple of I2C devices as
>> found on real HW.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>> ---
>>
>>  Changes since v2:
>>
>>  - removed 'ignore_memory_transaction_failures' flag on the machine.
>>    Will require a couple of fixes in the legacy U-Boot accessing wrong=
ly
>>    the bss before the DRAM is initialized.
>>
>>    The HW drops the write access surely because the SMC controller is
>>    configured in autoread mode by default. I don't know how to model
>>    this behavior in QEMU. I think we would need suppport to boot from
>>    a MMIO region.
>=20
> It is actually possible now -- see hw/ssi/xilinx_spips.c and the
> request_mmio_ptr code. It's a bit experimental at the moment
> though (in particular it breaks migration, a thing which we
> seem to have forgotten to fix for this release cycle :-( )

I see. So the Aspeed SMC model would have to maintain a cache area=20
of the flash device contents to satisfy the request_ptr() call ?  =20

> The other similar thing we have is the flash devices, which
> allow execution, but requires that the guest doesn't try to
> execute at the same time as it's put the flash into
> reads-like-a-device mode.
>=20
> How are you modelling this bit of the address space at the moment?

The different flash devices are mapped on the AHB bus in ranges=20
depending on the controller (and the SoC). For the AST2500, which=20
is the witherspoon SoC, we have :

  [2000:0000-2FFF:FFFF]  BMC SPI Flash Memory
  [3000:0000-37FF:FFFF]  SPI1 Flash Memory
  [3800:0000-3FFF:FFFF]  SPI2 Flash Memory

The SoC boots from CS0 of the BMC SPI Controller which is also=20
mapped at :

  [0000:0000-0FFF:FFFF]  Firmware SPI Memory (boot-up default)

Today, we  have created a ROM region which is filled with the=20
CS0 flash content. See commit d769a1da342d ("aspeed: use first=20
FMC flash as a boot ROM")

So we end up with address-space memory like this :

    0000000000000000-ffffffffffffffff (prio 0, i/o): system
      0000000000000000-0000000007ffffff (prio 0, rom): aspeed.boot_rom
      ...
      0000000020000000-000000002fffffff (prio 0, i/o): aspeed.smc.ast2500=
-fmc.flash
        0000000020000000-0000000027ffffff (prio 0, i/o): aspeed.smc.ast25=
00-fmc.0
        0000000028000000-0000000029ffffff (prio 0, i/o): aspeed.smc.ast25=
00-fmc.1
        000000002a000000-000000002bffffff (prio 0, i/o): aspeed.smc.ast25=
00-fmc.2
      0000000030000000-0000000037ffffff (prio 0, i/o): aspeed.smc.ast2500=
-spi1.flash
      ...  =20
 =20
This is a bit brutal, but it boots from the flash device. Booting=20
from the MMIO region would be much better. I will take a look at it,=20
but after some PPC work.=20

> A "reads like RAM but writes are ignored" lump of memory is easy...

yes. It seems but I haven't found my way through :/ a stack trace
of the failure looks like this :

#0  0x00005555558c1680 in arm_cpu_do_transaction_failed (cs=3D0x5555568cf=
c00, physaddr=3D537117152, addr=3D209376, size=3D4, access_type=3DMMU_DAT=
A_STORE, mmu_idx=3D3, attrs=3D..., response=3D2, retaddr=3D14073705442536=
7)
    at target/arm/op_helper.c:241
#1  0x00005555557e36c6 in cpu_transaction_failed (retaddr=3D1407370544253=
67, response=3D2, attrs=3D..., mmu_idx=3D3, access_type=3DMMU_DATA_STORE,=
 size=3D4, addr=3D209376, physaddr=3D537117152, cpu=3D0x5555568cfc00)
    at include/qom/cpu.h:895
#2  0x00005555557e36c6 in io_writex (env=3Denv@entry=3D0x5555568d7e90, io=
tlbentry=3D<optimized out>, mmu_idx=3Dmmu_idx@entry=3D3, val=3Dval@entry=3D=
4294967, addr=3Daddr@entry=3D209376, retaddr=3Dretaddr@entry=3D1407370544=
25367, size=3D4) at accel/tcg/cputlb.c:825
#3  0x00005555557e73ef in io_writel (retaddr=3D140737054425367, addr=3D20=
9376, val=3D4294967, index=3D204, mmu_idx=3D3, env=3D0x5555568d7e90) at a=
ccel/tcg/softmmu_template.h:265
#4  0x00005555557e73ef in helper_le_stl_mmu (env=3D0x5555568d7e90, addr=3D=
<optimized out>, val=3D4294967, oi=3D35, retaddr=3D140737054425367) at ac=
cel/tcg/softmmu_template.h:300
#5  0x00007fffe622c117 in code_gen_buffer ()
#6  0x00005555557eef8c in cpu_tb_exec (itb=3D<optimized out>, itb=3D<opti=
mized out>, cpu=3D0x5555568d7e90)


> In any case we can deal with this as a later patchset.

Well, I would prefer fixing that little issue above with a workaround
region.=20

Thanks,

C.=20
