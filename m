Received: from eggs.gnu.org ([2001:4830:134:3::10]:40807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGOP-0005Qy-6K
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGOO-0003Sp-8T
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:20:01 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-5-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8bb8a043-fb13-7c1c-4dc2-8b5ac40d5542@redhat.com>
Date: Sat, 12 May 2018 00:19:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-5-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="REuwJpb1mdEiOTmDG3KYuVAgBVEEhYo2F"
Subject: Re: [Qemu-devel] [PATCH 04/42] blockjob: Implement
 block_job_set_speed() centrally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--REuwJpb1mdEiOTmDG3KYuVAgBVEEhYo2F
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <8bb8a043-fb13-7c1c-4dc2-8b5ac40d5542@redhat.com>
Subject: Re: [PATCH 04/42] blockjob: Implement block_job_set_speed() centrally
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-5-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:25, Kevin Wolf wrote:
> All block job drivers support .set_speed and all of them duplicate the
> same code to implement it. Move that code to blockjob.c and remove the
> now useless callback.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/blockjob.h     |  2 ++
>  include/block/blockjob_int.h |  3 ---
>  block/backup.c               | 13 -------------
>  block/commit.c               | 14 --------------
>  block/mirror.c               | 14 --------------
>  block/stream.c               | 14 --------------
>  blockjob.c                   | 12 ++++--------
>  7 files changed, 6 insertions(+), 66 deletions(-)
>=20
> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> index 22bf418209..5aa8a6aaec 100644
> --- a/include/block/blockjob.h
> +++ b/include/block/blockjob.h
> @@ -29,6 +29,8 @@
>  #include "block/block.h"
>  #include "qemu/ratelimit.h"
> =20
> +#define SLICE_TIME 100000000ULL /* ns */
> +
>  typedef struct BlockJobDriver BlockJobDriver;
>  typedef struct BlockJobTxn BlockJobTxn;

SLICE_TIME can be anything.  I don't like something that can be anything
to be in a header file.  I can see that you still need it in mirror, so
it needs to be in a header; but maybe rename it to...
THROTTLE_SLICE_TIME?  At least JOB_SLICE_TIME?

Apart from that:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--REuwJpb1mdEiOTmDG3KYuVAgBVEEhYo2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2FwYACgkQ9AfbAGHV
z0BGugf9HNC36K7SkXYbguSwCMmX72fKCOuBGalVsL5MQnE9BVUT1E6RzlfBIYyS
mZOQ0pll4UShxIHn8B3E+D2usQZpkyGApgSrSTzByYizkI9N9Qf8DJba8yJjavg9
f1rJugFuI9s2fCEMAbuwcclQWbBSRrY+tkEC+Z9RvfZZXQ84xVzOh5LQwDh+ioM3
8SYzI4Ph9YM5309PteMHtCfL5qK6uO3Wse+NyVlP9h/fsWudsoyX4NgVB79QFJx/
6mIkNEZLgfYTGUJy/+uc7/1SjinQ7A4pUPGFLC1bI42deWgfzb8ksC54uHkOgzqY
iULdsCAxn+uz1b/+4ZzWN9LnhqntUg==
=Dlzf
-----END PGP SIGNATURE-----

--REuwJpb1mdEiOTmDG3KYuVAgBVEEhYo2F--
