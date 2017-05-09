Received: from eggs.gnu.org ([2001:4830:134:3::10]:57369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d88KJ-0002vg-0r
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d88KH-0006jx-Qv
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:49:31 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-3-f4bug@amsat.org>
	<2cd1e7a1-7f92-88a2-cf98-0dcea0a2f9b1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f7e86a1d-f53e-5dfa-e8d2-5dd2e860879a@amsat.org>
Date: Tue, 9 May 2017 13:49:18 -0300
MIME-Version: 1.0
In-Reply-To: <2cd1e7a1-7f92-88a2-cf98-0dcea0a2f9b1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 02/11] hw/pci: define msi_nonbroken in
 pci-stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-arm@nongnu.org

Hi Thomas,

On 05/09/2017 02:19 AM, Thomas Huth wrote:
> On 09.05.2017 01:39, Philippe Mathieu-Daudé wrote:
>> This field is accessed in hw/intc/arm_gicv[23*].c
>
> default-configs/arm-softmmu.mak sets CONFIG_PCI, so this should not be
> necessary, I think. Otherwise, you should extend your patch description,
> to elaborate on what you're trying to do here.
>
>  Thomas

Sure, I'm willing to add basic support for the TI Hercules MCU which is 
a big endian SoC (without PCI support).

I'm using the following config:

$ cat default-configs/armeb-softmmu.mak
# Default configuration for armeb-softmmu
CONFIG_ECC=y
CONFIG_SERIAL=y
CONFIG_PTIMER=y
CONFIG_SD=y
CONFIG_SSI=y
#CONFIG_USB=y
CONFIG_PLATFORM_BUS=y
CONFIG_ARM_V7M=y
CONFIG_ARM_GIC=y
CONFIG_ARM_TIMER=y
CONFIG_PL011=y
CONFIG_PL022=y
CONFIG_PL031=y
CONFIG_PL041=y
CONFIG_PL050=y
CONFIG_PL061=y
CONFIG_PL080=y
CONFIG_PL181=y
CONFIG_PL190=y
CONFIG_PL310=y
CONFIG_PL330=y
CONFIG_BITBANG_I2C=y
CONFIG_GPIO_KEY=y
CONFIG_HERCULES=y

I had to modify default-configs/arm-softmmu.mak to restrict a bit 
hw/arm/Makefile.objs, see:

https://github.com/qemu/qemu/compare/master...philmd:armeb_wip

In this branch I run:

$ ../configure --target-list=armeb-softmmu && make -j
[...]
   LINK    armeb-softmmu/qemu-system-armeb
../hw/intc/arm_gicv2m.o: In function `gicv2m_realize':
qemu/hw/intc/arm_gicv2m.c:154: undefined reference to `msi_nonbroken'
../hw/intc/arm_gicv3_its_common.o: In function `gicv3_its_init_mmio':
qemu/hw/intc/arm_gicv3_its_common.c:110: undefined reference to 
`msi_nonbroken'
collect2: error: ld returned 1 exit status
Makefile:201: recipe for target 'qemu-system-armeb' failed
make[1]: *** [qemu-system-armeb] Error 1
Makefile:327: recipe for target 'subdir-armeb-softmmu' failed
make: *** [subdir-armeb-softmmu] Error 2

This MCU does not use a GIC so I can also remove it, but this error 
seems odd to me.

As I understand the 'msi_nonbroken' is a kludge (there is no intrinsic 
relationship between PCI/MSI and this particular interrupt controller).
Since it is declared as extern in "hw/pci/msi.h" why not define it in 
pci-stub?

Regards,

Phil.
