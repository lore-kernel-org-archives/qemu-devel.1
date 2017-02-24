Received: from eggs.gnu.org ([2001:4830:134:3::10]:60010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chP3e-0004Ta-Qz
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chP3b-0004ao-KM
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:13:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chP3b-0004aW-Bb
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:13:47 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 924CC552CE
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 23:13:47 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-9-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6255319d-0a27-0909-00d1-059bae0ff8ef@redhat.com>
Date: Fri, 24 Feb 2017 17:13:45 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V9qvT0BR0qHLCArRs3HD337BRrhcu2Tjp"
Subject: Re: [Qemu-devel] [PATCH 08/21] qmp: Improve QMP dispatch error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V9qvT0BR0qHLCArRs3HD337BRrhcu2Tjp
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <6255319d-0a27-0909-00d1-059bae0ff8ef@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/21] qmp: Improve QMP dispatch error
 messages
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qmp-dispatch.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20

> @@ -41,15 +41,17 @@ static QDict *qmp_dispatch_check_obj(const QObject =
*request, Error **errp)
> =20
>          if (!strcmp(arg_name, "execute")) {
>              if (qobject_type(arg_obj) !=3D QTYPE_QSTRING) {
> -                error_setg(errp, "QMP input object member '%s' expects=
 '%s'",
> -                           "execute", "string");
> +                error_setg(errp,
> +                           "QMP input object member '%s' must be %s",
> +                           "execute", "a string");

Any reason we can't inline this to:

"QMP input object member 'execute' must be a string"

? It's not like we're translating the message.

>                  return NULL;
>              }
>              has_exec_key =3D true;
>          } else if (!strcmp(arg_name, "arguments")) {
>              if (qobject_type(arg_obj) !=3D QTYPE_QDICT) {
> -                error_setg(errp, "QMP input object member '%s' expects=
 '%s'",
> -                           "arguments", "object");
> +                error_setg(errp,
> +                           "QMP input object member '%s' must be %s",
> +                           "arguments", "an object");

and again

Then again, if you use my idea of a QAPI-generated visitor of each input
wire object, you'd get whatever error message qobject-input normally
gives, which may render these changes irrelevant.

At any rate, the new wordings are nicer, whether or not you inline
constant text.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--V9qvT0BR0qHLCArRs3HD337BRrhcu2Tjp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsL4pAAoJEKeha0olJ0NqUxMH+QG8p3c9P244omUnGxQ+i8M1
H/hH0M+S8at5iUTUVYmR3C6ZM6n4dhttj9DulsfIXH6iQi58BZlAOb1hiQe9/iCH
tDG1BRGzrzWJlYZGxF9MZrHS2dvAdaWYYusbKCsnZM+V5LAHX4cR7PYfM72PpVLo
6Iuis4sHJ4HBqEh49Ve+Ks7A55ZnYTdXK0hEZAa6YHDOahe85IZSky6Z1knd4Z4B
YNsFBTVxAyE5ALmTdiiEen2Mbg502M0muBE0DHfvjrYQRlou2z3vmOFJOMWn7s4j
+fDJ6o4CWYi6cwK2XfjoMkGETvEHfSqfe+NDehsm1WWgjQYRItQJ9a+hySLNrIg=
=THJ1
-----END PGP SIGNATURE-----

--V9qvT0BR0qHLCArRs3HD337BRrhcu2Tjp--
