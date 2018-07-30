Received: from eggs.gnu.org ([2001:4830:134:3::10]:40932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fk3kn-0002Ki-Bs
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fk3kk-00084U-7V
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:42:09 -0400
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:42769)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fk3kj-00081d-Vf
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:42:06 -0400
Received: from player692.ha.ovh.net (unknown [10.109.146.1])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 129131C9C55
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 10:41:58 +0200 (CEST)
Date: Mon, 30 Jul 2018 10:41:45 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180730104145.109ef196@bahia.lan>
In-Reply-To: <20180730055715.GD2708@umbus.fritz.box>
References: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
	<20180727052724.GJ3694@umbus.fritz.box>
	<20180727095452.45edee8b@bahia>
	<20180730055715.GD2708@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/TLlXh=LxAygrM6N=NTlYxmT";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, =?UTF-8?B?Q8Op?= =?UTF-8?B?ZHJpYw==?= Le Goater <clg@kaod.org>

--Sig_/TLlXh=LxAygrM6N=NTlYxmT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Jul 2018 15:57:15 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Jul 27, 2018 at 09:54:52AM +0200, Greg Kurz wrote:
> > On Fri, 27 Jul 2018 15:27:24 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Wed, Jul 25, 2018 at 04:45:26PM +0200, Greg Kurz wrote: =20
> > > > Commit b585395b655 fixed a regression introduced by some recent cha=
nges
> > > > in the XICS code, that was causing QEMU to crash instantly during C=
PU
> > > > hotplug with KVM. This is typically the kind of bug we'd like our
> > > > test suite to detect before it gets merged. Unfortunately, the curr=
ent
> > > > tests run with '-machine accel=3Dqtest' and don't exercise KVM spec=
ific
> > > > paths in QEMU.
> > > >=20
> > > > This patch hence changes add_pseries_test_case() to launch QEMU with
> > > > '-machine accel=3Dkvm' if KVM is available.
> > > >=20
> > > > A notable consequence is that the guest will execute SLOF, but for =
some
> > > > reasons SLOF sometimes hits a program exception. This causes the gu=
est
> > > > to loop forever and the test to be stuck.  Since we don't need the =
guest
> > > > to be truely running, let's pass -S to QEMU to avoid that.
> > > >=20
> > > > Also disable machine capabilities that could be unavailable in KVM,=
 eg,
> > > > when using PR KVM.
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>   =20
> > >=20
> > > I'm pretty sure trying to change the accelerator on a qtest test just
> > > doesn't make sense.  We'd need a different approach for testing cpu
> > > hotplug against kvm & tcg backends.
> > >  =20
> >=20
> > The test starts QEMU, triggers the CPU hotplug code with a QMP command
> > and checks the command didn't fail (or QEMU didn't crash, as it would
> > have before commit b585395b655a)... I really don't understand what
> > is wrong with that... Please elaborate. =20
>=20
> Well, ok, let me turn that around.  A test that doesn't rely on
> controlling the guest side behaviour at all probably shouldn't be a
> qtest based test, since that's what qtest is all about.
>=20

The CPU hotplug test doesn't seem to do anything on the guest side: it
just checks that 'device_add' returns a response that isn't an error.
I'm not aware that the guest is expected to have a specific behavior
during 'device_add', apart from not crashing or hanging. That was the
initial idea behind passing '-S' to ensure the guest doesn't run.

Your remark seems to be more general though... are you meaning that
doing something like qtest_start("-machine accel=3Dkvm:tcg") is just
wrong ?

--Sig_/TLlXh=LxAygrM6N=NTlYxmT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAltez0kACgkQcdTV5YIv
c9Z60g/+JA+Oomx9qmMPL+5aQiqSjkoiR2UGo2euav9CQGCItoYlneUbLqv3csmQ
bkY7Mzq9jQ6XFTEEandloVGhVd5mCyt2wAb3m4pTc9Cnih1ecYjq92+24GrER9Cd
UlvoaUOJZsuqcJ8ASH8riLH+eHepZNxFfOCVjgOyIXjzJ3nFKws2hvNlKYSfXvWI
VtwxpzAg4y1S0hsRfR6Pmfveeo7YisGNQ2Ro5PVBgYJBfL/ly5UDN8N1mGqph4x2
8XQmb/XJ95Hc/L96WGMTUxP+RRgk8Lx27Khg07jJCnkm1Lq0pZFasOZDdvPGQZvj
lQaIP8N0Tlg+SS4dwqFmecrFG7Rj7hc7pecsjPQd2pW4bC6iof840sTIHCYN50AR
ONV/94TyAtny9tTYaOZ6BNsowKi4xDo7/LN8OmVCJzImErPxFmlNKnCaZjQOvNqs
u556RJf6M86E0K7qVrzbJ/ufFsXVUUlftQxT627uTTpeFjdIRKVqNZUxK63YZldh
doZHcUVLs3W4Rt7gpC8znr8fIN5XHjMs+3k7OEZzAtFxRX1W3KLGt3S94G0IUltw
9GGruaGXysL1/FQePFUSAdoHysFPMcOLQzl7Kff0DtN0I2wri5r8fdGF/6qnFjZD
TrrZG4wcTOHO+xyXMm6SsXtvzZlJpQhEXwP2litSJAVscS2fmls=
=fOCI
-----END PGP SIGNATURE-----

--Sig_/TLlXh=LxAygrM6N=NTlYxmT--
