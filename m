Received: from eggs.gnu.org ([2001:4830:134:3::10]:47682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjsfX-0000Os-7f
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:15:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjsfU-0004od-1h
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:15:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjsfT-0004n8-Q1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:15:07 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7F7CC0099FF
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 19:15:07 +0000 (UTC)
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-26-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <82622f99-91d8-7ae0-2a38-53b49e200f72@redhat.com>
Date: Fri, 3 Mar 2017 13:15:05 -0600
MIME-Version: 1.0
In-Reply-To: <1488544368-30622-26-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E7dvkNbbs7V5Ka04503XWlJT0wPxARD1W"
Subject: Re: [Qemu-devel] [PATCH v4 25/28] qapi: Make input visitors detect
 unvisited list tails
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
--E7dvkNbbs7V5Ka04503XWlJT0wPxARD1W
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <82622f99-91d8-7ae0-2a38-53b49e200f72@redhat.com>
Subject: Re: [PATCH v4 25/28] qapi: Make input visitors detect unvisited list
 tails
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
 <1488544368-30622-26-git-send-email-armbru@redhat.com>
In-Reply-To: <1488544368-30622-26-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 06:32 AM, Markus Armbruster wrote:
> Fix the design flaw demonstrated in the previous commit: new method
> check_list() lets input visitors report that unvisited input remains
> for a list, exactly like check_struct() lets them report that
> unvisited input remains for a struct or union.
>=20
> Implement the method for the qobject input visitor (straightforward),
> and the string input visitor (less so, due to the magic list syntax
> there).  The opts visitor's list magic is even more impenetrable, and
> all I can do there today is a stub with a FIXME comment.  No worse
> than before.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Didn't I already review this one?

Ah, there's my R-b:
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg07614.html

But since it disappeared again, I had another look.

> +++ b/qapi/qobject-input-visitor.c
> @@ -51,7 +51,8 @@ static QObjectInputVisitor *to_qiv(Visitor *v)
>      return container_of(v, QObjectInputVisitor, visitor);
>  }
> =20
> -static const char *full_name(QObjectInputVisitor *qiv, const char *nam=
e)
> +static const char *full_name_nth(QObjectInputVisitor *qiv, const char =
*name,
> +                                 int n)
>  {
>      StackObject *so;
>      char buf[32];
> @@ -63,8 +64,10 @@ static const char *full_name(QObjectInputVisitor *qi=
v, const char *name)
>      }
> =20
>      QSLIST_FOREACH(so , &qiv->stack, node) {
> -        if (qobject_type(so->obj) =3D=3D QTYPE_QDICT) {
> -            g_string_prepend(qiv->errname, name);
> +        if (n) {
> +            n--;
> +        } else if (qobject_type(so->obj) =3D=3D QTYPE_QDICT) {
> +            g_string_prepend(qiv->errname, name ?: "<anonymous>");
>              g_string_prepend_c(qiv->errname, '.');
>          } else {
>              snprintf(buf, sizeof(buf), "[%u]", so->index);
> @@ -72,18 +75,24 @@ static const char *full_name(QObjectInputVisitor *q=
iv, const char *name)
>          }
>          name =3D so->name;
>      }
> +    assert(!n);

If I'm reading this right, your use of n-- in the loop followed by the
post-condition is to assert that QSLIST_FOREACH() iterated n times, but
lets see what callers pass for n:

> =20
>      if (name) {
>          g_string_prepend(qiv->errname, name);
>      } else if (qiv->errname->str[0] =3D=3D '.') {
>          g_string_erase(qiv->errname, 0, 1);
> -    } else {
> +    } else if (!qiv->errname->str[0]) {
>          return "<anonymous>";
>      }
> =20
>      return qiv->errname->str;
>  }
> =20
> +static const char *full_name(QObjectInputVisitor *qiv, const char *nam=
e)
> +{
> +    return full_name_nth(qiv, name, 0);
> +}

One caller passes 0,


> +static void qobject_input_check_list(Visitor *v, Error **errp)
> +{
> +    QObjectInputVisitor *qiv =3D to_qiv(v);
> +    StackObject *tos =3D QSLIST_FIRST(&qiv->stack);
> +
> +    assert(tos && tos->obj && qobject_type(tos->obj) =3D=3D QTYPE_QLIS=
T);
> +
> +    if (tos->entry) {
> +        error_setg(errp, "Only %u list elements expected in %s",
> +                   tos->index + 1, full_name_nth(qiv, NULL, 1));

the other passes 1.  No other calls.  Did we really need an integer,
where we use n--, or would a bool have done as well?

At any rate, since I've already reviewed it once, you can add R-b, but
we may want a followup to make it less confusing.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--E7dvkNbbs7V5Ka04503XWlJT0wPxARD1W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYucC5AAoJEKeha0olJ0NqAtUIAIcE/XnHOCT/hnMQYgmk3nSJ
D1NqlhlABsJeSLPAcamltbpMzyerVVKoWVUclaVMjXUJWCoES+daaJ8krYfl49sf
wVIZAYq/GcEuGNz+Nnl3HW03+9kQEJB9fXaK0hyCc0S5OnAL/71xrfaJdbKOP6ZS
34h7+QDTuY0G7EJVtu61CbOFdOORePUN3XPxs/9eysb9NK/l4ODtdW0g5a9SvlND
SgYQUVAIRfJ8+SDdUs8vesOZG83Ng0ylrmuZn5v2KWZnjG/LOley41zdR2Kzq6IH
F7EiPrEP5tJALf+fJydc+JEWbN8o76AoIf1Zvy8soOZw4NMlv6GS7yO1GM721rM=
=fD/6
-----END PGP SIGNATURE-----

--E7dvkNbbs7V5Ka04503XWlJT0wPxARD1W--
