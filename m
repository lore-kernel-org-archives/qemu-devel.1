Received: from eggs.gnu.org ([2001:4830:134:3::10]:59391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbr8t-0008Uh-AD
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:00:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbr8r-0004nU-Uy
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:00:19 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-19-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01d5a5fd-3ac8-0122-a07a-859bef4f3deb@redhat.com>
Date: Thu, 9 Feb 2017 10:00:07 -0600
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-19-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IgplMgtOM0RF1i2sOhSuuadS5g8sAFSOU"
Subject: Re: [Qemu-devel] [PATCH 18/18] nbd: BLOCK_STATUS for standard
 get_block_status function: client part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IgplMgtOM0RF1i2sOhSuuadS5g8sAFSOU
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <01d5a5fd-3ac8-0122-a07a-859bef4f3deb@redhat.com>
Subject: Re: [PATCH 18/18] nbd: BLOCK_STATUS for standard get_block_status
 function: client part
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-19-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-19-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Minimal realization: only first extent from the answer is used.

If you're only going to use one extent, should you implement
NBD_CMD_FLAG_REQ_ONE support to save the server some effort?

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
>  block/nbd-client.h  |  5 +++++
>  block/nbd.c         |  3 +++
>  include/block/nbd.h |  2 +-
>  nbd/client.c        | 23 ++++++++++++++++-------
>  qemu-nbd.c          |  2 +-
>  6 files changed, 66 insertions(+), 10 deletions(-)

> +int64_t coroutine_fn nbd_client_co_get_block_status(BlockDriverState *=
bs,
> +                                                    int64_t sector_num=
,
> +                                                    int nb_sectors, in=
t *pnum,
> +                                                    BlockDriverState *=
*file)
> +{
> +    int64_t ret;
> +    uint32_t nb_extents;
> +    NBDExtent *extents;
> +    NBDClientSession *client =3D nbd_get_client_session(bs);
> +
> +    if (!client->block_status_ok) {
> +        *pnum =3D nb_sectors;
> +        ret =3D BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
> +        if (bs->drv->protocol_name) {
> +            ret |=3D BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SECT=
OR_SIZE);
> +        }
> +        return ret;
> +    }

Looks like a sane fallback when we don't have anything more accurate.

> +
> +    ret =3D nbd_client_co_cmd_block_status(bs, sector_num << BDRV_SECT=
OR_BITS,
> +                                         nb_sectors << BDRV_SECTOR_BIT=
S,
> +                                         &extents, &nb_extents);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    *pnum =3D extents[0].length >> BDRV_SECTOR_BITS;
> +    ret =3D (extents[0].flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_ALLOCA=
TED) |
> +          (extents[0].flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0);
> +
> +    if ((ret & BDRV_BLOCK_ALLOCATED) && !(ret & BDRV_BLOCK_ZERO)) {
> +        ret |=3D BDRV_BLOCK_DATA;
> +    }

And this conversion looks correct.

> @@ -579,7 +617,8 @@ int nbd_client_init(BlockDriverState *bs,
>                                  &client->size,
>                                  &client->structured_reply,
>                                  bitmap_name,
> -                                &client->bitmap_ok, errp);
> +                                &client->bitmap_ok,
> +                                &client->block_status_ok, errp);

That's a lot of parameters we're adding; I'm wondering if its smarter to
start passing things through via a struct.  In fact, I have posted
patches previously (and need to rebase and repost them) that introduce
such a struct, in order to make the INFO extension viable.

> @@ -681,11 +681,19 @@ int nbd_receive_negotiate(QIOChannel *ioc, const =
char *name, uint16_t *flags,
>                                                false, NULL) =3D=3D 0;
>              }
> =20
> -            if (!!structured_reply && *structured_reply && !!bitmap_na=
me) {
> +            if (!!structured_reply && *structured_reply) {
>                  int ret;
> -                assert(!!bitmap_ok);
> -                ret =3D nbd_receive_query_bitmap(ioc, name, bitmap_nam=
e,
> -                                               bitmap_ok, errp) =3D=3D=
 0;
> +
> +                if (!!bitmap_name) {
> +                    assert(!!bitmap_ok);
> +                    ret =3D nbd_receive_query_bitmap(ioc, name, bitmap=
_name,
> +                                                   bitmap_ok, errp) =3D=
=3D 0;
> +                } else {
> +                    ret =3D nbd_receive_query_meta_context(ioc, name,
> +                                                         "base:allocat=
ion",
> +                                                         block_status_=
ok,
> +                                                         errp);
> +                }

This looks weird trying to grab 'base:allocation' only if bitmap_name is
not provided.  The logic will probably have to be different if we want
to allow a client to track both pieces of information at once.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IgplMgtOM0RF1i2sOhSuuadS5g8sAFSOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYnJIHAAoJEKeha0olJ0NqWzsH/0YnnkmcMjcRbFwtdPVe5WBg
jS2fYXG0X0SpOj+V24bJ+jM+Cm7yhwwo2cWn/W1qXZZ5wSJ4cS5qWmPUPUAyCcpk
WYZjiDj5yVrMfjTBAEjV63aLAR6uObiCQCYhWdKEmkJzh/2wIzHQNRVgzqNGSitM
RAadyOR46UvxIicQcgJ0P9j6RgaiZMQSyj1tO0T35BRHCON7qOpGsw7rMT9WnyZh
utwp1oyJiNRTBgENaOu29EbKHnm5AhjR4AOit/DL1c+Qr7k/yxU5Dn/b0/Gr+ulb
zEuWOpmPOPFdp7DoBr68+pgy9iBXm+2VxBmjycfr8Nx1WNWaCOB+x/8Xv6dNIS0=
=Z/sS
-----END PGP SIGNATURE-----

--IgplMgtOM0RF1i2sOhSuuadS5g8sAFSOU--
