Received: from eggs.gnu.org ([2001:4830:134:3::10]:60283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfnpk-00018B-DV
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfnpj-0005K5-8e
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:16:52 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-24-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ccdcbaa6-16c4-dc1c-9055-dfe57130aa3e@redhat.com>
Date: Mon, 20 Feb 2017 14:16:40 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-24-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BteRNBUh97tWbmopGgpO7rUMdEnPw19Os"
Subject: Re: [Qemu-devel] [RFC PATCH 23/41] block: Include details on
 permission errors in message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BteRNBUh97tWbmopGgpO7rUMdEnPw19Os
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <ccdcbaa6-16c4-dc1c-9055-dfe57130aa3e@redhat.com>
Subject: Re: [RFC PATCH 23/41] block: Include details on permission errors in
 message
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-24-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-24-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> Instead of just telling that there was some conflict, we can be specifi=
c
> and tell which permissions were in conflict and which way the conflict
> is.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---=
--------
>  1 file changed, 55 insertions(+), 11 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 2116542..d743f50 100644
> --- a/block.c
> +++ b/block.c
> @@ -1381,6 +1381,43 @@ static void bdrv_update_perm(BlockDriverState *b=
s)
>      bdrv_set_perm(bs, cumulative_perms, cumulative_shared_perms);
>  }
> =20
> +static char *bdrv_child_link_name(BdrvChild *c)
> +{
> +    if (c->role->get_link_name) {
> +        return c->role->get_link_name(c);
> +    }
> +
> +    return g_strdup("another user");

=2E..now I'm a bit disappointed, not least because "another user" is not =
a
link name.

But I don't think we want a link name anyway. I'd write it differently
altogether. Looking at the code below, this will be used as "Conflicts
with ${link_name}".

Now, "Conflicts with backing file link from foo" reads weird. In fact,
anything that actually reports a "link" is weird. I'd propose the followi=
ng:

"Conflicts with [use by] ${user} (used as ${c->name})"

user is c->role->get_name() if that exists, or "another user" if it does
not. If you implemented get_name() instead of get_link_name() for the
backing file role, there wouldn't be any need for get_link_name() at
all, IMO.

Also, you can implement c->role->get_name() not only for child_backing,
but also for child_file and child_format.

Max

> +}
> +
> +static char *bdrv_perm_names(uint64_t perm)
> +{
> +    struct perm_name {
> +        uint64_t perm;
> +        const char *name;
> +    } permissions[] =3D {
> +        { BLK_PERM_CONSISTENT_READ, "consistent read" },
> +        { BLK_PERM_WRITE,           "write" },
> +        { BLK_PERM_WRITE_UNCHANGED, "write unchanged" },
> +        { BLK_PERM_RESIZE,          "resize" },
> +        { BLK_PERM_GRAPH_MOD,       "change children" },
> +        { 0, NULL }
> +    };
> +
> +    char *result =3D g_strdup("");
> +    struct perm_name *p;
> +
> +    for (p =3D permissions; p->name; p++) {
> +        if (perm & p->perm) {
> +            char *old =3D result;
> +            result =3D g_strdup_printf("%s%s%s", old, *old ? ", " : ""=
, p->name);
> +            g_free(old);
> +        }
> +    }
> +
> +    return result;
> +}
> +
>  static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_u=
sed_perm,
>                                    uint64_t new_shared_perm,
>                                    BdrvChild *ignore_child, Error **err=
p)
> @@ -1397,17 +1434,24 @@ static int bdrv_check_update_perm(BlockDriverSt=
ate *bs, uint64_t new_used_perm,
>              continue;
>          }
> =20
> -        if ((new_used_perm & c->shared_perm) !=3D new_used_perm ||
> -            (c->perm & new_shared_perm) !=3D c->perm)
> -        {
> -            const char *user =3D NULL;
> -            if (c->role->get_name) {
> -                user =3D c->role->get_name(c);
> -                if (user && !*user) {
> -                    user =3D NULL;
> -                }
> -            }
> -            error_setg(errp, "Conflicts with %s", user ?: "another ope=
ration");
> +        if ((new_used_perm & c->shared_perm) !=3D new_used_perm) {
> +            char *link =3D bdrv_child_link_name(c);
> +            char *perm_names =3D bdrv_perm_names(new_used_perm & ~c->s=
hared_perm);
> +            error_setg(errp, "Conflicts with %s, which does not allow =
'%s' "
> +                             "on %s",
> +                       link, perm_names, bdrv_get_node_name(c->bs));
> +            g_free(link);
> +            g_free(perm_names);
> +            return -EPERM;
> +        }
> +
> +        if ((c->perm & new_shared_perm) !=3D c->perm) {
> +            char *link =3D bdrv_child_link_name(c);
> +            char *perm_names =3D bdrv_perm_names(c->perm & ~new_shared=
_perm);
> +            error_setg(errp, "Conflicts with %s, which uses '%s' on %s=
",
> +                       link, perm_names, bdrv_get_node_name(c->bs));
> +            g_free(link);
> +            g_free(perm_names);
>              return -EPERM;
>          }
> =20
>=20



--BteRNBUh97tWbmopGgpO7rUMdEnPw19Os
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliq7DgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AtbgH/REvjgJgTA6VctNSi5vvcKJR/RMbnWFi
WbB3vfxGtv5aGHbOfbJ77FOd9Uyoqguiw6zymEmlaZRz12bv/jmnuRg6kV28oKRk
5K0R080icRodVVfMUtWZN2mntnNjLyhwncofX9gMNWlKbeM1zrKDN2n/aBpQmtNY
dxvijBMc82rluT9qBUwktW+hb/+ENv0teDcXMe4fwOp5reN784UCkmyEtDD1/vb5
cJ1xkU1JSdvRSBLXXR1K9C13py9XLNlLPL/oywMUhUflQVP/f1BVcSwDGHgvXk1D
ujTzp/jxI3OHGtRETKt1iNPmf8tS59jmOYMcdmNhg3GxwcIXiAX0Uqw=
=I42a
-----END PGP SIGNATURE-----

--BteRNBUh97tWbmopGgpO7rUMdEnPw19Os--
