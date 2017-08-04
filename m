Received: from eggs.gnu.org ([2001:4830:134:3::10]:35011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddeRd-0005F5-Lk
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddeRY-0008Do-Ua
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:23:21 -0400
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501597152-25342-3-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <444f8ae2-dbf2-b4d5-a979-586142edae67@redhat.com>
Date: Fri, 4 Aug 2017 10:23:08 -0500
MIME-Version: 1.0
In-Reply-To: <1501597152-25342-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qotgX8tp9TJbXc9i67eggj6tn4JOHkp5b"
Subject: Re: [Qemu-devel] [PATCH v4 02/15] blkverify: set supported
 write/zero flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qotgX8tp9TJbXc9i67eggj6tn4JOHkp5b
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com,
 mreitz@redhat.com
Message-ID: <444f8ae2-dbf2-b4d5-a979-586142edae67@redhat.com>
Subject: Re: [PATCH v4 02/15] blkverify: set supported write/zero flags
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1501597152-25342-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501597152-25342-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2017 09:18 AM, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/blkverify.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Basically, blkverify supports a flag if BOTH of its underlying files
also support the flag; if either side can't handle the flag, then we
fall back to emulation for both sides.

With more overhead, we COULD state that we support both bits if at least
one of the two underlying BDS supports the bit, and then emulate support
for the bit on the second BDS where it was lacking, so that at least the
first BDS doesn't suffer from the penalties of the fallbacks.  But that
means duplicating the block layer fallback code in blkverify, which is
already something that we don't necessarily expect high performance from.=


For FUA, failure to implement the bit merely means that we have more
device-wide flush calls (instead of per-transaction mini-flushes), but
the end data should be the same.  But for MAY_UNMAP, I'm worried that we
may have situations where a plain BDS will create holes, while running
the same device paired through blkverify will fall back to slower
explicit zeroes.  I'm wondering whether this will bite us, if we have
scenarios where the mere fact of trying to verify block device behavior
changes what behavior we are even verifying.

Thus, while I think the code change _looks_ okay, I'm not sure if it is
correct design-wise, nor whether it is 2.10 material.

> +    bs->supported_write_flags =3D BDRV_REQ_FUA &
> +        bs->file->bs->supported_write_flags &
> +        s->test_file->bs->supported_write_flags;
> +
> +    bs->supported_zero_flags =3D
> +        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
> +        bs->file->bs->supported_zero_flags &
> +        s->test_file->bs->supported_zero_flags;
> +
>      ret =3D 0;
>  fail:
>      qemu_opts_del(opts);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qotgX8tp9TJbXc9i67eggj6tn4JOHkp5b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEkVwACgkQp6FrSiUn
Q2od2wf/VifCry/ysPrG97ZR1/LGSEd0mDuNkhvQOIKCUGG/qESE1xmFA1hxHqYE
x+S8ovV3AOnATZ1ee/DrwRyrk+YcGeDP0J5ArFQmhSa+G6071ulVRJlJiL0Qd3Fw
l28TIbxb9Ur3x09YkrHdQdEaXQYQg8WYpQBYJ3+AGvWatJQt+YwC5OtKWOPR4S3z
/vtl4fKhrX8UOatw1FZzO96QBcpppUyxVa0ufuImkdUgHrojrzhQOrobjGjRAg6u
3pP3l4pM1Up+wZd9rJxBw0o6sSYdYbhF4GgYYz0GdbI0IqvhjcUmDUDP/hwApGvZ
3kW7YTn4IWhJvKCW9kf0dCVtMOaN7g==
=tQGj
-----END PGP SIGNATURE-----

--qotgX8tp9TJbXc9i67eggj6tn4JOHkp5b--
