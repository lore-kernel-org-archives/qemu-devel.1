Received: from eggs.gnu.org ([2001:4830:134:3::10]:60135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egvnT-0002pC-8x
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egvnO-0004JD-P6
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:03:43 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11f684c4-9159-0e4e-5990-635194b32d65@amsat.org>
Date: Wed, 31 Jan 2018 14:03:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/14] Initial i.MX7 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

Hi Peter, Andrey.

On 01/15/2018 10:36 PM, Andrey Smirnov wrote:
> Hi everyone,
> 
> This v4 of the patch series containing the work that I've done in
> order to enable support for i.MX7 emulation in QEMU.
> 
> *NOTE*: Patches 1 and 2 are provided for the sake of completness and
> 	are going to have to be adapted once Philippe's SD changes
> 	land in master. As such, they are NOT ready to be
> 	accepted/merged.

Peter:
Since my series are taking longer, if this series is ready it is
probably easier to apply Andrey series first and I'll adapt my SDHCI
series after.

Andrey:
I only plan to keep the sdhci.c file generic (dealing with quirks) and
split out the imx usdhci code, similar to this patch:
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg01265.html

> 
> As the one before last commit in the series states the supported i.MX7
> features are:
> 
>     * up to 2 Cortex A9 cores (SMP works with PSCI)
>     * A7 MPCORE (identical to A15 MPCORE)
>     * 4 GPTs modules
>     * 7 GPIO controllers
>     * 2 IOMUXC controllers
>     * 1 CCM module
>     * 1 SVNS module
>     * 1 SRC module
>     * 1 GPCv2 controller
>     * 4 eCSPI controllers
>     * 4 I2C controllers
>     * 7 i.MX UART controllers
>     * 2 FlexCAN controllers
>     * 2 Ethernet controllers (FEC)
>     * 3 SD controllers (USDHC)
>     * 4 WDT modules
>     * 1 SDMA module
>     * 1 GPR module
>     * 2 USBMISC modules
>     * 2 ADC modules
>     * 1 PCIe controller
>     * 3 USB controllers
>     * 1 LCD controller
>     * 1 ARMv7 DAP IP block
> 
> Feedback is welcome!
> 
> Changes since [v3]:
> 
>     - Changes to FEC were split into a separate set and merged to master
> 
>     - Patchest is rebased on latest master
> 
>     - Converted to use PSCI DT fixup code that is shared with virt
>       platform (now relocated to live in arm/boot.c)
> 
>     - Large number of dummy block were converted to use
>       create_unimplemented_device() as opposed to its own dedicated
>       type
> 
>     - Incorporated varios small feedback items
> 
>     - Collected Reviewed-by tags from Peter
> 
> Changes since [v2]:
> 
>     - Added stubs for more blocks that were causing memory
>       transactions when booting Linux guest as were revealed by
>       additional testing of the patchest
> 
>     - Added proper USB emulation code, so now it should be possible to
>       emulated guest's USB bus
> 
> Changes since [v1]:
> 
>     - Patchset no longer relies on "ignore_memory_transaction_failures = false"
>       for its functionality
> 
>     - As a consequnce of implementing the above a number of patches
>       implementing dummy IP block emulation as well as PCIe emulation
>       patches that I alluded to in [v1] are now included in this patch
>       series
> 
>     - "has_el3" property is no longer being set to "false" as a part
>       of intialization of A7 CPU. I couldn't reproduce the issues that
>       I thought I was having, so I just dropped that code.
> 
>     - A number of smaller feedback items from Peter and other has been
>       incorporated into the patches.
> 
> 
> Thanks,
> Andrey Smirnov
> 
> [v3] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04236.html
> [v2] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg05516.html
> [v1] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04770.html
> 
> Andrey Smirnov (14):
>   sdhci: Add i.MX specific subtype of SDHCI
>   hw: i.MX: Convert i.MX6 to use TYPE_IMX_USDHC
>   i.MX: Add code to emulate i.MX7 CCM, PMU and ANALOG IP blocks
>   i.MX: Add code to emulate i.MX2 watchdog IP block
>   i.MX: Add code to emulate i.MX7 SNVS IP-block
>   i.MX: Add code to emulate GPCv2 IP block
>   i.MX: Add i.MX7 GPT variant
>   i.MX: Add implementation of i.MX7 GPR IP block
>   pci: Add support for Designware IP block
>   usb: Add basic code to emulate Chipidea USB IP
>   ARM: Add basic code to emulate A7MPCore DAP block
>   i.MX: Add i.MX7 SOC implementation.
>   hw/arm: Move virt's PSCI DT fixup code to arm/boot.c
>   Implement support for i.MX7 Sabre board
> 
>  default-configs/arm-softmmu.mak  |   3 +
>  hw/arm/Makefile.objs             |   5 +-
>  hw/arm/boot.c                    |  65 ++++
>  hw/arm/coresight.c               | 120 ++++++++
>  hw/arm/fsl-imx6.c                |   2 +-
>  hw/arm/fsl-imx7.c                | 583 ++++++++++++++++++++++++++++++++++++
>  hw/arm/mcimx7d-sabre.c           |  90 ++++++
>  hw/arm/virt.c                    |  61 ----
>  hw/intc/Makefile.objs            |   2 +-
>  hw/intc/imx_gpcv2.c              | 125 ++++++++
>  hw/misc/Makefile.objs            |   4 +
>  hw/misc/imx2_wdt.c               |  89 ++++++
>  hw/misc/imx7_ccm.c               | 277 ++++++++++++++++++
>  hw/misc/imx7_gpr.c               | 119 ++++++++
>  hw/misc/imx7_snvs.c              |  83 ++++++
>  hw/pci-host/Makefile.objs        |   2 +
>  hw/pci-host/designware.c         | 618 +++++++++++++++++++++++++++++++++++++++
>  hw/sd/sdhci-internal.h           |  19 ++
>  hw/sd/sdhci.c                    | 228 ++++++++++++++-
>  hw/timer/imx_gpt.c               |  25 ++
>  hw/usb/Makefile.objs             |   1 +
>  hw/usb/chipidea.c                | 176 +++++++++++
>  include/hw/arm/coresight.h       |  24 ++
>  include/hw/arm/fsl-imx7.h        | 223 ++++++++++++++
>  include/hw/intc/imx_gpcv2.h      |  22 ++
>  include/hw/misc/imx2_wdt.h       |  33 +++
>  include/hw/misc/imx7_ccm.h       | 139 +++++++++
>  include/hw/misc/imx7_gpr.h       |  28 ++
>  include/hw/misc/imx7_snvs.h      |  35 +++
>  include/hw/pci-host/designware.h |  93 ++++++
>  include/hw/pci/pci_ids.h         |   2 +
>  include/hw/sd/sdhci.h            |  14 +
>  include/hw/timer/imx_gpt.h       |   1 +
>  include/hw/usb/chipidea.h        |  16 +
>  34 files changed, 3261 insertions(+), 66 deletions(-)
>  create mode 100644 hw/arm/coresight.c
>  create mode 100644 hw/arm/fsl-imx7.c
>  create mode 100644 hw/arm/mcimx7d-sabre.c
>  create mode 100644 hw/intc/imx_gpcv2.c
>  create mode 100644 hw/misc/imx2_wdt.c
>  create mode 100644 hw/misc/imx7_ccm.c
>  create mode 100644 hw/misc/imx7_gpr.c
>  create mode 100644 hw/misc/imx7_snvs.c
>  create mode 100644 hw/pci-host/designware.c
>  create mode 100644 hw/usb/chipidea.c
>  create mode 100644 include/hw/arm/coresight.h
>  create mode 100644 include/hw/arm/fsl-imx7.h
>  create mode 100644 include/hw/intc/imx_gpcv2.h
>  create mode 100644 include/hw/misc/imx2_wdt.h
>  create mode 100644 include/hw/misc/imx7_ccm.h
>  create mode 100644 include/hw/misc/imx7_gpr.h
>  create mode 100644 include/hw/misc/imx7_snvs.h
>  create mode 100644 include/hw/pci-host/designware.h
>  create mode 100644 include/hw/usb/chipidea.h
> 
