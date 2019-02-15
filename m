Received: from eggs.gnu.org ([209.51.188.92]:40522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guUkS-0007uT-NB
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 23:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guUd9-0004sV-0F
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:57:39 -0500
Date: Fri, 15 Feb 2019 14:54:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190215035447.GI4573@umbus.fritz.box>
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214163743.7162ad53@w520.home>
	<f8effbfc-e42e-acad-d141-a84a8aa04b92@ozlabs.ru>
	<20190215032436.GG4573@umbus.fritz.box>
	<d6f2f973-f57a-f5f0-c20b-9a574e05bd7b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Content-Disposition: inline
In-Reply-To: <d6f2f973-f57a-f5f0-c20b-9a574e05bd7b@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2 0/4] spapr_pci,
 vfio: NVIDIA V100 + POWER9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 02:32:14PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 15/02/2019 14:24, David Gibson wrote:
> > On Fri, Feb 15, 2019 at 11:35:02AM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 15/02/2019 10:37, Alex Williamson wrote:
> >>> On Thu, 14 Feb 2019 16:21:40 +1100
> >>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>
> >>>> This is for passing through NVIDIA V100 GPUs on POWER9 systems.
> >>>>
> >>>> This implements a subdriver for NVIDIA V100 GPU with coherent memory=
 and
> >>>> NPU/ATS support available in the POWER9 CPU.
> >>>>
> >>>> 1/4 is a preparation for bigger DMA windows.
> >>>> 2/4 is a small cleanup.
> >>>>
> >>>> Here is the kernel driver:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/drivers/vfio/pci?h=3Dv5.0-rc6&id=3D7f92891778dff62303c070ac81de7b7d80=
de331a
> >>>>
> >>>> SLOF changes already went in.
> >>>>
> >>>> This depends on "pci: Move NVIDIA vendor id to the rest of ids" (pos=
ted separately).
> >>>
> >>> TBH, I'm not sure it was the best idea to let it live or die on it's
> >>> own when it now creates a build dependency for this series.
> >> I am sure that patch is disgustingly primitive and can make it to
> >> upstream in just one click and the rest of the series will take more
> >> time anyway (always does :) ).
> >>
> >>>> This is based on sha1
> >>>> 1ea6057 Mark Cave-Ayland "mac_newworld: change default NIC to sungem=
 for mac99 machine".
> >>>
> >>> Perhaps this is why it doesn't apply cleanly against qemu.git.  Are
> >>> there dependencies we need to wait for in the ppc tree as well?
> >>
> >> There are few changes in spapr_pci so conflicts are possible, every ti=
me
> >> when David updates his tree and I rebase I get some minor ones.
> >>
> >>>> Please comment. Thanks.
> >>>
> >>> Besides the build dependency on PCI_VENDOR_ID_NVIDIA, I also get this:
> >>>
> >>> .../qemu.git/hw/vfio/spapr.c: In function =E2=80=98vfio_spapr_create_=
window=E2=80=99:
> >>> .../qemu.git/hw/vfio/spapr.c:212:9: error: =E2=80=98ret=E2=80=99 may =
be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >>>          error_report("Failed to create a window, ret =3D %d (%m)", r=
et);
> >>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> cc1: all warnings being treated as errors
> >>
> >> Agrh. How exactly do you make them errors, not warnings? I get no
> >> warning/error with --disable-werror but not having  --disable-werror
> >> prints warnings, not errors so it does not fail the build and easy to =
miss.
> >=20
> > Are you sure it's printing warnings with --enable-werror?  Otherwise
> > it sounds like you just have a compiler version that's not picking
> > this up.
>=20
> Ah, here is my mistake - I thought not having --disable-werror means
> that it is enabled as ./configure does not advertise  "--enable-werror":
>=20
> [fstn1-p1 qemu]$ ./configure --help | grep werror
>   --disable-werror         disable compilation abort on warning
>=20
>=20
> Apparently it is a tri-state flag :)

Um.. no.. I believe it should be on by default as well, I was just
saying --enable-werror because I thought it was clearer than the
double negative in "without --disable-werror".

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxmOAcACgkQbDjKyiDZ
s5JJuBAAlllhFIB/ynWR599Zvq3EoeCAB1K3KYvPHqBTwAorfbu0kkzFQCsQm/dd
O/Sp+PSJJAq6piiT2AeyaIFeTBk3QIggwdHOCts1fEvrOAT+W3T0Au+3IGtxGWS5
yyt4d+fgM+NtjEFmn/TvMwqtwEYtyUPnHVim7RZL844Mkl6CnKWJ7YZfVZznUIGi
0HWiXgxByqvcy0XTOdSd0Uuhs5ZpQ3XhZWcVkwnw88zMqIkdUGVkH/ZF9UUEeUXU
68JwY68dnXPE8vD2JeC4kbcYngrnCEaODoZIMUWqKD3SX730K0R9lWrcgGYDLi/E
TRYC/DzLO7Igo3k00AzQOK47Cjr0pIhBA6o4B775muiC6pfaidnarZOq/D+/e1Ro
ZgY/lRwW+L5oIcdVH4ETNrpC408woCxQDDFP1KFwpfkTYmLBsLNq2a0kqaG2+/gl
wPTCRQzWDld6t/xUioHQdmhE10R8tm2iimxoaaIpwTPg/yahzEm0PdrKZUMC5Up1
KHTSCZtnSkNIFjQG8OWVe0auLJWyJXcrqPOuv85bFvbNSrGsFuamI66oubkoHYVN
QZ2hvZExURqTOHf4U/Zk1BKHW9GbZW7EBAONKP6OYDpVy2QjeqJ6CsyzjX0hk4n4
tJDWUkIC+/gnjBHLQnnPXZsp4hx8ZOLjZr84G6t8+bii27VECPg=
=5xfv
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--
