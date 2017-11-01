Received: from eggs.gnu.org ([2001:4830:134:3::10]:57657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e9v0G-0004qy-00
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e9v0B-0001Nv-25
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:32:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e9v0A-0001Nh-P0
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:32:22 -0400
Date: Wed, 1 Nov 2017 17:32:05 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171101172847-mutt-send-email-mst@kernel.org>
References: <20171031155435.4618-1-michael.nawrocki@gtri.gatech.edu>
	<20171031155435.4618-3-michael.nawrocki@gtri.gatech.edu>
	<20171031175048.GI4526@work-vm>
	<565D1929-C201-4AAD-A07E-12382FD23D81@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <565D1929-C201-4AAD-A07E-12382FD23D81@gtri.gatech.edu>
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
To: "Nawrocki, Michael" <Michael.Nawrocki@gtri.gatech.edu>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcel@redhat.com" <marcel@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>

On Wed, Nov 01, 2017 at 02:48:17PM +0000, Nawrocki, Michael wrote:
> On 10/31/17, 13:50, "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrot=
e:
>=20
>     * Mike Nawrocki (michael.nawrocki@gtri.gatech.edu) wrote:
>     > Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
>     > ---
>     >  hw/net/eepro100.c    | 2 +-
>     >  hw/pci/pci.c         | 2 ++
>     >  include/hw/pci/pci.h | 1 +
>     >  qemu-options.hx      | 2 +-
>     >  4 files changed, 5 insertions(+), 2 deletions(-)
>     >=20
>     > diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
>     > index 91dd058010..2c7c5cdeb9 100644
>     > --- a/hw/net/eepro100.c
>     > +++ b/hw/net/eepro100.c
>     > @@ -1973,7 +1973,7 @@ static E100PCIDeviceInfo e100_devices[] =3D=
 {
>     >          .name =3D "i82559a",
>     >          .desc =3D "Intel i82559A Ethernet",
>     >          .device =3D i82559A,
>     > -        .device_id =3D PCI_DEVICE_ID_INTEL_82557,
>     > +        .device_id =3D PCI_DEVICE_ID_INTEL_82559,
>    =20
>     Doesn't that break migration/compatibility - if one side suddenly
>     sees a different device_id ?
>    =20
>     Dave
>=20
> I=E2=80=99m not sure. I searched for code references to the i82559a int=
erface and couldn=E2=80=99t find any outside of the driver itself; it was=
n=E2=80=99t exported as a pci_nic_model before my patch, so I don=E2=80=99=
t think the i82559a device was being used, programmatically or via the co=
mmand line, before this point. Perhaps there=E2=80=99s a different way to=
 use the device that I=E2=80=99m not aware of?

the modern way to create devices is with -devices.

> I think the ID I=E2=80=99m using (0x8086 0x1030 =E2=80=93 Intel Corpora=
tion 82559 InBusiness 10/100) is more accurate to the chipset, and a driv=
er I=E2=80=99ve got explicitly searches for this ID. Most drivers seem to=
 search for a number of PCI IDs in the eepro100 family, at any rate, so I=
 think it should be okay. Let me know if another approach is preferable.
>=20
> Thanks,
> Mike

You need a property and set it to a compat value for
old machine types.

>     >          .revision =3D 0x06,
>     >          .stats_size =3D 80,
>     >          .has_extended_tcb_support =3D true,
>     > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>     > index 5ed3c8dca4..1126ad1eb3 100644
>     > --- a/hw/pci/pci.c
>     > +++ b/hw/pci/pci.c
>     > @@ -1826,6 +1826,7 @@ static const char * const pci_nic_models[] =
=3D {
>     >      "ne2k_pci",
>     >      "i82551",
>     >      "i82557b",
>     > +    "i82559a",
>     >      "i82559er",
>     >      "rtl8139",
>     >      "e1000",
>     > @@ -1839,6 +1840,7 @@ static const char * const pci_nic_names[] =3D=
 {
>     >      "ne2k_pci",
>     >      "i82551",
>     >      "i82557b",
>     > +    "i82559a",
>     >      "i82559er",
>     >      "rtl8139",
>     >      "e1000",

There's no need to add more nic names here. Just create with -device.


>     > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>     > index 8d02a0a383..f30e2cfb72 100644
>     > --- a/include/hw/pci/pci.h
>     > +++ b/include/hw/pci/pci.h
>     > @@ -70,6 +70,7 @@ extern bool pci_available;
>     >  /* Intel (0x8086) */
>     >  #define PCI_DEVICE_ID_INTEL_82551IT      0x1209
>     >  #define PCI_DEVICE_ID_INTEL_82557        0x1229
>     > +#define PCI_DEVICE_ID_INTEL_82559        0x1030
>     >  #define PCI_DEVICE_ID_INTEL_82801IR      0x2922
>     > =20
>     >  /* Red Hat / Qumranet (for QEMU) -- see pci-ids.txt */
>     > diff --git a/qemu-options.hx b/qemu-options.hx
>     > index 3728e9b4dd..a39c7e44b3 100644
>     > --- a/qemu-options.hx
>     > +++ b/qemu-options.hx
>     > @@ -2047,7 +2047,7 @@ that the card should have; this option curr=
ently only affects virtio cards; set
>     >  @var{v} =3D 0 to disable MSI-X. If no @option{-net} option is sp=
ecified, a single
>     >  NIC is created.  QEMU can emulate several different models of ne=
twork card.
>     >  Valid values for @var{type} are
>     > -@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559er},
>     > +@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559a}, @c=
ode{i82559er},
>     >  @code{ne2k_pci}, @code{ne2k_isa}, @code{pcnet}, @code{rtl8139},
>     >  @code{e1000}, @code{smc91c111}, @code{lance} and @code{mcf_fec}.
>     >  Not all devices are supported on all targets.  Use @code{-net ni=
c,model=3Dhelp}
>     > --=20
>     > 2.14.2
>     >=20
>     >=20
>     --
>     Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>    =20
>=20
