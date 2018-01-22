Received: from eggs.gnu.org ([2001:4830:134:3::10]:33361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ede6b-0004hc-GF
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ede6a-0008S7-De
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:33:53 -0500
References: <20180120154412.9990-1-mreitz@redhat.com>
	<20180120154412.9990-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <39ad6e43-024c-6384-d014-e0b8f83ed3a7@redhat.com>
Date: Mon, 22 Jan 2018 09:33:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180120154412.9990-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l5sKKp4Q3TZ3lBrFa47eslySyuIO7CMLH"
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qapi: Add qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l5sKKp4Q3TZ3lBrFa47eslySyuIO7CMLH
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <39ad6e43-024c-6384-d014-e0b8f83ed3a7@redhat.com>
Subject: Re: [PATCH v2 1/6] qapi: Add qobject_to()
References: <20180120154412.9990-1-mreitz@redhat.com>
 <20180120154412.9990-2-mreitz@redhat.com>
In-Reply-To: <20180120154412.9990-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2018 09:44 AM, Max Reitz wrote:
> This is a dynamic casting macro that, given a QObject type, returns an
> object as that type or NULL if the object is of a different type (or
> NULL itself).
>=20
> The macro uses lower-case letters because:
> 1. There does not seem to be a hard rule on whether qemu macros have to=

>    be upper-cased,
> 2. The current situation in qapi/qmp is inconsistent (compare e.g.
>    QINCREF() vs. qdict_put()),
> 3. qobject_to() will evaluate its @obj parameter only once, thus it is
>    generally not important to the caller whether it is a macro or not,
> 4. I prefer it aesthetically.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> You're more than welcome to convince me to call it QOBJECT_TO()!

I can live with the lower-case version; especially with your good list
of reasons for it ;)

> ---
>  include/qapi/qmp/qobject.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
> index 38ac68845c..1211989ca0 100644
> --- a/include/qapi/qmp/qobject.h
> +++ b/include/qapi/qmp/qobject.h
> @@ -50,6 +50,24 @@ struct QObject {
>  #define QDECREF(obj)              \
>      qobject_decref(obj ? QOBJECT(obj) : NULL)
> =20
> +/* Required for qobject_to() */
> +#define QTYPE_CAST_TO_QNull     QTYPE_QNULL
> +#define QTYPE_CAST_TO_QNum      QTYPE_QNUM
> +#define QTYPE_CAST_TO_QString   QTYPE_QSTRING
> +#define QTYPE_CAST_TO_QDict     QTYPE_QDICT
> +#define QTYPE_CAST_TO_QList     QTYPE_QLIST
> +#define QTYPE_CAST_TO_QBool     QTYPE_QBOOL
> +
> +#ifdef CONFIG_STATIC_ASSERT
> +_Static_assert(QTYPE__MAX =3D=3D 7,
> +               "The QTYPE_CAST_TO_* list needs to be extended");
> +#endif

Why not use QEMU_BUILD_BUG_ON() instead of _Static_assert?  That way,
this check will break the build even on older compilers that lack
_Static_assert but where we still know how to trigger a build failure.

> +
> +#define qobject_to(obj, type) \
> +    container_of(qobject_check_type(obj, glue(QTYPE_CAST_TO_, type)) ?=
: \
> +                     QOBJECT((type *)NULL), \
> +                 type, base)

Slick!

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--l5sKKp4Q3TZ3lBrFa47eslySyuIO7CMLH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpmBFcACgkQp6FrSiUn
Q2oDdwgAntwAp/jfBhXlpfDALDi5h8hbKreXIVl+DuzJvLOEeXE7I1dNokpYLQ2Q
EiULI9tLKx3Jdfi6MuGYLtfs1+SeAw2iNxxRdUj8oddGQJ6oswID6+R3eBehsbap
hDxc/A6+CqCGAy4or7z/QuLCvjGYpb6Yhzbmq2LeQHvvORrS/gzs6KPPfP/tudIe
SWLfD1/iPMAnOjfHC1j6nBroTx6twHRYhg/p9O7YghUCHGxn5q/i/sVgbdArW1Xe
q8zt9kK9eZtp3jkokI6MkZd32/t6fgECZdiaBPyQCAK2bSQxF+IGk/4bEG6QzWXc
KcdIy+4SQlpxrN37rTYzaXYCqZ8VoA==
=jelo
-----END PGP SIGNATURE-----

--l5sKKp4Q3TZ3lBrFa47eslySyuIO7CMLH--
