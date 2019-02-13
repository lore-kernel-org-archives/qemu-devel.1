Received: from eggs.gnu.org ([209.51.188.92]:59754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvq-0003Ds-HD
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvp-00059B-AP
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:13:58 -0500
Date: Wed, 13 Feb 2019 11:21:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213002118.GR1884@umbus.fritz.box>
References: <20190210174421.22062-1-mark.cave-ayland@ilande.co.uk>
	<442139a2-5ab2-9259-03a0-11d2f3c86c59@redhat.com>
	<28a8cd58-51a9-6301-1d25-02289af8c81d@ilande.co.uk>
	<alpine.BSF.2.21.9999.1902121157470.75929@zero.eik.bme.hu>
	<971ba38d-d883-d51c-55b2-531639336ed4@ilande.co.uk>
	<d78bc91b-efef-bb69-e443-6526ca433197@redhat.com>
	<e8329ece-32a2-d591-2ffc-3cdb468d56aa@ilande.co.uk>
	<bff82e7a-2315-fd42-cdae-e7d0baa2fd08@redhat.com>
	<de84d0a5-1942-5a22-b71e-e9bf888a0fc1@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QFliEIXSSz7hGqqc"
Content-Disposition: inline
In-Reply-To: <de84d0a5-1942-5a22-b71e-e9bf888a0fc1@ilande.co.uk>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] cuda: decrease time delay
 before raising VIA SR interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, hsp.cat7@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--QFliEIXSSz7hGqqc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 08:01:22PM +0000, Mark Cave-Ayland wrote:
> On 12/02/2019 18:21, Philippe Mathieu-Daud=E9 wrote:
>=20
> > On 2/12/19 6:50 PM, Mark Cave-Ayland wrote:
> >> On 12/02/2019 17:21, Philippe Mathieu-Daud=E9 wrote:
> >>
> >>>>> If this delay is to prevent a bug which only happens in MacOS then =
that's the hack
> >>>>> not the normal code path to run without the delay that you've just =
removed. So maybe
> >>>>> this should be kept if possible to avoid unecessary delays for othe=
r guests.
> >>>>> (Although if this only affects mac99,via=3Dcuda but not mac99,via=
=3Dpmu then I don't care
> >>>>> much as long as pmu works.)
> >>>>
> >>>> Well the reality is that the detection above doesn't actually seem t=
o work anyway -
> >>>> at least a quick boot test with Linux, MacOS X and MacOS 9 with a pr=
intf() added into
> >>>> the if() shows nothing firing once the kernel takes over. So the slo=
w path with the
> >>>> delay included was always being taken within the OS anyway.
> >>>>
> >>>> And indeed, the code doesn't affect pmu so you won't see any differe=
nce there.
> >>>>
> >>>>>> As a plus it also prevents a guest OS from accidentally triggering=
 the hack whilst
> >>>>>> programming the VIA port.
> >>>>>
> >>>>> That may be a problem though. What's the issue exactly? Why is the =
delay needed in
> >>>>> the first place?
> >>>>
> >>>> It's some kind of racy polling with OS 9 (I wasn't involved in the t=
echnical details,
> >>>> sorry) which causes OS 9 to hang on boot if the delay isn't present.=
 And even better
> >>>> the slow path that was previously always being taken has now been re=
duced from 300us
> >>>> to 30us so whichever way you look at it, having this patch applied i=
s a win.
> >>>
> >>> Can you write a paragraph about this, that David can amend to your
> >>> patch? That would stop worrying me about looking at this patch in
> >>> various months...
> >>
> >> Hmmmm well the existing description already describes the interrupt ra=
ce in OS 9 so I
> >> guess the only part missing is the bit about the fast path. How about =
the revised
> >> text below for the patch description?
> >>
> >>
> >>     cuda: decrease time delay before raising VIA SR interrupt and remo=
ve fast path
> >>
> >>     In order to handle a race condition in the MacOS 9 CUDA driver, a =
delay was
> >>     introduced when raising the VIA SR interrupt inspired by similar c=
ode in
> >>     MacOnLinux.
> >>
> >>     During original testing of the MacOS 9 patches it was found that t=
he 30us
> >>     delay used in MacOnLinux did not work reliably within QEMU, and a =
value of
> >>     300us was required to function correctly.
> >>
> >>     Recent experiments have shown two things: firstly when booting Lin=
ux, MacOS
> >>     9 and MacOS X the fast path which bypasses the delay is never trig=
gered once the
> >>     OS kernel is loaded making it effectively useless. Rather than lea=
ve this code
> >>     in place where a guest could potentially enable it by accident and=
 break itself,
> >>     we might as well just remove it.
> >>
> >>     Secondly the previous reliability issues are no longer present, an=
d this value
> >>     can be reduced down to 20us with no apparent ill effects. This has=
 the benefit of
> >>     considerably improving the responsiveness of the ADB keyboard and =
mouse within
> >>     the guest.
> >>
> >>     Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >>
> >=20
> > Thanks!
> >=20
> > Phil.
>=20
> No worries. David, are you able to update the commit message in your ppc-=
for-4.0
> branch accordingly?

Done.

>=20
>=20
> ATB,
>=20
> Mark.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QFliEIXSSz7hGqqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjYv0ACgkQbDjKyiDZ
s5Jpqw//TFEw+pe3ELHi7Ebm0n9pURs8ohTVCVhpooHCiU6u19Myr4AE8mTVjvF6
Rx7sRczlVdAURm5g/a2yH7BWKsAFahwFxBtsYgIyCLYpxKCbOG6WTjIE4j19aMzi
RUuSoZkK2ZLEioOpnEQ/yL5v+P14WmSzzFT8nd/64lrg68dKVY7+5hnavzA7bOyX
H13IRhkgRLCXS6WSAWm/jaGOKAFp2elOg7qcmtqjiYOngPaMXfyYB28CZJTFLyHq
qYoWSEE9T7g+Qzb5XmM7ocvz9r2kn7FPdFjiDi6IDK4zlbFKU3chVSnCmaLeRH0f
0zQxoesaNyofaZmn2m++tpBCe2ZVTREofJPMJi6smWtcdtLdnOYcvU+5I7yGXgib
pO3wjaEsJzcpjB6/10GDgI1kRwPnNNRd0VnfV3mvSktM0fsuI9plPmwiDIr0nmy6
7CjS3THpGiVGsn3Nf55Rr1froq3w8DoEmJHu7xuSLwsMCVVDFy5GAiRjaXGJanT2
OC+kfMxAT9r+74D20vB470uWwTT0Qm5Ft3/IdetmzCXk7Q7RP+UlBWqCF7GB0qJt
/xQlKSV+nwrscTPjjCBk+96digwlz3LZSuo/iXplzPC1rkqdLT+sRb9lObaPL5Zx
pGe5rinw7/9Qighud9hvNra6kc83wB9dh8Yx6pcDd7mYbMhIVAM=
=wcdG
-----END PGP SIGNATURE-----

--QFliEIXSSz7hGqqc--
