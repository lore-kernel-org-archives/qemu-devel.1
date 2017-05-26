Received: from eggs.gnu.org ([2001:4830:134:3::10]:43936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMpn-0001L1-5L
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMpm-0004zz-3H
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:31:47 -0400
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-6-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7ca29a83-b3de-1775-0284-d208a5b3e511@redhat.com>
Date: Fri, 26 May 2017 16:31:35 -0500
MIME-Version: 1.0
In-Reply-To: <1495830130-30611-6-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ts6VNggVG1jNDDWtFdOa8w9kjTF4M3x6P"
Subject: Re: [Qemu-devel] [PATCH 05/29] qed: Remove callback from
 qed_find_cluster()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ts6VNggVG1jNDDWtFdOa8w9kjTF4M3x6P
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Message-ID: <7ca29a83-b3de-1775-0284-d208a5b3e511@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/29] qed: Remove callback from
 qed_find_cluster()
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
 <1495830130-30611-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495830130-30611-6-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 03:21 PM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed-cluster.c | 39 ++++++++++++++++++++++-----------------
>  block/qed.c         | 20 +++++++++++---------
>  block/qed.h         |  4 ++--
>  3 files changed, 35 insertions(+), 28 deletions(-)
>=20

This diffstat is not as slick as the earlier patches, but the cleanup is
still worthwhile.

> @@ -93,16 +98,16 @@ void qed_find_cluster(BDRVQEDState *s, QEDRequest *=
request, uint64_t pos,
>      /* Limit length to L2 boundary.  Requests are broken up at the L2 =
boundary
>       * so that a request acts on one L2 table at a time.
>       */
> -    len =3D MIN(len, (((pos >> s->l1_shift) + 1) << s->l1_shift) - pos=
);
> +    *len =3D MIN(*len, (((pos >> s->l1_shift) + 1) << s->l1_shift) - p=
os);

Perhaps a separate cleanup, but wouldn't this be easier to read as:
*len =3D MIN(*len, QEMU_ALIGN_UP(pos, 1ULL << s->l1_shift) - pos);

(or if there is a direct variable for l1 size, rather than '1ULL <<
s->l1_shift')

> +++ b/block/qed.h
> @@ -247,8 +247,8 @@ int qed_write_l2_table_sync(BDRVQEDState *s, QEDReq=
uest *request,
>  /**
>   * Cluster functions
>   */
> -void qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t p=
os,
> -                      size_t len, QEDFindClusterFunc *cb, void *opaque=
);
> +int qed_find_cluster(BDRVQEDState *s, QEDRequest *request, uint64_t po=
s,
> +                     size_t *len, uint64_t *img_offset);

While we're touching this, would it be better to switch to an
always-64-bit type, rather than using platform-dependent size_t for len?
 But even so, that cleanup would be a separate patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ts6VNggVG1jNDDWtFdOa8w9kjTF4M3x6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKJ63AAoJEKeha0olJ0Nq8r8IAICkq4cEkeG0RrHc2DcOEMHi
BKU9Pn0qkfpOKDv3Xg4RFP5g8FN0pfrHVdSyfFiniBVB3GdgT6W4qm/hfboZMdj9
Z4S/W13WvStg8Fv3wgrIFOb2GOqOtMaZcBULo3E69j8ibdsWRb62puG8YB1tgXwB
XVcEiwGNzK7+KxZD/fPSPgfEfZCejJ6Kswf4itFHdrCMn/7tFXOIc9JUma0Htxu/
hmsBNZ3Ltd94HDAF31nsSx2XG6+1c9CWAs34eERMe+39OLECOfcnQx0nuWxA4gcY
im+abYoTnFygY9owIOlJbVobK2A+iFEYr9I2K2Kv9o8WYfaMTEMnekm8pAdvwts=
=n4Jt
-----END PGP SIGNATURE-----

--ts6VNggVG1jNDDWtFdOa8w9kjTF4M3x6P--
