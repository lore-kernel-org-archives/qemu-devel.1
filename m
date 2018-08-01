Received: from eggs.gnu.org ([2001:4830:134:3::10]:41386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fkr7L-00078F-I8
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fkr7I-0003kt-DT
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:24:43 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:56229)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fkr7I-0003jr-4s
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:24:40 -0400
Received: from player779.ha.ovh.net (unknown [10.109.160.244])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id EAD661BFE2D
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 15:24:37 +0200 (CEST)
Date: Wed, 1 Aug 2018 15:24:30 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180801152430.3f1c5cee@bahia.lan>
In-Reply-To: <20180731032559.GH2708@umbus.fritz.box>
References: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
	<20180727052724.GJ3694@umbus.fritz.box>
	<20180727095452.45edee8b@bahia>
	<20180730055715.GD2708@umbus.fritz.box>
	<20180730104145.109ef196@bahia.lan>
	<20180731032559.GH2708@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/NzLrYkO_a1=Nn6R6NB/0bqM";
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

--Sig_/NzLrYkO_a1=Nn6R6NB/0bqM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Jul 2018 13:25:59 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:
[...]
> >=20
> > The CPU hotplug test doesn't seem to do anything on the guest side: it
> > just checks that 'device_add' returns a response that isn't an
> > error. =20
>=20
> Right, which makes this ill suited to being a qtest test.  The whole
> point of qtest is making it easier to test qemu peripherals without
> having to have specific test code within the guest, by essentially
> replacing the guest's cpu with a stub controlled by the test harness.
> That's what the qtest accel is all about.
>=20

I agree with what a qtest test should be, but cpu-plug-test doesn't
do anything like that obviously, ie, the guest CPU does nothing at
all. Only the hotplug path of the QEMU device model that don't need
the guest to run is tested here.

The more general issue is that paths guarded with kvm_enabled() cannot
be tested with a genuine qtest test. That's really unfortunate since
these paths are sometimes the one that are mostly used on the field,
eg, in-kernel XICS versus emulated XICS.

> I think it's confusing to have a test which tries things with both
> qtest and kvm accelerators.  Looking like a qtest test, people might
> reasonably think they can extend/refine the test to check behaviour
> when the guest does respond to the hotplug events.  But such an
> extension won't work with the kvm accel, because the qtest code used
> to simulate that guest response won't have any effect with kvm.
>=20

If the motivation is to let the test be a true qtest in case someone
wants to emulate some guest behavior, I agree the kvm change is wrong.

> > I'm not aware that the guest is expected to have a specific behavior
> > during 'device_add', apart from not crashing or hanging. That was the
> > initial idea behind passing '-S' to ensure the guest doesn't run. =20
>=20
> Note that with qtest (or -S) we don't even test that minimal
> condition.  We only test that *qemu* doesn't crash - it could fatally
> compromise the guest and the test would never know.
>=20

True.

> > Your remark seems to be more general though... are you meaning that
> > doing something like qtest_start("-machine accel=3Dkvm:tcg") is just
> > wrong ? =20
>=20
> Pretty much, yes.  A non-qtest test which does that is reasonable, but
> not a qtest test.
>=20

So, instead of hijacking the current qtest, we may add a non-qtest test
that would start QEMU with "-machine accel=3Dkvm:tcg -S". This would allow
at least to test that QEMU doesn't crash right away. And, as suggested
by Thomas, the coverage could include SLOF as well if we don't pass -S.
But I would need to understand why SLOF sometimes hits a 0x700 when
running cpu-plug-test with this patch applied...

--Sig_/NzLrYkO_a1=Nn6R6NB/0bqM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlthtI4ACgkQcdTV5YIv
c9YX7Q//WEPYk+tXrmyIkdCtfx1GvAM1siMhAS7V7B1ok6Vki2I3FOwrJfKnBjUy
VakmKtuejs7ni0nhHSVINgXimmGXGQ9Kn9XOA4xY9wkPYbPvHKjZ30LiWYzdbAhl
4uhh6Ql6/kw/JQtkdJcjkzQUliLvxDPAAF+POkbxwlv3m8/PaEIzvMVfgTlE4Ggw
ok4b1LRAuyCXjEWvfzJ4wRr3uZPg/z2yny/JGIvyLUipcppjTFZgxRKl4Zo3WKiU
YhH5lMj1kunn0Wos4Km1LSjtFMFjMJKMkf8vO3b9i6jddcac0XDwOIJIQsaFUnga
AkGMVY5I4eAwt9mnStUyYb6DAalakNR3nv6usLforqZ6s9e4JJCLr4eqYGDUji5K
kRP/hqycvB1a2Nn7CImXwW+l/P/2cBi8i6KjdPDhfLENtPHSwkzrvjCJ0v+u2/2l
6wgpqW+eCgGmeLHcFryiihRSD+MJRoLp54zHQuAM9suoxQKMKKnrGOiM5Ri/dZZB
E+xoQE04PfLT59RPc3JcjUcgmgWxWGjmKVOuef7FjHizT8sDnKvb4qnnzNgvAIDQ
/WrZ4185lzZnJ33E/Zx3SuO0CIBcdfCGNtZ38YKQnIOQ8wrgXYN+H/H3Kdr0S53Z
aQkUtePjuCO9NI5lTXO/OEqnp64koQYg0NOkGz4H5SxU5fM0D0I=
=Lza+
-----END PGP SIGNATURE-----

--Sig_/NzLrYkO_a1=Nn6R6NB/0bqM--
