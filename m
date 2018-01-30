Received: from eggs.gnu.org ([2001:4830:134:3::10]:48215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egZ3z-0000cC-9i
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egZ3r-0000Y7-DE
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:47:15 -0500
References: <20180130150435.2553-1-berto@igalia.com>
	<b93f21cf-5cd4-a6d0-7005-e19a3de211c8@redhat.com>
	<w51607juy5j.fsf@maestria.local.igalia.com>
	<62e23e8c-9873-9fa2-c70f-c823d64f4415@redhat.com>
	<w51372nuxj9.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0127ca7d-958b-40cc-e714-bb7b61871502@redhat.com>
Date: Tue, 30 Jan 2018 10:46:47 -0600
MIME-Version: 1.0
In-Reply-To: <w51372nuxj9.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kNKurKs15TvNql7VZs3rlpLsLOqRUBQgR"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Replace align_offset() with
 ROUND_UP()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kNKurKs15TvNql7VZs3rlpLsLOqRUBQgR
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <0127ca7d-958b-40cc-e714-bb7b61871502@redhat.com>
Subject: Re: [PATCH] qcow2: Replace align_offset() with ROUND_UP()
References: <20180130150435.2553-1-berto@igalia.com>
 <b93f21cf-5cd4-a6d0-7005-e19a3de211c8@redhat.com>
 <w51607juy5j.fsf@maestria.local.igalia.com>
 <62e23e8c-9873-9fa2-c70f-c823d64f4415@redhat.com>
 <w51372nuxj9.fsf@maestria.local.igalia.com>
In-Reply-To: <w51372nuxj9.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 10:22 AM, Alberto Garcia wrote:
> On Tue 30 Jan 2018 05:17:47 PM CET, Eric Blake wrote:
>> On 01/30/2018 10:08 AM, Alberto Garcia wrote:
>>> On Tue 30 Jan 2018 05:03:16 PM CET, Eric Blake wrote:
>>>
>>>>> -    virtual_size =3D align_offset(qemu_opt_get_size_del(opts, BLOC=
K_OPT_SIZE, 0),
>>>>> +    virtual_size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OP=
T_SIZE, 0),
>>>>>                                  cluster_size);
>>>
>>> I just realized that the first parameter here is a function call with=

>>> side effects, it it safe to use ROUND_UP() in this case?
>>>
>>> #define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))
>>
>> Oh, good catch.  No, we need a temporary variable to hold the result
>> of the function call
>=20
> ...which is what align_offset() was doing in the first place. I can
> still modify that function to use the macro internally.

Nah. I think the ROUND_UP naming is enough to remind us to be careful,
and since this was the only affected spot in your conversion, it's nicer
to drop align_offset() and just do:

virtual_size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
virtual_size =3D ROUND_UP(virtual_size, cluster_size);

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kNKurKs15TvNql7VZs3rlpLsLOqRUBQgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwoXcACgkQp6FrSiUn
Q2r1tAgArXxThbdmGN6nKF7PDDSPLs4HDJyasJVAQky6iKBFQls2vfuwhylfI0cY
I0yy46p7VLuzsuJna3JA08Q1+50jzAbl5+WaZ6YEMkIbEzG/2HeoQvqHKPs0yokr
peYvInYjj0bYOHdPU2v0ufAhvvILyILtFDutnhb0YKiwgNoVVYAvejzcX3+rG1ga
ulAHrV3NahObuTcN2A+OwIbuPPfcNCjiF3JiUS1jwofnzoJkhepnkCZakhUizAS6
uRUrDTCkqF2IlTa1BnOxAntG2t2agH/FVEcy5CjRXxf7PBueebkcrjRxND57unmr
gAsp5t7AeSFsMix4Vi952qC1cPGhLg==
=qqKr
-----END PGP SIGNATURE-----

--kNKurKs15TvNql7VZs3rlpLsLOqRUBQgR--
