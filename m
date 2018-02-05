Received: from eggs.gnu.org ([2001:4830:134:3::10]:52297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih51-0000Mv-VW
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih4x-0002s5-3e
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:08 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih4w-0002rg-Tg
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:03 -0500
Received: by mail-qt0-f193.google.com with SMTP id d8so39578125qtm.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:45:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-8-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-8-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:45:01 +0100
Message-ID: <CAMxuvaxBg4nxVaKJR_tzChS4kRQXOWMSzk7pKAwOotyefYyuJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 07/21] qapi: Move parse_command_line()
 next to its only use
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
>  scripts/qapi-gen.py    | 52 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
>  scripts/qapi/common.py | 54 --------------------------------------------=
------
>  2 files changed, 51 insertions(+), 55 deletions(-)
>
> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> index 575c938a1b..6302fd0d55 100755
> --- a/scripts/qapi-gen.py
> +++ b/scripts/qapi-gen.py
> @@ -4,8 +4,10 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
>  # See the COPYING file in the top-level directory.
>
> +import getopt
> +import re
>  import sys
> -from qapi.common import parse_command_line, QAPISchema
> +from qapi.common import QAPISchema
>  from qapi.types import gen_types
>  from qapi.visit import gen_visit
>  from qapi.commands import gen_commands
> @@ -14,6 +16,54 @@ from qapi.introspect import gen_introspect
>  from qapi.doc import gen_doc
>
>
> +def parse_command_line(extra_options=3D'', extra_long_options=3D[]):
> +
> +    try:
> +        opts, args =3D getopt.gnu_getopt(sys.argv[1:],
> +                                       'chp:o:' + extra_options,
> +                                       ['source', 'header', 'prefix=3D',
> +                                        'output-dir=3D'] + extra_long_op=
tions)
> +    except getopt.GetoptError as err:
> +        print >>sys.stderr, "%s: %s" % (sys.argv[0], str(err))
> +        sys.exit(1)
> +
> +    output_dir =3D ''
> +    prefix =3D ''
> +    do_c =3D False
> +    do_h =3D False
> +    extra_opts =3D []
> +
> +    for oa in opts:
> +        o, a =3D oa
> +        if o in ('-p', '--prefix'):
> +            match =3D re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
> +            if match.end() !=3D len(a):
> +                print >>sys.stderr, \
> +                    "%s: 'funny character '%s' in argument of --prefix" =
\
> +                    % (sys.argv[0], a[match.end()])
> +                sys.exit(1)
> +            prefix =3D a
> +        elif o in ('-o', '--output-dir'):
> +            output_dir =3D a + '/'
> +        elif o in ('-c', '--source'):
> +            do_c =3D True
> +        elif o in ('-h', '--header'):
> +            do_h =3D True
> +        else:
> +            extra_opts.append(oa)
> +
> +    if not do_c and not do_h:
> +        do_c =3D True
> +        do_h =3D True
> +
> +    if len(args) !=3D 1:
> +        print >>sys.stderr, "%s: need exactly one argument" % sys.argv[0=
]
> +        sys.exit(1)
> +    fname =3D args[0]
> +
> +    return (fname, output_dir, do_c, do_h, prefix, extra_opts)
> +
> +
>  def main(argv):
>      (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
>          parse_command_line('bu', ['builtins', 'unmask-non-abi-names'])
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index d73ef618e2..cfa2671ca3 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -12,7 +12,6 @@
>  # See the COPYING file in the top-level directory.
>
>  import errno
> -import getopt
>  import os
>  import re
>  import string
> @@ -1917,59 +1916,6 @@ def build_params(arg_type, boxed, extra):
>
>
>  #
> -# Common command line parsing
> -#
> -
> -
> -def parse_command_line(extra_options=3D'', extra_long_options=3D[]):
> -
> -    try:
> -        opts, args =3D getopt.gnu_getopt(sys.argv[1:],
> -                                       'chp:o:' + extra_options,
> -                                       ['source', 'header', 'prefix=3D',
> -                                        'output-dir=3D'] + extra_long_op=
tions)
> -    except getopt.GetoptError as err:
> -        print >>sys.stderr, "%s: %s" % (sys.argv[0], str(err))
> -        sys.exit(1)
> -
> -    output_dir =3D ''
> -    prefix =3D ''
> -    do_c =3D False
> -    do_h =3D False
> -    extra_opts =3D []
> -
> -    for oa in opts:
> -        o, a =3D oa
> -        if o in ('-p', '--prefix'):
> -            match =3D re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
> -            if match.end() !=3D len(a):
> -                print >>sys.stderr, \
> -                    "%s: 'funny character '%s' in argument of --prefix" =
\
> -                    % (sys.argv[0], a[match.end()])
> -                sys.exit(1)
> -            prefix =3D a
> -        elif o in ('-o', '--output-dir'):
> -            output_dir =3D a + '/'
> -        elif o in ('-c', '--source'):
> -            do_c =3D True
> -        elif o in ('-h', '--header'):
> -            do_h =3D True
> -        else:
> -            extra_opts.append(oa)
> -
> -    if not do_c and not do_h:
> -        do_c =3D True
> -        do_h =3D True
> -
> -    if len(args) !=3D 1:
> -        print >>sys.stderr, "%s: need exactly one argument" % sys.argv[0=
]
> -        sys.exit(1)
> -    fname =3D args[0]
> -
> -    return (fname, output_dir, do_c, do_h, prefix, extra_opts)
> -
> -
> -#
>  # Accumulate and write output
>  #
>
> --
> 2.13.6
>
