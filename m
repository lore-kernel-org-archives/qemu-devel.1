Received: from eggs.gnu.org ([2001:4830:134:3::10]:54524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhBI-00044S-Lb
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhBH-0001sC-KC
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:45:36 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzhBH-0001rj-Eu
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:45:35 -0400
Received: by mail-oi0-x242.google.com with SMTP id p187so4297761oif.3
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:45:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-4-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-4-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:45:33 +0200
Message-ID: <CAJ+F1C+cdqMjssd3VJ+0Yk1yufiyEV4=pJf8fnJR3=dh3KT5GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 03/32] qapi2texi: Fix for examples
 containing '@'
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

Hi

On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Instead of quoting example text so that the @example environment shows
> it verbatim, simply use the @verbatim environment.
>

Not sure if this is really worth it, unless we have a real use-case of
@ in examples.

> Examples are no longer indented in output, because makeinfo doesn't
> indent @verbatim, unlike @example.
> TODO keep indentation somehow?
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi2texi.py            | 12 +++++-------
>  tests/qapi-schema/doc-good.json |  2 +-
>  tests/qapi-schema/doc-good.out  |  2 +-
>  tests/qapi-schema/doc-good.texi | 16 ++++++++--------
>  4 files changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 92e2af2cd6..1500afc553 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -52,13 +52,11 @@ def subst_braces(doc):
>
>
>  def texi_example(doc):
> -    """Format @example"""
> -    # TODO: Neglects to escape @ characters.
> -    # We should probably escape them in subst_braces(), and rename the
> -    # function to subst_special() or subs_texi_special().  If we do that=
, we
> -    # need to delay it until after subst_vars() in texi_format().
> -    doc =3D subst_braces(doc).strip('\n')
> -    return EXAMPLE_FMT(code=3Ddoc)
> +    """Format example text"""
> +    return """@verbatim
> +{code}
> +@end verbatim
> +""".format(code=3Ddoc.strip('\n'))
>
>
>  def texi_format(doc):
> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
> index 44098d7f1a..54a0012d5f 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -117,7 +117,7 @@
>  # <- out
>  # Examples:
>  # - *verbatim*
> -# - @at sign BUG: gets passed to Texinfo unescaped
> +# - @at sign
>  # - {braces}
>  # Since: 2.10
>  ##
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
> index b732b81119..a62d2d879c 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -138,7 +138,7 @@ Duis aute irure dolor
>  <- out
>      section=3DExamples
>  - *verbatim*
> -- @at sign BUG: gets passed to Texinfo unescaped
> +- @at sign
>  - {braces}
>      section=3DSince
>  2.10
> diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
> index 840a492249..3b77f2f675 100644
> --- a/tests/qapi-schema/doc-good.texi
> +++ b/tests/qapi-schema/doc-good.texi
> @@ -201,17 +201,17 @@ Ut enim ad minim veniam
>  Duis aute irure dolor
>
>  @b{Example:}
> -@example
> +@verbatim
>  -> in
>  <- out
> -@end example
> +@end verbatim
>
>  @b{Examples:}
> -@example
> +@verbatim
>  - *verbatim*
> -- @at sign BUG: gets passed to Texinfo unescaped
> -- @{braces@}
> -@end example
> +- @at sign
> +- {braces}
> +@end verbatim
>
>  @b{Since:}
>  2.10
> @@ -227,11 +227,11 @@ If you're bored enough to read this, go see a video=
 of boxed cats
>  @b{Arguments:} the members of @code{Object}
>
>  @b{Example:}
> -@example
> +@verbatim
>  -> in
>
>  <- out
> -@end example
> +@end verbatim
>
>  @end deftypefn
>
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
