Received: from eggs.gnu.org ([2001:4830:134:3::10]:39892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Pt2-00048Z-DV
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Pt1-0004oM-8z
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:29:44 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1e0Pt0-0004my-HC
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:29:43 -0400
Date: Fri, 6 Oct 2017 21:23:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006102329.GN10961@umbus.fritz.box>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<150706931752.3830.12126799989731308076@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dPW7zu3hTOhZvCDO"
Content-Disposition: inline
In-Reply-To: <150706931752.3830.12126799989731308076@sif>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qdev/vfio: defer DEVICE_DEL
 to avoid races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com


--dPW7zu3hTOhZvCDO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2017 at 05:21:57PM -0500, Michael Roth wrote:
> Quoting Michael Roth (2017-07-26 20:30:52)
> > This series was motivated by the discussion in this thread:
> >=20
> >   https://www.redhat.com/archives/libvir-list/2017-June/msg01370.html
> >=20
> > The issue this series addresses is that when libvirt unplugs a VFIO PCI=
 device,
> > it may attempt to bind the host device back to the host driver when QEM=
U emits
> > the DEVICE_DELETED event for the corresponding vfio-pci device. However=
, the
> > VFIO group FD is not actually cleaned up until vfio-pci device is *fina=
lized*
> > by QEMU, whereas the event is emitted earlier during device_unparent.
> > Depending on the host device and how long certain operations like reset=
ting the
> > device might take, this can in result in libvirt trying to rebind the d=
evice
> > back to the host while it is still in use by VFIO, leading to host cras=
hes or
> > other unexpected behavior.
> >=20
> > In particular, Mellanox CX4 adapters on PowerNV hosts might not be fully
> > quiesced by vfio-pci's finalize() routine until up to 6s after the
> > DEVICE_DELETED was emitted, leading to detach-device on the libvirt sid=
e pretty
> > much always crashing the host.
> >=20
> > Implementing this change requires 2 prereqs to ensure the same informat=
ion is
> > available when the DEVICE_DELETED is finally emitted:
> >=20
> > 1) Storing the path in the composition patch, which is addressed by PAT=
CH 1,
> >    which was plucked from another pending series from Greg Kurz:
> >=20
> >    https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07922.html
> >=20
> >    since we are now "disconnected" at the time the event is emitted, and
> >=20
> > 2) Deferring qemu_opts_del of the DeviceState->QemuOpts till finalize, =
since
> >    that is where DeviceState->id is stored. This was actually how it was
> >    done in the past, so PATCH 2 simply reverts the change which moved i=
t to
> >    device_unparent.
> >=20
> > From there it's just a mechanical move of the event from device_unparen=
t to
> > device_finalize.
>=20
> Ping.

I think it got forgotten amongst the rush to get v2.10 out.

> The situation has changed somewhat since original posting as Alex now
> has a fix on the kernel side for the VFIO issue noted above:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D6586b561a91cd80a91c8f107ed0d144feb3eadc2
>=20
> However, I think this series would still be useful for addressing the
> issue for hosts using older kernels, and there seems to be general
> interest from the libvirt side in aligning "DEVICE_DELETED" events
> with the notion that QEMU is completely finished with a device.
>=20
> Patch 1/3 is also needed for another series that Greg is working on
> and I don't want to hold that up for this series, so if it's
> preferred that we just post that patch separately in the meantime
> please let me know.

Yeah, now that I've understood the issue properly, I also think this
is a good idea.  I recommend reposting.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dPW7zu3hTOhZvCDO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXWaEACgkQbDjKyiDZ
s5KH/g/+KLTmA2jm558TiGdm6zyGwOUxfz0iZoN/hWAxC1/uf2sOcRIwSKIwemTL
VuqDryBtEOeT0EOpTRh7xTYXAZJuAjZtnXpj7EVi0o/iLY93VYwXMDOKk80Xxs6J
9TO7+uoMFE6lHDs1l8RyeUDWmmeuaDzMQoX03Th4YjCGJ2ZBOzoIme4o+dRQHYr/
k7Nc4D/EpGnU+4So0iENtqMelCH4I4T1KmrHHSoMnC+pQjrtYMDfCIw7PErR0e1a
n4SNGe1ECnVKP8NNxRmL1BoKPaCiT0U+di8tsRSfao+6m6lJcqBFpTWGTYejd1Ni
U7hJr1wstWdDcnYMm2SsxtCFlfSSsBgnkbov1AdOOnCU7VTNlHM113dMDcY3cfd2
ccgfPuOYXHNSNMPEbLBTQPfmochHs/vRqsZCcDCtG8E3jwvIL2GbFrGM6wIMBIjc
63QhjbTZrg3ALm2wDe2X4z7FO14wn+p5pglhOkHh42nHPNZnIAlSBw0/kTmjffmd
q0WYcaWcGaX74+Ni/xYMJUupwKaehA0PVUYHjriyuItT4zhvbmVfNb/Me8Ygl5F5
MZZSBbWctAsyw/9GtRHv3G1YM0DE7ydbgsOpfq/6JafumjU//Unuk5gPe9dsSqtc
JNFVjfX336pr/QkhJEZy8Ug2aAR8fSRKKzOB5NcIZqqcjESEibg=
=+6mv
-----END PGP SIGNATURE-----

--dPW7zu3hTOhZvCDO--
