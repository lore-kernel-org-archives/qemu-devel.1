Received: from eggs.gnu.org ([2001:4830:134:3::10]:54981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejt2C-0007ve-W6
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejt2B-0000pQ-Vm
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:43:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180208223323-mutt-send-email-mst@kernel.org>
References: <20180207042438.15422-1-andrew.smirnov@gmail.com>
	<20180207042438.15422-11-andrew.smirnov@gmail.com>
	<20180208194226-mutt-send-email-mst@kernel.org>
	<CAHQ1cqGZHie0sYudPGr-15LOEjMRT05=0+tsViKfCJBnN96Nag@mail.gmail.com>
	<20180208221121-mutt-send-email-mst@kernel.org>
	<CAHQ1cqHGfTYyKuMEDGPWnHBbWYV2sMrqfHU6oJV3NQSv0Xi0Qg@mail.gmail.com>
	<20180208223323-mutt-send-email-mst@kernel.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 8 Feb 2018 12:43:03 -0800
Message-ID: <CAHQ1cqHxUZTFiXpzdKWk1MA9QuqHC0Ljs0-uBkWZbYsNn6ix8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 10/14] pci: Add support for Designware
 IP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "open list:ARM" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Thu, Feb 8, 2018 at 12:33 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Feb 08, 2018 at 12:22:53PM -0800, Andrey Smirnov wrote:
>> On Thu, Feb 8, 2018 at 12:11 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Thu, Feb 08, 2018 at 12:03:04PM -0800, Andrey Smirnov wrote:
>> >> >> +#define PCIE_PORT_LINK_CONTROL          0x710
>> >> >> +
>> >> >> +#define PCIE_PHY_DEBUG_R1               0x72C
>> >> >> +#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP  BIT(4)
>> >> >> +
>> >> >> +#define PCIE_LINK_WIDTH_SPEED_CONTROL   0x80C
>> >> >> +#define PORT_LOGIC_SPEED_CHANGE         (0x1 << 17)
>> >> >> +
>> >> >> +#define PCIE_MSI_ADDR_LO                0x820
>> >> >> +#define PCIE_MSI_ADDR_HI                0x824
>> >> >> +#define PCIE_MSI_INTR0_ENABLE           0x828
>> >> >> +#define PCIE_MSI_INTR0_MASK             0x82C
>> >> >> +#define PCIE_MSI_INTR0_STATUS           0x830
>> >> >> +
>> >> >> +#define PCIE_ATU_VIEWPORT               0x900
>> >> >> +#define PCIE_ATU_REGION_INBOUND         (0x1 << 31)
>> >> >> +#define PCIE_ATU_REGION_OUTBOUND        (0x0 << 31)
>> >> >> +#define PCIE_ATU_REGION_INDEX2          (0x2 << 0)
>> >> >> +#define PCIE_ATU_REGION_INDEX1          (0x1 << 0)
>> >> >> +#define PCIE_ATU_REGION_INDEX0          (0x0 << 0)
>> >> >> +#define PCIE_ATU_CR1                    0x904
>> >> >> +#define PCIE_ATU_TYPE_MEM               (0x0 << 0)
>> >> >> +#define PCIE_ATU_TYPE_IO                (0x2 << 0)
>> >> >> +#define PCIE_ATU_TYPE_CFG0              (0x4 << 0)
>> >> >> +#define PCIE_ATU_TYPE_CFG1              (0x5 << 0)
>> >> >> +#define PCIE_ATU_CR2                    0x908
>> >> >> +#define PCIE_ATU_ENABLE                 (0x1 << 31)
>> >> >> +#define PCIE_ATU_BAR_MODE_ENABLE        (0x1 << 30)
>> >> >> +#define PCIE_ATU_LOWER_BASE             0x90C
>> >> >> +#define PCIE_ATU_UPPER_BASE             0x910
>> >> >> +#define PCIE_ATU_LIMIT                  0x914
>> >> >> +#define PCIE_ATU_LOWER_TARGET           0x918
>> >> >> +#define PCIE_ATU_BUS(x)                 (((x) >> 24) & 0xff)
>> >> >> +#define PCIE_ATU_DEVFN(x)               (((x) >> 16) & 0xff)
>> >> >> +#define PCIE_ATU_UPPER_TARGET           0x91C
>> >
>> > Can you avoid a PCIE prefix for this btw?
>> >
>>
>> That's how those constants were named in Linux kernel, but yeah, I'll
>> add a prefix to them.
>>
>> Thanks,
>> Andrey Smirnov
>
> In that case you should not copy it into your file.
> Stuff from linux kernel should be imported into standard-headers.
>

Just to be sure we are on the same page, this is the file I am talking about:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/dwc/pcie-designware.h?h=v4.15

you want me to put it in standard-headers/linux and get those
constants from there?

Thanks,
Andrey Smirnov
