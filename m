Received: from eggs.gnu.org ([2001:4830:134:3::10]:37307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYFZZ-0007D2-Ge
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 12:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYFZU-0001Jr-Ik
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 12:16:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYFZU-0001Ji-9x
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 12:16:52 -0500
References: <1485771730-19849-1-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <33cf3518-bf30-88fa-5fb5-17d9ddff503d@redhat.com>
Date: Mon, 30 Jan 2017 11:16:49 -0600
MIME-Version: 1.0
In-Reply-To: <1485771730-19849-1-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LaFECtjilj5pJ8tkfvkwrvqP3eKeVLloG"
Subject: Re: [Qemu-devel] [PATCH 1/1] mirror: restore offset after zeroing
 out the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LaFECtjilj5pJ8tkfvkwrvqP3eKeVLloG
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <33cf3518-bf30-88fa-5fb5-17d9ddff503d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] mirror: restore offset after zeroing out
 the image
References: <1485771730-19849-1-git-send-email-den@openvz.org>
In-Reply-To: <1485771730-19849-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2017 04:22 AM, Denis V. Lunev wrote:
> If explicit zeroing out before mirroring is required for the target ima=
ge,
> it moves the block job offset counter to EOF, then offset and len count=
ers
> count the image size twice.
>=20
> There is no harm but confusing stats (e.g. for 1G image the completion
> counter starts from 1G and increases to 2G)
>=20
> The patch fixed that problem by resetting the offset counter.

Counters are explicitly documented NOT tied to disk length; they are
merely estimates of proportional completion.  I'm not sure if this makes
the numbers jump backwards from the observer's viewpoint, but if you can
ever spot 1g/1g right before rewinding to 0g/1g (where pre-patch could
see 1g/2g), then that is a reason to not take this patch.  On the other
hand, your argument that the pre-patch behavior progressing towards 2g
has a very fast progression from 0-1g/2g, and then a much slower
1g-2g/2g, which makes the estimate of percent completion skewed, while a
newer progression of 0-1g/1g is more realistic, may have some merit.

I'm not sold on this patch yet, but stronger arguments in the commit
message may sway me.

> +++ b/tests/qemu-iotests/094.out
> @@ -3,9 +3,9 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D671=
08864
>  Formatting 'TEST_DIR/source.IMGFMT', fmt=3DIMGFMT size=3D67108864
>  {"return": {}}
>  {"return": {}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_READY", "data": {"device": "src", "len": 67108864, "offs=
et": 67108864, "speed": 0, "type": "mirror"}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_READY", "data": {"device": "src", "len": 0, "offset": 0,=
 "speed": 0, "type": "mirror"}}
>  {"return": {}}

This part of the change is scary - a ready event showing 0/0 HAS been
known to confuse libvirt in the past.  Qemu should NEVER advertise a
ready event with 0/0, it should at least be 1/1 (because of the number
of clients that have workarounds to deal with older qemu behavior on 0/0
and which might misbehave if we ever issue that again).

> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 67108864, "=
offset": 67108864, "speed": 0, "type": "mirror"}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 0, "offset"=
: 0, "speed": 0, "type": "mirror"}}

So NACK to the patch as currently written, but not necessarily to the
idea if you can give better progress numbers and never reach the state
of BLOCK_JOB_READY and BLOCK_JOB_COMPLETED with a 0/0 length/offset.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--LaFECtjilj5pJ8tkfvkwrvqP3eKeVLloG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj3UBAAoJEKeha0olJ0NqLYMIAIAZYJNtcbSjEK40sxM2aGOG
NYVk9PjR14yelWYXGCBuE1t9eMFkbFNM5uDZliHzKC7UxCv3zfZrNR1QFQdSJ9IY
t2rgeH51HyDRlS7xqjzF49oT5zThc0CyVI/N5fyouzY731V9EweK0B+kuIkBUOfS
CqiWD6UIMiJGaj/uLxK+o6mX9zL0ANNpg+bLMfD7c/694KlgqcPE7xviYXgY0BhE
i8fprGbn88qwig/mGfVSXDCrETJWvahyg5d1xn6eQX8Kw1XBVbFZZwotwZBwUDEw
VcS/httdyfTks0S9hHNezFv7Ta93QoDCDpyLbNbA+LW/dR+qPI1fvZfA5zYwqYk=
=XiVk
-----END PGP SIGNATURE-----

--LaFECtjilj5pJ8tkfvkwrvqP3eKeVLloG--
