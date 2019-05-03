Received: from eggs.gnu.org ([209.51.188.92]:51894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMfIp-0004O8-G7
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMfIo-0003qU-G8
	for qemu-devel@nongnu.org; Fri, 03 May 2019 17:01:07 -0400
References: <20190503093832.9015-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <47bddacf-e212-92fe-f1cc-dced934b73b9@redhat.com>
Date: Fri, 3 May 2019 16:01:01 -0500
MIME-Version: 1.0
In-Reply-To: <20190503093832.9015-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AEgvS7RyC9mVix3buedH5RFrUGTq496xo"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Assert that host cluster offsets
 fit in L2 table entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AEgvS7RyC9mVix3buedH5RFrUGTq496xo
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <47bddacf-e212-92fe-f1cc-dced934b73b9@redhat.com>
Subject: Re: [PATCH] qcow2: Assert that host cluster offsets fit in L2 table
 entries
References: <20190503093832.9015-1-berto@igalia.com>
In-Reply-To: <20190503093832.9015-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/3/19 4:38 AM, Alberto Garcia wrote:
> The standard cluster descriptor in L2 table entries has a field to
> store the host cluster offset. When we need to get that offset from an
> entry we use L2E_OFFSET_MASK to ensure that we only use the bits that
> belong to that field.
>=20
> But while that mask is used every time we read from an L2 entry, it
> is never used when we write to it. Due to the QCOW_MAX_CLUSTER_OFFSET
> limit set in the cluster allocation code QEMU can never produce
> offsets that don't fit in that field so any such offset would indicate
> a bug in QEMU.

Yeah, I'm not seeing where this one could ever overflow.

>=20
> Compressed cluster descriptors contain two fields (host cluster offset
> and size of the compressed data) and the situation with them is
> similar. In this case the masks are not constant but are stored in the
> csize_mask and cluster_offset_mask fields of BDRVQcow2State.

For this one, we did have a bug in the past where we were overflowing,
as evidenced by iotest 220 shortly after we patched the bug (77d6a215).

>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20

Adding more assertions shouldn't hurt.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--AEgvS7RyC9mVix3buedH5RFrUGTq496xo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzMrA0ACgkQp6FrSiUn
Q2rCvwf/QXi8mr+bBThXr+FmIOfU8UDfZuP2HkcUfm53WH8ef3GIPX+yPSuflR3F
mDIDGbdBbjfmPchKTDORE7MPZhX9k6Hiq7g3+9bB+sfM2WdNRamwYKV0lh1SD6ml
ptdsxZpwmZ3YAzNuJMYGKfu62t2fWq8D4ux9RJehgyBa6QIZbg/wHKFnxEdH1qu4
N1zdflpBzntl6tbWrP1to1Cay0+4Ipw7Kn8STlcvb2gkI+fKdf60wcuihZNcj1ny
VE0W23YKMuDLLRNjMwvGdeDkfNNw5tGqVF65OQX0dk90M/ck2oW0QtXra8hjj+Xx
ThkaehfBJYJDGR0XZu7kyh0zkThMjQ==
=SM4p
-----END PGP SIGNATURE-----

--AEgvS7RyC9mVix3buedH5RFrUGTq496xo--
