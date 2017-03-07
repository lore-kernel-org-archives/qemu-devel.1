Received: from eggs.gnu.org ([2001:4830:134:3::10]:47667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clG02-0002Rz-2E
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clFzx-0001od-53
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:22:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1clFzw-0001oL-Pk
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 09:21:57 -0500
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-11-git-send-email-armbru@redhat.com>
	<dd7a93a5-87d5-83c9-b608-8511036ac394@amsat.org>
	<87efycduf0.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <52bc1274-8d93-d477-a3e3-d3b7b5094d7a@redhat.com>
Date: Tue, 7 Mar 2017 08:21:52 -0600
MIME-Version: 1.0
In-Reply-To: <87efycduf0.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jXk3l6mq8rk5rnHkp8NKEP0ka116tH7ID"
Subject: Re: [Qemu-devel] [PATCH v4 10/28] qmp: Improve QMP dispatch error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jXk3l6mq8rk5rnHkp8NKEP0ka116tH7ID
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Message-ID: <52bc1274-8d93-d477-a3e3-d3b7b5094d7a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 10/28] qmp: Improve QMP dispatch error
 messages
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
 <1488544368-30622-11-git-send-email-armbru@redhat.com>
 <dd7a93a5-87d5-83c9-b608-8511036ac394@amsat.org>
 <87efycduf0.fsf@dusky.pond.sub.org>
In-Reply-To: <87efycduf0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/05/2017 02:01 AM, Markus Armbruster wrote:

> Since substantial other work depends on this series, it needs to go in
> sooner rather than later.  I'm therefore *dropping* this patch from the=

> series.  We can then bikeshed^Wpolish to our heart's content without
> holding up other work.
>=20
> That said: what about this?
>=20
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index dc50212..5ad36f8 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -30,7 +30,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *r=
equest, Error **errp)
> =20
>      dict =3D qobject_to_qdict(request);
>      if (!dict) {
> -        error_setg(errp, "Expected '%s' in QMP input", "object");
> +        error_setg(errp, "QMP input must be a JSON object");
>          return NULL;
>      }
> =20
> @@ -41,26 +41,26 @@ static QDict *qmp_dispatch_check_obj(const QObject =
*request, Error **errp)
> =20
>          if (!strcmp(arg_name, "execute")) {
>              if (qobject_type(arg_obj) !=3D QTYPE_QSTRING) {
> -                error_setg(errp, "QMP input object member '%s' expects=
 '%s'",
> -                           "execute", "string");
> +                error_setg(errp,
> +                           "QMP input member 'execute' must be a strin=
g");
>                  return NULL;
>              }
>              has_exec_key =3D true;
>          } else if (!strcmp(arg_name, "arguments")) {
>              if (qobject_type(arg_obj) !=3D QTYPE_QDICT) {
> -                error_setg(errp, "QMP input object member '%s' expects=
 '%s'",
> -                           "arguments", "object");
> +                error_setg(errp,
> +                           "QMP input member 'arguments' must be an ob=
ject");
>                  return NULL;
>              }
>          } else {
> -            error_setg(errp, "QMP input object member '%s' is unexpect=
ed",
> +            error_setg(errp, "QMP input member '%s' is unexpected",
>                         arg_name);
>              return NULL;
>          }
>      }
> =20
>      if (!has_exec_key) {
> -        error_setg(errp, "Expected '%s' in QMP input", "execute");
> +        error_setg(errp, "QMP input lacks member 'execute'");
>          return NULL;
>      }
> =20
>=20
>=20

Based on the rest of this sub-thread, I'm making it explicit that you
can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--jXk3l6mq8rk5rnHkp8NKEP0ka116tH7ID
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvsIAAAoJEKeha0olJ0NqrjEH/i3Q90HQkuHEjmJW2/6f1dwB
YDqwytQhnoUz4RSwdIl4ioumtKLT8qRF/A+iWXMGJ3/kQwqppMC6rNM48TYqLwkZ
HSD6iIosPYJEu9udFN5C2gF9Ko1XgK2bnH1MTyc13NjduNThRJC95bdEWjQJYd8X
MmkatG6wfnvVIzjifjbrApn6w371SWHkmSixm/6zw+1XeXdtFAiDWHNw1CTo/eQw
uufBNCN16DKfZsGlRh6Ifx+h5mZFTqCepiMc+3B8o0slC9uQkQxFXj2ENXvW1g9v
jgYuZIxrZJn5dWOUW7kzponVcOYtF7facj5GPpM++Ujn6OCTyMskbKA10w1WbkU=
=QU4D
-----END PGP SIGNATURE-----

--jXk3l6mq8rk5rnHkp8NKEP0ka116tH7ID--
