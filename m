Received: from eggs.gnu.org ([2001:4830:134:3::10]:39219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgHcS-0007Rv-1c
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgHcQ-0007To-UJ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:05:08 -0500
References: <1487683100-16013-1-git-send-email-eric.auger@redhat.com>
	<1487683100-16013-2-git-send-email-eric.auger@redhat.com>
	<98d4d9e8-761c-76f9-ecb0-c5a4a658dfab@codeaurora.org>
	<2dcc9002-ec06-c55e-c0a2-75d05fe05762@redhat.com>
	<970561bf-0adc-4f60-bf2b-57bbafabb0aa@codeaurora.org>
	<8d790f60-6ee6-9b48-6dfc-524532db112b@redhat.com>
	<a9ed1831-5a1c-5c27-25b0-71d06c7dee2e@codeaurora.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b248aa6f-2cb7-05ba-54f2-ba1be0fa6775@redhat.com>
Date: Tue, 21 Feb 2017 22:04:54 +0100
MIME-Version: 1.0
In-Reply-To: <a9ed1831-5a1c-5c27-25b0-71d06c7dee2e@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio/platform: make the vfio-platform
 device non abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sinan Kaya <okaya@codeaurora.org>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: shankerd@codeaurora.org, vikrams@codeaurora.org, agraf@suse.de, pelcan@codeaurora.org

Hi Sinan,

On 21/02/2017 16:34, Sinan Kaya wrote:
> On 2/21/2017 10:23 AM, Auger Eric wrote:
>>> Note that the goal is to be able to instantiate any platform device by just
>>> passing a compatible string and the object from the host. We don't want
>>> to make changes to QEMU every time somebody comes up with a new platform device.
>>> This step is unnecessary.
>> Well we need to generate a device tree node for your device. We have not
>> proven yet the function that creates this latter can be generic. There
>> are some helpers that can read the host dt node, copy some properties
>> from the host to the guest. But still at the moment we can't make things
>> as generic as PCIe and this is why the platform passthrough still is
>> controversial. So this patch aims at lowering the integration efforts
>> but minimal specialization needs to be done in sysbus-fdt. Same on
>> kernel side with the reset module.
> 
> Understood. You need to bring in the entire device tree parameters for a full-blown
> solution. We can always treat this as a TODO.
> 
> I was more interested in simple devices like XHCI, AHCI, HIDMA where there
> is no platform device attribute besides the interrupt number and memory
> resources. QEMU already has access to these.
> 
> I was hoping to cover this at least. More complex objects need their own
> implementation like the AMD driver in your example.
> 
> I'm pasting my comment from the archives here. 
> 
> https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03267.html
With respect to the compatible string we have 2 strategies: either
1) the user passes it along the -device option line or
2) qemu retrieves it in the host dt and applies the same on guest side.

I currently implemented 1)

Then assuming the above mentioned devices have very basic dt nodes
(compatible, reg, interrupts) we could imagine to copy the host property
into the guest device tree. But looking at

http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/usb/usb-xhci.txt

there can be optional properties which are much more complex to handle
(clocks for instance).

We could potentially have a minimalist node creation function that
examines the host dt node and in case it only contains compat, reg,
interrupts (and maybe dma_coherent) copies those on guest side. In case
other properties exist and no specialized node creation function exists
qemu would abort.

Same for AHCI:

http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/ata/ahci-platform.txt

HIDMA (https://patchwork.kernel.org/patch/8168281/) also seem to have
non trivial properties which would require a custom node creation function.

So I think this definitively deserves more discussions and agreements
upstream before starting more time consuming developments. This is not
for 2.9 anyway so I will move the series into an RFC.

Thanks

Eric
> 
> "Why submit a new SATA AHCI driver for QEMU just to set the compat string?"
> 
> 
>>
>> Thanks
>>
>> Eric
>>
>>
> 
> 
