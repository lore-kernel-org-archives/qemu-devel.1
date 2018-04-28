Received: from eggs.gnu.org ([2001:4830:134:3::10]:47876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fCNtP-0000XA-8q
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 07:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fCNtO-0005qk-9q
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 07:19:51 -0400
References: <20180421132929.21610-1-mreitz@redhat.com>
	<20180421132929.21610-4-mreitz@redhat.com>
	<5ee0cf91-5533-2500-b4f1-5eac0dee8be4@redhat.com>
	<377c9a6a-aa05-dec8-52fb-f0cdfc2c2b50@redhat.com>
	<ae48f373-a9a5-fb67-3241-4812e13a4b08@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7632df03-6884-7533-f2b1-cdd8f293bea1@redhat.com>
Date: Sat, 28 Apr 2018 13:19:37 +0200
MIME-Version: 1.0
In-Reply-To: <ae48f373-a9a5-fb67-3241-4812e13a4b08@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WsqXQmGPcl1VQF40BZEIDpEnUIjphGMbF"
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
--WsqXQmGPcl1VQF40BZEIDpEnUIjphGMbF
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <7632df03-6884-7533-f2b1-cdd8f293bea1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/9] block: Add BDRV_REQ_WRITE_UNCHANGED
 flag
References: <20180421132929.21610-1-mreitz@redhat.com>
 <20180421132929.21610-4-mreitz@redhat.com>
 <5ee0cf91-5533-2500-b4f1-5eac0dee8be4@redhat.com>
 <377c9a6a-aa05-dec8-52fb-f0cdfc2c2b50@redhat.com>
 <ae48f373-a9a5-fb67-3241-4812e13a4b08@redhat.com>
In-Reply-To: <ae48f373-a9a5-fb67-3241-4812e13a4b08@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-26 04:12, Eric Blake wrote:
> On 04/25/2018 10:08 AM, Max Reitz wrote:
>=20
>>
>>> Also, that does raise the question of whether you have more work to
>>> support write-zero requests with WRITE_UNCHANGED (which indeed sounds=

>>> like something plausible to support).
>>
>> I'm afraid I don't quite understand the question.
>> BDRV_REQ_WRITE_UNCHANGED support is usually rather simple because as
>> said above it is only needed by drivers that rely on their parent to
>> request the permissions, i.e. filter drivers.  Since filter drivers ju=
st
>> forward the requests, all they have to do is retain the
>> BDRV_REQ_WRITE_UNCHANGED flag, be it a zero write or a normal write.
>=20
> I'm trying to figure out if BDRV_REQ_WRITE_UNCHANGED makes sense for
> bdrv_co_pwrite_zeroes as well as bdrv_co_pwrite. I think the answer is
> yes (if we know the guest already reads zeroes, but need to write to th=
e
> protocol layer anyways because of a commit operation, then mixing both
> BDRV_REQ_WRITE_UNCHANGED and BDRV_REQ_ZERO_WRITE to the block layer
> makes sense, and supported_zero_flags should indeed pass
> BDRV_REQ_WRITE_UNCHANGED on to a driver.

Well, why not.

>> It would be more complicated for format drivers, because they would ha=
ve
>> to verify that the incoming unchanged write actually ends up as an
>> unchanged write in their file.  But we have already recognized that th=
at
>> would be too much to ask and that format drivers may want to generally=

>> just write anything to their child if it's writable (even regardless o=
f
>> whether the grandparent issues writes to the format driver node), so
>> they always grab a WRITE permission on their file if possible.
>> Therefore, they do not have to support this request flag.
>=20
> So qcow2 doesn't have to support the flag, but file-posix.c might want
> to.  Or are you saying that only filter drivers need to advertise
> support for the flag?

It might make sense for file-posix, but when you think further, it
wouldn't do anything in practice.

First, if a protocol driver receives WRITE_UNCHANGED, there are two
things it can do: If it knows that it only has very plain storage, it
can just ignore the request because it won't do anything.

If a protocol driver supports backing files (gluster does, I think), it
cannot ignore them because just like qcow2 it needs to now make sure
that the data ends up in the top layer.  So if the protocol driver can
draw any benefits from advertising to the protocol that this is an
unchanging write (or that it just wants to bring data from a backing
file up to the top level, which it can infer from the WRITE_UNCHANGED
flag), then it would make sense for it to support the flag.

(Good point to add to the documentation.)

But from qemu's perspective, this is not required.  The protocol driver
will just be less efficient if it submits normal writes (and it can do
that, because qemu will refuse to grant WRITE_UNCHANGED on read-only
nodes, so the protocol driver must have write access).

OTOH, filter drivers (usually) *must* support this flag because they are
caught up in qemu's permission system.  They do not submit the writes to
some protocol, but to the block layer, and the block layer wants you to
have the proper permissions for that -- and that's not a simple RW/RO
decision, but we have read/write-unchanged in between.  So if a filter
driver that only forwards the permissions from its parent may only do
the very same requests the parent does -- and if the parent does a
WRITE_UNCHANGED request, the filter driver must do the same.

Max


--WsqXQmGPcl1VQF40BZEIDpEnUIjphGMbF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrkWMkACgkQ9AfbAGHV
z0DF4AgAu8hw88IQWNetBT+HRCSdjZj9vWK3m0GTE5FXQUe+nDPt/LABJaRJtbqt
SMrdZjKZhWLq0g8B0THN+oK/EyKI5oDAEP1PfmTIhF8bgBQj8boV88GGfHLGFyZv
TL9FAkjbXgj33KlJdiA3puBCbui5plyOvbHdjAd9byQXjjwdTg48jiSuBfV6U+0W
TWg6W6xZwT39H+nqRYnGKJH5o27vQ+IqrbJEmfX2tEyfu+v721VL4hZYSKCYNELL
CvmG6XBmuAg8kmFAz8W5dB3VE9owFXlQbN127q9SDsrcqdlh9Fye9M4r8A7Nq2xI
f2rxgOrm1hrkMYCrNGBpWTYsUVgSjg==
=SVxL
-----END PGP SIGNATURE-----

--WsqXQmGPcl1VQF40BZEIDpEnUIjphGMbF--
