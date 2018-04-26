Received: from eggs.gnu.org ([2001:4830:134:3::10]:50064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBWPQ-00076B-Mv
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 22:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBWPP-0005xi-MC
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 22:13:20 -0400
References: <20180421132929.21610-1-mreitz@redhat.com>
	<20180421132929.21610-4-mreitz@redhat.com>
	<5ee0cf91-5533-2500-b4f1-5eac0dee8be4@redhat.com>
	<377c9a6a-aa05-dec8-52fb-f0cdfc2c2b50@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae48f373-a9a5-fb67-3241-4812e13a4b08@redhat.com>
Date: Wed, 25 Apr 2018 21:12:54 -0500
MIME-Version: 1.0
In-Reply-To: <377c9a6a-aa05-dec8-52fb-f0cdfc2c2b50@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YuCYkA4wgbe523PQNRvXrjD0GkJadfXGA"
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
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YuCYkA4wgbe523PQNRvXrjD0GkJadfXGA
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <ae48f373-a9a5-fb67-3241-4812e13a4b08@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/9] block: Add BDRV_REQ_WRITE_UNCHANGED
 flag
References: <20180421132929.21610-1-mreitz@redhat.com>
 <20180421132929.21610-4-mreitz@redhat.com>
 <5ee0cf91-5533-2500-b4f1-5eac0dee8be4@redhat.com>
 <377c9a6a-aa05-dec8-52fb-f0cdfc2c2b50@redhat.com>
In-Reply-To: <377c9a6a-aa05-dec8-52fb-f0cdfc2c2b50@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 10:08 AM, Max Reitz wrote:

>=20
>> Also, that does raise the question of whether you have more work to
>> support write-zero requests with WRITE_UNCHANGED (which indeed sounds
>> like something plausible to support).
>=20
> I'm afraid I don't quite understand the question.
> BDRV_REQ_WRITE_UNCHANGED support is usually rather simple because as
> said above it is only needed by drivers that rely on their parent to
> request the permissions, i.e. filter drivers.  Since filter drivers jus=
t
> forward the requests, all they have to do is retain the
> BDRV_REQ_WRITE_UNCHANGED flag, be it a zero write or a normal write.

I'm trying to figure out if BDRV_REQ_WRITE_UNCHANGED makes sense for
bdrv_co_pwrite_zeroes as well as bdrv_co_pwrite. I think the answer is
yes (if we know the guest already reads zeroes, but need to write to the
protocol layer anyways because of a commit operation, then mixing both
BDRV_REQ_WRITE_UNCHANGED and BDRV_REQ_ZERO_WRITE to the block layer
makes sense, and supported_zero_flags should indeed pass
BDRV_REQ_WRITE_UNCHANGED on to a driver.

>=20
> It would be more complicated for format drivers, because they would hav=
e
> to verify that the incoming unchanged write actually ends up as an
> unchanged write in their file.  But we have already recognized that tha=
t
> would be too much to ask and that format drivers may want to generally
> just write anything to their child if it's writable (even regardless of=

> whether the grandparent issues writes to the format driver node), so
> they always grab a WRITE permission on their file if possible.
> Therefore, they do not have to support this request flag.

So qcow2 doesn't have to support the flag, but file-posix.c might want
to.  Or are you saying that only filter drivers need to advertise
support for the flag?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--YuCYkA4wgbe523PQNRvXrjD0GkJadfXGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrhNaYACgkQp6FrSiUn
Q2pt8Af/VlPNq/AlWyZpnutzl93MMYCZeLVmb1az3Z/TCcJnDI5uzDctKqkGS+Sm
y3Vs6CAEv1ZB2aA7YwfSLPs70Lqdp3XWhs5Od359Pmv5NDjyfxaUMCKlh9s43/M6
3lpp9plP4S3XY2Z7CoKJYY1Z7Wp1eJmSBfZnHSB7r29DSJznrm0yAlOoOENqABVH
uAhOv1nd9BMDy5phV1prl8/xSb3wyyHGN+vFPTpVBPhdmd2m5I5tAiLU3rvyYpyJ
Ss7W0JDTvb/VjxGQRF9+lI8XIROHXJWK4c+Zznjzizfym7BEavfhkSFJzfKyXV5a
5od4jWjGZuQm06SMjwUGZD8G7/FSTA==
=0fF/
-----END PGP SIGNATURE-----

--YuCYkA4wgbe523PQNRvXrjD0GkJadfXGA--
