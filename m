Received: from eggs.gnu.org ([2001:4830:134:3::10]:59011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOR6x-0003V7-Vf
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOR6u-0008CL-Rh
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:34:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOR6u-0008CA-JD
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:34:48 -0500
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
	<1483371890-289981-4-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd7470b8-42e1-c681-f5c5-0d3808e0a9b6@redhat.com>
Date: Tue, 3 Jan 2017 09:34:40 -0600
MIME-Version: 1.0
In-Reply-To: <1483371890-289981-4-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SAXP97t5lmTUFec8FeJL7XKXWHqSc7uOE"
Subject: Re: [Qemu-devel] [PATCH 3/3] fix qmp/hmp query-memdev not
 repporting IDs of memory backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com, afaerber@suse.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SAXP97t5lmTUFec8FeJL7XKXWHqSc7uOE
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 afaerber@suse.de
Message-ID: <bd7470b8-42e1-c681-f5c5-0d3808e0a9b6@redhat.com>
Subject: Re: [PATCH 3/3] fix qmp/hmp query-memdev not repporting IDs of memory
 backends
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
 <1483371890-289981-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1483371890-289981-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/02/2017 09:44 AM, Igor Mammedov wrote:

s/repporting/reporting/ in the subject

> Do it by adding 'id' property to hostmem backends and fetch it
> in query-memdev from object directly.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

> +++ b/qom/object_interfaces.c
> @@ -4,6 +4,7 @@
>  #include "qemu/module.h"
>  #include "qapi-visit.h"
>  #include "qapi/opts-visitor.h"
> +#include "qapi/qmp/qstring.h"
> =20
>  void user_creatable_complete(Object *obj, Error **errp)
>  {
> @@ -35,7 +36,7 @@ bool user_creatable_can_be_deleted(UserCreatable *uc,=
 Error **errp)
>  }
> =20
>  Object *user_creatable_add_type(const char *type, const char *id,
> -                                const QDict *qdict,
> +                                QDict *qdict,
>                                  Visitor *v, Error **errp)
>  {
>      Object *obj;
> @@ -62,6 +63,9 @@ Object *user_creatable_add_type(const char *type, con=
st char *id,
> =20
>      assert(qdict);
>      obj =3D object_new(type);
> +    if (object_property_find(obj, "id", NULL)) {
> +        qdict_put(qdict, "id", qstring_from_str(id));
> +    }

Wait. Isn't this going to inject an 'id' dict member to every use of
user_creatable_add_type()?  But not all QAPI structs contain an id
member.  Which means that you are now explicitly relying on the visitor
to silently ignore garbage in the dictionary, rather than our desired
goal of only validating if the dictionary exactly matches what the QAPI
says it will match.

I'm not sure if I like this hack, or if there is a better way to do
things when using a strict (rather than relaxed) input visitor.

>      visit_start_struct(v, NULL, NULL, 0, &local_err);
>      if (local_err) {
>          goto out;
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--SAXP97t5lmTUFec8FeJL7XKXWHqSc7uOE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa8SQAAoJEKeha0olJ0NqXeQIALDk/fz1y0qx//OCo/1y+rAG
xuXhfTj42ZMPh/uhFUraliqAVesRBv/k4S2ZW/6BLG9QqVKaltqMfjYNaJZOMXgC
8ICJoqjLNqGXaspunf3MVgVZUDtBxH1U60BTkLTfWa29coEyJf53hV7Haaanl9dk
cUjCxOBZB3EPEk1VVmiHOJh14nufvVbySz7LmkMbLb983am3uXAExJ3k4v89nfF9
6nyKpkwItVPLI9jqjVcoKz55IO84OuSslvx2xvFUS0JaTDAancla6sNBPmV5y7gC
cXoW79CYKSCatw9PxRYHRmPJHvCJ/68kIHaS8N+YmnQwaNoMBgfVa1Z16J2lGVw=
=qrxB
-----END PGP SIGNATURE-----

--SAXP97t5lmTUFec8FeJL7XKXWHqSc7uOE--
