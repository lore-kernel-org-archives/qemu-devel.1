Received: from eggs.gnu.org ([2001:4830:134:3::10]:39703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMdGX-0002R8-6S
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:13:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMdGS-0002bw-Kh
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:13:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eMdGS-0002ZE-CR
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:13:44 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-7-marcandre.lureau@redhat.com>
Date: Wed, 06 Dec 2017 18:13:39 +0100
In-Reply-To: <20170911110623.24981-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 11 Sep 2017 13:05:39 +0200")
Message-ID: <87h8t3wzi4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/50] qapi: pass 'if' condition into
 QAPISchemaEntity objects
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

> Built-in objects remain unconditional.  Explicitly defined objects
> use the condition specified in the schema.  Implicitly defined
> objects inherit their condition from their users.  For most of them,
> there is exactly one user, so the condition to use is obvious.  The
> exception is the wrapper types generated for simple union variants,
> which can be shared by any number of simple unions.  The tight
> condition would be the disjunction of the conditions of these simple
> unions.  For now, use wrapped type's condition instead.  Much

the wrapped type's

> simpler and good enough for now.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py | 89 ++++++++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 57 insertions(+), 32 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 20c1abf915..0f55caa18d 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1000,7 +1000,7 @@ def check_exprs(exprs):
>  #
>=20=20
>  class QAPISchemaEntity(object):
> -    def __init__(self, name, info, doc):
> +    def __init__(self, name, info, doc, ifcond=3DNone):
>          assert isinstance(name, str)
>          self.name =3D name
>          # For explicitly defined entities, info points to the (explicit)
> @@ -1010,6 +1010,7 @@ class QAPISchemaEntity(object):
>          # such place).
>          self.info =3D info
>          self.doc =3D doc
> +        self.ifcond =3D ifcond
>=20=20
>      def c_name(self):
>          return c_name(self.name)
> @@ -1126,8 +1127,8 @@ class QAPISchemaBuiltinType(QAPISchemaType):
>=20=20
>=20=20
>  class QAPISchemaEnumType(QAPISchemaType):
> -    def __init__(self, name, info, doc, values, prefix):
> -        QAPISchemaType.__init__(self, name, info, doc)
> +    def __init__(self, name, info, doc, ifcond, values, prefix):
> +        QAPISchemaType.__init__(self, name, info, doc, ifcond)
>          for v in values:
>              assert isinstance(v, QAPISchemaMember)
>              v.set_owner(name)
> @@ -1162,7 +1163,7 @@ class QAPISchemaEnumType(QAPISchemaType):
>=20=20
>  class QAPISchemaArrayType(QAPISchemaType):
>      def __init__(self, name, info, element_type):
> -        QAPISchemaType.__init__(self, name, info, None)
> +        QAPISchemaType.__init__(self, name, info, None, None)
>          assert isinstance(element_type, str)
>          self._element_type_name =3D element_type
>          self.element_type =3D None
> @@ -1170,6 +1171,7 @@ class QAPISchemaArrayType(QAPISchemaType):
>      def check(self, schema):
>          self.element_type =3D schema.lookup_type(self._element_type_name)
>          assert self.element_type
> +        self.ifcond =3D self.element_type.ifcond
>=20=20
>      def is_implicit(self):
>          return True

In my review of v2, I wrote:

    This is subtler than it looks on first glance.

    All the other entities set self.ifcond in their constructor to the true
    value passed in as argument.

    QAPISchemaArrayType doesn't take such an argument.  Instead, it inherits
    its .ifcond from its .element_type.  However, .element_type isn't known
    at construction time if it's a forward reference.  We therefore delay
    setting it until .check() time.  You do the same for .ifcond (no
    choice).

    Before .check(), .ifcond is None, because the constructor sets it that
    way: it calls QAPISchemaType.__init__() without passing a ifcond
    argument, which then sets self.ifcond to its default argument None.

    Pitfall: accessing ent.ifcond before ent.check() works *except* when ent
    is an array type.  Hmm.

The problem is of course more general.  We commonly initialize
attributes to None in .init(), then set their real value in .check().
Accessing the attribute before .check() yields None.  If we're lucky,
the code that accesses the attribute prematurely chokes on None.

It won't for .ifcond, because None is a legitimate value.

Perhaps we should leave such attributes undefined until .check().  What
do you think?  No need to tie that idea to this series, though.

[...]

With the commit message tidied up:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
