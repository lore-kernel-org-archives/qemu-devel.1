Received: from eggs.gnu.org ([209.51.188.92]:58447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBS5O-0004eJ-Km
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 18:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBS5N-0006WN-LS
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 18:40:54 -0400
References: <20190401140903.19186-1-eblake@redhat.com>
	<20190401140903.19186-11-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7d73404-3b61-22f5-626d-6c4791c609b0@redhat.com>
Date: Tue, 2 Apr 2019 17:40:47 -0500
MIME-Version: 1.0
In-Reply-To: <20190401140903.19186-11-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CNGuY8g3aKdo97p01V0F5h8MDQuM2f60R"
Subject: Re: [Qemu-devel] [PULL 10/14] nbd/client: Reject inaccessible tail
 of inconsistent server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CNGuY8g3aKdo97p01V0F5h8MDQuM2f60R
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <a7d73404-3b61-22f5-626d-6c4791c609b0@redhat.com>
Subject: Re: [Qemu-devel] [PULL 10/14] nbd/client: Reject inaccessible tail of
 inconsistent server
References: <20190401140903.19186-1-eblake@redhat.com>
 <20190401140903.19186-11-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-11-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/1/19 9:08 AM, Eric Blake wrote:
> The NBD spec suggests that a server should never advertise a size
> inconsistent with its minimum block alignment, as that tail is
> effectively inaccessible to a compliant client obeying those block
> constraints. Since we have a habit of rounding up rather than
> truncating, to avoid losing the last few bytes of user input, and we
> cannot access the tail when the server advertises bogus block sizing,
> abort the connection to alert the server to fix their bug.  And
> rejecting such servers matches what we already did for a min_block
> that was not a power of 2 or which was larger than max_block.
>=20
> Does not impact either qemu (which always sends properly aligned
> sizes) or nbdkit (which does not send minimum block requirements yet);
> so this is mostly aimed at new NBD server implementations, and ensures
> that the rest of our code can assume the size is aligned.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20190330155704.24191-1-eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index de7da48246b..427980bdd22 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -426,6 +426,14 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uin=
t32_t opt,
>                  nbd_send_opt_abort(ioc);
>                  return -1;
>              }
> +            if (info->min_block &&
> +                !QEMU_IS_ALIGNED(info->size, info->min_block)) {
> +                error_setg(errp, "export size %" PRIu64 "is not multip=
le of "

Missing a space in the error message. If I have any other patches worthy
of an -rc3 pull request, I'll do the obvious fix then.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--CNGuY8g3aKdo97p01V0F5h8MDQuM2f60R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyj5O8ACgkQp6FrSiUn
Q2r1+Qf8DbJYoUdnJz+EB7+SOsRyNanOPtI597GCpM4b1h3iv0x4nbXuR8df/dd2
q8JPBqpuzK7hT0utacPeQUhcsL9OupPYwjn/z0dFBUpBnBf1y+Yb1SkhsiCk7Wyh
TFfVRkTnj1WtkUyAqVaBT9/jAOYFNmqTWDNEirly6BUI8asSjOawAvxo5oph4hYN
KgqUTS9wczwQGMA58HWDxtHEeUwq0izYGZrRhmqKHCZkhKNNXh44g/2uksHU7b9r
r3N/wteBGUx8jGer9MT9OL3lF3KD9rJNmQ/3K9zCHGmQZNWNdoVlsq/CdVd0a/vM
Q2hvmJReZbk6/jrLo31TQPcchs/umA==
=5NCN
-----END PGP SIGNATURE-----

--CNGuY8g3aKdo97p01V0F5h8MDQuM2f60R--
