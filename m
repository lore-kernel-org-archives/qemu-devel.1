Received: from eggs.gnu.org ([2001:4830:134:3::10]:54476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpANd-0001rC-5z
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpANY-0001Jg-DH
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:42:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpANY-0001Ia-4m
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:42:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-21-marcandre.lureau@redhat.com>
Date: Tue, 05 Sep 2017 11:42:39 +0200
In-Reply-To: <20170822132255.23945-21-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:21 +0200")
Message-ID: <87fuc11nxs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 20/54] qapi-introspect: modify to_qlit()
 to take an optional suffix
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

> The following patch is going to break list entries with #if/#endif, so
> they should have the trailing ',' as suffix.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi-introspect.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index 4c437d60ec..dfb6d2ded4 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -16,7 +16,7 @@ def to_c_string(s):
>      return '"' + s.replace('\\', r'\\').replace('"', r'\"') + '"'
>=20=20
>=20=20
> -def to_qlit(obj, level=3D0, first_indent=3DTrue):
> +def to_qlit(obj, level=3D0, first_indent=3DTrue, suffix=3D''):
>=20=20
>      def indent(level):
>          return level * 4 * ' '
> @@ -29,11 +29,11 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue):
>      elif isinstance(obj, str):
>          ret +=3D 'QLIT_QSTR(' + to_c_string(obj) + ')'
>      elif isinstance(obj, list):
> -        elts =3D [to_qlit(elt, level + 1)
> +        elts =3D [to_qlit(elt, level + 1, suffix=3D',')
>                  for elt in obj]
>          elts.append(indent(level + 1) + "{}")
>          ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
> -        ret +=3D ',\n'.join(elts) + '\n'
> +        ret +=3D '\n'.join(elts) + '\n'
>          ret +=3D indent(level) + '}))'
>      elif isinstance(obj, dict):
>          elts =3D []
> @@ -46,7 +46,7 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue):
>          ret +=3D indent(level) + '}))'
>      else:
>          assert False                # not implemented
> -    return ret
> +    return ret + suffix
>=20=20
>=20=20
>  class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):

Hmm.  I wonder the appended simpler patch would do.

diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 4c437d60ec..73edb55cd5 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -33,7 +33,7 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue):
                 for elt in obj]
         elts.append(indent(level + 1) + "{}")
         ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
-        ret +=3D ',\n'.join(elts) + '\n'
+        ret +=3D '\n'.join(elts) + '\n'
         ret +=3D indent(level) + '}))'
     elif isinstance(obj, dict):
         elts =3D []
@@ -46,6 +46,8 @@ def to_qlit(obj, level=3D0, first_indent=3DTrue):
         ret +=3D indent(level) + '}))'
     else:
         assert False                # not implemented
+    if level > 0:
+        ret +=3D ','
     return ret
=20
=20
