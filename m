Received: from eggs.gnu.org ([2001:4830:134:3::10]:46339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkLKI-0001Oe-90
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 23:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkLKH-0007eZ-1R
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 23:27:58 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fkLKF-0007Xh-Ty
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 23:27:56 -0400
Date: Tue, 31 Jul 2018 13:27:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180731032715.GI2708@umbus.fritz.box>
References: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
	<20180727052724.GJ3694@umbus.fritz.box>
	<20180727095452.45edee8b@bahia>
	<20180730055715.GD2708@umbus.fritz.box>
	<20180730104145.109ef196@bahia.lan>
	<20180730115900.0ba16809@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Content-Disposition: inline
In-Reply-To: <20180730115900.0ba16809@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-3.1] tests/cpu-plug-test: check CPU
 hotplug on ppc64 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 11:59:00AM +0200, Greg Kurz wrote:
> On Mon, 30 Jul 2018 10:41:45 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Mon, 30 Jul 2018 15:57:15 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> [...]
> > > > > I'm pretty sure trying to change the accelerator on a qtest test =
just
> > > > > doesn't make sense.  We'd need a different approach for testing c=
pu
> > > > > hotplug against kvm & tcg backends.
> > > > >    =20
> > > >=20
> > > > The test starts QEMU, triggers the CPU hotplug code with a QMP comm=
and
> > > > and checks the command didn't fail (or QEMU didn't crash, as it wou=
ld
> > > > have before commit b585395b655a)... I really don't understand what
> > > > is wrong with that... Please elaborate.   =20
> > >=20
> > > Well, ok, let me turn that around.  A test that doesn't rely on
> > > controlling the guest side behaviour at all probably shouldn't be a
> > > qtest based test, since that's what qtest is all about.
> > >  =20
> >=20
> > The CPU hotplug test doesn't seem to do anything on the guest side: it
> > just checks that 'device_add' returns a response that isn't an error.
> > I'm not aware that the guest is expected to have a specific behavior
> > during 'device_add', apart from not crashing or hanging. That was the
> > initial idea behind passing '-S' to ensure the guest doesn't run.
> >=20
> > Your remark seems to be more general though... are you meaning that
> > doing something like qtest_start("-machine accel=3Dkvm:tcg") is just
> > wrong ?
>=20
> The purpose of this test is simply to exercise a path in QEMU that
> is only used with KVM, but it can also be achieved the other way
> around:
>=20
> @@ -189,7 +190,7 @@ static void xics_system_init(MachineState *machine, i=
nt nr_irqs, Error **errp)
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
>      Error *local_err =3D NULL;
> =20
> -    if (kvm_enabled()) {
> +    if (kvm_enabled() || qtest_enabled()) {
>          if (machine_kernel_irqchip_allowed(machine) &&
>              !xics_kvm_init(spapr, &local_err)) {
>=20
> This will test the setup of the in-kernel XICS when run on a book3s host,
> and fallback to emulated XICS otherwise (eg, travis).
>=20
> Would this be more acceptable ?

No, I don't think that will work.  With this we call into kvm related
code via machine_kernel_irqchip_allowed() and xics_kvm_init() even in
the qtest case.  If they work on a host which doesn't have KVM (say
x86) it will only be by sheer accident.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltf1xMACgkQbDjKyiDZ
s5KN+xAA17mDxScr2ZGZMoCmUI4ldUqObagHwtsZsK+ImwPdjEv0MkC4uc4Ukh2j
pmkGyTifvbvu/LBEuWkjR2xN7vzAdhwvgkxAOnQlW6A6KzxAnpB4w0qXeDq3LaJh
ubC0YbmtBV/KcnvF0IZhxS2OqJdBXVDF2scCPvTqYwF3LPBAHiaKo5QBPnZaxn8z
KdQ1IlsD2CUBHEfLLswDQE5Tiu3UpzbDsKyQaHHyX3unyNlIosKIczgeDhkxrOXz
47IYFHNn7F4WuKyYKkpjClmJengr9u30gvkeWAc1AIO/Em3JJ1B5UVOpKRDf3xC7
vPM1yje3dVYaG4KJoAEd4TpzMiDmZ6y2k8woOPM/FuWD5PBDangETksS9vBq5q5V
iPbCWR6/ESdLv8r3c2UEqGWnPzTjPao4qcsBa2covyTSeHh34j5dUcaVHfBtrlVX
MvRVryKWOqs0P1caO5ycjHn4wZbE3S5GP80hfNXKruiyG/c8MoiTJk2q7ymzNlIq
F2VmUt76FhEeROaNUB8IhW/GR9EiwapMUZtl9q03EMcYhSZ4MT2OtzVm3bvvCgnr
PHW/7UsX+0DjD4qG2/mp+Y0kUUzkX9GP6sA3KqCLyNIV+oRlEo94AlzWy82gdfyY
fIwIm5hyonC0s1rQUXcF6+ppx0/Lz+Bg2Mz+FpMFHu0Q6an3UfM=
=oevt
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--
