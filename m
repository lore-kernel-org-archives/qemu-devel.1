Received: from eggs.gnu.org ([2001:4830:134:3::10]:57753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elJzQ-0003E3-2a
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elJzM-0000V5-DV
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:42:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elJzM-0000U7-7G
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:42:08 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a095759a-0b4b-125d-a178-3456e3651c42@redhat.com>
Date: Mon, 12 Feb 2018 13:42:05 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/29] qapi-gen: New common driver for
 code and doc generators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:35 AM, Markus Armbruster wrote:
> Whenever qapi-schema.json changes, we run six programs eleven times to
> update eleven files.  Similar for qga/qapi-schema.json.  This is
> silly.  Replace the six programs by a single program that spits out
> all eleven files.
>=20
> The programs become modules in new Python package qapi, along with the
> helper library.  This requires moving them to scripts/qapi/.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   .gitignore                                         |  2 +
>   Makefile                                           | 86 +++++++++----=
------
>   docs/devel/qapi-code-gen.txt                       | 97 ++++++++++---=
---------
>   monitor.c                                          |  2 +-
>   qapi-schema.json                                   |  2 +-
>   scripts/qapi-gen.py                                | 41 +++++++++
>   scripts/qapi/__init__.py                           |  0
>   scripts/{qapi-commands.py =3D> qapi/commands.py}     | 23 ++---
>   scripts/{qapi.py =3D> qapi/common.py}                | 18 +---
>   scripts/{qapi2texi.py =3D> qapi/doc.py}              | 29 ++-----
>   scripts/{qapi-event.py =3D> qapi/events.py}          | 23 ++---
>   scripts/{qapi-introspect.py =3D> qapi/introspect.py} | 32 ++-----
>   scripts/{qapi-types.py =3D> qapi/types.py}           | 34 ++------
>   scripts/{qapi-visit.py =3D> qapi/visit.py}           | 34 ++------
>   tests/Makefile.include                             | 56 ++++++-------
>   tests/qapi-schema/test-qapi.py                     |  4 +-
>   16 files changed, 193 insertions(+), 290 deletions(-)
>   create mode 100755 scripts/qapi-gen.py
>   create mode 100644 scripts/qapi/__init__.py
>   rename scripts/{qapi-commands.py =3D> qapi/commands.py} (94%)
>   rename scripts/{qapi.py =3D> qapi/common.py} (99%)
>   rename scripts/{qapi2texi.py =3D> qapi/doc.py} (92%)
>   mode change 100755 =3D> 100644

Still forgot mention that the mode bit change was intentional, but not=20
worth a respin for just that.

>   rename scripts/{qapi-event.py =3D> qapi/events.py} (92%)
>   rename scripts/{qapi-introspect.py =3D> qapi/introspect.py} (90%)
>   rename scripts/{qapi-types.py =3D> qapi/types.py} (90%)
>   rename scripts/{qapi-visit.py =3D> qapi/visit.py} (92%)

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/docs/devel/qapi-code-gen.txt

> -    $ python scripts/qapi-event.py --output-dir=3D"qapi-generated"
> -    --prefix=3D"example-" example-schema.json
>       $ cat qapi-generated/example-qapi-event.h
>   [Uninteresting stuff omitted...]
>  =20
> @@ -1302,23 +1296,22 @@ Example:
>       }
>  =20
>       const char *const example_QAPIEvent_lookup[] =3D {
> -        [EXAMPLE_QAPI_EVENT_MY_EVENT] =3D "MY_EVENT",
> +
> +[EXAMPLE_QAPI_EVENT_MY_EVENT] =3D "MY_EVENT",
>           [EXAMPLE_QAPI_EVENT__MAX] =3D NULL,
>       };

Looks like our generated code indentation has slightly regressed from=20
what we would write by hand, but it's still okay for generated code (and=20
the commit message in 5/29 did call that out)

> +++ b/scripts/qapi-gen.py

> +++ b/scripts/qapi/commands.py
> @@ -13,7 +13,7 @@ This work is licensed under the terms of the GNU GPL,=
 version 2.
>   See the COPYING file in the top-level directory.
>   """
>  =20
> -from qapi import *
> +from qapi.common import *
>  =20
>  =20
>   def gen_command_decl(name, arg_type, boxed, ret_type):
> @@ -255,13 +255,8 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisito=
r):
>           self._regy +=3D gen_register_command(name, success_response)
>  =20
>  =20
> -def main(argv):
> -    (input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_comma=
nd_line()
> -
> -    blurb =3D '''
> - * Schema-defined QAPI/QMP commands
> -'''
> -
> +def gen_commands(schema, output_dir, prefix):
> +    blurb =3D ' * Schema-defined QAPI/QMP commands'

We discussed whether to make the assignment to blurb be a one-liner in=20
an earlier patch, but I'm also fine with the churn you have over the=20
course of the series.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
