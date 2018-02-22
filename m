Received: from eggs.gnu.org ([2001:4830:134:3::10]:39577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep0GQ-0002oQ-CC
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ep0G1-00006e-K7
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:26:58 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-22-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3482089d-ae14-ff82-6792-498de033c600@redhat.com>
Date: Fri, 23 Feb 2018 00:25:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-22-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KhUKg3ypqAprTyaCzWU986x1QH0yOpwoo"
Subject: Re: [Qemu-devel] [PATCH v2 21/36] rbd: Pass BlockdevOptionsRbd to
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
--KhUKg3ypqAprTyaCzWU986x1QH0yOpwoo
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <3482089d-ae14-ff82-6792-498de033c600@redhat.com>
Subject: Re: [PATCH v2 21/36] rbd: Pass BlockdevOptionsRbd to
 qemu_rbd_connect()
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-22-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-22-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> With the conversion to a QAPI options object, the function is now
> prepared to be used in a .bdrv_co_create implementation.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/rbd.c | 102 +++++++++++++++++++++++++++++++---------------------=
--------
>  1 file changed, 52 insertions(+), 50 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index 2e79c2d1fd..26641e53e0 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c

[...]

> @@ -482,24 +484,27 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
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
>          if (!host) {
>              error_setg(errp, "Parameter server.%d.host is missing", i)=
;
>              rados_str =3D NULL;

host and port are mandatory in the schema, so we can omit this now.

> @@ -524,56 +529,34 @@ out:
> =20
>  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
>                              char **s_snap, char **s_image_name,
> -                            QDict *options, bool cache,
> +                            BlockdevOptionsRbd *opts, bool cache,
>                              const char *keypairs, const char *secretid=
,
>                              Error **errp)
>  {
> -    QemuOpts *opts;
>      char *mon_host =3D NULL;
> -    const char *pool, *snap, *conf, *user, *image_name;
>      Error *local_err =3D NULL;
>      int r;
> =20
> -    opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> -    qemu_opts_absorb_qdict(opts, options, &local_err);
> +    mon_host =3D qemu_rbd_mon_host(opts, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          r =3D -EINVAL;
>          goto failed_opts;
>      }
> =20
> -    mon_host =3D qemu_rbd_mon_host(options, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        r =3D -EINVAL;
> -        goto failed_opts;
> -    }
> -
> -    pool           =3D qemu_opt_get(opts, "pool");
> -    conf           =3D qemu_opt_get(opts, "conf");
> -    snap           =3D qemu_opt_get(opts, "snapshot");
> -    user           =3D qemu_opt_get(opts, "user");
> -    image_name     =3D qemu_opt_get(opts, "image");
> -
> -    if (!pool || !image_name) {
> -        error_setg(errp, "Parameters 'pool' and 'image' are required")=
;
> -        r =3D -EINVAL;
> -        goto failed_opts;
> -    }
> -
> -    r =3D rados_create(cluster, user);
> +    r =3D rados_create(cluster, opts->user);
>      if (r < 0) {
>          error_setg_errno(errp, -r, "error initializing");
>          goto failed_opts;
>      }
> =20
> -    *s_snap =3D g_strdup(snap);
> -    *s_image_name =3D g_strdup(image_name);
> +    *s_snap =3D g_strdup(opts->snapshot);
> +    *s_image_name =3D g_strdup(opts->image);
> =20
>      /* try default location when conf=3DNULL, but ignore failure */
> -    r =3D rados_conf_read_file(*cluster, conf);
> -    if (conf && r < 0) {
> -        error_setg_errno(errp, -r, "error reading conf file %s", conf)=
;
> +    r =3D rados_conf_read_file(*cluster, opts->conf);
> +    if (opts->has_conf && r < 0) {

Reading opts->conf without knowing whether opts->has_conf is true is a
bit weird.  Would you mind "s->has_conf ? opts->conf : NULL" for the
rados_conf_read() call?

On that thought, opts->snapshot and opts->user are optional, too.  Are
they guaranteed to be NULL if they haven't been specified?  Should we
guard those accesses with opts->has_* queries, too?

> +        error_setg_errno(errp, -r, "error reading conf file %s", opts-=
>conf);
>          goto failed_shutdown;
>      }
> =20

[..]

> @@ -666,8 +650,25 @@ static int qemu_rbd_open(BlockDriverState *bs, QDi=
ct *options, int flags,
>          qdict_del(options, "password-secret");
>      }
> =20
> +    /* Convert the remaining options into a QAPI object */
> +    crumpled =3D qdict_crumple(options, errp);
> +    if (crumpled =3D=3D NULL) {
> +        return -EINVAL;

"goto out", or this will leak @keypairs and @secretid.

Max

> +    }
> +
> +    v =3D qobject_input_visitor_new_keyval(crumpled);
> +    visit_type_BlockdevOptionsRbd(v, NULL, &opts, &local_err);
> +    visit_free(v);
> +    qobject_decref(crumpled);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        r =3D -EINVAL;
> +        goto out;
> +    }
> +
>      r =3D qemu_rbd_connect(&s->cluster, &s->io_ctx, &s->snap, &s->imag=
e_name,
> -                         options, !(flags & BDRV_O_NOCACHE), keypairs,=
 secretid,
> +                         opts, !(flags & BDRV_O_NOCACHE), keypairs, se=
cretid,
>                           errp);
>      if (r < 0) {
>          goto out;
> @@ -706,6 +707,7 @@ failed_open:
>      g_free(s->image_name);
>      rados_shutdown(s->cluster);
>  out:
> +    qapi_free_BlockdevOptionsRbd(opts);
>      g_free(keypairs);
>      g_free(secretid);
>      return r;
>=20



--KhUKg3ypqAprTyaCzWU986x1QH0yOpwoo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPUV4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AFFQH/jbAM+EJSsuFK0cxONostDhYcpOOA3lm
7o+C6dkv4cpOPZecbko4tpnKg4oEttQYuvvJNHsCaPzrPWsAQPG48mpEWop09Se/
T/Le9sP458ZVqaF0LrnAs5WvFOhNo9VfBCQKqoFLmTctE2a76l20IqsZHGqhhU1T
yjFT6Kiulu86E+9d6eArmY809dGboSJ7AhFrwcOm/O2+ZKHB4FERI7P/PKS77DRH
NLmFaPM/6PsLxHVFc/a0Q6VqPAyjxHZ8DbpY62P2Edb/3q1w7VPZGAgv+o1B1rmK
EnnrkoUweFzHn1Jr712KB8VJuxa93QbcZpu0Z3j87hK/sd3z6U+e8P0=
=utW/
-----END PGP SIGNATURE-----

--KhUKg3ypqAprTyaCzWU986x1QH0yOpwoo--
