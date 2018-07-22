Received: from eggs.gnu.org ([2001:4830:134:3::10]:47971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fhF0H-0003cG-Do
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 10:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fhF0G-0007fO-DR
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 10:06:29 -0400
References: <20180719034118.27741-1-famz@redhat.com>
	<640247eb-482c-0c27-f1f3-acea29e8cb3a@redhat.com>
	<CAK1Eb9mQ8ERn5eiA6hyXotmbgTckU=TE8mNbX+zeotXXfMxmGg@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <46511655-713c-6537-0495-0b36384d6fb7@redhat.com>
Date: Sun, 22 Jul 2018 16:06:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAK1Eb9mQ8ERn5eiA6hyXotmbgTckU=TE8mNbX+zeotXXfMxmGg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6A091OrccWJgjx34sutxKsopP2OLIrEM4"
Subject: Re: [Qemu-devel] [PATCH] block: Don't lock /dev/null and /dev/zero
 automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6A091OrccWJgjx34sutxKsopP2OLIrEM4
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <46511655-713c-6537-0495-0b36384d6fb7@redhat.com>
Subject: Re: [PATCH] block: Don't lock /dev/null and /dev/zero automatically
References: <20180719034118.27741-1-famz@redhat.com>
 <640247eb-482c-0c27-f1f3-acea29e8cb3a@redhat.com>
 <CAK1Eb9mQ8ERn5eiA6hyXotmbgTckU=TE8mNbX+zeotXXfMxmGg@mail.gmail.com>
In-Reply-To: <CAK1Eb9mQ8ERn5eiA6hyXotmbgTckU=TE8mNbX+zeotXXfMxmGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-07-22 04:37, Fam Zheng wrote:
> On Sun, Jul 22, 2018 at 5:08 AM Max Reitz <mreitz@redhat.com> wrote:
>>
>> On 2018-07-19 05:41, Fam Zheng wrote:
>>> On my Fedora 28, /dev/null is locked by some other process (couldn't
>>> inspect it due to the current lslocks limitation), so iotests 226 fai=
ls
>>> with some unexpected image locking errors because it uses qemu-io to
>>> open it.
>>>
>>> Actually it's safe to not use any lock on /dev/null or /dev/zero.
>>>
>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>> ---
>>>  block/file-posix.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>> index 60af4b3d51..8bf034108a 100644
>>> --- a/block/file-posix.c
>>> +++ b/block/file-posix.c
>>> @@ -503,7 +503,12 @@ static int raw_open_common(BlockDriverState *bs,=
 QDict *options,
>>>          s->use_lock =3D false;
>>>          break;
>>>      case ON_OFF_AUTO_AUTO:
>>> -        s->use_lock =3D qemu_has_ofd_lock();
>>> +        if (!strcmp(filename, "/dev/null") ||
>>> +                   !strcmp(filename, "/dev/zero")) {
>>
>> I=E2=80=99m not sure I like a strcmp() based on filename (though it sh=
ould work
>> for all of the cases where someone would want to specify either of tho=
se
>> for a qemu block device).  Isn=E2=80=99t there some specific major/min=
or number
>> we can use to check for these two files?  Or are those Linux-specific?=

>=20
> Yeah, I guess major/minor numbers are Linux-specific.
>=20
>>
>> I could also imagine just not locking any host_device, but since peopl=
e
>> do use qcow2 immediately on block devices, maybe we do want to lock th=
em.
>=20
> That's right.
>=20
>>
>> Finally, if really all you are trying to do is to make test code easie=
r,
>> then I don=E2=80=99t know exactly why.  Just disabling locking in 226 =
shouldn=E2=80=99t
>> be too hard.
>=20
> The tricky thing is in remembering to do that for future test cases.
> My machine seems to be somehow different than John's so that my 226
> cannot lock /dev/null, but I'm not sure that is the case for other
> releases, distros or system instances.

Usually we don=E2=80=99t need to use /dev/null, though, because null-co:/=
/ is
better suited for most purposes.  This is a very specific test of host
devices.

Maybe we should start a doc file with common good practices about
writing iotests?

Max


--6A091OrccWJgjx34sutxKsopP2OLIrEM4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltUj1oACgkQ9AfbAGHV
z0BOhgf/VqnB2xgsK2GGXX9Kic1CUgqALW3IfA7t3gGG+SUNbMjGgLDWKaM7Iy+Z
3ZHIozg3i3hucXRikfEe6/kdXIqklQT1hcOwpao3j0XKc4dAY3wLNHu9YMjLhV9Q
7K61oaLnAcBCM644wgzBl9ESXVhx1Xelss7b8No6xNDVHgjcBbeyCyIMWUC0yJ4Z
ykN9edGRSrTnzJTeSS556b4UXy5Pehztku/rN/xXgc+6VMcOEBt/56DvVJ/SPg0L
5itTEU8E73yFIJTE/qlppADmVpgHr9+n6iDgfwvEJ0FR1qQPwtCsJDhZ/ljQ/usm
G4ETil6mjaUJHVfLT/lAAUCcoBDKTg==
=Rf8m
-----END PGP SIGNATURE-----

--6A091OrccWJgjx34sutxKsopP2OLIrEM4--
