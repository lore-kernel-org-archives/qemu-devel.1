Received: from eggs.gnu.org ([2001:4830:134:3::10]:36233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhgv-0001LH-6h
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhgt-0004u7-VS
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:18:17 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:53796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzhgt-0004tT-Qw
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:18:15 -0400
Received: by mail-oi0-x230.google.com with SMTP id j126so18971395oia.10
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 04:18:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-14-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-14-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 13:18:13 +0200
Message-ID: <CAJ+F1CLiQd-zk4=QZZzamEFZO19rrZbrTnMngRaSLDN6se=FAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 13/32] qapi: Use argparse to open
 schema file
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

On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> QAPISchema.__init__() opens the schema file.  Since it doesn't bother
> to catch exceptions, an invalid schema argument is reported like this:
>
>     Traceback (most recent call last):
>       File "../scripts/qapi-commands.py", line 318, in <module>
>         schema =3D QAPISchema(args.schema)
>       File "/work/armbru/qemu/scripts/qapi.py", line 1464, in __init__
>         parser =3D QAPISchemaParser(open(fname, 'r'))
>     IOError: [Errno 2] No such file or directory: 'nonexistent'
>
> Leave it to argparse, which handles the exception like this:
>
>     usage: qapi-commands.py [-h] [-o OUTPUT_DIR] [-p PREFIX] schema
>     qapi-commands.py: error: argument schema: can't open 'nonexistent': [=
Errno 2] No such file or directory: 'nonexistent'
>
> Too verbose for my taste, but let's not second-guess the standard
> library.

indeed :)

>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi.py                | 6 +++---
>  scripts/qapi2texi.py           | 2 +-
>  tests/qapi-schema/test-qapi.py | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 25f6c81b08..a33203e82d 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1450,9 +1450,9 @@ class QAPISchemaEvent(QAPISchemaEntity):
>
>
>  class QAPISchema(object):
> -    def __init__(self, fname):
> +    def __init__(self, file):
>          try:
> -            parser =3D QAPISchemaParser(open(fname, 'r'))
> +            parser =3D QAPISchemaParser(file)
>              self.exprs =3D check_exprs(parser.exprs)
>              self.docs =3D parser.docs
>              self._entity_dict =3D {}
> @@ -1934,7 +1934,7 @@ def common_argument_parser(builtins=3DFalse):
>                          help=3D'output directory')
>      parser.add_argument('-p', '--prefix', default=3D'', type=3Dprefix,
>                          help=3D'prefix to add to output files')
> -    parser.add_argument('schema',
> +    parser.add_argument('schema', type=3Dargparse.FileType('r'),
>                          help=3D'QAPI schema source file')
>      return parser
>
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index fd90d8953e..d95d7541a3 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -282,7 +282,7 @@ def texi_schema(schema):
>  def main(argv):
>      """Takes schema argument, prints result to stdout"""
>      parser =3D argparse.ArgumentParser()
> -    parser.add_argument('schema',
> +    parser.add_argument('schema', type=3Dargparse.FileType('r'),
>                          help=3D'QAPI schema source file')
>      args =3D parser.parse_args()
>
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index a7e21d016f..225417d861 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -53,7 +53,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>                  print '    case %s: %s' % (v.name, v.type.name)
>
>  parser =3D argparse.ArgumentParser()
> -parser.add_argument('schema',
> +parser.add_argument('schema', type=3Dargparse.FileType('r'),
>                      help=3D'QAPI schema source file')
>  args =3D parser.parse_args()
>
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
