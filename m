Received: from eggs.gnu.org ([2001:4830:134:3::10]:57042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFlee-0008Ay-H7
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFled-00010m-D7
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:46:20 -0500
References: <20171117164747.11525-1-eblake@redhat.com>
	<9279377e-9165-d6b9-930f-7949c2c1fb72@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbb84db4-ead4-e8cf-25c4-fba4dd8701c4@redhat.com>
Date: Fri, 17 Nov 2017 12:46:09 -0600
MIME-Version: 1.0
In-Reply-To: <9279377e-9165-d6b9-930f-7949c2c1fb72@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WXIvoCV7uhh3bsORxBbEBDCPLJoFWj1PV"
Subject: Re: [Qemu-devel] [PATCH for-2.11] qcow2: fix image corruption on
 commit with persistent snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WXIvoCV7uhh3bsORxBbEBDCPLJoFWj1PV
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com
Message-ID: <dbb84db4-ead4-e8cf-25c4-fba4dd8701c4@redhat.com>
Subject: Re: [PATCH for-2.11] qcow2: fix image corruption on commit with
 persistent snapshot
References: <20171117164747.11525-1-eblake@redhat.com>
 <9279377e-9165-d6b9-930f-7949c2c1fb72@redhat.com>
In-Reply-To: <9279377e-9165-d6b9-930f-7949c2c1fb72@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2017 12:17 PM, Max Reitz wrote:
> On 2017-11-17 17:47, Eric Blake wrote:
>> If an image contains persistent snapshots, we cannot use the
>> fast path of bdrv_make_empty() to clear the image during
>> qemu-img commit, because that will lose the clusters related
>> to the bitmaps.
>>
>> Also leave a comment in qcow2_read_extensions to remind future
>> feature additions to think about fast-path removal, since we
>> just barely fixed the same bug for LUKS encryption.
>>
>> It's a pain that qemu-img has not yet been taught to manipulate,
>> or even at a very minimum display, information about persistent
>> bitmaps; instead, we have to use QMP commands.  It's also a
>> pain that only qeury-block and x-debug-block-dirty-bitmap-sha256
>> will allow bitmap introspection; but the former requires the
>> node to be hooked to a block device, and the latter is experimental.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> As promised, based on Dan's similar patch for LUKS encryption
>>
>>  block/qcow2.c              |  17 ++--
>>  tests/qemu-iotests/176     |  55 ++++++++++--
>>  tests/qemu-iotests/176.out | 216 ++++++++++++++++++++++++++++++++++++=
++++++++-
>>  3 files changed, 270 insertions(+), 18 deletions(-)
>=20
> The test fails with -m32 and probably also on Big Endian architectures,=

> because the bitmap hash differs.

Oh my.  Thanks for the rapid testing.

> We could "fix" this by replacing the 2100 by a 2102, so for both bit
> widths rounding is the same.  But that would still leave the issue open=

> for Big Endian architectures (which generate just completely different
> hashes)

Isn't sha256 supposed to be a byte-based hash that is not endian
specific?  What causes that difference?

> -- and I'm not really a fan of testing this on every possible
> architecture and then adding different reference outputs.
>=20
> Therefore, the best fix is probably to just filter the hashes out (you
> don't need the exact value anyway, do you?), and I think it's fine to d=
o
> this as a follow-up.

At any rate, I concur with this conclusion; I'll post a followup that
filters out the hash (for this test, we only care that the existence of
a hash proves the bitmap exists; unlike 165 where we want to validate
that it is actually tracking correct information).

I missed Kevin's -rc2 pull, unless he wants to send a v2; but we also
have time (it's not the end of the world if the fix goes in -rc3).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WXIvoCV7uhh3bsORxBbEBDCPLJoFWj1PV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloPLnEACgkQp6FrSiUn
Q2rj2QgApOPfzAy8QLEwOvA7TNvQBzw1mt2CXfz/7+QGE+9AFijkaC2RPRXiZeUe
AvGqCD7sbyAyyKdYfW8ZPm5iE4FH3jrkyNXWZQIMytg/8w2qlQKkAtZSe0ufQ5W5
9M4yHyY5YkZCLuEufoYKkPk8do25aXwSf0ZfzQVjtrCUigd0hzKL2+52f+UKOQjg
Vf5Zh1nPmdU3mt/ENlnFJWbo/aZ8fTTpRSmqq5lH4Rjz6TBPG/jlwa5AWm+0uh3p
O6cZtdCwM1q1ahz+DMlBzspBMCXq2pE1i69DuIMxekf0svK69k6ECDXKsoKbzQf7
mOQ7E5Gil0JQB4xrQfBdXuZie63hVQ==
=xUyR
-----END PGP SIGNATURE-----

--WXIvoCV7uhh3bsORxBbEBDCPLJoFWj1PV--
