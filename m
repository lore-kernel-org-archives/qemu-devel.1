Received: from eggs.gnu.org ([2001:4830:134:3::10]:33418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVIqG-0003RZ-G6
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVIqF-0006Jb-FY
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:42:16 -0400
References: <20170511182705.23648-1-jsnow@redhat.com>
	<19a665be-12c2-2876-0438-08327d94473e@redhat.com>
	<6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
	<815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
	<de0c59c3-2516-db0e-1a02-99b3ea0a0a65@redhat.com>
	<ea023ed7-4925-b338-8636-435103ce757b@redhat.com>
	<20170516081703.GB4438@noname.redhat.com>
	<48a7f2f9-5f79-f944-71ce-2a988e5d468b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd12265d-e764-34ee-8d1e-504f27b78614@redhat.com>
Date: Wed, 12 Jul 2017 09:42:04 -0500
MIME-Version: 1.0
In-Reply-To: <48a7f2f9-5f79-f944-71ce-2a988e5d468b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Am6Md8Vf4Og70ksk6SPRUKLSlTtaIa8Qv"
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
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Am6Md8Vf4Og70ksk6SPRUKLSlTtaIa8Qv
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <dd12265d-e764-34ee-8d1e-504f27b78614@redhat.com>
Subject: Re: [PATCH v4] qemu-img: Check for backing image if specified during
 create
References: <20170511182705.23648-1-jsnow@redhat.com>
 <19a665be-12c2-2876-0438-08327d94473e@redhat.com>
 <6b8d6c51-d849-75fa-59c1-dd256471c0dc@redhat.com>
 <815d2530-7767-0f1d-d9d4-3b6c8de0260b@redhat.com>
 <de0c59c3-2516-db0e-1a02-99b3ea0a0a65@redhat.com>
 <ea023ed7-4925-b338-8636-435103ce757b@redhat.com>
 <20170516081703.GB4438@noname.redhat.com>
 <48a7f2f9-5f79-f944-71ce-2a988e5d468b@redhat.com>
In-Reply-To: <48a7f2f9-5f79-f944-71ce-2a988e5d468b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 07:38 AM, Max Reitz wrote:

>>>>>>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1213786
>>>>>>>>
>>>>>>>> Or, rather, force the open of a backing image if one was specifi=
ed
>>>>>>>> for creation. Using a similar -unsafe option as rebase, allow qe=
mu-img
>>>>>>>> to ignore the backing file validation if possible.
>>>>>>>>
>>>>>>

>>> I suspect this is because the backing file is opened somewhere and
>>> trying to open it breaks now with the locking series applied.
>>
>> I think we can legitimately set force-shared=3Don for opening the back=
ing
>> file when testing whether the file exists.
>=20
> For testing whether the file exists, probably. I wouldn't call it
> legitimately because I don't like making that the default at all, but i=
t
> should work.
>=20
> But then we have to differentiate between testing whether the file
> exists and opening it to read its size; I'm even more wary regarding th=
e
> latter.
>=20
> All in all, I've stated my opinion on this matter on IRC: I don't know
> how much we need this patch. It's nice to have, it's convenient to know=

> you have mistyped the backing filename before you try to use the image
> in qemu, but it's not critical. I don't consider the current behavior a=

> bug per-se, it's just counterintuitive behavior (that will not cut your=

> head off if you don't know it, though!).
>=20

The fact that this topic came up on the mailing list again means we
should probably consider something along these lines for 2.10.

> (Also, we have a lot of counterintuitive behavior. See this:
>=20
> $ qemu-img create -f qcow2 sub/backing.qcow2 64M
> Formatting 'sub/backing.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3D=
off
> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> $ qemu-img create -f qcow2 -b sub/backing.qcow2 sub/top.qcow2
> qemu-img: sub/top.qcow2: Could not open 'sub/sub/backing.qcow2': No suc=
h
> file or directory
>=20
> Yeah, sure, you'll know after you've done the mistake once. But the sam=
e
> applies here, too, doesn't it...?)
>=20
> So for me, it's a question of convenience: How much does the current
> behavior annoy users? How much annoyance will changing the behavior
> bring? I'm not (or rather, no longer) convinced the former outweighs th=
e
> latter, especially since it means having to change management tools
> (which create external snapshots with qemu-img create while the backing=

> image is in use by qemu).
>=20
> If you think otherwise, well, you're the main maintainer. :-)
>=20
> Max
>=20
>=20
> PS: Can there be a middle ground? Like just printing a warning if the
> backing file cannot be opened and we don't absolutely have to?

Middle ground may be harder, but may be nicer (especially since we are
talking about tightening behavior, making things that used to work now
fail is not nice if there is not a transition period where it first just
warns).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Am6Md8Vf4Og70ksk6SPRUKLSlTtaIa8Qv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZjU8AAoJEKeha0olJ0NqEJIIAIQ5TQQsFVH68DuXRR+g0vAb
BGe6h9B5xghXLN6SRk9X2E7IbR0vZpa59qfItREk8TKvgSB8EpFq1O/GR6RdCIYd
0CAD1b8er7B7pBqdcz/8CX3YIzWTDZGxzs2130BXsbndKeVC8AUniBqQlzsZBOM7
2v8hldVPORz2V/83MBYddOcqgNIQe+asAW5FU0wxDZZv3uo7lFYG+q6nJih/5IcE
P8F6swsvUEzIgaUrW/Y0WasRX0mx04Cpa6TqypQMLWYUhiVi6IVxGm74KWv5xbmU
13OcTDTJ3WL/U7O0LxWhthXBlWXRLlhyeINE9gnXSWtCWARI6iIRLE1TwCf8JE0=
=6dF7
-----END PGP SIGNATURE-----

--Am6Md8Vf4Og70ksk6SPRUKLSlTtaIa8Qv--
