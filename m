Received: from eggs.gnu.org ([2001:4830:134:3::10]:49300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea4RN-0003ZQ-74
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea4RM-0007R7-7q
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:52:33 -0500
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:36492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ea4RM-0007QZ-2n
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:52:32 -0500
Received: by mail-it0-x22c.google.com with SMTP id p124so10387836ite.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:52:31 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <f544092b-9214-32a1-4aa2-faac004618d4@amsat.org>
References: <20180111193021.17466-1-f4bug@amsat.org>
	<20180111193021.17466-4-f4bug@amsat.org>
	<CAFEAcA8UvqmtzxcQrDWF24OQsBek0s2uYPOsoCs5YqH80MpXnw@mail.gmail.com>
	<CAAdtpL7Dz3kQyVYZy9iUvy-iFRZMD-+3o0Gsfb=HOzpMgDTkhw@mail.gmail.com>
	<f544092b-9214-32a1-4aa2-faac004618d4@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 Jan 2018 15:52:30 -0300
Message-ID: <CAAdtpL6ATZ_-E_0zP-PToQUWLsLvcqSQoCJQtVPkMfNBUC+=4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

> On 01/12/2018 02:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On Fri, Jan 12, 2018 at 2:05 PM, Peter Maydell <peter.maydell@linaro.org=
> wrote:
>>> On 11 January 2018 at 19:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>>>> Now both sysbus/pci classes inherit of the 'pending-insert-quirk' prop=
erty,
>>>> which is a HCI dependent property (regardless if accessed through a MM=
IO
>>>> sysbus or a PCI bus).
>>>> So far only the BCM implementation has to use it.
>>>>
>>>> Add sysbus/pci/sdbus comments to have clearer code blocks separation.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>>>
>>> I'm not sure about this patch, because it means that we now have
>>> no mechanism for having a property which exists on the sysbus
>>> device but not on the PCI device (and as per my comments on the
>>> last patch in this set, we do need to be able to do that).
>
> Does this look OK to you?
>
> static Property sdhci_sysbus_pending_insert_quirk_property =3D
>      DEFINE_PROP_BOOL("pending-insert-quirk",
>            SDHCIState, pending_insert_quirk, false);
>
> static Property sdhci_sysbus_dma_mr_property =3D
>      DEFINE_PROP_LINK("dma",
>          SDHCIState, dma_mr, TYPE_MEMORY_REGION, MemoryRegion *);
>
> static void sdhci_sysbus_post_init(Object *obj)

No need to use the post_init(), this can go in the sdhci_initfn().

> {
>     SDHCIState *s =3D SYSBUS_SDHCI(obj);
>
>     sdhci_common_post_init(obj); /* add common properties */
>     qdev_property_add_static(DEVICE(obj),
>         &sdhci_sysbus_pending_insert_quirk_property, &error_abort);
>     qdev_property_add_static(DEVICE(obj),
>         &sdhci_sysbus_dma_mr_property, &error_abort);
> }
>
> static const TypeInfo sdhci_sysbus_info =3D {
>     .name =3D TYPE_SYSBUS_SDHCI,
>     .parent =3D TYPE_SYS_BUS_DEVICE,
>     .instance_size =3D sizeof(SDHCIState),
>     .instance_init =3D sdhci_sysbus_init,
>     .instance_post_init =3D sdhci_sysbus_post_init,

Not needed.

>     ...
> };
>
> This way we can have a property which exists on the sysbus
> device but not on the PCI device, and keep the common one in the same
> piece of code (I later add a few common properties).
