Received: from eggs.gnu.org ([2001:4830:134:3::10]:34365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHV-0002I5-LJ
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHR-0003LE-Q3
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrHR-0003Jo-Gy
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:17 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJd523136717
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:16 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g80r1k6e0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:08 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:08 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-14-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-14-armbru@redhat.com>
Date: Sun, 18 Feb 2018 17:17:05 -0600
Message-Id: <151899582542.12376.4243102437425245839@sif>
Subject: Re: [Qemu-devel] [PATCH v2 13/29] qapi: Lift error reporting from
 QAPISchema.__init__() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Quoting Markus Armbruster (2018-02-11 03:35:51)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  scripts/qapi-gen.py            |  8 ++++++--
>  scripts/qapi/common.py         | 23 +++++++++--------------
>  tests/qapi-schema/test-qapi.py | 10 ++++++++--
>  3 files changed, 23 insertions(+), 18 deletions(-)
> =

> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> index e5be484e3e..fea7d4589b 100755
> --- a/scripts/qapi-gen.py
> +++ b/scripts/qapi-gen.py
> @@ -8,7 +8,7 @@ from __future__ import print_function
>  import argparse
>  import re
>  import sys
> -from qapi.common import QAPISchema
> +from qapi.common import QAPIError, QAPISchema
>  from qapi.types import gen_types
>  from qapi.visit import gen_visit
>  from qapi.commands import gen_commands
> @@ -39,7 +39,11 @@ def main(argv):
>                file=3Dsys.stderr)
>          sys.exit(1)
> =

> -    schema =3D QAPISchema(args.schema)
> +    try:
> +        schema =3D QAPISchema(args.schema)
> +    except QAPIError as err:
> +        print(err, file=3Dsys.stderr)
> +        exit(1)
> =

>      gen_types(schema, args.output_dir, args.prefix, args.builtins)
>      gen_visit(schema, args.output_dir, args.prefix, args.builtins)
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index d72c339ad5..dce289ae21 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -16,7 +16,6 @@ import errno
>  import os
>  import re
>  import string
> -import sys
>  try:
>      from collections import OrderedDict
>  except:
> @@ -1459,19 +1458,15 @@ class QAPISchemaEvent(QAPISchemaEntity):
> =

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
> -            print(err, file=3Dsys.stderr)
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
> =

>      def _def_entity(self, ent):
>          # Only the predefined types are allowed to not have info
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index bb1b6dd297..4da14b43af 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -12,7 +12,7 @@
> =

>  from __future__ import print_function
>  import sys
> -from qapi.common import QAPISchema, QAPISchemaVisitor
> +from qapi.common import QAPIError, QAPISchema, QAPISchemaVisitor
> =

> =

>  class QAPISchemaTestVisitor(QAPISchemaVisitor):
> @@ -52,7 +52,13 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>              for v in variants.variants:
>                  print('    case %s: %s' % (v.name, v.type.name))
> =

> -schema =3D QAPISchema(sys.argv[1])
> +
> +try:
> +    schema =3D QAPISchema(sys.argv[1])
> +except QAPIError as err:
> +    print(err, file=3Dsys.stderr)
> +    exit(1)
> +
>  schema.visit(QAPISchemaTestVisitor())
> =

>  for doc in schema.docs:
> -- =

> 2.13.6
>=20
