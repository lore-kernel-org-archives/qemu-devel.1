Received: from eggs.gnu.org ([2001:4830:134:3::10]:60553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1daDs7-0003TB-0n
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1daDs3-0006KT-Ro
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:24:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1daDs3-0006I8-IH
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:24:27 -0400
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-6-git-send-email-zuban32s@gmail.com>
	<20170723055006-mutt-send-email-mst@kernel.org>
	<b566a69d-a977-bf9f-d567-b742d400b288@redhat.com>
	<20170723173111-mutt-send-email-mst@kernel.org>
	<CAKSfGUBP8oH2YymDnCA+Q=ngmyyVRYTVujwfOLRgdBQ82qgivg@mail.gmail.com>
	<20170725165213-mutt-send-email-mst@kernel.org>
	<CAKSfGUDiJ9GVNepiX7nGHtPf5=OqUaZgyPwwwDUDWuwnAND-Ew@mail.gmail.com>
	<a16dcefb-8abd-cf24-762c-82e26a0f9ec4@redhat.com>
	<CAKSfGUDOC7vBG30+NmrTr+UO4=vb6phiDreTA=4mA1LOfLs3Tw@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <4e3f9aad-3528-59b4-1fab-d109cf49632a@redhat.com>
Date: Wed, 26 Jul 2017 07:24:17 +0300
MIME-Version: 1.0
In-Reply-To: <CAKSfGUDOC7vBG30+NmrTr+UO4=vb6phiDreTA=4mA1LOfLs3Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 5/6] hw/pci: add bus_reserve
 property to pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Bezzubikov <zuban32s@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, ehabkost@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net, seabios@seabios.org

On 25/07/2017 20:11, Alexander Bezzubikov wrote:
>=20
> =D0=B2=D1=82, 25 =D0=B8=D1=8E=D0=BB=D1=8F 2017 =D0=B3. =D0=B2 19:10, Ma=
rcel Apfelbaum <marcel@redhat.com=20
> <mailto:marcel@redhat.com>>:
>=20
>     On 25/07/2017 17:09, Alexander Bezzubikov wrote:
>      > 2017-07-25 16:53 GMT+03:00 Michael S. Tsirkin <mst@redhat.com
>     <mailto:mst@redhat.com>>:
>      >> On Tue, Jul 25, 2017 at 04:50:49PM +0300, Alexander Bezzubikov
>     wrote:
>      >>> 2017-07-25 16:43 GMT+03:00 Michael S. Tsirkin <mst@redhat.com
>     <mailto:mst@redhat.com>>:
>      >>>> On Sun, Jul 23, 2017 at 05:13:11PM +0300, Marcel Apfelbaum wr=
ote:
>      >>>>> On 23/07/2017 15:22, Michael S. Tsirkin wrote:
>      >>>>>> On Sun, Jul 23, 2017 at 01:15:42AM +0300, Aleksandr
>     Bezzubikov wrote:
>      >>>>>>> To enable hotplugging of a newly created pcie-pci-bridge,
>      >>>>>>> we need to tell firmware (SeaBIOS in this case)
>      >>>>>>
>      >>>>>
>      >>>>> Hi Michael,
>      >>>>>
>      >>>>>> Presumably, EFI would need to support this too?
>      >>>>>>
>      >>>>>
>      >>>>> Sure, Eduardo added to CC, but he is in PTO now.
>      >>>>>
>      >>>>>>> to reserve
>      >>>>>>> additional buses for pcie-root-port, that allows us to
>      >>>>>>> hotplug pcie-pci-bridge into this root port.
>      >>>>>>> The number of buses to reserve is provided to the device
>     via a corresponding
>      >>>>>>> property, and to the firmware via new PCI capability (next
>     patch).
>      >>>>>>> The property's default value is 1 as we want to hotplug at
>     least 1 bridge.
>      >>>>>>
>      >>>>>> If so you should just teach firmware to allocate one bus #
>      >>>>>> unconditionally.
>      >>>>>>
>      >>>>>
>      >>>>> That would be a problem for the PCIe machines, since each PC=
Ie
>      >>>>> devices is plugged in a different bus and we are already
>      >>>>> limited to 256 PCIe devices. Allocating an extra-bus always
>      >>>>> would really limit the PCIe devices we can use.
>      >>>>
>      >>>> One of the declared advantages of PCIe is easy support for
>     multiple roots.
>      >>>> We really should look at that IMHO so we do not need to pile
>     up hacks.
>      >>>>
>      >>>>>> But why would that be so? What's wrong with a device
>      >>>>>> directly in the root port?
>      >>>>>>
>      >>>>
>      >>>> To clarify, my point is we might be wasting bus numbers by
>     reservation
>      >>>> since someone might just want to put pcie devices there.
>      >>>
>      >>> I think, changing default value to 0 can help us avoid this,
>      >>> as no bus reservation by default. If one's surely wants
>      >>> to hotplug pcie-pci-bridge into this root port in future,
>      >>> the property gives him such an opportunity.
>      >>> So, sure need pcie-pci-bridge hotplug -> creating a root port =
with
>      >>> bus_reserve > 0. Otherwise (and default) - just as now, no cha=
nges
>      >>> in bus topology.
>      >>
>      >> I guess 0 should mean "do not reserve any buses".  So I think w=
e
>     also
>      >> need a flag to just avoid the capability altogether.  Maybe -1?=
=20
>     *That*
>      >> should be the default.
>      >
>      > -1 might be useful if any limit value 0 is legal, but is it?
>      > If not, we can set every field to 0 and
>      > this is a sign of avoiding capability since none legal
>      > values are provided.
>      >
>=20
>     As Gerd suggested, this value is not a "delta" but the number
>     of buses to be reserved behind the bridge. If I got it right,
>     0 is not a valid value, since the bridge by definition
>     has a list one bus behind.
>=20
>=20
> Gerd's suggestion was to set min(cap_value, children_found). From such=20
> point of view 0 can be a valid value.
>=20

I am lost now :)
How can we use the capability to reserve "more" buses since
children-found will be always the smaller value?

I think you should use max(cap_value, children_found) to
ensure you always reserve enough buses for existing children.

In this case 0 is actually an invalid value since
children_found > 0 for a bridge.

Thanks,
Marcel

>=20
>=20
>     Michael, would you be OK with that?
>=20
>     Thanks,
>     Marcel
>=20
>      >>
>      >>>>
>      >>>>> First, plugging a legacy PCI device into a PCIe Root Port
>      >>>>> looks strange at least, and it can;t be done on real HW anyw=
ay.
>      >>>>> (incompatible slots)
>      >>>>>
>      >>>>> Second (and more important), if we want 2 or more PCI
>      >>>>> devices we would loose both IO ports space and bus numbers.
>      >>>>>
>      >>>>>>
>      >>>>>>>
>      >>>>>>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com
>     <mailto:zuban32s@gmail.com>>
>      >>>>>>> ---
>      >>>>>>>    hw/pci-bridge/pcie_root_port.c | 1 +
>      >>>>>>>    include/hw/pci/pcie_port.h     | 3 +++
>      >>>>>>>    2 files changed, 4 insertions(+)
>      >>>>>>>
>      >>>>>>> diff --git a/hw/pci-bridge/pcie_root_port.c
>     b/hw/pci-bridge/pcie_root_port.c
>      >>>>>>> index 4d588cb..b0e49e1 100644
>      >>>>>>> --- a/hw/pci-bridge/pcie_root_port.c
>      >>>>>>> +++ b/hw/pci-bridge/pcie_root_port.c
>      >>>>>>> @@ -137,6 +137,7 @@ static void rp_exit(PCIDevice *d)
>      >>>>>>>    static Property rp_props[] =3D {
>      >>>>>>>        DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_pre=
sent,
>      >>>>>>>                        QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>      >>>>>>> +    DEFINE_PROP_UINT8("bus_reserve", PCIEPort,
>     bus_reserve, 1),
>      >>>>>>>        DEFINE_PROP_END_OF_LIST()
>      >>>>>>>    };
>      >>>>>>> diff --git a/include/hw/pci/pcie_port.h
>     b/include/hw/pci/pcie_port.h
>      >>>>>>> index 1333266..1b2dd1f 100644
>      >>>>>>> --- a/include/hw/pci/pcie_port.h
>      >>>>>>> +++ b/include/hw/pci/pcie_port.h
>      >>>>>>> @@ -34,6 +34,9 @@ struct PCIEPort {
>      >>>>>>>        /* pci express switch port */
>      >>>>>>>        uint8_t     port;
>      >>>>>>> +
>      >>>>>>> +    /* additional buses to reserve on firmware init */
>      >>>>>>> +    uint8_t     bus_reserve;
>      >>>>>>>    };
>      >>>>>>>    void pcie_port_init_reg(PCIDevice *d);
>      >>>>>>
>      >>>>>> So here is a property and it does not do anything.
>      >>>>>> It makes it easier to work on series maybe, but review
>      >>>>>> is harder since we do not see what it does at all.
>      >>>>>> Please do not split up patches like this - you can maintain
>      >>>>>> it split up in your branch if you like and merge before sen=
ding.
>      >>>>>>
>      >>>>>
>      >>>>> Agreed, Alexandr please merge patches 4-5-6 for your next
>     submission.
>      >>>>>
>      >>>>> Thanks,
>      >>>>> Marcel
>      >>>>>
>      >>>>>
>      >>>>>>> --
>      >>>>>>> 2.7.4
>      >>>
>      >>>
>      >>>
>      >>> --
>      >>> Alexander Bezzubikov
>      >
>      >
>      >
>=20
> --=20
> Alexander Bezzubikov
