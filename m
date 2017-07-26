Received: from eggs.gnu.org ([2001:4830:134:3::10]:40212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiong.y.zhang@intel.com>) id 1daEnW-0007ri-Af
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiong.y.zhang@intel.com>) id 1daEnT-0005RG-6U
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:23:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:27741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiong.y.zhang@intel.com>)
	id 1daEnS-0005Qc-LG
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:23:47 -0400
From: "Zhang, Xiong Y" <xiong.y.zhang@intel.com>
Date: Wed, 26 Jul 2017 05:22:09 +0000
Message-ID: <8082FF9BCB2B054996454E47167FF4EC1C56E3CC@SHSMSX104.ccr.corp.intel.com>
References: <20170724120729.24350-1-dmitry@daynix.com>
	<20170725093148.3898b2da@w520.home>
In-Reply-To: <20170725093148.3898b2da@w520.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vfio/pci-quirks: Set non-zero GMS memory
 size for IGD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zhang, Xiong Y" <xiong.y.zhang@intel.com>

Sorry, we indeed found Intel windows guest graphic driver couldn't be bind =
when GMS memory size is zero. And we have fixed it and the next intel windo=
ws driver release will contain this fix.
So currently please use x-igd-gms in legacy mode to work around this.=20

BTW, how did you know window driver allocate extra ~4G memory when GMS size=
 set to 0 ?

thanks
> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Tuesday, July 25, 2017 11:32 PM
> To: Dmitry Fleytman <dmitry@daynix.com>
> Cc: qemu-devel@nongnu.org; Zhang, Xiong Y <xiong.y.zhang@intel.com>
> Subject: Re: [PATCH] vfio/pci-quirks: Set non-zero GMS memory size for IG=
D
>=20
> [cc +Zhang, Xiong Y]
>=20
>=20
> Intel, any comments?
>=20
>=20
> On Mon, 24 Jul 2017 15:07:29 +0300
> Dmitry Fleytman <dmitry@daynix.com> wrote:
>=20
> > There is a claim that GMS memory is unused however
> > Intel Windows 10 drivers starting from V.4534 (10/7/2016)
> > allocate extra ~4G memory when GMS size set to 0.
> >
> > This patch fixes this issue by seting IGD GMS memory
> > size to minimum by changing default value of x-igd-gms
> > device parameter.
> >
> > Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
> > ---
> >  hw/vfio/pci-quirks.c | 13 +++++++++----
> >  hw/vfio/pci.c        |  2 +-
> >  2 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > index 349085e..197cb90 100644
> > --- a/hw/vfio/pci-quirks.c
> > +++ b/hw/vfio/pci-quirks.c
> > @@ -1527,10 +1527,15 @@ static void
> vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> >      }
> >
> >      /*
> > -     * Assume we have no GMS memory, but allow it to be overrided by
> device
> > -     * option (experimental).  The spec doesn't actually allow zero GM=
S
> when
> > -     * when IVD (IGD VGA Disable) is clear, but the claim is that it's=
 unused,
> > -     * so let's not waste VM memory for it.
> > +     * There is a claim that GMS memory is unused and we want to waste
> for it
> > +     * as less VM memory as possible, however Intel Windows 10 drivers
> starting
> > +     * from V.4534 (10/7/2016) allocate extra ~4G memory when GMS
> size set to 0.
> > +     * The spec as well doesn't actually allow zero GMS when IVD
> > +     * (IGD VGA Disable) is clear.
> > +     *
> > +     * Therefore we set GMS memory size to minimal by default via devi=
ce
> > +     * option x-igd-gms (experimental) and allow further tweaking of t=
his
> > +     * parameter.
> >       */
> >      gmch &=3D ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index d4051cb..bda07b7 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2982,7 +2982,7 @@ static Property vfio_pci_dev_properties[] =3D {
> >                         sub_vendor_id, PCI_ANY_ID),
> >      DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
> >                         sub_device_id, PCI_ANY_ID),
> > -    DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
> > +    DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 1),
> >      /*
> >       * TODO - support passed fds... is this necessary?
> >       * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
