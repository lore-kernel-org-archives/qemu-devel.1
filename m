Received: from eggs.gnu.org ([2001:4830:134:3::10]:37240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiong.y.zhang@intel.com>) id 1cg2Na-00036L-97
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiong.y.zhang@intel.com>) id 1cg2NX-0006FH-2z
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:48:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:32051)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiong.y.zhang@intel.com>)
	id 1cg2NW-0006Ew-Od
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:48:43 -0500
From: "Zhang, Xiong Y" <xiong.y.zhang@intel.com>
Date: Tue, 21 Feb 2017 04:48:29 +0000
Message-ID: <8082FF9BCB2B054996454E47167FF4EC1C43E690@SHSMSX104.ccr.corp.intel.com>
References: <20170220114254.12265-1-xiong.y.zhang@intel.com>
	<20170220131541.0af48a8a@t450s.home>
In-Reply-To: <20170220131541.0af48a8a@t450s.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vfio/pci-quirks.c: Disable stolen memory
 for igd VFIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Song, Jike" <jike.song@intel.com>, "Lv, Zhiyuan" <zhiyuan.lv@intel.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "Zhang, Xiong Y" <xiong.y.zhang@intel.com>

>=20
> On Mon, 20 Feb 2017 19:42:54 +0800
> Xiong Zhang <xiong.y.zhang@intel.com> wrote:
>=20
> > From: XiongZhang <xiong.y.zhang@intel.com>
> >
> > If IGD isn't assigned at 00:02.0 in UPT and host bios enable stolen
> > memory, seabios won't reseave stolen memory in E820 for guest. Then
> > both Intel graphic driver and others in guest could use stolen
> > memory, this will generate system hang. So we should disable stolen
> > memory in this case.
>=20
> Wasn't the intent of UPT mode that it removed all of the BIOS and
> chipset dependencies of IGD such that it could be assigned as just
> another PCI device?  Does this mean that the drivers fail to meet that
> promise by evaluating the size and location of stolen memory as
> programmed on the physical device even in UPT mode?
[Zhang, Xiong Y] The intent of UPT mode is correct. Driver also evaluate
the size and location of stolen memory correctly.
The current problem is: when IGD isn't at 00:02.0, seabios don't create mem=
ory
region and reserve memory resource in E820 for stolen memory.
So guest OS maybe assign stolen memory MMIO to other devices, when IGD driv=
er
access stolen memory, it access the wrong device and cause system error.=20
If guest OS don't assign stolen memory MMIO to other devices, then there
isn't gpa to hpa translate for stolen memory, guest IGD driver couldn't
access it.=20
>=20
> I'm a little confused by the use of the term "others" here and in the
> comment below.  Can you be more specific what other software beyond the
> graphics driver is evaluating the size or location of stolen memory?
>=20
> > Bugzilla:https://bugs.freedesktop.org/show_bug.cgi?id=3D99028
> >          https://bugs.freedesktop.org/show_bug.cgi?id=3D99025
> >
> > Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> > Tested-by: Terrence Xu <terrence.xu@intel.com>
> > ---
> >  hw/vfio/pci-quirks.c | 63
> ++++++++++++++++++++++++++++++----------------------
> >  1 file changed, 36 insertions(+), 27 deletions(-)
> >
> > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > index 1e97bc4..015d0c2 100644
> > --- a/hw/vfio/pci-quirks.c
> > +++ b/hw/vfio/pci-quirks.c
> > @@ -1364,14 +1364,43 @@ static void
> vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> >      uint32_t gmch;
> >      uint16_t cmd_orig, cmd;
> >
> > +    /* This must be an Intel VGA device. */
> > +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> > +        !vfio_is_vga(vdev) || nr !=3D 4) {
> > +        return;
> > +    }
> > +
> >      /*
> > -     * This must be an Intel VGA device at address 00:02.0 for us to e=
ven
> > -     * consider enabling legacy mode.  The vBIOS has dependencies on
> the
> > -     * PCI bus address.
> > +     * IGD is not a standard, they like to change their specs often.  =
We
> > +     * only attempt to support back to SandBridge and we hope that
> newer
> > +     * devices maintain compatibility with generation 8.
> >       */
> > -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> > -        !vfio_is_vga(vdev) || nr !=3D 4 ||
> > -        &vdev->pdev !=3D
> pci_find_device(pci_device_root_bus(&vdev->pdev),
> > +    gen =3D igd_gen(vdev);
> > +    if (gen !=3D 6 && gen !=3D 8) {
> > +        error_report("IGD device %s is unsupported in legacy mode, "
> > +                     "try SandyBridge or newer",
> vdev->vbasedev.name);
>=20
> This is a little bit misleading now since this is no longer exclusively
> a legacy mode path, a user trying to use UPT mode might disregard this
> as noise.  Perhaps...
>=20
>     error_report("IGD device %s is unsupported by IGD quirks, "
>                  "try SandyBridge or newer", vdev->vbasedev.name);
>=20
>=20
> > +        return;
> > +    }
> > +    /*
> > +     * If this isn't at address 00:02.0, bios won't reserv stolen
>=20
> s/reserv/reserve/
>=20
> > +     * memory in E820, then others could use stolen memory. If guest
> > +     * graphic driver still use stolen memory, system maybe hang.
> > +     * so we set stolen memory size to 0 and guest graphic driver won'=
t
> > +     * use stolen memory.
>=20
> Based on my understanding of the bug, I might suggest:
>=20
>   Regardless of running in UPT or legacy mode, the guest graphics
>   driver may attempt to use stolen memory, however only legacy mode has
>   BIOS support for reserving stolen memory in the guest VM.  Emulate
>   the GMCH register in all cases and zero out the stolen memory size
>   here.  Legacy mode may request allocation and re-write this below.
>=20
> > +     */
> > +    gmch =3D vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
> > +    gmch &=3D ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
> > +
> > +    /* GMCH is read-only, emulated */
> > +    pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
> > +    pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
> > +    pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
> > +
> > +    /*
> > +     * This must be at address 00:02.0 for us to even onsider enabling
> > +     * legacy mode.  The vBIOS has dependencies on the PCI bus address=
.
> > +     */
> > +    if (&vdev->pdev !=3D pci_find_device(pci_device_root_bus(&vdev->pd=
ev),
> >                                         0, PCI_DEVFN(0x2, 0))) {
> >          return;
> >      }
> > @@ -1391,18 +1420,6 @@ static void
> vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> >      }
> >
> >      /*
> > -     * IGD is not a standard, they like to change their specs often.  =
We
> > -     * only attempt to support back to SandBridge and we hope that new=
er
> > -     * devices maintain compatibility with generation 8.
> > -     */
> > -    gen =3D igd_gen(vdev);
> > -    if (gen !=3D 6 && gen !=3D 8) {
> > -        error_report("IGD device %s is unsupported in legacy mode, "
> > -                     "try SandyBridge or newer", vdev->vbasedev.name);
> > -        return;
> > -    }
> > -
> > -    /*
> >       * Most of what we're doing here is to enable the ROM to run, so i=
f
> >       * there's no ROM, there's no point in setting up this quirk.
> >       * NB. We only seem to get BIOS ROMs, so a UEFI VM would need
> CSM support.
> > @@ -1457,8 +1474,6 @@ static void
> vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> >          goto out;
> >      }
> >
> > -    gmch =3D vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
> > -
> >      /*
> >       * If IGD VGA Disable is clear (expected) and VGA is not already
> enabled,
> >       * try to enable it.  Probably shouldn't be using legacy mode with=
out
> VGA,
> > @@ -1526,12 +1541,11 @@ static void
> vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> >       * when IVD (IGD VGA Disable) is clear, but the claim is that it's
> unused,
> >       * so let's not waste VM memory for it.
> >       */
> > -    gmch &=3D ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
> > -
> >      if (vdev->igd_gms) {
> >          if (vdev->igd_gms <=3D 0x10) {
> >              gms_mb =3D vdev->igd_gms * 32;
> >              gmch |=3D vdev->igd_gms << (gen < 8 ? 3 : 8);
> > +            pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
> >          } else {
> >              error_report("Unsupported IGD GMS value 0x%x",
> vdev->igd_gms);
> >              vdev->igd_gms =3D 0;
> > @@ -1551,11 +1565,6 @@ static void
> vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> >      fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
> >                      bdsm_size, sizeof(*bdsm_size));
> >
> > -    /* GMCH is read-only, emulated */
> > -    pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
> > -    pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
> > -    pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
> > -
> >      /* BDSM is read-write, emulated.  The BIOS needs to be able to wri=
te
> it */
> >      pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
> >      pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
