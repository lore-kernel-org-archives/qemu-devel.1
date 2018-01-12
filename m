Received: from eggs.gnu.org ([2001:4830:134:3::10]:45293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea4KN-00063x-Ej
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea4KJ-0006om-4e
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:45:19 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea4KI-0006oK-WF
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:45:15 -0500
Received: by mail-qt0-x241.google.com with SMTP id f2so7183939qtj.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:45:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180111193021.17466-1-f4bug@amsat.org>
	<20180111193021.17466-4-f4bug@amsat.org>
	<CAFEAcA8UvqmtzxcQrDWF24OQsBek0s2uYPOsoCs5YqH80MpXnw@mail.gmail.com>
	<CAAdtpL7Dz3kQyVYZy9iUvy-iFRZMD-+3o0Gsfb=HOzpMgDTkhw@mail.gmail.com>
Message-ID: <f544092b-9214-32a1-4aa2-faac004618d4@amsat.org>
Date: Fri, 12 Jan 2018 15:45:10 -0300
MIME-Version: 1.0
In-Reply-To: <CAAdtpL7Dz3kQyVYZy9iUvy-iFRZMD-+3o0Gsfb=HOzpMgDTkhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 03/13] sdhci: refactor same sysbus/pci
 properties into a common one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 01/12/2018 02:20 PM, Philippe Mathieu-Daudé wrote:
> On Fri, Jan 12, 2018 at 2:05 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 11 January 2018 at 19:30, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>> Now both sysbus/pci classes inherit of the 'pending-insert-quirk' property,
>>> which is a HCI dependent property (regardless if accessed through a MMIO
>>> sysbus or a PCI bus).
>>> So far only the BCM implementation has to use it.
>>>
>>> Add sysbus/pci/sdbus comments to have clearer code blocks separation.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>>
>> I'm not sure about this patch, because it means that we now have
>> no mechanism for having a property which exists on the sysbus
>> device but not on the PCI device (and as per my comments on the
>> last patch in this set, we do need to be able to do that).

Does this look OK to you?

static Property sdhci_sysbus_pending_insert_quirk_property =
     DEFINE_PROP_BOOL("pending-insert-quirk",
           SDHCIState, pending_insert_quirk, false);

static Property sdhci_sysbus_dma_mr_property =
     DEFINE_PROP_LINK("dma",
         SDHCIState, dma_mr, TYPE_MEMORY_REGION, MemoryRegion *);

static void sdhci_sysbus_post_init(Object *obj)
{
    SDHCIState *s = SYSBUS_SDHCI(obj);

    sdhci_common_post_init(obj); /* add common properties */
    qdev_property_add_static(DEVICE(obj),
        &sdhci_sysbus_pending_insert_quirk_property, &error_abort);
    qdev_property_add_static(DEVICE(obj),
        &sdhci_sysbus_dma_mr_property, &error_abort);
}

static const TypeInfo sdhci_sysbus_info = {
    .name = TYPE_SYSBUS_SDHCI,
    .parent = TYPE_SYS_BUS_DEVICE,
    .instance_size = sizeof(SDHCIState),
    .instance_init = sdhci_sysbus_init,
    .instance_post_init = sdhci_sysbus_post_init,
    ...
};

This way we can have a property which exists on the sysbus
device but not on the PCI device, and keep the common one in the same
piece of code (I later add a few common properties).

Regards,

Phil.
