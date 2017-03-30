Received: from eggs.gnu.org ([2001:4830:134:3::10]:43647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctdA2-0006c1-Vg
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctdA1-0004fC-S4
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:42:59 -0400
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-11-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b65b4a5a-bb31-8b15-f35f-b55ffd10b4c3@redhat.com>
Date: Thu, 30 Mar 2017 18:42:47 +0200
MIME-Version: 1.0
In-Reply-To: <1490879707-6060-11-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pjVNgIxPrrOW8pruqQWM61Vh7l1JIvahm"
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 10/10] sheepdog: Fix blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pjVNgIxPrrOW8pruqQWM61Vh7l1JIvahm
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com
Message-ID: <b65b4a5a-bb31-8b15-f35f-b55ffd10b4c3@redhat.com>
Subject: Re: [RFC v2 for-2.9 10/10] sheepdog: Fix blockdev-add
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
 <1490879707-6060-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1490879707-6060-11-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 30.03.2017 15:15, Markus Armbruster wrote:
> Commit 831acdc "sheepdog: Implement bdrv_parse_filename()" and commit
> d282f34 "sheepdog: Support blockdev-add" have different ideas on how
> the QemuOpts parameters for the server address are named.  Fix that.
> While there, rename BlockdevOptionsSheepdog member addr to server, for
> consistency with BlockdevOptionsSsh, BlockdevOptionsGluster,
> BlockdevOptionsNbd.
>=20
> Commit 831acdc's example becomes
>=20
>     --drive driver=3Dsheepdog,server.type=3Dinet,server.host=3Dfido,ser=
ver.port=3D7000,vdi=3Ddolly
>=20
> instead of
>=20
>     --drive driver=3Dsheepdog,host=3Dfido,vdi=3Ddolly
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/sheepdog.c     | 84 ++++++++++++++++++++++++++++++++++----------=
--------
>  qapi/block-core.json |  4 +--
>  2 files changed, 58 insertions(+), 30 deletions(-)

There's trailing whitespace somewhere in this patch (git-am complained).

> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 89e98ed..c81013d 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -13,9 +13,11 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qapi-visit.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qint.h"
> +#include "qapi/qobject-input-visitor.h"
>  #include "qemu/uri.h"
>  #include "qemu/error-report.h"
>  #include "qemu/sockets.h"
> @@ -547,6 +549,47 @@ static SocketAddress *sd_socket_address(const char=
 *path,
>      return addr;
>  }
> =20
> +static SocketAddress *sd_server_config(QDict *options, Error **errp)
> +{
> +    QDict *server =3D NULL;
> +    QObject *crumpled_server =3D NULL;
> +    Visitor *iv =3D NULL;
> +    SocketAddressFlat *saddr_flat =3D NULL;
> +    SocketAddress *saddr =3D NULL;
> +    Error *local_err =3D NULL;
> +
> +    qdict_extract_subqdict(options, &server, "server.");

server may be empty:

$ ./qemu-img info sheepdog:vdi
qemu-img: Could not open 'sheepdog:vdi': Parameter 'type' is missing

I'd propose creating an 'inet' SocketAddress object then for
SD_DEFAULT_ADDR and SD_DEFAULT_PORT so that existing behavior won't chang=
e.

> +
> +    crumpled_server =3D qdict_crumple(server, errp);
> +    if (!crumpled_server) {
> +        goto done;
> +    }
> +
> +    /*
> +     * FIXME .numeric, .to, .ipv4 or .ipv6 don't work with -drive
> +     * server.type=3Dinet.  .to doesn't matter, it's ignored anyway.
> +     * That's because when @options come from -blockdev or
> +     * blockdev_add, members are typed according to the QAPI schema,
> +     * but when they come from -drive, they're all QString.  The
> +     * visitor expects the former.
> +     */
> +    iv =3D qobject_input_visitor_new(crumpled_server);
> +    visit_type_SocketAddressFlat(iv, NULL, &saddr_flat, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto done;
> +    }
> +
> +    saddr =3D socket_address_crumple(saddr_flat);
> +
> +done:
> +    qapi_free_SocketAddressFlat(saddr_flat);
> +    visit_free(iv);
> +    qobject_decref(crumpled_server);
> +    QDECREF(server);
> +    return saddr;
> +}
> +
>  /* Return -EIO in case of error, file descriptor on success */
>  static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
>  {
> @@ -1175,15 +1218,17 @@ static void sd_parse_filename(const char *filen=
ame, QDict *options,
>      }
> =20
>      if (cfg.host) {
> -        qdict_set_default_str(options, "host", cfg.host);
> +        qdict_set_default_str(options, "server.host", cfg.host);
> +        qdict_set_default_str(options, "server.type", "inet");
>      }
>      if (cfg.port) {
>          snprintf(buf, sizeof(buf), "%d", cfg.port);
> -        qdict_set_default_str(options, "port", buf);
> +        qdict_set_default_str(options, "server.port", buf);

=2Eport is mandatory, so doing this optionally results in:

$ ./qemu-img info sheepdog://localhost/foo
qemu-img: Could not open 'sheepdog://localhost/foo': Parameter 'port' is
missing

>      }
>      if (cfg.path) {
> -        qdict_set_default_str(options, "path", cfg.path);
> -    }
> +        qdict_set_default_str(options, "server.path", cfg.path);=20
> +        qdict_set_default_str(options, "server.type", "unix");
> +   }

Indentation is off.

Max

>      qdict_set_default_str(options, "vdi", cfg.vdi);
>      qdict_set_default_str(options, "tag", cfg.tag);
>      if (cfg.snap_id) {
> @@ -1510,18 +1555,6 @@ static QemuOptsList runtime_opts =3D {
>      .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>      .desc =3D {
>          {
> -            .name =3D "host",
> -            .type =3D QEMU_OPT_STRING,
> -        },
> -        {
> -            .name =3D "port",
> -            .type =3D QEMU_OPT_STRING,
> -        },
> -        {
> -            .name =3D "path",
> -            .type =3D QEMU_OPT_STRING,
> -        },
> -        {
>              .name =3D "vdi",
>              .type =3D QEMU_OPT_STRING,
>          },
> @@ -1543,7 +1576,7 @@ static int sd_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
>      int ret, fd;
>      uint32_t vid =3D 0;
>      BDRVSheepdogState *s =3D bs->opaque;
> -    const char *host, *port, *path, *vdi, *snap_id_str, *tag;
> +    const char *vdi, *snap_id_str, *tag;
>      uint64_t snap_id;
>      char *buf =3D NULL;
>      QemuOpts *opts;
> @@ -1560,20 +1593,17 @@ static int sd_open(BlockDriverState *bs, QDict =
*options, int flags,
>          goto err_no_fd;
>      }
> =20
> -    host =3D qemu_opt_get(opts, "host");
> -    port =3D qemu_opt_get(opts, "port");
> -    path =3D qemu_opt_get(opts, "path");
> +    s->addr =3D sd_server_config(options, errp);
> +    if (!s->addr) {
> +        ret =3D -EINVAL;
> +        goto err_no_fd;
> +    }
> +    =20
>      vdi =3D qemu_opt_get(opts, "vdi");
>      snap_id_str =3D qemu_opt_get(opts, "snap-id");
>      snap_id =3D qemu_opt_get_number(opts, "snap-id", CURRENT_VDI_ID);
>      tag =3D qemu_opt_get(opts, "tag");
> =20
> -    if ((host || port) && path) {
> -        error_setg(errp, "can't use 'path' together with 'host' or 'po=
rt'");
> -        ret =3D -EINVAL;
> -        goto err_no_fd;
> -    }
> -
>      if (!vdi) {
>          error_setg(errp, "parameter 'vdi' is missing");
>          ret =3D -EINVAL;
> @@ -1604,8 +1634,6 @@ static int sd_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
>          goto err_no_fd;
>      }
> =20
> -    s->addr =3D sd_socket_address(path, host, port);
> -
>      QLIST_INIT(&s->inflight_aio_head);
>      QLIST_INIT(&s->failed_aio_head);
>      QLIST_INIT(&s->inflight_aiocb_head);
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 8d87962..b5f0e99 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2623,7 +2623,7 @@
>  # Driver specific block device options for sheepdog
>  #
>  # @vdi:         Virtual disk image name
> -# @addr:        The Sheepdog server to connect to
> +# @server:      The Sheepdog server to connect to
>  # @snap-id:     Snapshot ID
>  # @tag:         Snapshot tag name
>  #
> @@ -2632,7 +2632,7 @@
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsSheepdog',
> -  'data': { 'addr': 'SocketAddressFlat',
> +  'data': { 'server': 'SocketAddressFlat',
>              'vdi': 'str',
>              '*snap-id': 'uint32',
>              '*tag': 'str' } }
>=20



--pjVNgIxPrrOW8pruqQWM61Vh7l1JIvahm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljdNYcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AlpwIAILNbfVmeBdR/02O6htaBzBkSw6OmOTY
Vdy1lfp3SboIIR03eq2GgX/PtWyfiV9M3TKkfQaKzYWRSOaHzxBoJS9KU+9WRkKn
LuRT5Lqh/+XsfL3mYHM9CqRdPH3jkJIwGcUtd51gt77CyivAmrci5Iutem2HoTSb
03ykrvmG39q+MK3+r+dgp7jBiN6Fpr6+/Sj1mD64juDI6IAdL1JVcretCuuzLl7H
D/HXJKUlomKuBUg+SEzTYuoxnwGoJF4vdemA6YPSXQuMiCnJo71zeurm9tXLAVp7
ZdmR8MT2BX4LkHbX4I+hQO+d0KU4Ri4wFqQVUbSKhY6SjD4s6HSooLU=
=AfBd
-----END PGP SIGNATURE-----

--pjVNgIxPrrOW8pruqQWM61Vh7l1JIvahm--
