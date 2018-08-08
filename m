Received: from eggs.gnu.org ([2001:4830:134:3::10]:48481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fnOKA-0001y3-OF
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fnOK9-0004ul-4c
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:16:26 -0400
References: <20180725143413.9728-1-geert+renesas@glider.be>
	<20180725143413.9728-5-geert+renesas@glider.be>
	<e52bfdab-5c23-a617-8bef-0c17ab831ec1@redhat.com>
	<CAMuHMdUuHcoZxFVFivBwD3LveeE8yQ+AnaWFr76kATG+rCzd=w@mail.gmail.com>
	<9305142a-8b88-8beb-dd95-02dd84881aa8@redhat.com>
	<CAMuHMdVFT5PuXGVuT7wobJd_m1X8SvY+XohJWNtB7b-59JXKhQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ea6551f6-517b-4f51-4a50-72430efaad41@redhat.com>
Date: Wed, 8 Aug 2018 15:16:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVFT5PuXGVuT7wobJd_m1X8SvY+XohJWNtB7b-59JXKhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/4] hw/arm/sysbus-fdt: Add support for
 instantiating generic devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Alex Williamson <alex.williamson@redhat.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, qemu-arm <qemu-arm@nongnu.org>

Hi Geert,

On 08/08/2018 02:59 PM, Geert Uytterhoeven wrote:
> Hi Eric,
> 
> On Tue, Aug 7, 2018 at 7:21 PM Auger Eric <eric.auger@redhat.com> wrote:
>> On 08/07/2018 05:32 PM, Geert Uytterhoeven wrote:
>>> On Tue, Aug 7, 2018 at 4:19 PM Auger Eric <eric.auger@redhat.com> wrote:
>>>> On 07/25/2018 04:34 PM, Geert Uytterhoeven wrote:
>>>>> Add a fallback for instantiating generic devices without a type-specific
>>>>> or compatible-specific instantation method.  This will be used when no
>>>>> other match is found.
>>>>>
>>>>> The generic instantation method creates a device node with "reg" and
>>>>> (optional) "interrupts" properties, and copies the "compatible"
>>>>> property and other optional properties from the host.
> 
>>>>> --- a/hw/arm/sysbus-fdt.c
>>>>> +++ b/hw/arm/sysbus-fdt.c
>>>>> @@ -415,6 +415,99 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
>>>>>      return 0;
>>>>>  }
>>>>>
>>>>> +static HostProperty generic_copied_properties[] = {
>>>>> +    {"compatible", false},
>>>>> +    {"#gpio-cells", true},
>>>>> +    {"gpio-controller", true},
>>>>> +    {"#interrupt-cells", true},
>>>>> +    {"interrupt-controller", true},
>>>>> +    {"interrupt-names", true},
>>>>
>>>> I think we would need to enumerate the other source properties which
>>>> were not copied to the guest fdt and either warn the userspace those
>>>> were omitted or fail. We may end up generating an incomplete guest dt
>>>> node that may not work properly.
>>>
>>> The list above is quite generic, so it is expected that some of the optional
>>> properties (marked "true") cannot be copied. Hence warning about them
>>> will be noisy, and confuse users.  Failing is definitely the wrong thing
>>> to do.
>>
>> I was not talking about those listed here and optional. Those ones are
>> taken care of. I was rather talking about potential other ones, present
>> on host side and not copied on guest side. For instance, let's say your
>> host dt node has a clocks property. You will attempt to create a guest
>> dt node without this property and obviously the device will not work
>> properly on guest side. The end user attempting this assignment does not
>> get any warning on guest launch. Maybe the driver on guest side will be
>> cool enough to issue a warning but we cannot really rely on this
>> assumption. So from a maintenance point of view, it looks not
>> manageable. I think we should checl all props found in the host dt node
>> are considered and copied into the guest node. Otherwise this means the
>> host dt node does not belong to the category of a "simple" one and thus
>> cannot use this creation function.
> 
> It depends. And that makes it difficult to come up with a sensible
> detection system for notifying the user, while avoiding too many false
> positives and negatives.
> 
> Properties like "clocks" typically use phandles, which means the node
> they're pointing to should be copied, too, possibly involving rewriting
> like with interrupts. Hence I think this should be left to a
> device-specific instantiation method.
Fully agreed. But with patch 4, an end-user can try to assign this
device without writing a specific dt node creation function. The device
on guest side will not run properly and he may report a bug. Then what
do we do?

Better emitting a false positive than nothing?
> 
> Furthermore, depending on the SoC, some DT properties should be ignored,
> and must not be copied.
> Examples are:
>   1. "power-domains", and optionally "clocks", when the device is part of a
>      power and/or clock domain.
>      Power management must be handled by the host, cfr. commit
>      415eb9fc0e23071f ("vfio: platform: Fix using devices in PM Domains",
>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=415eb9fc0e23071f).
>      That is another reason why we are replacing explicit clock handling
>      for power management by Runtime PM in the individual drivers, cfr.
>      e.g. commit 1ecd34ddf63ef1d4 ("ata: sata_rcar: Add rudimentary Runtime
>      PM support") in linux-next
>      (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1ecd34ddf63ef1d4).
>      (the first reason is abstracting power management, which may differ
>       among SoCs using the same IP core).
>   2. "resets", pointing to a reset controller, as reset must be handled by
>      the host's vfio driver to restore the device to a pristine state
>      before/after virtualization.
>      See also "[PATCH v3 2/2] vfio: platform: Add generic DT reset support"
>      (https://www.spinics.net/lists/devicetree/msg223516.html).

Yes. maybe this should be handled by using a white list of properties
that are safe not to be copied? This is a vast topic.

Wouldn't it make sense to try getting 1-3 upstream separately as this
last patch seems more controversial and independent?

Thanks

Eric
> 
>>> If the host lacks a property that is mandatory for a specific device, the
>>> device won't have worked on the host before neither, right?
>>>
>>> The major issue remains that an incomplete guest DT node may be generated
>>> if the list above lacks certain needed properties, or if subnodes are
>>> needed.
>>> I expect the guest OS driver would complain about the missing parts, though.
>>> In that case, either the list should be extended, or a device-specific
>>> instantiation method should be written.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
