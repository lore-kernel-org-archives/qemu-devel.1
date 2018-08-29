Received: from eggs.gnu.org ([2001:4830:134:3::10]:55214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuxwX-0001pb-B7
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuxwV-0000ce-CX
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:43:21 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<054195c8f83f524ee1f4d117407ac507dd18b0d8.1535291602.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <af713c19-bc70-c581-aa9c-58aa08ab5e55@redhat.com>
Date: Wed, 29 Aug 2018 12:43:06 +0200
MIME-Version: 1.0
In-Reply-To: <054195c8f83f524ee1f4d117407ac507dd18b0d8.1535291602.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DyEo4rOO2MVH1jXtw0vZoZflhnFBfcKBN"
Subject: Re: [Qemu-devel] [PATCH 3/9] block: Remove child references from
 bs->{options, explicit_options}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DyEo4rOO2MVH1jXtw0vZoZflhnFBfcKBN
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <af713c19-bc70-c581-aa9c-58aa08ab5e55@redhat.com>
Subject: Re: [PATCH 3/9] block: Remove child references from
 bs->{options,explicit_options}
References: <cover.1535291602.git.berto@igalia.com>
 <054195c8f83f524ee1f4d117407ac507dd18b0d8.1535291602.git.berto@igalia.com>
In-Reply-To: <054195c8f83f524ee1f4d117407ac507dd18b0d8.1535291602.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-26 16:09, Alberto Garcia wrote:
> Block drivers allow opening their children using a reference to an
> existing BlockDriverState. These references remain stored in the
> 'options' and 'explicit_options' QDicts, but we don't need to keep
> them once everything is open.
>=20
> What is more important, these values can become wrong if the children
> change:
>=20
>     $ qemu-img create -f qcow2 hd0.qcow2 10M
>     $ qemu-img create -f qcow2 hd1.qcow2 10M
>     $ qemu-img create -f qcow2 hd2.qcow2 10M
>     $ $QEMU -drive if=3Dnone,file=3Dhd0.qcow2,node-name=3Dhd0 \
>             -drive if=3Dnone,file=3Dhd1.qcow2,node-name=3Dhd1,backing=3D=
hd0 \
>             -drive file=3Dhd2.qcow2,node-name=3Dhd2,backing=3Dhd1
>=20
> After this hd2 has hd1 as its backing file. Now let's remove it using
> block_stream:
>=20
>     (qemu) block_stream hd2 0 hd0.qcow2
>=20
> Now hd0 is the backing file of hd2, but hd2's options QDicts still
> contain backing=3Dhd1.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Also, the question is, why would we discard the child options, but keep
the references (which we do not add, so we only have the ones specified
by the user).

> diff --git a/block.c b/block.c
> index 0dbb1fcc7b..2f2484965d 100644
> --- a/block.c
> +++ b/block.c
> @@ -2763,12 +2763,15 @@ static BlockDriverState *bdrv_open_inherit(cons=
t char *filename,
>          }
>      }
> =20
> -    /* Remove all children options from bs->options and bs->explicit_o=
ptions */
> +    /* Remove all children options and references
> +     * from bs->options and bs->explicit_options */
>      QLIST_FOREACH(child, &bs->children, next) {
>          char *child_key_dot;
>          child_key_dot =3D g_strdup_printf("%s.", child->name);
>          qdict_extract_subqdict(bs->explicit_options, NULL, child_key_d=
ot);
>          qdict_extract_subqdict(bs->options, NULL, child_key_dot);
> +        qdict_del(bs->explicit_options, child->name);
> +        qdict_del(bs->options, child->name);
>          g_free(child_key_dot);
>      }
> =20
> @@ -3289,6 +3292,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_s=
tate)
>  {
>      BlockDriver *drv;
>      BlockDriverState *bs;
> +    BdrvChild *child;
>      bool old_can_write, new_can_write;
> =20
>      assert(reopen_state !=3D NULL);
> @@ -3313,6 +3317,12 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_=
state)
>      bs->open_flags         =3D reopen_state->flags;
>      bs->read_only =3D !(reopen_state->flags & BDRV_O_RDWR);
> =20
> +    /* Remove child references from bs->options and bs->explicit_optio=
ns */
> +    QLIST_FOREACH(child, &bs->children, next) {
> +        qdict_del(bs->explicit_options, child->name);
> +        qdict_del(bs->options, child->name);
> +    }
> +

Why don't you remove the child options as well?

Max

>      bdrv_refresh_limits(bs, NULL);
> =20
>      bdrv_set_perm(reopen_state->bs, reopen_state->perm,
>=20



--DyEo4rOO2MVH1jXtw0vZoZflhnFBfcKBN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGeLoACgkQ9AfbAGHV
z0ABOwgAvFnhaNsp5HqDtBsq6zBuFYOB/xoSzlgaC3flA1+/822YnOh2AoqbM3D2
kgLdO6m4G9L59FTVer7w3TVsxULTGClIdRpIi7vfgmgPX1gC0xSD0AWrh7T/5L67
a/6QknE9nsKPo/vAzWSwKmoO8FxKGuZa8Cj5aZ0sKQkBnEEJKbdH16XiVTo+Xb0O
+zVub0Ovwxd8qKzoQbIT3jdOZRu7JSMAZIYfgVE3QItcgoZULubiM9znJpbsXgig
uUuzbYr/BT9EFvzBGqrfVhSGrfrqxhXA1tnaxFUhncinsYI3rkMTk6Rz6q7R+RIe
oofrLHyu9gpnTnysnYWWKGeMdVuByw==
=Ku3Z
-----END PGP SIGNATURE-----

--DyEo4rOO2MVH1jXtw0vZoZflhnFBfcKBN--
