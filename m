Received: from eggs.gnu.org ([2001:4830:134:3::10]:37104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDwba-0003zY-0q
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDwbZ-0000KT-38
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:35:54 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-8-mreitz@redhat.com>
	<563e34b7-2b97-da1a-9e38-784608197b89@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c5e4a284-2d3e-4a89-6010-be0875fe8ce1@redhat.com>
Date: Wed, 2 May 2018 20:35:46 +0200
MIME-Version: 1.0
In-Reply-To: <563e34b7-2b97-da1a-9e38-784608197b89@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xaxxu7YwBN1aURXZrwuk8RFCEwdOyIwrN"
Subject: Re: [Qemu-devel] [PATCH 7/7] iotests: Rework 113
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xaxxu7YwBN1aURXZrwuk8RFCEwdOyIwrN
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c5e4a284-2d3e-4a89-6010-be0875fe8ce1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/7] iotests: Rework 113
References: <20180421165423.30759-1-mreitz@redhat.com>
 <20180421165423.30759-8-mreitz@redhat.com>
 <563e34b7-2b97-da1a-9e38-784608197b89@redhat.com>
In-Reply-To: <563e34b7-2b97-da1a-9e38-784608197b89@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-02 20:24, Eric Blake wrote:
> On 04/21/2018 11:54 AM, Max Reitz wrote:
>> This test case has been broken since 398e6ad014df261d (roughly half a
>> year).=C2=A0 qemu-img amend requires its output image to be R/W, so it=
 opens
>> it as such; the node is then turned into an read-only node automatical=
ly
>> which is now accompanied by a warning, however.=C2=A0 This warning has=
 not
>> been part of the reference output.
>>
>=20
>> The reason nobody has noticed the breakage until now of course is the
>> fact that nobody runs the iotests for nbd+bochs.=C2=A0 There actually =
was
>> never any reason to set the protocol to "nbd" but because that was
>> technically correct; functionally it made no difference.=C2=A0 So that=
 is the
>> first thing we are going to change: Make the protocol "file" instead s=
o
>> that people might actually notice breakage here.
>=20
> There's probably several tests that fail with an explicit pairing of nb=
d
> as protocol + explicit format (I'm guilty of usually testing either the=

> format './check -qcow2' or the protocol './check -nbd', and not
> combining the two).
>=20
>> So with this test now being a raw test, we can rework the amend test
>> case to use raw instead.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/113=C2=A0=C2=A0=C2=A0=C2=A0 | 19 +++++++++--=
--------
>> =C2=A0 tests/qemu-iotests/113.out |=C2=A0 7 ++++---
>> =C2=A0 2 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
>> index 19b68b2727..4e09810905 100755
>> --- a/tests/qemu-iotests/113
>> +++ b/tests/qemu-iotests/113
>> @@ -38,16 +38,17 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>> =C2=A0 . ./common.rc
>> =C2=A0 . ./common.filter
>> =C2=A0 -# We can only test one format here because we need its sample =
file
>> -_supported_fmt bochs
>> -_supported_proto nbd
>> +# Some of these test cases use bochs, but others do use raw, so this
>> +# is only half a lie.
>> +_supported_fmt raw
>> +_supported_proto file
>=20
> Naive question - can we pass a list to _supported_fmt/_supported_proto,=

> in which case the test runs under both elements of the list?=C2=A0 That=
 is,
> I'm wondering if:
>=20
> _supported_fmt raw bochs
> _supported_proto file nbd
>=20
> gives us any additional coverage (theoretically 4 times the testing
> possibilities - but if the rest of the test hard-codes a particular
> format or protocol then it might not actually execute a different
> combination).

Well, anyone who's going to run any of these combinations is probably
going to run raw+file as well.  You could argue that if someone changes
something about NBD, they might just run raw+nbd; but then again, this
test doesn't really test nbd at all.  In fact, it just tests qemu-img
(we simply need a format that does not support image creation, but it's
not like we actually do anything with that format).  Same for bochs.

(And I think anyone who wants to test qemu-img is indeed going to run
the raw+file tests.)

But see my reply to John, I think the best way would be if tests like
these could be just run in "default" mode without forcing some
format/protocol combination on them.

Max


--xaxxu7YwBN1aURXZrwuk8RFCEwdOyIwrN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrqBQIACgkQ9AfbAGHV
z0C80wf/eQabw0HM8UFC0ZXfTkO3+0o5PeIvHkNec6/iG8o14uxguhRWmZQ4WuWF
LmbayjAUQ1PNCvnswsDYsioRtS8GpEDGBDW3HJnEvp5H+R7C1vRPOegghbq8Wf7z
gBxKeQD49D9J2dEHgqFy3NWq7yO8o+3c+HR+XTfCLnFrxCAFGYvB1vNrXPlg8inU
kJB/9KCLmv+lIAGdYU9pqNtCfac52UX3yitQnOWR8tOMD7pHXUnjBVQ0MnoPLImw
dtWQ51CSvBAaqLS8bA8CmzdtrQHcavPTiuXq+G12rY5Kt4suJPYNBIXzD/YEzx37
7Z1beDpZDnZIGyl29C8EUQH/2WRMWQ==
=lpf6
-----END PGP SIGNATURE-----

--xaxxu7YwBN1aURXZrwuk8RFCEwdOyIwrN--
