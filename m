Received: from eggs.gnu.org ([2001:4830:134:3::10]:51054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVcqA-0004ZZ-MD
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVcq9-0005l9-RB
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:08:02 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fVcq9-0005kk-KY
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:08:01 -0400
Received: by mail-wr0-x241.google.com with SMTP id e18-v6so3246277wrs.5
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:08:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180620124742.16979-1-armbru@redhat.com>
References: <20180620124742.16979-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Jun 2018 15:07:59 +0200
Message-ID: <CAJ+F1CJguzAVgKeyeGR1EpXX2F8CjWR1sVkJajUrNgHQEsuucA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi/introspect: Eliminate pointless
 variable in .visit_end()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Wed, Jun 20, 2018 at 2:47 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Commit 1a9a507b2e3 "qapi-introspect: Hide type names" added local
> variable @jsons to improve sorting, but also removed the sorting.  It
> was part of a big series that went to v8, and it made sense until v2
> or so...
>
> Commit 7d0f982bfbb replaced @jsons by @qlits, preserving the
> uselessness.
>
> Get rid of it.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  scripts/qapi/introspect.py | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 5b6c72c7b2..6ad198ae5b 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -75,13 +75,10 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonoli=
thicCVisitor):
>
>      def visit_end(self):
>          # visit the types that are actually used
> -        qlits =3D self._qlits
> -        self._qlits =3D []
>          for typ in self._used_types:
>              typ.visit(self)
>          # generate C
>          # TODO can generate awfully long lines
> -        qlits.extend(self._qlits)
>          name =3D c_name(self._prefix, protect=3DFalse) + 'qmp_schema_qli=
t'
>          self._genh.add(mcgen('''
>  #include "qapi/qmp/qlit.h"
> @@ -93,7 +90,7 @@ extern const QLitObject %(c_name)s;
>  const QLitObject %(c_name)s =3D %(c_string)s;
>  ''',
>                               c_name=3Dc_name(name),
> -                             c_string=3Dto_qlit(qlits)))
> +                             c_string=3Dto_qlit(self._qlits)))
>          self._schema =3D None
>          self._qlits =3D []
>          self._used_types =3D []
> --
> 2.17.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
