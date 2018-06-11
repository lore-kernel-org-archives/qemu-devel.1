Received: from eggs.gnu.org ([2001:4830:134:3::10]:58015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSO3l-0002Vz-A5
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSO3j-0001Ih-KE
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:44:41 -0400
References: <20180607062559.16127-1-armbru@redhat.com>
	<20180607062559.16127-7-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <45abd156-104c-de20-25ef-01831faffb34@redhat.com>
Date: Mon, 11 Jun 2018 16:44:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180607062559.16127-7-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GGtjE8mrkMu8pjTlLWAqsdALEBHvZHfc1"
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 06/19] block: Fix
 -blockdev for certain non-string scalars
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GGtjE8mrkMu8pjTlLWAqsdALEBHvZHfc1
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <45abd156-104c-de20-25ef-01831faffb34@redhat.com>
Subject: Re: [Qemu-block] [RFC PATCH 06/19] block: Fix -blockdev for certain
 non-string scalars
References: <20180607062559.16127-1-armbru@redhat.com>
 <20180607062559.16127-7-armbru@redhat.com>
In-Reply-To: <20180607062559.16127-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-07 08:25, Markus Armbruster wrote:
> Configuration flows through the block subsystem in a rather peculiar
> way.  Configuration made with -drive enters it as QemuOpts.
> Configuration made with -blockdev / blockdev-add enters it as QAPI
> type BlockdevOptions.  The block subsystem uses QDict, QemuOpts and
> QAPI types internally.  The precise flow is next to impossible to
> explain (I tried for this commit message, but gave up after wasting
> several hours).  What I can explain is a flaw in the BlockDriver
> interface that leads to this bug:
>=20
>     $ qemu-system-x86 -blockdev node-name=3Dn1,driver=3Dnfs,server.type=
=3Dinet,server.host=3Dlocalhost,path=3D/foo/bar,user=3D1234: Internal err=
or: parameter user invalid
>     qemu-system-x86: -blockdev node-name=3Dn1,driver=3Dnfs,server.type=3D=
inet,server.host=3Dlocalhost,path=3D/foo/bar,user=3D1234: Internal error:=
 parameter user invalid
>=20
> QMP blockdev-add is broken the same way.
>=20
> Here's what happens.  The block layer passes configuration represented
> as flat QDict (with dotted keys) to BlockDriver methods
> .bdrv_file_open().  The QDict's members are typed according to the
> QAPI schema.
>=20
> nfs_file_open() converts it to QAPI type BlockdevOptionsNfs, with
> qdict_crumple() and a qobject input visitor.
>=20
> This visitor comes in two flavors.  The plain flavor requires scalars
> to be typed according to the QAPI schema.  That's the case here.  The
> keyval flavor requires string scalars.  That's not the case here.
> nfs_file_open() uses the latter, and promptly falls apart for members
> @user, @group, @tcp-syn-count, @readahead-size, @page-cache-size,
> @debug.
>=20
> Switching to the plain flavor would fix -blockdev, but break -drive,
> because there the scalars arrive in nfs_file_open() as strings.

(I'll just chime in because why not.)

> The proper fix would be to replace the QDict by QAPI type
> BlockdevOptions in the BlockDriver interface.  Sadly, that's beyond my
> reach right now.

Agreed.  The way there probably is to (as always) unify how the block
drivers convert their QDict to their own BlockdevOptions, and then pull
that out into block.c, but let's see how far off that still is.

> Next best would be to fix the block layer to always pass correctly
> typed QDicts to the BlockDriver methods.  Also beyond my reach.

I tried and failed.

(http://lists.nongnu.org/archive/html/qemu-block/2018-05/msg00061.html)

But that will probably be an intermediate step before we get to
BlockdevOptions.

> What I can do is throw another hack onto the pile: have
> nfs_file_open() convert all members to string, so use of the keyval
> flavor actually works, by replacing qdict_crumple() by new function
> qdict_crumple_for_keyval_qiv().

I'm calling qdict_stringify_for_keyval() only from a single function,
and it's immediately followed by a qdict_crumple(), so I suppose
replacing those invocations in my series would be trivial.

OTOH, just using qdict_stringify_for_keyval() in your
qdict_crumple_for_keyval_qiv() function would be trivial as well. :-)
But then again, it probably makes more sense to combine the two
functions because I too assumed the QDict to be flattened before the
function call for simplification.  This assumption makes more sense if
the function proceeds to call qdict_crumple().

> The pattern "pass result of qdict_crumple() to
> qobject_input_visitor_new_keyval()" occurs several times more:
>=20
> * qemu_rbd_open()
>=20
>   Same issue as nfs_file_open(), but since BlockdevOptionsRbd has only
>   string members, its only a latent bug.  Fix it anyway.
>=20
> * parallels_co_create_opts(), qcow_co_create_opts(),
>   qcow2_co_create_opts(), bdrv_qed_co_create_opts(),
>   sd_co_create_opts(), vhdx_co_create_opts(), vpc_co_create_opts()
>=20
>   These work, because they create the QDict with
>   qemu_opts_to_qdict_filtered(), which creates only string scalars.
>   The function sports a TODO comment asking for better typing; that's
>   going to be fun.  Use qdict_crumple_for_keyval_qiv() to be safe.

Sounds good!

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/nfs.c           |  2 +-
>  block/parallels.c     |  2 +-
>  block/qcow.c          |  2 +-
>  block/qcow2.c         |  2 +-
>  block/qed.c           |  2 +-
>  block/rbd.c           |  2 +-
>  block/sheepdog.c      |  2 +-
>  block/vhdx.c          |  2 +-
>  block/vpc.c           |  2 +-
>  include/block/qdict.h |  1 +
>  qobject/block-qdict.c | 57 +++++++++++++++++++++++++++++++++++++++++++=

>  11 files changed, 67 insertions(+), 9 deletions(-)

[...]

> @@ -513,6 +516,60 @@ QObject *qdict_crumple(const QDict *src, Error **e=
rrp)
>      return NULL;
>  }
> =20
> +/**
> + * qdict_crumple_for_keyval_qiv:
> + * @src: the flat dictionary (only scalar values) to crumple
> + * @errp: location to store error
> + *
> + * Like qdict_crumple(), but additionally transforms scalar values so
> + * the result can be passed to qobject_input_visitor_new_keyval().
> + *
> + * The block subsystem uses this function to prepare its flat QDict
> + * with possibly confused scalar types for a visit.  It should not be
> + * used for anything else, and it should go away once the block
> + * subsystem has been cleaned up.
> + */
> +QObject *qdict_crumple_for_keyval_qiv(QDict *src, Error **errp)
> +{
> +    QDict *tmp =3D NULL;
> +    char *buf;
> +    const char *s;
> +    const QDictEntry *ent;
> +    QObject *dst;
> +
> +    for (ent =3D qdict_first(src); ent; ent =3D qdict_next(src, ent)) =
{
> +        buf =3D NULL;
> +        switch (qobject_type(ent->value)) {
> +        case QTYPE_QNULL:
> +        case QTYPE_QSTRING:
> +            continue;
> +        case QTYPE_QNUM:
> +            s =3D buf =3D qnum_to_string(qobject_to(QNum, ent->value))=
;
> +            break;
> +        case QTYPE_QDICT:
> +        case QTYPE_QLIST:
> +            /* @src isn't flat; qdict_crumple() will fail */
> +            continue;
> +        case QTYPE_QBOOL:
> +            s =3D qbool_get_bool(qobject_to(QBool, ent->value))
> +                ? "on" : "off";
> +            break;
> +        default:
> +            abort();
> +        }
> +
> +        if (!tmp) {
> +            tmp =3D qdict_clone_shallow(src);
> +        }
> +        qdict_put(tmp, ent->key, qstring_from_str(s));
> +        g_free(buf);
> +    }
> +
> +    dst =3D qdict_crumple(tmp ?: src, errp);
> +    qobject_unref(tmp);
> +    return dst;
> +}
> +
>  /**
>   * qdict_array_entries(): Returns the number of direct array entries i=
f the
>   * sub-QDict of src specified by the prefix in subqdict (or src itself=
 for
>=20

Looks functionally very much equivalent to my version, so no complaints
from me.

Max


--GGtjE8mrkMu8pjTlLWAqsdALEBHvZHfc1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlseis4ACgkQ9AfbAGHV
z0D42wgAw89mmJjBkgv278ykLl2lb5j+XwNEO1a7L0fwrsnOy80SRdhRUG6mIh/U
aeYoo72RPyZxtqpYoI6Q7xoJ8yCmpcVe1umRR4C9BHdX4Oq/IIZR0aGxKPEpl2Cc
CLhUbLMM2qA7Coum3gcuGV/56r74s9Eo2P19k38n7+wlpgQQsW6sqwqn800SYPiy
tSTzrnELAiwZ4PQ0um+X34g9SKR2095qUaHcUYz/JD4FEVvyXeEtabW9y9IDVUvv
JyX9OjCx1X0cdPF8HrSqrKPeRwskn7mn+FN3f2Pj0Cscf/TYK7025xsJE5qHlH0Z
dFjIxs8f/w3Nwx10nRo1z/0sKug6og==
=BhJp
-----END PGP SIGNATURE-----

--GGtjE8mrkMu8pjTlLWAqsdALEBHvZHfc1--
