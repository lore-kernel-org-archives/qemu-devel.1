Received: from eggs.gnu.org ([2001:4830:134:3::10]:56440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1erOxv-00067a-9K
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1erOxu-00077p-9z
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:13:47 -0500
References: <1519883168-22092-1-git-send-email-thuth@redhat.com>
	<CAFEAcA9Q9+sK5S1BREuCAVp4J5tU_mexDZU9nBuett3W7bQp-Q@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8459fa75-826e-b42b-a002-e45b309d9e4b@redhat.com>
Date: Thu, 1 Mar 2018 15:13:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Q9+sK5S1BREuCAVp4J5tU_mexDZU9nBuett3W7bQp-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Use more CONFIG switches to decide
 which object files should be linked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 01.03.2018 14:03, Peter Maydell wrote:
> On 1 March 2018 at 05:46, Thomas Huth <thuth@redhat.com> wrote:
>> A lot of ARM object files are linked into the executable unconditional=
ly,
>> even though we have corresponding CONFIG switches like CONFIG_PXA2XX o=
r
>> CONFIG_OMAP. We should make sure to use these switches in the Makefile=
 so
>> that the users can disable certain unwanted boards and devices more ea=
sily.
>> Also introduce the new switch CONFIG_STRONGARM to be able to disable t=
he
>> "Collie" machine if it is not wanted.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  default-configs/arm-softmmu.mak |  2 ++
>>  hw/arm/Makefile.objs            | 26 +++++++++++++++++---------
>>  2 files changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-sof=
tmmu.mak
>> index ca34cf4..43f382a 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -133,3 +133,5 @@ CONFIG_GPIO_KEY=3Dy
>>  CONFIG_MSF2=3Dy
>>  CONFIG_FW_CFG_DMA=3Dy
>>  CONFIG_XILINX_AXI=3Dy
>> +
>> +CONFIG_STRONGARM=3Dy
>> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
>> index 1c896ba..5e1e0a9 100644
>> --- a/hw/arm/Makefile.objs
>> +++ b/hw/arm/Makefile.objs
>> @@ -1,15 +1,23 @@
>> -obj-y +=3D boot.o collie.o exynos4_boards.o gumstix.o highbank.o
>> -obj-$(CONFIG_DIGIC) +=3D digic_boards.o
>> -obj-y +=3D integratorcp.o mainstone.o musicpal.o nseries.o
>> -obj-y +=3D omap_sx1.o palm.o realview.o spitz.o stellaris.o
>> -obj-y +=3D tosa.o versatilepb.o vexpress.o virt.o xilinx_zynq.o z2.o
>> +obj-y +=3D boot.o virt.o sysbus-fdt.o
>>  obj-$(CONFIG_ACPI) +=3D virt-acpi-build.o
>> -obj-y +=3D netduino2.o
>> -obj-y +=3D sysbus-fdt.o
>> +obj-$(CONFIG_ARM_V7M) +=3D highbank.o netduino2.o vexpress.o
>=20
> This is definitely wrong -- highbank and vexpress are not V7M
> platforms.

Ooops, sorry, seems like I mixed up V7M with v7-A :-(

> Netduino2 is a v7M platform, but I don't think we
> should be making it conditional on ARM_V7M -- we have per-board
> configs for other boards, so you'd have a CONFIG_NETDUINO2 here
> if you wanted it.

OK, I think I'll simply introduce proper config switches for all three
boards.

>> +obj-$(CONFIG_ASPEED_SOC) +=3D integratorcp.o musicpal.o versatilepb.o
>=20
> This is wrong too -- none of these are aspeed-based devices.

*facepalm* ... looks like I grep'ed that wrong (I was searching for
"arm926" IIRC) ... I'll add proper config switches for those boards, too.

 Thomas
