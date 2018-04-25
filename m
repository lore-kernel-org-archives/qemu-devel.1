Received: from eggs.gnu.org ([2001:4830:134:3::10]:44774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBM2l-0008Hs-CG
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBM2f-0006Tr-5T
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:09:15 -0400
References: <20180421132929.21610-1-mreitz@redhat.com>
	<20180421132929.21610-4-mreitz@redhat.com>
	<5ee0cf91-5533-2500-b4f1-5eac0dee8be4@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <377c9a6a-aa05-dec8-52fb-f0cdfc2c2b50@redhat.com>
Date: Wed, 25 Apr 2018 17:08:58 +0200
MIME-Version: 1.0
In-Reply-To: <5ee0cf91-5533-2500-b4f1-5eac0dee8be4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UbsXZRjPzyn0644q2PHqtGDhYCQwQ58ek"
Subject: Re: [Qemu-devel] [PATCH v2 3/9] block: Add BDRV_REQ_WRITE_UNCHANGED
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UbsXZRjPzyn0644q2PHqtGDhYCQwQ58ek
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <377c9a6a-aa05-dec8-52fb-f0cdfc2c2b50@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/9] block: Add BDRV_REQ_WRITE_UNCHANGED
 flag
References: <20180421132929.21610-1-mreitz@redhat.com>
 <20180421132929.21610-4-mreitz@redhat.com>
 <5ee0cf91-5533-2500-b4f1-5eac0dee8be4@redhat.com>
In-Reply-To: <5ee0cf91-5533-2500-b4f1-5eac0dee8be4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-25 16:33, Eric Blake wrote:
> On 04/21/2018 08:29 AM, Max Reitz wrote:
>> This flag signifies that a write request will not change the visible
>> disk content.  With this flag set, it is sufficient to have the
>> BLK_PERM_WRITE_UNCHANGED permission instead of BLK_PERM_WRITE.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  include/block/block.h | 6 +++++-
>>  block/io.c            | 6 +++++-
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> Since patch 5 adds an instance of a driver setting supported_write_flag=
s
> =3D BDRV_REQ_WRITE_UNCHANGED, I think this patch should tweak the
> documentation of supported_write_flags (and supported_zero_flags?) in
> block_int.h to mention that drivers can opt-in to supporting this
> particular flag (rather than it being handled completely at the block
> layer).

Ah, right, I just didn't know we had a list of supported flags there.

And the flag isn't handled by the block layer if drivers don't support
it -- it just is cleared then and thus treated like a normal write.

Maybe I should make a note that drivers should support the flag when
they support writes to their children, but don't explicitly request a
WRITE permission (so they rely on their parent to request the proper
permission, which might be just WRITE_UNCHANGED and not the full WRITE).

I'll send a patch.

> Also, that does raise the question of whether you have more work to
> support write-zero requests with WRITE_UNCHANGED (which indeed sounds
> like something plausible to support).

I'm afraid I don't quite understand the question.
BDRV_REQ_WRITE_UNCHANGED support is usually rather simple because as
said above it is only needed by drivers that rely on their parent to
request the permissions, i.e. filter drivers.  Since filter drivers just
forward the requests, all they have to do is retain the
BDRV_REQ_WRITE_UNCHANGED flag, be it a zero write or a normal write.

It would be more complicated for format drivers, because they would have
to verify that the incoming unchanged write actually ends up as an
unchanged write in their file.  But we have already recognized that that
would be too much to ask and that format drivers may want to generally
just write anything to their child if it's writable (even regardless of
whether the grandparent issues writes to the format driver node), so
they always grab a WRITE permission on their file if possible.
Therefore, they do not have to support this request flag.

Max


--UbsXZRjPzyn0644q2PHqtGDhYCQwQ58ek
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrgmgoACgkQ9AfbAGHV
z0AUBgf9FX9ENes3mFDNppL3eZqwFahrvXeee5FpSYSadoN73SNG/q2izL5uIRye
FcTBuzePoEckbq5dgBf9q63ZrSbZkZGJ+4RimXROylachYoeKu9CTxlwvri0sqzg
jdGcnLd81kNCELDFGWylDHulobrL1drUA9rKDy2PrM14wN0VJmgMDIu6YUvzlBvU
Zfq5R/atLUbv7LewfDtFAstSoh5+79dYBHlqqaE7laXbNIkk2Q1F0QpVqbl7G7wh
w7OqUrr2Dl1jnnha2Pghx7cdU9wUDvfDvuARctAnA9OCEi5mLNI4TDDARA2l4iIn
+bJEHQY77tQk3Ya5Dfxdc5gy/wGVog==
=Okgn
-----END PGP SIGNATURE-----

--UbsXZRjPzyn0644q2PHqtGDhYCQwQ58ek--
