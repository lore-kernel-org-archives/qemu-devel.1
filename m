Received: from eggs.gnu.org ([2001:4830:134:3::10]:59086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fuuu8-0005sk-A9
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 03:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fuuu4-00066C-WB
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 03:28:40 -0400
Received: from ozlabs.org ([203.11.71.1]:34659)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fuuu3-0005zn-SK
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 03:28:36 -0400
Date: Wed, 29 Aug 2018 12:54:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180829025440.GE2222@umbus.fritz.box>
References: <1535368030-214556-1-git-send-email-imammedo@redhat.com>
	<20180827160239.54cc993a@bahia.lan>
	<20180828005237.GC2222@umbus.fritz.box>
	<20180828151848.3d09ca06@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline
In-Reply-To: <20180828151848.3d09ca06@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pc: make sure that guest isn't able to
 unplug the first cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, david@redhat.com, cohuck@redhat.com


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2018 at 03:18:48PM +0200, Igor Mammedov wrote:
> On Tue, 28 Aug 2018 10:52:37 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, Aug 27, 2018 at 04:02:39PM +0200, Greg Kurz wrote:
> > > On Mon, 27 Aug 2018 13:07:10 +0200
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > >  =20
> > > > The first cpu unplug wasn't ever supported and corresponding
> > > > monitor/qmp commands refuse to unplug it. However guest is able
> > > > to issue eject request either using following command:
> > > >   # echo 1 >/sys/devices/system/cpu/cpu0/firmware_node/eject =20
> > >=20
> > > I can't reproduce the issue with a pc guest and current master...
> > >=20
> > > All I seem to get is an error in dmesg:
> > >=20
> > > [   97.435446] processor cpu0: Offline failed.
> > >  =20
> > > > or directly writing to cpu hotplug registers, which makes
> > > > qemu crash with SIGSEGV following back trace:
> > > >=20
> > > >    kvm_flush_coalesced_mmio_buffer ()
> > > >        while (ring->first !=3D ring->last)
> > > >    ...
> > > >    qemu_flush_coalesced_mmio_buffer
> > > >    prepare_mmio_access
> > > >    flatview_read_continue
> > > >    flatview_read
> > > >    address_space_read_full
> > > >    address_space_rw
> > > >    kvm_cpu_exec(cpu!0)
> > > >    qemu_kvm_cpu_thread_fn
> > > >=20
> > > > the reason for which is that ring =3D=3D KVMState::coalesced_mmio_r=
ing
> > > > happens to be a part of 1st CPU that was uplugged by guest.
> > > >=20
> > > > Fix it by forbidding 1st cpu unplug from guest side and in addition
> > > > remove CPU0._EJ0 ACPI method to make clear that unplug of the first
> > > > CPU is not supported.
> > > >=20
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > > CCing spapr and s390x folks in case targets need to prevent 1st CPU=
 unplug as well
> > > >  =20
> > >=20
> > > A spapr guest can _release_ the first cpu by doing something like:
> > >=20
> > > # echo -n "/cpus/PowerPC,POWER8@0" > /sys/devices/system/cpu/release
> > >=20
> > > But AFAIK, this doesn't unplug the cpu from a QEMU standpoint. =20
> >=20
> > Unplugging CPU 0 with device_del should be ok too.
> Do you mean real unplugging (cpu0 object freed) or just remove request?

Real unplugging should be possible.  I'm not sure how thorougly it's
been tested, though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluGCu4ACgkQbDjKyiDZ
s5LtFg//cLVgLSAP83IM40VRMSmJwFblgOJzdTOQEBXb/QyJ5Rr+Ojjh0vpzMt5K
tngAQCiCoEj61tnW88f3ghk+8Hmh2ujBi5VKI1POCvoeJs0S927uWOYUX8ZCnMzW
Wcb9dFDjm9rQq7p/sCTuAAxB8Y+TPCPHV/50Ow1Vle8VLrQ5aLME++CvFu98GTVx
IguXLHF2ikPGKiBJxzD6bYj2rJhVcXdGYqCfc3eCDOIds08uZDc7vms98t1cNgoM
IrXGPgj3sU+q2HWcCTuoKXk+aVPHUlkffOKWQhapab/iZUZmyAwmhUMTG5i0DVwn
bnE+4jfs6yAi8nOmPqT5YZwvqPLT1ryXl1e7MKdP8EjwXEkT/McVJRahlFegLwYm
2AfpRIynoxPvvM1SJkIlPag5PHFOHkUdk74MOK799RtXg/WW8s3pcq42uufpvObk
aAScBrA6bEkqi+9KOk1UZZoFbI7+wD9Ji1y5+UPAfiu+CARPtRSkKL46I1+0TyAc
uTXmoQl11dhcio24vw1BtrtUNJIJh2mwdylziPTyQUawfUcSct3D36wOiPyX77uO
sgdxAyzQmhuiFNFpv8az6HNYNpOKAD54ZAWJDvDXRlSQz4sYcaE6G23YCa4Av2U+
NUACCdOm1fcgosJeTlf7f5+5bI3MxkbtyHCSe/s8geNRpWK+Nc8=
=Q/A/
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
