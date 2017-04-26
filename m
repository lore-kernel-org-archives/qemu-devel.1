Received: from eggs.gnu.org ([2001:4830:134:3::10]:41920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Ddx-0007vd-L2
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Ddu-0000Fc-GR
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:29:29 -0400
Date: Wed, 26 Apr 2017 12:38:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170426023843.GJ16882@umbus.fritz.box>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
	<CAFEAcA-SR5LXw4uw_Xid94JTarDBpVO2nkGb2axRUu2BcX318Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pMCBjikF2xGw87uL"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-SR5LXw4uw_Xid94JTarDBpVO2nkGb2axRUu2BcX318Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/47] ppc-for-2.10 queue 20170424
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--pMCBjikF2xGw87uL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2017 at 02:12:19PM +0100, Peter Maydell wrote:
> On 24 April 2017 at 02:58, David Gibson <david@gibson.dropbear.id.au> wro=
te:
> > The following changes since commit 32c7e0ab755745e961f1772e95cac381cc68=
769d:
> >
> >   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/201=
70421' into staging (2017-04-21 15:59:27 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170424
> >
> > for you to fetch changes up to 4cab48942a1c5353f0a314fab1aa85a5f0a61461:
> >
> >   target/ppc: Style fixes (2017-04-24 08:56:19 +1000)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2017-04-24
> >
> > Here's my first pull request for qemu-2.10, consisting of assorted
> > patches which have accumulated while qemu-2.9 stabilized.  Highlights
> > are:
> >     * Rework / cleanup of the XICS interrupt controller
> >     * Substantial improvement to the 'powernv' machine type
> >         - Includes an MMIO XICS version
> >     * POWER9 support improvements
> >         - POWER9 guests with KVM
> >         - Partial support for POWER9 guests with TCG
> >     * IOMMU and VFIO improvements
> >     * Assorted minor changes
> >
> > There are several IPMI patches here that aren't usually in my area of
> > maintenance, but there isn't a regular maintainer and these patches
> > are for the benefit of the powernv machine type.
>=20
>=20
> Hi -- I'm afraid this pullreq generates a new clang sanitizer warning
> running 'make check':

Drat.  What do I need to do to see these warnings?  Sounds like I
should add that to my pre-pull-request testing sequence.  Just
building with clang (on Fedora 25) and running make check doesn't seem
to be sufficient.

> /home/petmay01/linaro/qemu-for-merges/hw/core/loader.c:67:15: runtime
> error: null pointer passed as argument 1, which is declared to never
> be null
>=20
> It looks like we try to call open(NULL, ...).
>=20
> Affected tests are in check-qtest-i386:
> tests/bios-tables-test
>   /i386/acpi/piix4/ipmi
>   /i386/acpi/q35/ipmi
> tests/ipmi-kcs-test
>=20
> Here's a backtrace:
>=20
> #0  0x00005555567e6197 in get_image_size (filename=3D0x0) at
> /home/petmay01/linaro/qemu-for-merges/hw/core/loader.c:67
> #1  0x00005555568ead3c in ipmi_fru_init (fru=3D0x55555ab98588)
>     at /home/petmay01/linaro/qemu-for-merges/hw/ipmi/ipmi_bmc_sim.c:1902
> #2  0x00005555568e91ac in ipmi_sim_realize (dev=3D<optimised out>,
> errp=3D<optimised out>)
>     at /home/petmay01/linaro/qemu-for-merges/hw/ipmi/ipmi_bmc_sim.c:1943
> #3  0x00005555567d6df6 in device_set_realized (obj=3D<optimised out>,
> value=3D<optimised out>, errp=3D<optimised out>)
>     at /home/petmay01/linaro/qemu-for-merges/hw/core/qdev.c:905
> #4  0x0000555556d7b1f8 in property_set_bool (obj=3D0x55555ab93c90,
> v=3D<optimised out>, name=3D<optimised out>, opaque=3D<optimised out>,
> errp=3D0x7fffffffde90) at
> /home/petmay01/linaro/qemu-for-merges/qom/object.c:1860
> #5  0x0000555556d7dd1d in object_property_set_qobject (obj=3D0x0,
> value=3D<optimised out>, name=3D0x58fdf801 <error: Cannot access memory at
> address 0x58fdf801>, errp=3D0x1) at
> /home/petmay01/linaro/qemu-for-merges/qom/qom-qobject.c:27
> #6  0x0000555556d78cb2 in object_property_set_bool
> (obj=3D0x55555ab93c90, value=3D<optimised out>, name=3D0x55555710e087
> "realized", errp=3D0x7fffffffde90) at
> /home/petmay01/linaro/qemu-for-merges/qom/object.c:1163
> #7  0x000055555661d80d in qdev_device_add (opts=3D<optimised out>,
> errp=3D<optimised out>)
>     at /home/petmay01/linaro/qemu-for-merges/qdev-monitor.c:630
> #8  0x00005555566374cb in device_init_func (opaque=3D<optimised out>,
> opts=3D0x0, errp=3D0x58fdf801)
>     at /home/petmay01/linaro/qemu-for-merges/vl.c:2305
> #9  0x000055555701dc81 in qemu_opts_foreach (list=3D<optimised out>,
> func=3D<optimised out>, opaque=3D<optimised out>, errp=3D<optimised out>)=
 at
> /home/petmay01/linaro/qemu-for-merges/util/qemu-option.c:1114
> #10 0x0000555556633289 in main (argc=3D<optimised out>, argv=3D<optimised
> out>, envp=3D<optimised out>)
>     at /home/petmay01/linaro/qemu-for-merges/vl.c:4583
>=20
> It looks like the device doesn't handle not having its fru.filename
> property set -- this should either cause an error in realize or the
> rest of the device code should handle NULL.
>=20
> thanks
> -- PMM
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pMCBjikF2xGw87uL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZAAgvAAoJEGw4ysog2bOSjMIQANCX2RjVYS3FD6b0KZrLGPQ9
S8SM21DGLAecuRCscyu5nMQ0y5EoOhdaSefSjsXC4G9xCdTUfUrVhfaECiVEaJPz
csokU0OAJqJDyyId8+KMT/HdzHmW+KXWLtQVYZkHPG5USlRBPPDEH5A1ijq327gd
hAFSH2B3q80btcnG2nGqt9FF4Kpt224ipKkcS45DSK8t6Ugium8R7dQiEC6ynRH0
f9RkpsXxHH69q+paNNRWybfd1r6n61zN8MIvQhrFP8I9VgR9JCW5doloVDnyg+II
MLB3fE2psBC4VZzVDH5ccDNr1umL+FjxH7Mb0fvJtsgjNjvgPECCVWp3JzfDR86B
TgzbU7XegYAPqo3V6KgooZ1xhc1vemEgHPdK+Tr0RuO+3OlGPu2wHXaSHbp+Vtnr
eqXcgaTAGQaCDCiQm5QNs3h1VXrmd2EspXJdSgO4LZS6a6xBkLtLloC2R+6d3aNw
xxkUGKPPcHuIw1QOZCpLJp04CV4SYV8gN7zCQIHrdS3QGvPlLN+NJbM+1Is70I9t
T36zFJuUhCEmxCyBN5YsplY6cGH0UOcKlCoyHYUuR66w7DRZgsFL2nNYqjlTqcsR
wW0Dy2CWGLMH7fmYbRSXl7Tj4+QVbPiQNZcB24BihcktrINnUfIe22ZMJXGtKETS
gr/vA+HZ20+5F68haqT/
=3zBJ
-----END PGP SIGNATURE-----

--pMCBjikF2xGw87uL--
