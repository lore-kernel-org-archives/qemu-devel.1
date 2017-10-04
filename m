Received: from eggs.gnu.org ([2001:4830:134:3::10]:47751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgsr-0006G0-VQ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgsr-0005h8-0L
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:26:33 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:53632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzgsq-0005gW-Re
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:26:32 -0400
Received: by mail-oi0-x241.google.com with SMTP id j126so18794489oia.10
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:26:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002141341.24616-8-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
	<20171002141341.24616-8-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:26:30 +0200
Message-ID: <CAJ+F1CKrC5YQCfaETzdKKzMDLQbN-pDHN2eiE=ygUNTN0=ajVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/11] qapi: Unify representation of doc
 section without name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Mon, Oct 2, 2017 at 4:13 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> We have two representations of sections without a name: the main
> section uses name=3DNone, the others name=3D''.  Standardize on name=3DNo=
ne.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

> ---
>  scripts/qapi.py                       | 2 +-
>  scripts/qapi2texi.py                  | 2 +-
>  tests/qapi-schema/doc-bad-section.out | 2 +-
>  tests/qapi-schema/doc-good.out        | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 2f2738f562..2137067b48 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -204,7 +204,7 @@ class QAPIDoc(object):
>          self.section =3D QAPIDoc.ArgSection(name)
>          self.args[name] =3D self.section
>
> -    def _start_section(self, name=3D''):
> +    def _start_section(self, name=3DNone):
>          if name in ('Returns', 'Since') and self.has_section(name):
>              raise QAPIParseError(self.parser,
>                                   "Duplicated '%s' section" % name)
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index f876d9a174..f16fa1ba53 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -184,7 +184,7 @@ def texi_sections(doc):
>              # prefer @b over @strong, so txt doesn't translate it to *Fo=
o:*
>              body +=3D '\n\n@b{%s:}\n' % section.name
>          text =3D str(section)
> -        if section.name.startswith('Example'):
> +        if section.name and section.name.startswith('Example'):
>              body +=3D texi_example(text)
>          else:
>              body +=3D texi_format(text)
> diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/do=
c-bad-section.out
> index 6fce84dd34..089bde1381 100644
> --- a/tests/qapi-schema/doc-bad-section.out
> +++ b/tests/qapi-schema/doc-bad-section.out
> @@ -9,5 +9,5 @@ doc symbol=3DEnum
>  The _one_ {and only}
>      arg=3Dtwo
>
> -    section=3D
> +    section=3DNone
>  @two is undocumented
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
> index c55e394e8a..1d2c250527 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -82,7 +82,7 @@ doc symbol=3DEnum
>  The _one_ {and only}
>      arg=3Dtwo
>
> -    section=3D
> +    section=3DNone
>  @two is undocumented
>  doc symbol=3DBase
>      body=3D
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
