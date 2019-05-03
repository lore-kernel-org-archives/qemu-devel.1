Received: from eggs.gnu.org ([209.51.188.92]:43419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMegF-00064H-8H
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMegD-00045S-2a
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:21:15 -0400
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
	<f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
	<61685a48-b84e-c379-7193-f456e82635ba@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <67a38513-89af-7f54-2fc8-05b5777983ca@redhat.com>
Date: Fri, 3 May 2019 15:21:06 -0500
MIME-Version: 1.0
In-Reply-To: <61685a48-b84e-c379-7193-f456e82635ba@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P4XcR4BlkHunkEgwKw1nIrLatmWP6HWMf"
Subject: Re: [Qemu-devel] Failing QEMU iotest 175
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Nir Soffer <nirsof@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P4XcR4BlkHunkEgwKw1nIrLatmWP6HWMf
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Message-ID: <67a38513-89af-7f54-2fc8-05b5777983ca@redhat.com>
Subject: Re: Failing QEMU iotest 175
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
 <f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
 <61685a48-b84e-c379-7193-f456e82635ba@redhat.com>
In-Reply-To: <61685a48-b84e-c379-7193-f456e82635ba@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/2/19 11:37 PM, Thomas Huth wrote:
> On 02/05/2019 23.56, Eric Blake wrote:
>> On 4/28/19 10:18 AM, Thomas Huth wrote:
>>> QEMU iotest 175 is failing for me when I run it with -raw:
>>>
>>
>>>  =3D=3D creating image with default preallocation =3D=3D
>>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
>>> -size=3D1048576, blocks=3D0
>>> +size=3D1048576, blocks=3D2
>>
>> What filesystem?
>=20
> ext4
>=20

Hmm, it's passing for me on ext4, but that probably means we have
different configuration parameters. I'm not sure how to easily show what
parameters a particular ext4 partition uses to compare the differences
between your setup and mine (mine is tuned to whatever defaults Fedora's
installer chose on my behalf), so maybe someone else can chime in.

>> It should be fairly obvious that 'stat -c blocks=3D%b' is
>> file-system dependent (some allocate slightly more or less space, base=
d
>> on granularities and on predictions of future use), so we may need to
>> update the test to apply a filter or otherwise allow a bit of fuzz in
>> the answer. But 0/2 is definitely different than...
>>>
>>>  =3D=3D creating image with preallocation off =3D=3D
>>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 prealloc=
ation=3Doff
>>> -size=3D1048576, blocks=3D0
>>> +size=3D1048576, blocks=3D2
>>>
>>>  =3D=3D creating image with preallocation full =3D=3D
>>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 prealloc=
ation=3Dfull
>>> -size=3D1048576, blocks=3D2048
>>> +size=3D1048576, blocks=3D2050
>>
>> 2048/2050, so we DO have some indication of whether the file is sparse=

>> or fully allocated.
>=20
> Maybe we could check that the value after "blocks=3D" is a single digit=
 in
> the first case, and matches "blocks=3D20.." in the second case?

I wonder if 'qemu-img map --output=3Djson $TEST_IMG' might be any more
reliable (at least for ignoring any extra block allocations associated
with the file, if it is some journaling option or xattr or other reason
why your files seem to occupy more disk sectors than just the size of
the file would imply).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--P4XcR4BlkHunkEgwKw1nIrLatmWP6HWMf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzMorIACgkQp6FrSiUn
Q2qKBwgAgbEypAH4HvnQKf3go0sASavZzeaPlq3+val68ZK5/jUKHCMWIvc6E9G6
OoRogzOBfeFfY71eYPbabZ4Mo6p139I6CPbxnpKXOlqU7v0g4FHis3kICEoNcIrB
yWzPNn8i+iamLvnpkkmxMH0pSPIxAQYJTltU7wxRI6/27Is3Y0DUPhEphxu+V3DM
GbIAZFY7N8Gzq8H+MU6iwstt5rwTefxEnnKuiO+dkD7+q5GAMaBbJkWElqz6+iTc
F5ja6Yq2R95g4kwzdV2QpJXJwZir4PkeM9TA9SkwYmruU6epn9sQGrso5MBnwNLf
xBZbUVkFctD+YJdMGz3EiZmBnU76Rw==
=kD93
-----END PGP SIGNATURE-----

--P4XcR4BlkHunkEgwKw1nIrLatmWP6HWMf--
