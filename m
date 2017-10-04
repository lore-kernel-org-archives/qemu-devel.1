Received: from eggs.gnu.org ([2001:4830:134:3::10]:47441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dziKP-0001je-Fg
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dziKL-0004Ag-IC
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:59:05 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:48152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dziKL-0004AU-Co
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:59:01 -0400
Received: by mail-oi0-x243.google.com with SMTP id m198so6720544oig.5
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 04:59:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-20-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-20-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 13:58:59 +0200
Message-ID: <CAJ+F1CJYd4LqyPtkmr40tnCKhDV63urnAhUgkX=M++njtPmgYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 19/32] qapi: Accept double-quoted
 strings
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
> The QAPI schema parser has always accepted only single-quoted strings,
> even though JSON strings are double-quoted.  Accept double-quoted
> strings as well, so you can write strings containing single quotes
> without backslash escapes.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

What's the motivation to allow both? If we were to switch from single
to double quote only, that would make more sense.
otherwise, patch looks good

> ---
>  docs/devel/qapi-code-gen.txt            | 2 +-
>  scripts/qapi.py                         | 8 +++++---
>  tests/qapi-schema/qapi-schema-test.json | 2 +-
>  3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 3186c36460..835c641ea8 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -32,7 +32,7 @@ differences:
>
>  * No JSON numbers
>
> -* Strings use 'single quotes' instead of "double quotes"
> +* Strings can use 'single quotes' in addition to "double quotes"
>
>  * The input character set is plain ASCII
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 477402b7f8..18c8175866 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -382,14 +382,15 @@ class QAPISchemaParser(object):
>                      return
>              elif self.tok in '{}:,[]':
>                  return
> -            elif self.tok =3D=3D "'":
> +            elif self.tok =3D=3D "'" or self.tok =3D=3D '"':
>                  string =3D ''
>                  esc =3D False
>                  while True:
>                      ch =3D self.src[self.cursor]
>                      self.cursor +=3D 1
>                      if ch =3D=3D '\n':
> -                        raise QAPIParseError(self, 'Missing terminating =
"\'"')
> +                        raise QAPIParseError(
> +                            self, 'Missing terminating %r' % self.tok)
>                      if esc:
>                          if ch =3D=3D 'b':
>                              string +=3D '\b'
> @@ -429,8 +430,9 @@ class QAPISchemaParser(object):
>                          esc =3D False
>                      elif ch =3D=3D '\\':
>                          esc =3D True
> -                    elif ch =3D=3D "'":
> +                    elif ch =3D=3D self.tok:
>                          self.val =3D string
> +                        self.tok =3D "'"
>                          return
>                      else:
>                          string +=3D ch
> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
> index ac8aefc924..c74d5632a5 100644
> --- a/tests/qapi-schema/qapi-schema-test.json
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -11,7 +11,7 @@
>          'guest-sync' ] } }
>
>  { 'struct': 'TestStruct',
> -  'data': { 'integer': 'int', 'boolean': 'bool', 'string': 'str' } }
> +  'data': { 'integer': 'int', 'boolean': 'bool', 'string': "str" } }
>
>  # for testing enums
>  { 'struct': 'NestedEnumsOne',
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
