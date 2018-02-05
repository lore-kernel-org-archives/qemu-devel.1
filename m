Received: from eggs.gnu.org ([2001:4830:134:3::10]:52333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih58-0000XD-2S
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih53-0002z8-9E
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:14 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih53-0002yM-4a
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:09 -0500
Received: by mail-qt0-f180.google.com with SMTP id t25so6001809qtg.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:45:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-12-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-12-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:45:08 +0100
Message-ID: <CAMxuvazcT3xF-qD0ZTN4TvGoF_R2kvCT2kPZ3w5uBjfni=M8YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 11/21] qapi: Lift error reporting from
 QAPISchema.__init__() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>, mdroth@linux.vnet.ibm.com

On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi-gen.py            |  8 ++++++--
>  scripts/qapi/common.py         | 23 +++++++++--------------
>  tests/qapi-schema/test-qapi.py |  8 +++++++-
>  3 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> index 6302fd0d55..ba82ca92cc 100755
> --- a/scripts/qapi-gen.py
> +++ b/scripts/qapi-gen.py
> @@ -7,7 +7,7 @@
>  import getopt
>  import re
>  import sys
> -from qapi.common import QAPISchema
> +from qapi.common import QAPIError, QAPISchema
>  from qapi.types import gen_types
>  from qapi.visit import gen_visit
>  from qapi.commands import gen_commands
> @@ -77,7 +77,11 @@ def main(argv):
>          if o in ('-u', '--unmask-non-abi-names'):
>              opt_unmask =3D True
>
> -    schema =3D QAPISchema(input_file)
> +    try:
> +        schema =3D QAPISchema(input_file)
> +    except QAPIError as err:
> +        print >>sys.stderr, err
> +        exit(1)
>
>      gen_types(schema, output_dir, prefix, opt_builtins)
>      gen_visit(schema, output_dir, prefix, opt_builtins)
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 78e960d07c..d334e1db5a 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -15,7 +15,6 @@ import errno
>  import os
>  import re
>  import string
> -import sys
>  from ordereddict import OrderedDict
>
>  builtin_types =3D {
> @@ -1455,19 +1454,15 @@ class QAPISchemaEvent(QAPISchemaEntity):
>
>  class QAPISchema(object):
>      def __init__(self, fname):
> -        try:
> -            parser =3D QAPISchemaParser(open(fname, 'r'))
> -            exprs =3D check_exprs(parser.exprs)
> -            self.docs =3D parser.docs
> -            self._entity_dict =3D {}
> -            self._predefining =3D True
> -            self._def_predefineds()
> -            self._predefining =3D False
> -            self._def_exprs(exprs)
> -            self.check()
> -        except QAPIError as err:
> -            print >>sys.stderr, err
> -            exit(1)
> +        parser =3D QAPISchemaParser(open(fname, 'r'))
> +        exprs =3D check_exprs(parser.exprs)
> +        self.docs =3D parser.docs
> +        self._entity_dict =3D {}
> +        self._predefining =3D True
> +        self._def_predefineds()
> +        self._predefining =3D False
> +        self._def_exprs(exprs)
> +        self.check()
>
>      def _def_entity(self, ent):
>          # Only the predefined types are allowed to not have info
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index 7772d09919..d6bb8ec6a4 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -53,7 +53,13 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>              for v in variants.variants:
>                  print '    case %s: %s' % (v.name, v.type.name)
>
> -schema =3D QAPISchema(sys.argv[1])
> +
> +try:
> +    schema =3D QAPISchema(sys.argv[1])
> +except QAPIError as err:
> +    print >>sys.stderr, err
> +    exit(1)
> +
>  schema.visit(QAPISchemaTestVisitor())
>
>  for doc in schema.docs:
> --
> 2.13.6
>
