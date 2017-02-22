Received: from eggs.gnu.org ([2001:4830:134:3::10]:59946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgfta-0000VG-42
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 18:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgftZ-0007lq-3S
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 18:00:26 -0500
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be675c58-2fda-c736-4fcb-e8de14071485@redhat.com>
Date: Wed, 22 Feb 2017 17:00:12 -0600
MIME-Version: 1.0
In-Reply-To: <1487710908-26356-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7RjOMG6stiPrjD5BKF36JlWEFejL4mKjm"
Subject: Re: [Qemu-devel] [PATCH RFC v3 3/5] qapi: Permit scalar type
 conversions in QObjectInputVisitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7RjOMG6stiPrjD5BKF36JlWEFejL4mKjm
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org
Message-ID: <be675c58-2fda-c736-4fcb-e8de14071485@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 3/5] qapi: Permit scalar type
 conversions in QObjectInputVisitor
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
 <1487710908-26356-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1487710908-26356-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 03:01 PM, Markus Armbruster wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> Currently the QObjectInputVisitor assumes that all scalar values are
> directly represented as the final types declared by the thing being
> visited. i.e. it assumes an 'int' is using QInt, and a 'bool' is using
> QBool, etc.  This is good when QObjectInputVisitor is fed a QObject
> that came from a JSON document on the QMP monitor, as it will strictly
> validate correctness.
>=20
> To allow QObjectInputVisitor to be reused for visiting a QObject
> originating from keyval_parse(), an alternative mode is needed where
> all the scalars types are represented as QString and converted on the
> fly to the final desired type.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> Message-Id: <1475246744-29302-8-git-send-email-berrange@redhat.com>
>=20
> Rebased, conflicts resolved, commit message updated to refer to
> keyval_parse().
>=20
> Control flow in qobject_input_type_number_autocast() simplified.
>=20
> Additional tests in test-qemu-opts.c to verify QemuOpts compatibility.
> To make the tests pass, use qemu_strtou64() instead of
> parse_uint_full().
>=20
> Use qemu_strtou64() and qemu_strtosz() instead of
> parse_option_number() and parse_option_size() so we have to call
> qobject_input_get_name() only when actually needed.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qobject-input-visitor.h |  32 ++++-
>  qapi/qobject-input-visitor.c         | 165 ++++++++++++++++++++++++
>  tests/test-keyval.c                  | 241 +++++++++++++++++++++++++++=
++++++++
>  tests/test-qobject-input-visitor.c   | 194 +++++++++++++++++++++++++++=
-
>  4 files changed, 624 insertions(+), 8 deletions(-)
>=20

> @@ -71,6 +72,7 @@ static const char *qobject_input_get_name(QObjectInpu=
tVisitor *qiv,
>              g_string_prepend(qiv->errname, name);
>              g_string_prepend_c(qiv->errname, '.');
>          } else {
> +            /* TODO needs to be .%zu for autocast */
>              snprintf(buf, sizeof(buf), "[%zu]", so->index);

Ah, the TODO means you started thinking about list integration, and
that's part of why this is still RFC.


> +static void qobject_input_type_bool_autocast(Visitor *v, const char *n=
ame,
> +                                             bool *obj, Error **errp)
> +{
> +    QObjectInputVisitor *qiv =3D to_qiv(v);
> +    QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);=

> +    QString *qstr;
> +    const char *str;
> +
> +    if (!qobj) {
> +        return;
> +    }
> +    qstr =3D qobject_to_qstring(qobj);
> +    if (!qstr) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
> +                   qobject_input_get_name(qiv, name), "string");
> +        return;
> +    }
> +
> +    str =3D qstring_get_str(qstr);
> +    if (!strcmp(str, "on")) {
> +        *obj =3D true;
> +    } else if (!strcmp(str, "off")) {
> +        *obj =3D false;

Why are we reimplementing only a subset of parse_option_bool() here?

Overall, most of the changes from Dan's original look sane.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7RjOMG6stiPrjD5BKF36JlWEFejL4mKjm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrhf8AAoJEKeha0olJ0NqlmAH/3AzN6PfIMSqFu8cASalbuKc
FlYqTkcDraWL/AMzMjmzpIW9SlDTRIHj4LyCQCUc6KYUknDO1b9BOjlxHCFdAFFi
e2d/e6naiNv84DTaK7bWBr+CmXaYJvfpRcVrWoX/wczz/i7ey6noeQNoHiFIV9q0
e7c8+sj1ESwqpZ7rZyBms2JC2Y9hZZFXYsp2RunHaiLayncv2yan6br68kAeOgph
NLPnBLcG+TSiF8Xm8PV+y6iTLNzNpqi08ZRJbC7I2m04rZo9IIqNHIpCQE2wpdOB
s756RV32lyoqivH2euf06VRmvhODtSIoIn1e1JzUEhZNHRq4SQRbeCflOMiyrfc=
=ZryQ
-----END PGP SIGNATURE-----

--7RjOMG6stiPrjD5BKF36JlWEFejL4mKjm--
