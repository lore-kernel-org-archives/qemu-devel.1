Received: from eggs.gnu.org ([2001:4830:134:3::10]:50429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eBnvx-0005ex-QS
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eBnvu-0001Kp-I1
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:23:49 -0500
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:45411)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eBnvu-0001J6-CG
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:23:46 -0500
References: <20171031155435.4618-1-michael.nawrocki@gtri.gatech.edu>
	<20171031155435.4618-3-michael.nawrocki@gtri.gatech.edu>
	<20171031175048.GI4526@work-vm>
	<565D1929-C201-4AAD-A07E-12382FD23D81@gtri.gatech.edu>
	<20171101172847-mutt-send-email-mst@kernel.org>
From: Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>
Message-ID: <47074dda-b73b-2831-b10d-aada72f39f7b@gtri.gatech.edu>
Date: Mon, 6 Nov 2017 15:23:42 -0500
MIME-Version: 1.0
In-Reply-To: <20171101172847-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] Add i82559a eepro100 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcel@redhat.com" <marcel@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>


On 11/01/2017 11:32 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 01, 2017 at 02:48:17PM +0000, Nawrocki, Michael wrote:
>> On 10/31/17, 13:50, "Dr. David Alan Gilbert" <dgilbert@redhat.com> wro=
te:
>>
>>      * Mike Nawrocki (michael.nawrocki@gtri.gatech.edu) wrote:
>>      > Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
>>      > ---
>>      >  hw/net/eepro100.c    | 2 +-
>>      >  hw/pci/pci.c         | 2 ++
>>      >  include/hw/pci/pci.h | 1 +
>>      >  qemu-options.hx      | 2 +-
>>      >  4 files changed, 5 insertions(+), 2 deletions(-)
>>      >
>>      > diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
>>      > index 91dd058010..2c7c5cdeb9 100644
>>      > --- a/hw/net/eepro100.c
>>      > +++ b/hw/net/eepro100.c
>>      > @@ -1973,7 +1973,7 @@ static E100PCIDeviceInfo e100_devices[] =3D=
 {
>>      >          .name =3D "i82559a",
>>      >          .desc =3D "Intel i82559A Ethernet",
>>      >          .device =3D i82559A,
>>      > -        .device_id =3D PCI_DEVICE_ID_INTEL_82557,
>>      > +        .device_id =3D PCI_DEVICE_ID_INTEL_82559,
>>     =20
>>      Doesn't that break migration/compatibility - if one side suddenly
>>      sees a different device_id ?
>>     =20
>>      Dave
>>
>> I=E2=80=99m not sure. I searched for code references to the i82559a in=
terface and couldn=E2=80=99t find any outside of the driver itself; it wa=
sn=E2=80=99t exported as a pci_nic_model before my patch, so I don=E2=80=99=
t think the i82559a device was being used, programmatically or via the co=
mmand line, before this point. Perhaps there=E2=80=99s a different way to=
 use the device that I=E2=80=99m not aware of?
>=20
> the modern way to create devices is with -devices.
>=20

Gotcha. I've updated my usage to reflect this.


>> I think the ID I=E2=80=99m using (0x8086 0x1030 =E2=80=93 Intel Corpor=
ation 82559 InBusiness 10/100) is more accurate to the chipset, and a dri=
ver I=E2=80=99ve got explicitly searches for this ID. Most drivers seem t=
o search for a number of PCI IDs in the eepro100 family, at any rate, so =
I think it should be okay. Let me know if another approach is preferable.
>>
>> Thanks,
>> Mike
>=20
> You need a property and set it to a compat value for
> old machine types.

I've added a "use-alt-device-id" boolean property, an "alt_device_id"=20
field in the info struct, and reverted the device_id to the 82557 one.=20
I'll push the v2 patches shortly.

>=20
>>      >          .revision =3D 0x06,
>>      >          .stats_size =3D 80,
>>      >          .has_extended_tcb_support =3D true,
>>      > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>      > index 5ed3c8dca4..1126ad1eb3 100644
>>      > --- a/hw/pci/pci.c
>>      > +++ b/hw/pci/pci.c
>>      > @@ -1826,6 +1826,7 @@ static const char * const pci_nic_models[=
] =3D {
>>      >      "ne2k_pci",
>>      >      "i82551",
>>      >      "i82557b",
>>      > +    "i82559a",
>>      >      "i82559er",
>>      >      "rtl8139",
>>      >      "e1000",
>>      > @@ -1839,6 +1840,7 @@ static const char * const pci_nic_names[]=
 =3D {
>>      >      "ne2k_pci",
>>      >      "i82551",
>>      >      "i82557b",
>>      > +    "i82559a",
>>      >      "i82559er",
>>      >      "rtl8139",
>>      >      "e1000",
>=20
> There's no need to add more nic names here. Just create with -device.

Gotcha. I've removed these in the upcoming patches.

Thanks,
Mike
>=20
>=20
>>      > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>      > index 8d02a0a383..f30e2cfb72 100644
>>      > --- a/include/hw/pci/pci.h
>>      > +++ b/include/hw/pci/pci.h
>>      > @@ -70,6 +70,7 @@ extern bool pci_available;
>>      >  /* Intel (0x8086) */
>>      >  #define PCI_DEVICE_ID_INTEL_82551IT      0x1209
>>      >  #define PCI_DEVICE_ID_INTEL_82557        0x1229
>>      > +#define PCI_DEVICE_ID_INTEL_82559        0x1030
>>      >  #define PCI_DEVICE_ID_INTEL_82801IR      0x2922
>>      >
>>      >  /* Red Hat / Qumranet (for QEMU) -- see pci-ids.txt */
>>      > diff --git a/qemu-options.hx b/qemu-options.hx
>>      > index 3728e9b4dd..a39c7e44b3 100644
>>      > --- a/qemu-options.hx
>>      > +++ b/qemu-options.hx
>>      > @@ -2047,7 +2047,7 @@ that the card should have; this option cu=
rrently only affects virtio cards; set
>>      >  @var{v} =3D 0 to disable MSI-X. If no @option{-net} option is =
specified, a single
>>      >  NIC is created.  QEMU can emulate several different models of =
network card.
>>      >  Valid values for @var{type} are
>>      > -@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559er},
>>      > +@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559a}, =
@code{i82559er},
>>      >  @code{ne2k_pci}, @code{ne2k_isa}, @code{pcnet}, @code{rtl8139}=
,
>>      >  @code{e1000}, @code{smc91c111}, @code{lance} and @code{mcf_fec=
}.
>>      >  Not all devices are supported on all targets.  Use @code{-net =
nic,model=3Dhelp}
>>      > --
>>      > 2.14.2
>>      >
>>      >
>>      --
>>      Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>     =20
>>
