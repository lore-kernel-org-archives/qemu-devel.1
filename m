Received: from eggs.gnu.org ([2001:4830:134:3::10]:36517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYazS-0005N3-4G
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYazO-0002Fn-TC
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:45:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45324 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fYazO-0002FV-OR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:45:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-5-marcandre.lureau@redhat.com>
Date: Thu, 28 Jun 2018 19:45:44 +0200
In-Reply-To: <20180627163551.31610-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 27 Jun 2018 18:35:40 +0200")
Message-ID: <87a7reg5yv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 04/15] qapi: leave the ifcond attribute
 undefined until check()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> We commonly initialize attributes to None in .init(), then set their
> real value in .check().  Accessing the attribute before .check()
> yields None.  If we're lucky, the code that accesses the attribute
> prematurely chokes on None.
>
> It won't for .ifcond, because None is a legitimate value.
>
> Leave the ifcond attribute undefined until check().
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Note to self: consider squashing into previous patch.

> ---
>  scripts/qapi/common.py | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 4f4014b387..46e33e23e4 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1021,13 +1021,19 @@ class QAPISchemaEntity(object):
>          # such place).
>          self.info =3D info
>          self.doc =3D doc
> -        self.ifcond =3D listify_cond(ifcond)
> +        self._ifcond =3D ifcond  # self.ifcond is set only after .check()
>=20=20
>      def c_name(self):
>          return c_name(self.name)
>=20=20
>      def check(self, schema):
> -        pass
> +        if isinstance(self._ifcond, QAPISchemaType):
> +            # inherit the condition from a type
> +            typ =3D self._ifcond
> +            typ.check(schema)
> +            self.ifcond =3D typ.ifcond
> +        else:
> +            self.ifcond =3D listify_cond(self._ifcond)
>=20=20
>      def is_implicit(self):
>          return not self.info

One of the questions I had on v5 of this patch is still open.  I asked
whether we can restrict the inheritance feature to array elements.  You
pointed to implicit object types.  I asked for an example (because I
couldn't figure out what you meant).  Please reply in that thread.

[...]
