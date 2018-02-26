Received: from eggs.gnu.org ([2001:4830:134:3::10]:45932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHp3-0004fe-Kp
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqHp2-0005DH-N8
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 07:24:01 -0500
References: <20180223192549.26666-1-kwolf@redhat.com>
	<20180223192549.26666-22-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7fe0a141-3a60-0c24-9f9a-4287870aa054@redhat.com>
Date: Mon, 26 Feb 2018 13:23:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180223192549.26666-22-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tcmmpbQuBIMGeT1ZEnJmB38mOHrnHYb3U"
Subject: Re: [Qemu-devel] [PATCH v3 21/36] rbd: Pass BlockdevOptionsRbd to
 qemu_rbd_connect()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tcmmpbQuBIMGeT1ZEnJmB38mOHrnHYb3U
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <7fe0a141-3a60-0c24-9f9a-4287870aa054@redhat.com>
Subject: Re: [PATCH v3 21/36] rbd: Pass BlockdevOptionsRbd to
 qemu_rbd_connect()
References: <20180223192549.26666-1-kwolf@redhat.com>
 <20180223192549.26666-22-kwolf@redhat.com>
In-Reply-To: <20180223192549.26666-22-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-23 20:25, Kevin Wolf wrote:
> With the conversion to a QAPI options object, the function is now
> prepared to be used in a .bdrv_co_create implementation.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/rbd.c | 109 +++++++++++++++++++++++++++++-----------------------=
--------
>  1 file changed, 53 insertions(+), 56 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index 2e79c2d1fd..9b247f020d 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c

[...]

> @@ -482,29 +484,27 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>      qemu_aio_unref(acb);
>  }
> =20
> -static char *qemu_rbd_mon_host(QDict *options, Error **errp)
> +static char *qemu_rbd_mon_host(BlockdevOptionsRbd *opts, Error **errp)=

>  {
> -    const char **vals =3D g_new(const char *, qdict_size(options) + 1)=
;
> -    char keybuf[32];
> +    const char **vals;
>      const char *host, *port;
>      char *rados_str;
> -    int i;
> -
> -    for (i =3D 0;; i++) {
> -        sprintf(keybuf, "server.%d.host", i);
> -        host =3D qdict_get_try_str(options, keybuf);
> -        qdict_del(options, keybuf);
> -        sprintf(keybuf, "server.%d.port", i);
> -        port =3D qdict_get_try_str(options, keybuf);
> -        qdict_del(options, keybuf);
> -        if (!host && !port) {
> -            break;
> -        }
> -        if (!host) {
> -            error_setg(errp, "Parameter server.%d.host is missing", i)=
;
> -            rados_str =3D NULL;
> -            goto out;
> -        }
> +    InetSocketAddressBaseList *p;
> +    int i, cnt;
> +
> +    if (!opts->has_server) {
> +        return NULL;
> +    }
> +
> +    for (cnt =3D 0, p =3D opts->server; p; p =3D p->next) {
> +        cnt++;
> +    }
> +
> +    vals =3D g_new(const char *, cnt + 1);
> +
> +    for (i =3D 0, p =3D opts->server; p; p =3D p->next, i++) {
> +        host =3D p->value->host;
> +        port =3D p->value->port;
> =20
>          if (strchr(host, ':')) {
>              vals[i] =3D port ? g_strdup_printf("[%s]:%s", host, port)

host *and* port are mandatory, so this and the next ternary can be
simplified, too. ;-)

But not necessary, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--tcmmpbQuBIMGeT1ZEnJmB38mOHrnHYb3U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqT/EwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AvGoH90Lb1o9N86q7og8xdj7K/W2ItPogKVRi
j6sTFpjheAbekSRJHkz0QQ6OrszDXy3OTAlMawF20eSvXS1a6Fwgcte+hnyJJg3D
gmm9Prud39qeG28MqAZ5/0shTP/FcsvIvG8B+i8F1P5X18p8qJc3gOP9b45VfsbQ
zbLCIaFVzcdR3iNDVnx7T6L9mSyK9xzV8IFwi/H+FRsO2+eZ2Oh/fZxkj/t+nkn7
3K3k+NgIRmjvkpGnLdGQ/JwwUBTQq2ehHV9OyN94EnjZmdeZ88xZWpkk5U9zGaJ8
1xuA3LuUXGmaIuu8nuP8N5hj8sM/ogN72UvER6/qVGcy+htyTJxl1A==
=nbdG
-----END PGP SIGNATURE-----

--tcmmpbQuBIMGeT1ZEnJmB38mOHrnHYb3U--
