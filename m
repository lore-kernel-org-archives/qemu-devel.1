Received: from eggs.gnu.org ([2001:4830:134:3::10]:36720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzckO-0002Qv-Vw
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 02:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzckN-0003qj-SJ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 02:01:33 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dzckN-0003q9-4j
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 02:01:31 -0400
Date: Wed, 4 Oct 2017 17:01:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171004060102.GU3260@umbus.fritz.box>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<150706931752.3830.12126799989731308076@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dg6Tyglv1qyvGx3q"
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


--dg6Tyglv1qyvGx3q
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
>=20
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

Yeah, I'd been meaning to ask you about this.  I think it just got
lost in the rush of things for qemu-2.10.  I think it would be worth
rebasing and reposting.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dg6Tyglv1qyvGx3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnUeR4ACgkQbDjKyiDZ
s5KapRAAuGAWbkBLYJHmQt2JDTI2crjpq04BTCMfO29gjDI98iQCxS9K8a0X/sOB
tmUQGPy89buLpzy7BZJZRcuodCHlOhQcp7Q4FsdoS0KwHBEjt9eMgrbUd1Y7FAZ6
BdPXH387h6PbDlgYeQl3pEezNBcMkhj/OSTbPdQRWwExlZBEwYjhhiZi1DiPyQqv
t4zE/nqTnUI8zx0EQPgSQwcHr6fyOAUmVH837tk1GAVotcge6jcg1ImhXNgB0Kiy
Yb9pDlls3x9p5rZzjhLIIpdBPC7zNodRMk9blQLgbAIrQXXoroMoLvoBGf29tSrE
OXjFhLs90lnKRR3M/hqgNUgGuJfiy3vl+iWcHyV1JMEN0Z90pDGZu3bCHuMytnYj
HG7lCMl3ycywR3lJgC2Ke9ENQm6sLgLSra7tmaDCdqP+RC6AGM1r0Ucri6rEqQa4
p4rMUD1OQG0qkm7EOAc4Y+jI5e/EXh7Nzvkf0h0yCJW/TJbnawcjvGwr7Ms2jgAZ
kjyMPQZIo5WqmcSl0OC6Ov7lUtoUs9TjrKMvj9d9Xsb+N4uzTy3mYefFIe/9pb/y
DNbgNecl/r6YAq2artyP4/Dq/L7bwnRRBaCCMMhDiLaiFMmM3BKjKfaMhBmHcD7W
QuBesG650S5MRSBjlPPBS3B0QHZRQ3PhmIhgOK/rmAJDC9BFD/I=
=piJH
-----END PGP SIGNATURE-----

--dg6Tyglv1qyvGx3q--
