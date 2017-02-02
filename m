Received: from eggs.gnu.org ([2001:4830:134:3::10]:46709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cZJ8T-00035J-R0
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cZJ8S-0008E6-Sd
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:17:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cZJ8S-0008DN-KE
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:17:20 -0500
References: <1486045515-8009-1-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <68cc533c-a7d6-c87f-a404-4c93186d0aaa@redhat.com>
Date: Thu, 2 Feb 2017 09:17:17 -0600
MIME-Version: 1.0
In-Reply-To: <1486045515-8009-1-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HFBUw6ltuBJJg6iMRiJ4GkPV2D4Fgn7Ti"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] mirror: do not increase offset
 during initial zero_or_discard phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HFBUw6ltuBJJg6iMRiJ4GkPV2D4Fgn7Ti
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Jeff Cody
 <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <68cc533c-a7d6-c87f-a404-4c93186d0aaa@redhat.com>
Subject: Re: [PATCH v2 1/1] mirror: do not increase offset during initial
 zero_or_discard phase
References: <1486045515-8009-1-git-send-email-den@openvz.org>
In-Reply-To: <1486045515-8009-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2017 08:25 AM, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>=20
> If explicit zeroing out before mirroring is required for the target ima=
ge,
> it moves the block job offset counter to EOF, then offset and len count=
ers
> count the image size twice. There is no harm but stats are confusing,
> specifically the progress of the operation is always reported as 99% by=

> management tools.
>=20
> The patch skips offset increase for the first "technical" pass over the=

> image. This should not cause any further harm.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Jeff Cody <jcody@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> ---

> +    bool initial_zeroing_ongoing;

Long name. With a bit of bikeshedding, I might have used 'init_pass' for
a shorter name (particularly if some later patch introduces another
aspect of initialization that is not zeroing but is worth ignoring with
respects to progress reporting).

>  } MirrorBlockJob;
> =20
>  typedef struct MirrorOp {
> @@ -117,9 +118,10 @@ static void mirror_iteration_done(MirrorOp *op, in=
t ret)
>          if (s->cow_bitmap) {
>              bitmap_set(s->cow_bitmap, chunk_num, nb_chunks);
>          }
> -        s->common.offset +=3D (uint64_t)op->nb_sectors * BDRV_SECTOR_S=
IZE;
> +        if (!s->initial_zeroing_ongoing) {
> +            s->common.offset +=3D (uint64_t)op->nb_sectors * BDRV_SECT=
OR_SIZE;
> +        }
>      }
> -
>      qemu_iovec_destroy(&op->qiov);

Why are you deleting the blank line?

Other than naming, the patch looks reasonable.  If you spin a v3 with
only the name changed, you can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--HFBUw6ltuBJJg6iMRiJ4GkPV2D4Fgn7Ti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYk019AAoJEKeha0olJ0NqUccH/j98unY1DT9TSRyKzuHObtgP
t/NIWdtlmfhMcYiCiDafdgjRpjnCP54Dc45UA9r6HfN3lIjkQgcomZIhjo3N7VlJ
UIi2UbezdtwfXOxlxMy3V8U6JWs6KgHisZPgA3RipqcIhOkKiKtF/q44dSB8ksEE
NXxbkAgEQ2qyrRg4m5ErioGa5j/w2hrxZicto7+7Ig7+5uGUubsYIl8kabKzEha4
xKtQUQWh5dlZNACcmxDgMubKyYCxXx34fD+ItK3vvbeJqCPDF7qNuJmM2Ms6tQ92
n3DuoXsW9onlNGbXdyPOyhhFh7l1a7DACMI/II11xenorHSliP7PMSrD6Fz0TOw=
=aeUV
-----END PGP SIGNATURE-----

--HFBUw6ltuBJJg6iMRiJ4GkPV2D4Fgn7Ti--
