Received: from eggs.gnu.org ([2001:4830:134:3::10]:56187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fk56P-0008D1-Jw
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fk56M-0006fi-Cm
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:08:33 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:60486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fk56M-0006f9-4f
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 06:08:30 -0400
Received: from player756.ha.ovh.net (unknown [10.109.146.163])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 32A70CEDF9
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 12:08:28 +0200 (CEST)
Date: Mon, 30 Jul 2018 11:59:00 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180730115900.0ba16809@bahia.lan>
In-Reply-To: <20180730104145.109ef196@bahia.lan>
References: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
	<20180727052724.GJ3694@umbus.fritz.box>
	<20180727095452.45edee8b@bahia>
	<20180730055715.GD2708@umbus.fritz.box>
	<20180730104145.109ef196@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/nMSUG=Qiex=nCPm767pG9Le";
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?Q8Op?= =?UTF-8?B?ZHJpYw==?= Le Goater <clg@kaod.org>

--Sig_/nMSUG=Qiex=nCPm767pG9Le
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Jul 2018 10:41:45 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Mon, 30 Jul 2018 15:57:15 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
[...]
> > > > I'm pretty sure trying to change the accelerator on a qtest test ju=
st
> > > > doesn't make sense.  We'd need a different approach for testing cpu
> > > > hotplug against kvm & tcg backends.
> > > >    =20
> > >=20
> > > The test starts QEMU, triggers the CPU hotplug code with a QMP command
> > > and checks the command didn't fail (or QEMU didn't crash, as it would
> > > have before commit b585395b655a)... I really don't understand what
> > > is wrong with that... Please elaborate.   =20
> >=20
> > Well, ok, let me turn that around.  A test that doesn't rely on
> > controlling the guest side behaviour at all probably shouldn't be a
> > qtest based test, since that's what qtest is all about.
> >  =20
>=20
> The CPU hotplug test doesn't seem to do anything on the guest side: it
> just checks that 'device_add' returns a response that isn't an error.
> I'm not aware that the guest is expected to have a specific behavior
> during 'device_add', apart from not crashing or hanging. That was the
> initial idea behind passing '-S' to ensure the guest doesn't run.
>=20
> Your remark seems to be more general though... are you meaning that
> doing something like qtest_start("-machine accel=3Dkvm:tcg") is just
> wrong ?

The purpose of this test is simply to exercise a path in QEMU that
is only used with KVM, but it can also be achieved the other way
around:

@@ -189,7 +190,7 @@ static void xics_system_init(MachineState *machine, int=
 nr_irqs, Error **errp)
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
     Error *local_err =3D NULL;
=20
-    if (kvm_enabled()) {
+    if (kvm_enabled() || qtest_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
             !xics_kvm_init(spapr, &local_err)) {

This will test the setup of the in-kernel XICS when run on a book3s host,
and fallback to emulated XICS otherwise (eg, travis).

Would this be more acceptable ?

--Sig_/nMSUG=Qiex=nCPm767pG9Le
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlte4WQACgkQcdTV5YIv
c9ZS7Q//UcOqd3UdlndrCjxhGGFCN2GEtLiG4t6/yoPuPBorWFa5y3IknV6/vR1Q
6tlvcaqjJPK5r3DLFGz6bFqc/sxrsKHGFmF5zCSlWQMlq+fPYHZVJymN+80nROtD
bj/+wC9GjkqQa7vWBxJn7XvLYamj/XCo5qcPgEXVFe/RtnUG1AJSgogneiBBAiop
YE+d5PqFCAxX6ms5msaEFk5GyePvxiF4KL3cHB8eosVKIcG5zM81lQe6K6MBWhGZ
XDOKBZkERLXtzdNHwfHbQCIiVmlsxe90A1BjVF0QeCpdVTR9jAoCeHQLJKLqXCpU
aPIwSmGgw5d+oIcWE77i/AUYnTJRKO6TYYMC47vegnFF8Ikwyk7Dwya8Xn2Q2PTR
UJy0WNfixQ9xQ5mvpCN+SmP275sTgu2vdKaQTCppoe1ygKjXseGsC9nMEsKZHUwq
QdeF1Rmb7xEPkWkPjwKGK8nmt+cRebBWmQLefIJifAi3sXZRD+jFO6OnpGKUdbTT
ECXLfSuZdUrTNQylsqWs+pg77SsggnM1+p1RpPkrnDFH6arPhYTSWZcd876ZOXLJ
iEZOSHGngMT2r2HGBeNKg6SJKtjLDboH2wwgDxY1lLRZcbFdw2NbiddwxIkxiKwH
nvxtu/Lf1W/Xgc6vyua5gEldYsY3D5BV1eBiKj9R0Wj4mFv1I0A=
=ibaq
-----END PGP SIGNATURE-----

--Sig_/nMSUG=Qiex=nCPm767pG9Le--
