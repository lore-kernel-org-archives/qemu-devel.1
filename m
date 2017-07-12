Received: from eggs.gnu.org ([2001:4830:134:3::10]:41648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVJ4K-0004f5-SB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVJ4J-0007J0-NL
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:56:48 -0400
Date: Wed, 12 Jul 2017 16:56:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170712145634.GF4917@noname.str.redhat.com>
References: <20170511182705.23648-1-jsnow@redhat.com>
	<19a665be-12c2-2876-0438-08327d94473e@redhat.com>
	<6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
	<815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
	<de0c59c3-2516-db0e-1a02-99b3ea0a0a65@redhat.com>
	<ea023ed7-4925-b338-8636-435103ce757b@redhat.com>
	<20170516081703.GB4438@noname.redhat.com>
	<48a7f2f9-5f79-f944-71ce-2a988e5d468b@redhat.com>
	<dd12265d-e764-34ee-8d1e-504f27b78614@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <dd12265d-e764-34ee-8d1e-504f27b78614@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.07.2017 um 16:42 hat Eric Blake geschrieben:
> On 05/17/2017 07:38 AM, Max Reitz wrote:
>=20
> >>>>>>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1213786
> >>>>>>>>
> >>>>>>>> Or, rather, force the open of a backing image if one was specifi=
ed
> >>>>>>>> for creation. Using a similar -unsafe option as rebase, allow qe=
mu-img
> >>>>>>>> to ignore the backing file validation if possible.
> >>>>>>>>
> >>>>>>
>=20
> >>> I suspect this is because the backing file is opened somewhere and
> >>> trying to open it breaks now with the locking series applied.
> >>
> >> I think we can legitimately set force-shared=3Don for opening the back=
ing
> >> file when testing whether the file exists.
> >=20
> > For testing whether the file exists, probably. I wouldn't call it
> > legitimately because I don't like making that the default at all, but it
> > should work.
> >=20
> > But then we have to differentiate between testing whether the file
> > exists and opening it to read its size; I'm even more wary regarding the
> > latter.
> >=20
> > All in all, I've stated my opinion on this matter on IRC: I don't know
> > how much we need this patch. It's nice to have, it's convenient to know
> > you have mistyped the backing filename before you try to use the image
> > in qemu, but it's not critical. I don't consider the current behavior a
> > bug per-se, it's just counterintuitive behavior (that will not cut your
> > head off if you don't know it, though!).
> >=20
>=20
> The fact that this topic came up on the mailing list again means we
> should probably consider something along these lines for 2.10.
>=20
> > (Also, we have a lot of counterintuitive behavior. See this:
> >=20
> > $ qemu-img create -f qcow2 sub/backing.qcow2 64M
> > Formatting 'sub/backing.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=
=3Doff
> > cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> > $ qemu-img create -f qcow2 -b sub/backing.qcow2 sub/top.qcow2
> > qemu-img: sub/top.qcow2: Could not open 'sub/sub/backing.qcow2': No such
> > file or directory
> >=20
> > Yeah, sure, you'll know after you've done the mistake once. But the same
> > applies here, too, doesn't it...?)
> >=20
> > So for me, it's a question of convenience: How much does the current
> > behavior annoy users? How much annoyance will changing the behavior
> > bring? I'm not (or rather, no longer) convinced the former outweighs the
> > latter, especially since it means having to change management tools
> > (which create external snapshots with qemu-img create while the backing
> > image is in use by qemu).
> >=20
> > If you think otherwise, well, you're the main maintainer. :-)
> >=20
> > Max
> >=20
> >=20
> > PS: Can there be a middle ground? Like just printing a warning if the
> > backing file cannot be opened and we don't absolutely have to?
>=20
> Middle ground may be harder, but may be nicer (especially since we are
> talking about tightening behavior, making things that used to work now
> fail is not nice if there is not a transition period where it first just
> warns).

We can do the nowadays usual thing: Add a -u option, print a deprecation
warning if we don't have -u and can't open the backing file, and put
it into the list of things to remove in 3.0.

Kevin

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZZjiiAAoJEH8JsnLIjy/WDroP/jncXF7ZMVrVI4Sy51nvpBAn
f2utcsRBsbWLyOf/sgrcYRQlpVY731pqy0/2kVvsJBjuRlcUCfrSTElj4ejlnGUD
tSEn6HhnDHnfdPBGdaQXxvGzYh0X+hazLIyvC84UQn55uw7b8BUyMemWiFPbyZS2
twhQ35FoU3qqm2gAW/EEDpPdvX3CGmU1M6wYF9IVgeDkgg71thcsHWK9K10wCEG0
6cJje8FJIrL8ogbm1/8Yyzod0iJQ7x5q9V/ZJNWpKRA7r5VCFBE7gUQwFBSmATVn
2/AOE3t4bwFD2momDzVg7I4ULLMoNp4cLhrSYhXoOcEKHUBiTnp8MI/nt5PEEyw5
ZT1XgM5d6V/WSCNIsot6jwrBuD+wPUWRO/dVKwBqBGMtxOewkGbnU6fNKcpfqF8s
fjZ3I2yiGiNWVfl107pBlA/lA5+OOPG9gzoGp1SJTHJ6AoXzAaHAP8fBNL94BvvC
Ku7wWIHBR7QVjQHWZWRTEIGHdDUTE9/Z3kfBH2s3bXLtFm/1gjSWZB9ytAhSomb6
6LTGNWCCNwef2oSmqMh1RC6MUVgJECztMhyPXi5MgwbekPfqIhL5B2rqtt6zjbGW
qg/nQyT+AccsnFNxmLsDQ0tu87LMVdqw8IZ/XfR2Hrz4ajxBoVk/AvYg4lTlVj+H
DtXK4o6OnZyDGz9uUDUB
=LcVT
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
