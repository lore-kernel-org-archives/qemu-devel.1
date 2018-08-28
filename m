Received: from eggs.gnu.org ([2001:4830:134:3::10]:43297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fuSlr-0006t7-B5
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 21:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fuSlo-0003Zp-61
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 21:26:15 -0400
Received: from ozlabs.org ([203.11.71.1]:44151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fuSln-0003OA-4I
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 21:26:12 -0400
Date: Tue, 28 Aug 2018 10:52:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180828005237.GC2222@umbus.fritz.box>
References: <1535368030-214556-1-git-send-email-imammedo@redhat.com>
	<20180827160239.54cc993a@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20180827160239.54cc993a@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, david@redhat.com, cohuck@redhat.com


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 04:02:39PM +0200, Greg Kurz wrote:
> On Mon, 27 Aug 2018 13:07:10 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > The first cpu unplug wasn't ever supported and corresponding
> > monitor/qmp commands refuse to unplug it. However guest is able
> > to issue eject request either using following command:
> >   # echo 1 >/sys/devices/system/cpu/cpu0/firmware_node/eject
>=20
> I can't reproduce the issue with a pc guest and current master...
>=20
> All I seem to get is an error in dmesg:
>=20
> [   97.435446] processor cpu0: Offline failed.
>=20
> > or directly writing to cpu hotplug registers, which makes
> > qemu crash with SIGSEGV following back trace:
> >=20
> >    kvm_flush_coalesced_mmio_buffer ()
> >        while (ring->first !=3D ring->last)
> >    ...
> >    qemu_flush_coalesced_mmio_buffer
> >    prepare_mmio_access
> >    flatview_read_continue
> >    flatview_read
> >    address_space_read_full
> >    address_space_rw
> >    kvm_cpu_exec(cpu!0)
> >    qemu_kvm_cpu_thread_fn
> >=20
> > the reason for which is that ring =3D=3D KVMState::coalesced_mmio_ring
> > happens to be a part of 1st CPU that was uplugged by guest.
> >=20
> > Fix it by forbidding 1st cpu unplug from guest side and in addition
> > remove CPU0._EJ0 ACPI method to make clear that unplug of the first
> > CPU is not supported.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CCing spapr and s390x folks in case targets need to prevent 1st CPU unp=
lug as well
> >=20
>=20
> A spapr guest can _release_ the first cpu by doing something like:
>=20
> # echo -n "/cpus/PowerPC,POWER8@0" > /sys/devices/system/cpu/release
>=20
> But AFAIK, this doesn't unplug the cpu from a QEMU standpoint.

Unplugging CPU 0 with device_del should be ok too.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluEnNMACgkQbDjKyiDZ
s5KbRg//WXmNNMgisxOqxnQelVDR3+NtaOv17M6fpA1moMYvBo/YIOU1fwdBzjhn
Y/SMvygTeGrjB9g6vCGNKfIVsMkBqQkb3m5Vcp6LM4hfywWwKyilwE1IiH6PvTHx
DTNaDk6pJa2mF4oyb4K9dSfbrrm+DcI9Q5oqS/plLDLuebw1ZORhlCSXbJpzF7wV
fpFlvpamKp/Fzvb9EbKyIAUbsYIa2A3sDiAnzIl0eI56j7LTQumL/I5YEBwrMFWh
zcBZeNHWuP0vX3My8qYtqx1UGo6b2J61NVAWmxFMWV91PZrmJoPRwkQJvFtBtXxz
dmOVR3guXgQkTU5niwx3haruSG1iB6rVNwEJ5DjJkA1RXr52DTymvOWBzY0GXzAl
AdOoTMI7xpS5uam1t3OClh1rFs2QEO6Zj7abPVnMVRW4X2Q2QU2s7Q49dvdBII3D
XLAHigNOykFafqZ79Iw2bDey9iWXZMBa7SQ/baSMS0cZlVPgUqquU74YgCJ42G5n
oDTxQOBNREhtiC675GaNXoXZ/8ZabWEhrlvwT+ivquPkFFesGI6NUqhhMJ60RTT0
ZxlKvjOdqP8rl5VTgDFRKM2kdLtSaTENaLUY+YUVgcAg7aTXUPTp+1Kz0cKL8bXH
u2xDhwCCVuPdaUU6AkIPii1BE01il5wuC2wwWYRzchPhBViE70Q=
=hmui
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
