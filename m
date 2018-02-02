Received: from eggs.gnu.org ([2001:4830:134:3::10]:48916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehgzx-0002mF-9o
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehgzt-00075Y-NI
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:27:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehgzt-00073j-EK
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:27:41 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-7-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <05068311-b8db-69b0-9c86-50839994f630@redhat.com>
Date: Fri, 2 Feb 2018 13:27:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-7-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Tj1KR3AgdliKCojREjlFbNmwpSDhD4xih"
Subject: Re: [Qemu-devel] [PATCH RFC 06/21] qapi-gen: New common driver for
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tj1KR3AgdliKCojREjlFbNmwpSDhD4xih
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <05068311-b8db-69b0-9c86-50839994f630@redhat.com>
Subject: Re: [PATCH RFC 06/21] qapi-gen: New common driver for code and doc
 generators
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-7-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 07:03 AM, Markus Armbruster wrote:
> Whenever qapi-schema.json changes, we run six programs eleven times to
> update eleven files.  This is silly.  Replace the six programs by a
> single program that spits out all eleven files.

Yay, about time!

One program, but still invoked multiple times:

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  Makefile                                           | 86 ++++++++++----=
--------
>  scripts/qapi-gen.py                                | 41 +++++++++++
>  scripts/qapi/__init__.py                           |  0
>  scripts/{qapi-commands.py =3D> qapi/commands.py}     | 23 ++----
>  scripts/{qapi.py =3D> qapi/common.py}                |  0
>  scripts/{qapi2texi.py =3D> qapi/doc.py}              | 29 ++------
>  scripts/{qapi-event.py =3D> qapi/events.py}          | 23 ++----
>  scripts/{qapi-introspect.py =3D> qapi/introspect.py} | 32 ++------
>  scripts/{qapi-types.py =3D> qapi/types.py}           | 34 ++-------
>  scripts/{qapi-visit.py =3D> qapi/visit.py}           | 34 ++-------

Maybe the commit message should mention:

This requires moving some files around for proper use in python.

>  tests/Makefile.include                             | 56 +++++++-------=

>  tests/qapi-schema/test-qapi.py                     |  2 +-
>  12 files changed, 140 insertions(+), 220 deletions(-)
>  create mode 100755 scripts/qapi-gen.py
>  create mode 100644 scripts/qapi/__init__.py
>  rename scripts/{qapi-commands.py =3D> qapi/commands.py} (94%)
>  rename scripts/{qapi.py =3D> qapi/common.py} (100%)
>  rename scripts/{qapi2texi.py =3D> qapi/doc.py} (92%)
>  mode change 100755 =3D> 100644

Unintinentional?  We're inconsistent on which of our *.py files are
executable in git.  Does it matter whether a file that is designed for
use as a module is marked executable (if so, perhaps 5/21 should be
adding the x attribute on other files, rather than this patch removing
it on the doc generator).

> +++ b/Makefile

> +qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.=
h \
> +qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.=
h \
> +qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marsh=
al.c \
> +qga/qapi-generated/qga-qapi.texi: \
> +qga/qapi-generated/qapi-gen-timestamp ;
> +qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.jso=
n $(qapi-py)
> +	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
> +		-o qga/qapi-generated -p "qga-" $<, \
> +		"GEN","$(@:%-timestamp=3D%)")
> +	@>$@

once for qga,


> +qapi-types.c qapi-types.h \
> +qapi-visit.c qapi-visit.h \
> +qmp-commands.h qmp-marshal.c \
> +qapi-event.c qapi-event.h \
> +qmp-introspect.h qmp-introspect.c \
> +qapi.texi: \
> +qapi-gen-timestamp ;
> +qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
> +	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
> +		-o "." -b $<, \
> +		"GEN","$(@:%-timestamp=3D%)")
> +	@>$@

and again for the main level.  Still, a definite improvement!

> +++ b/scripts/qapi-gen.py

> +def main(argv):
> +    (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
> +        parse_command_line('bu', ['builtins', 'unmask-non-abi-names'])=

> +
> +    opt_builtins =3D False
> +    opt_unmask =3D False
> +
> +    for o, a in opts:
> +        if o in ('-b', '--builtins'):
> +            opt_builtins =3D True
> +        if o in ('-u', '--unmask-non-abi-names'):
> +            opt_unmask =3D True
> +
> +    schema =3D QAPISchema(input_file)
> +
> +    gen_types(schema, output_dir, prefix, opt_builtins)
> +    gen_visit(schema, output_dir, prefix, opt_builtins)
> +    gen_commands(schema, output_dir, prefix)
> +    gen_events(schema, output_dir, prefix)
> +    gen_introspect(schema, output_dir, prefix, opt_unmask)
> +    gen_doc(schema, output_dir, prefix)

Rather simple, but definitely nicer all in one python file than as a
series of make rules.

> @@ -255,13 +255,8 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisito=
r):
>          self._regy +=3D gen_register_command(name, success_response)
> =20
> =20
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

Some churn on the definition of blurb; worth tidying this in the
introduction earlier in the series?

> rename to scripts/qapi/introspect.py
> index 09e7d1f140..2153060f2c 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -10,7 +10,7 @@ This work is licensed under the terms of the GNU GPL,=
 version 2.
>  See the COPYING file in the top-level directory.
>  """
> =20
> -from qapi import *
> +from qapi.common import *
> =20
> =20
>  # Caveman's json.dumps() replacement (we're stuck at Python 2.4)
> @@ -168,22 +168,8 @@ const char %(c_name)s[] =3D %(c_string)s;
>          self._gen_json(name, 'event', {'arg-type': self._use_type(arg_=
type)})
> =20
> =20
> -def main(argv):
> -    # Debugging aid: unmask QAPI schema's type names
> -    # We normally mask them, because they're not QMP wire ABI
> -    opt_unmask =3D False
> -
> -    (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
> -        parse_command_line('u', ['unmask-non-abi-names'])

Hmm - we didn't have any docs about this hidden command line option; I
see you still preserved it, but it may be worth mentioning in your
pending doc updates for the series respin.

> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -23,7 +23,16 @@ check-help:
>  ifneq ($(wildcard config-host.mak),)
>  export SRC_PATH
> =20
> -qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddic=
t.py
> +# TODO don't duplicate $(SRC_PATH)/Makefile's qapi-py here
> +qapi-py =3D $(SRC_PATH)/scripts/qapi/commands.py \
> +$(SRC_PATH)/scripts/qapi/events.py \
> +$(SRC_PATH)/scripts/qapi/introspect.py \
> +$(SRC_PATH)/scripts/qapi/types.py \
> +$(SRC_PATH)/scripts/qapi/visit.py \
> +$(SRC_PATH)/scripts/qapi/common.py \
> +$(SRC_PATH)/scripts/qapi/doc.py \
> +$(SRC_PATH)/scripts/ordereddict.py \
> +$(SRC_PATH)/scripts/qapi-gen.py

So, were you counting these in the 11 generated files mentioned in the
commit message? :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Tj1KR3AgdliKCojREjlFbNmwpSDhD4xih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0u6UACgkQp6FrSiUn
Q2r5xQgAqmPrCGImrrbUFNzAh3NcctpzuvLUIqmk0iPQZC5gpR3hMHYUGHt3837t
a3q3DMNbbsWQ76Yw8R2Dg2WglAjH4wTTkOSlGJtHMTiRc4wnKb3ImwOgUzBZXAqE
qjRhkjyg0x78HDvkukbVICBk8tTgNg9yvuzrKlH/t5phk+vfoijkPNWgaWTFng+f
9RLjiH561So26f2jdoc9NrB2j57XC/hW1iSbt+IuzCBTru+vUHiZMPzaItxL4nXz
y7FQKRdQSeyIvFiMoXWF+RHWg0oJ5uoZaZbPtry3dKL+ZacUEpn1/mU4lpPGNCZs
JULkQ5ovcA2qJM2e6YFVIm1lCnz9+w==
=hIg9
-----END PGP SIGNATURE-----

--Tj1KR3AgdliKCojREjlFbNmwpSDhD4xih--
