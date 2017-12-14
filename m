Received: from eggs.gnu.org ([2001:4830:134:3::10]:47056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePTyB-0002T8-Rx
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePTy7-00068s-Ue
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:54:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ePTy7-00067o-Lz
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:54:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-42-marcandre.lureau@redhat.com>
Date: Thu, 14 Dec 2017 14:54:25 +0100
In-Reply-To: <20170911110623.24981-42-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:06:14 +0200")
Message-ID: <87zi6lza7i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 41/50] qapi: add a 'unit' pragma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add a pragma that allows to tag the following expressions with a unit
> name. By default, an expression has no unit name.

Please explain the unit name's intended purpose.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py              | 9 ++++++++-
>  docs/devel/qapi-code-gen.txt | 3 +++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index eb4ffdc06d..1d0defd638 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -279,10 +279,12 @@ class QAPISchemaParser(object):
>          self.docs =3D []
>          self.cur_doc =3D None
>          self.accept()
> +        self.unit =3D None
>=20=20
>          while self.tok is not None:
>              info =3D {'file': fname, 'line': self.line,
> -                    'parent': self.incl_info}
> +                    'parent': self.incl_info,
> +                    'unit': self.unit}
>              if self.tok =3D=3D '#':
>                  self.reject_expr_doc()
>                  self.cur_doc =3D self.get_doc(info)
> @@ -371,6 +373,11 @@ class QAPISchemaParser(object):
>                                     "Pragma name-case-whitelist must be"
>                                     " a list of strings")
>              name_case_whitelist =3D value
> +        elif name =3D=3D 'unit':
> +            if not isinstance(value, str):
> +                raise QAPISemError(info,
> +                                   "Pragma 'unit' must be string")
> +            self.unit =3D value
>          else:
>              raise QAPISemError(info, "Unknown pragma '%s'" % name)
>=20=20
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 24fc6f74ee..37a27cd9d7 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -326,6 +326,9 @@ violate the rules on permitted return types.  Default=
 is none.
>  Pragma 'name-case-whitelist' takes a list of names that may violate
>  rules on use of upper- vs. lower-case letters.  Default is none.
>=20=20
> +Pragma 'unit' takes a string value. It will set the unit name for the
> +following expressions in the schema. Most code generator can filter
> +based on a unit name. Default is none.

Do you mean "most code generators"?

What does "filtering" mean?

>=20=20
>  =3D=3D=3D Struct types =3D=3D=3D

Humor me: put two spaces after a sentence-ending period.
