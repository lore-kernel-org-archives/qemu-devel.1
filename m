Received: from eggs.gnu.org ([2001:4830:134:3::10]:46348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkLKL-0001Oq-4m
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 23:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkLKH-0007eT-1c
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 23:28:01 -0400
Received: from ozlabs.org ([203.11.71.1]:46721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fkLKF-0007Xf-Tw
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 23:27:56 -0400
Date: Tue, 31 Jul 2018 13:25:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180731032559.GH2708@umbus.fritz.box>
References: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
	<20180727052724.GJ3694@umbus.fritz.box>
	<20180727095452.45edee8b@bahia>
	<20180730055715.GD2708@umbus.fritz.box>
	<20180730104145.109ef196@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <20180730104145.109ef196@bahia.lan>
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
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 10:41:45AM +0200, Greg Kurz wrote:
> On Mon, 30 Jul 2018 15:57:15 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Jul 27, 2018 at 09:54:52AM +0200, Greg Kurz wrote:
> > > On Fri, 27 Jul 2018 15:27:24 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Wed, Jul 25, 2018 at 04:45:26PM +0200, Greg Kurz wrote: =20
> > > > > Commit b585395b655 fixed a regression introduced by some recent c=
hanges
> > > > > in the XICS code, that was causing QEMU to crash instantly during=
 CPU
> > > > > hotplug with KVM. This is typically the kind of bug we'd like our
> > > > > test suite to detect before it gets merged. Unfortunately, the cu=
rrent
> > > > > tests run with '-machine accel=3Dqtest' and don't exercise KVM sp=
ecific
> > > > > paths in QEMU.
> > > > >=20
> > > > > This patch hence changes add_pseries_test_case() to launch QEMU w=
ith
> > > > > '-machine accel=3Dkvm' if KVM is available.
> > > > >=20
> > > > > A notable consequence is that the guest will execute SLOF, but fo=
r some
> > > > > reasons SLOF sometimes hits a program exception. This causes the =
guest
> > > > > to loop forever and the test to be stuck.  Since we don't need th=
e guest
> > > > > to be truely running, let's pass -S to QEMU to avoid that.
> > > > >=20
> > > > > Also disable machine capabilities that could be unavailable in KV=
M, eg,
> > > > > when using PR KVM.
> > > > >=20
> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>   =20
> > > >=20
> > > > I'm pretty sure trying to change the accelerator on a qtest test ju=
st
> > > > doesn't make sense.  We'd need a different approach for testing cpu
> > > > hotplug against kvm & tcg backends.
> > > >  =20
> > >=20
> > > The test starts QEMU, triggers the CPU hotplug code with a QMP command
> > > and checks the command didn't fail (or QEMU didn't crash, as it would
> > > have before commit b585395b655a)... I really don't understand what
> > > is wrong with that... Please elaborate. =20
> >=20
> > Well, ok, let me turn that around.  A test that doesn't rely on
> > controlling the guest side behaviour at all probably shouldn't be a
> > qtest based test, since that's what qtest is all about.
> >=20
>=20
> The CPU hotplug test doesn't seem to do anything on the guest side: it
> just checks that 'device_add' returns a response that isn't an
> error.

Right, which makes this ill suited to being a qtest test.  The whole
point of qtest is making it easier to test qemu peripherals without
having to have specific test code within the guest, by essentially
replacing the guest's cpu with a stub controlled by the test harness.
That's what the qtest accel is all about.

I think it's confusing to have a test which tries things with both
qtest and kvm accelerators.  Looking like a qtest test, people might
reasonably think they can extend/refine the test to check behaviour
when the guest does respond to the hotplug events.  But such an
extension won't work with the kvm accel, because the qtest code used
to simulate that guest response won't have any effect with kvm.

> I'm not aware that the guest is expected to have a specific behavior
> during 'device_add', apart from not crashing or hanging. That was the
> initial idea behind passing '-S' to ensure the guest doesn't run.

Note that with qtest (or -S) we don't even test that minimal
condition.  We only test that *qemu* doesn't crash - it could fatally
compromise the guest and the test would never know.

> Your remark seems to be more general though... are you meaning that
> doing something like qtest_start("-machine accel=3Dkvm:tcg") is just
> wrong ?

Pretty much, yes.  A non-qtest test which does that is reasonable, but
not a qtest test.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltf1sQACgkQbDjKyiDZ
s5K0/xAAgbNnMD3AbMwtUAA4R9LS0t4Gwec5PKgmAHRQ3FcA/7U073kY0JwUpD6T
8yZ0Boryv+ovlUrIHb82azSpmOihYodkPyWW0tcRUZ0Efx/RaoEUvAhN0wq5sZV3
3kTgMq7x89VaytTtBFEMDar1MokZ7vsZm1FLVezFR473B9utrUkGCXdNevZy+NPJ
gmx6VTJdi0AHN/OQpfrzqfUJyPp3y95b4p22rJ85sW8+ZmM22a5gE0aH1HF/jnXb
BjWTDT7A6qf8APdpsqVaYJBbBw5yupP/p9cursC772mauETi8lzFA4zdKUQvTK1r
AByr5Z13rG2vVXaeVjoK7OvRXZku0HozC874sTx2BiPpbV5ASMeBUdw+F3GHP2D7
xQdW+Xz7f7kSgCsOTF1RJhj5ItPkjX2HnyXwLt/IfI0bXXUFMPRh+vl8Qd2hSE5B
P15UsndstJXxx3EGNlsJV+snSuJ+SKbPbKbqxk4EiqSrpAfBSuIT+ZRtsJBv8EoD
9t8DTt2NN1sVYBlp2GZJ4g1lNINopDqkEQ9+rvwA4vo8TAlDM0kdXM4adyUNLZp+
hAmTpIWZ5/v/zfnMox1ub4txa6eniXYvkv0xzrymHZwmeHtZ0thsnPUwQvabhcww
uf6QEla3O3yB/5wqzMYIxrt2V5At7a2EVjXpr3CssJElleNK66A=
=xhOz
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
