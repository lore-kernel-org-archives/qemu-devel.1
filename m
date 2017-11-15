Received: from eggs.gnu.org ([2001:4830:134:3::10]:42575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF2kr-0005ol-Gq
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF2kq-0003rN-T4
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:49:45 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-4-git-send-email-anton.nefedov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <be9e3518-cca4-18b8-d56b-8e574fd782da@redhat.com>
Date: Wed, 15 Nov 2017 19:49:30 +0100
MIME-Version: 1.0
In-Reply-To: <1510654613-47868-4-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eWhoWDld3Bk9RoULPiV9nkXBxBMA91SM1"
Subject: Re: [Qemu-devel] [PATCH 3/5] block: support compressed write for
 copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eWhoWDld3Bk9RoULPiV9nkXBxBMA91SM1
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com
Message-ID: <be9e3518-cca4-18b8-d56b-8e574fd782da@redhat.com>
Subject: Re: [PATCH 3/5] block: support compressed write for copy-on-read
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1510654613-47868-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1510654613-47868-4-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 11:16, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/io.c         | 30 ++++++++++++++++++++++++------
>  block/trace-events |  2 +-
>  2 files changed, 25 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index 3d5ef2c..93c6b24 100644
> --- a/block/io.c
> +++ b/block/io.c

[...]

> @@ -1209,6 +1220,13 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child=
,
>          return ret;
>      }
> =20
> +    /* write compressed only makes sense with copy on read */
> +    if ((flags & BDRV_REQ_WRITE_COMPRESSED) &&
> +        !(flags & BDRV_REQ_COPY_ON_READ))
> +    {
> +        return -EINVAL;
> +    }
> +

I think the assertion in bdrv_aligned_preadv() should be enough, but
either way:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>      bdrv_inc_in_flight(bs);
> =20
>      /* Don't do copy-on-read if we read data before write operation */=



--eWhoWDld3Bk9RoULPiV9nkXBxBMA91SM1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMjDoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyQ4H/35OyezFl0gKozpa3kG5JaQWOYZ4nz2h
FVPFOpJmbDYHF2zkqf+pEdpNlLl5XQ4seSKVkXJdfyFBmMI36zTSk59NQS5oQEVD
wNohojKx+HPISERImIQXi803pW1JfaFScG98oJSiDu3y4KzAnurGi+jMO+FcoaZ9
jGYI0Bhru5Om7tMV/GUNzu/HxLrt3NXFhPXzjTbGX25+q8G1AzJVDoilcIAD6tYB
RFhnGLc3zDfuE6CT6HX75JwZzldgGIIWBQVxv20Bs+TeO3UeCVrHu4cnyXnqYM1R
bFdZGGJW8Vour43Gg7VWPH3dJDL4EHcvkyawgzsjtEfkd6ySxOEe90Q=
=X6nD
-----END PGP SIGNATURE-----

--eWhoWDld3Bk9RoULPiV9nkXBxBMA91SM1--
