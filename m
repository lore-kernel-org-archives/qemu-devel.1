Received: from eggs.gnu.org ([2001:4830:134:3::10]:45531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5vys-0006i8-Il
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5vyo-0002Vi-3k
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:18:50 -0400
References: <cover.1523376013.git.berto@igalia.com>
	<0f687957feb72e80c740403191a47e607c2463fe.1523376013.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d48c55a6-3405-3ab7-0bb9-96a2238874da@redhat.com>
Date: Tue, 10 Apr 2018 11:18:28 -0500
MIME-Version: 1.0
In-Reply-To: <0f687957feb72e80c740403191a47e607c2463fe.1523376013.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TNWte9HuQ7B6xGflLFZNUtjD2sJQH1n9p"
Subject: Re: [Qemu-devel] [PATCH 1/2] Fix error message about compressed
 clusters with OFLAG_COPIED
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
--TNWte9HuQ7B6xGflLFZNUtjD2sJQH1n9p
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <d48c55a6-3405-3ab7-0bb9-96a2238874da@redhat.com>
Subject: Re: [PATCH 1/2] Fix error message about compressed clusters with
 OFLAG_COPIED
References: <cover.1523376013.git.berto@igalia.com>
 <0f687957feb72e80c740403191a47e607c2463fe.1523376013.git.berto@igalia.com>
In-Reply-To: <0f687957feb72e80c740403191a47e607c2463fe.1523376013.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2018 11:05 AM, Alberto Garcia wrote:
> Compressed clusters are not supposed to have the COPIED bit set.
> "qemu-img check" detects that and prints an error message reporting
> the number of the affected host cluster. This doesn't make much sense
> because compressed clusters are not aligned to host clusters, so it
> would be better to report the offset instead. Plus, the calculation is
> wrong and it uses the raw L2 entry as if it was simply an offset.
>=20
> This patch fixes the error message and reports the offset of the
> compressed cluster.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-refcount.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Do we have iotests coverage of this?

Should the qcow2 spec be explicit that OFLAG_COPIED should never be set
on a compressed cluster? The current documentation for L2 table entry
mentions that bit 63 is '1' for a cluster with a refcount of exactly 1
if it is an L2 table reachable from the active L1 table, with no mention
of a restriction that it must not be set when bit 62 is set.  Or is it
feasible that although qemu itself (should) never set OFLAG_COPIED on a
compressed cluster, that some third-party tool could still validly set
the bit for a compressed cluster that happens to occupy a host cluster
with a refcount of exactly 1 (and where writing to that cluster could be
done by replacing the cluster in-place with uncompressed data, or by
again writing compressed data - compression is rather wasteful in that
sense as the tail of the host cluster is unused, and the only way to use
the tail of the cluster is with another compressed cluster at which
point the refcount is no longer 1).

> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 6b8b63514a..2dc23005b7 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1577,9 +1577,9 @@ static int check_refcounts_l2(BlockDriverState *b=
s, BdrvCheckResult *res,
>          case QCOW2_CLUSTER_COMPRESSED:
>              /* Compressed clusters don't have QCOW_OFLAG_COPIED */
>              if (l2_entry & QCOW_OFLAG_COPIED) {
> -                fprintf(stderr, "ERROR: cluster %" PRId64 ": "
> +                fprintf(stderr, "ERROR: coffset=3D0x%" PRIx64 ": "
>                      "copied flag must never be set for compressed "
> -                    "clusters\n", l2_entry >> s->cluster_bits);
> +                    "clusters\n", l2_entry & s->cluster_offset_mask);
>                  l2_entry &=3D ~QCOW_OFLAG_COPIED;

At any rate, regardless of the answers to my questions, the error
message cleanup makes sense.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TNWte9HuQ7B6xGflLFZNUtjD2sJQH1n9p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrM49QACgkQp6FrSiUn
Q2rcyQf+JfUVeN7ui7U0z8S74Vgk+Wax5e3ksOHQZqYwpCCoY14uPwpQBnPaiGiE
jaahQo4ck54fKBhHdwsj/QHReG+eZi1dg4r2L/RNOOZ+MNrlU1bEBK29jEN7enl4
cm+y9XC/s2LqPelbtZoJbC0MNrF5zu2s44FBNYBjrP4LdsVv8XsY0qhRnsFPGS58
BLRdz6z/615rrGvOUF2gqn9gBOlqZVQLR+VJZiWb9o2hFyYQOGPhKFELpesQzB0J
MPaehuoNWvYfnoWRa6aMvEdn2ETbAOC3XgOQLFh54AZMfYSF5Lr5JvN+gNjucbQx
kNtLANXRokvGf8NrjucEL3uzBwMUIQ==
=/2I5
-----END PGP SIGNATURE-----

--TNWte9HuQ7B6xGflLFZNUtjD2sJQH1n9p--
