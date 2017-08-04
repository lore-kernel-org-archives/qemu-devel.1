Received: from eggs.gnu.org ([2001:4830:134:3::10]:57892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddelm-0005ce-5w
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddell-0005eU-7H
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:44:10 -0400
References: <20170804140848.880-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0c382c84-1135-56b6-d90f-1c44e33f1f00@redhat.com>
Date: Fri, 4 Aug 2017 10:44:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170804140848.880-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nWuWm1o7EMSh6wBsksOpOxKwqLPpPo1uW"
Subject: Re: [Qemu-devel] [PATCH for-2.10] quorum: Handle bdrv_getlength()
 failures in quorum_co_flush()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nWuWm1o7EMSh6wBsksOpOxKwqLPpPo1uW
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Message-ID: <0c382c84-1135-56b6-d90f-1c44e33f1f00@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] quorum: Handle bdrv_getlength()
 failures in quorum_co_flush()
References: <20170804140848.880-1-berto@igalia.com>
In-Reply-To: <20170804140848.880-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 09:08 AM, Alberto Garcia wrote:
> A bdrv_getlength() call can fail and return a negative value. This
> is not being handled in quorum_co_flush(), which can result in a
> QUORUM_REPORT_BAD event with an arbitrary value on the 'sectors-count'
> field.
>=20
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/quorum.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/quorum.c b/block/quorum.c
> index 55ba916655..d77991d680 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -785,8 +785,9 @@ static coroutine_fn int quorum_co_flush(BlockDriver=
State *bs)
>      for (i =3D 0; i < s->num_children; i++) {
>          result =3D bdrv_co_flush(s->children[i]->bs);
>          if (result) {
> +            int64_t length =3D bdrv_getlength(s->children[i]->bs);
>              quorum_report_bad(QUORUM_OP_TYPE_FLUSH, 0,
> -                              bdrv_getlength(s->children[i]->bs),
> +                              length > 0 ? length : 0,

In the fallback case, is always picking 0 good enough?  Then again, this
is in the error path, so it is unlikely in practice, and I don't see any
better way to handle it.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nWuWm1o7EMSh6wBsksOpOxKwqLPpPo1uW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmElkAACgkQp6FrSiUn
Q2pQIgf/SsL3xcUzNykbvJOF2GMRF29s0D0VpsLq5gC9fdxksCfqDOO0iIXTruHl
pwLpVvQpv8AD5yMjmr37xcMkkea9C0hgwuJq47Vzoz6DjliooNsaxO0ywzi10Pou
8H4kyPCN0hVZXmO/6WjPRLO6ZSUs8NxZ+j1t5pJx3GmgVc+ipQIvi0b1WmzkW7o3
Sb/63MMuEO0Sq7fnomigBSb6zWjC4cHVUDtw2IgmSys5lFiIzT/hE4CL7TtHNp8C
mTZgO2Nq/P8JdIADaYk8qDn3GuVOiRRgECwrnLh4nvHQNHyNhNNbzI6uh3SzeVYp
qxnaWO1rYDRVin1x4fgnCt1TkO74og==
=AcJp
-----END PGP SIGNATURE-----

--nWuWm1o7EMSh6wBsksOpOxKwqLPpPo1uW--
