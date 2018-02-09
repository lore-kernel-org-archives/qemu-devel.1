Received: from eggs.gnu.org ([2001:4830:134:3::10]:36430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ekDG4-0002js-Qh
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ekDG3-0000ZN-Pk
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:18:48 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-10-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1386f182-a2c9-1c86-cb0e-ac01c50cde4e@redhat.com>
Date: Fri, 9 Feb 2018 19:18:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-10-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b02b7y9UiWrISu4Gnept1DThQBae2FizK"
Subject: Re: [Qemu-devel] [PATCH 09/27] qdict: Introduce qdict_rename_keys()
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
--b02b7y9UiWrISu4Gnept1DThQBae2FizK
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <1386f182-a2c9-1c86-cb0e-ac01c50cde4e@redhat.com>
Subject: Re: [PATCH 09/27] qdict: Introduce qdict_rename_keys()
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-10-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> A few block drivers will need to rename .bdrv_create options for their
> QAPIfication, so let's have a helper function for that.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qapi/qmp/qdict.h |  6 ++++++
>  qobject/qdict.c          | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)

Hmmm, looks OK, but I wonder whether this is going to be any more
efficient than if we simply had a qdict_rename_key() function that you
call multiple times.

("efficient" both in terms of code readability and runtime efficiency)

So, I'll give you a

Reviewed-by: Max Reitz <mreitz@redhat.com>

and let you decide.

>=20
> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
> index fc218e7be6..862441b9d3 100644
> --- a/include/qapi/qmp/qdict.h
> +++ b/include/qapi/qmp/qdict.h
> @@ -90,4 +90,10 @@ QObject *qdict_crumple(const QDict *src, Error **err=
p);
> =20
>  void qdict_join(QDict *dest, QDict *src, bool overwrite);
> =20
> +typedef struct QDictRenames {
> +    const char *from;
> +    const char *to;
> +} QDictRenames;
> +bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Erro=
r **errp);
> +
>  #endif /* QDICT_H */
> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index e8f15f1132..07ae9489a7 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -1051,3 +1051,33 @@ void qdict_join(QDict *dest, QDict *src, bool ov=
erwrite)
>          entry =3D next;
>      }
>  }
> +
> +/**
> + * qdict_rename_keys(): Rename keys in qdict according to the replacem=
ents
> + * specified in the array renames. The array must be terminated by an =
entry
> + * with from =3D NULL.
> + *
> + * Returns true for success, false in error cases.
> + */
> +bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Erro=
r **errp)
> +{
> +    QObject *qobj;
> +
> +    while (renames->from) {
> +        if (qdict_haskey(qdict, renames->from)) {
> +            if (qdict_haskey(qdict, renames->to)) {
> +                error_setg(errp, "'%s' and its alias '%s' can't be use=
d at the "
> +                           "same time", renames->to, renames->from);
> +                return false;
> +            }
> +
> +            qobj =3D qdict_get(qdict, renames->from);
> +            qobject_incref(qobj);
> +            qdict_put_obj(qdict, renames->to, qobj);
> +            qdict_del(qdict, renames->from);
> +        }
> +
> +        renames++;
> +    }
> +    return true;
> +}
>=20



--b02b7y9UiWrISu4Gnept1DThQBae2FizK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp95fUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9As6UIAK5tQlBcWG7kxD5lllUD0T6E0bLfMJvY
Az3pIbJ5/0YZWe9Fe3j1KMFw/+6H3a0mQX7kq8fR5N/K9IvyTiy0YaixPhOKJD1v
7kC5zuKC5oyZd82I32Xi6mI97MSNbx/rH6mbCoGktmwhBmWtFbt2ooWin9/GyAJa
ed5XEL6KWEOR79WaOOLCTNoG/QcJp85RZZWvCOfXOCNKxUYnMNkKI5IXLnhBjPT5
U9PJIJfljGdhF/VCU3VFPyoNkznva1Asbxe3gu3AGPncnCmroEKaeK07ZSm/xbLS
mnkLFnuwlFsQs460q5Fo1iimunTPzqKnE9zNKzPdBcuok+FrUVy9MFk=
=oQ2S
-----END PGP SIGNATURE-----

--b02b7y9UiWrISu4Gnept1DThQBae2FizK--
