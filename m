Received: from eggs.gnu.org ([2001:4830:134:3::10]:55406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhDN-0005aK-36
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhDM-0003fr-4j
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:47:45 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:32931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzhDL-0003fN-VH
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:47:44 -0400
Received: by mail-oi0-x244.google.com with SMTP id n129so6839318oia.0
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:47:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-5-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-5-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:47:42 +0200
Message-ID: <CAJ+F1CJWegxw4DLPUkoUybNPR8-hLx5PRsn8F8OL3-eTm-JZZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 04/32] qapi2texi: Fix for '@' not
 followed by \w character
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
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi2texi.py            | 22 ++++++++++++----------
>  tests/qapi-schema/doc-good.json |  2 +-
>  tests/qapi-schema/doc-good.out  |  2 +-
>  tests/qapi-schema/doc-good.texi |  2 +-
>  4 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 1500afc553..cfcd8a19f0 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -41,14 +41,17 @@ def subst_emph(doc):
>      return re.sub(r'\b_([^_\n]+)_\b', r'@emph{\1}', doc)
>
>
> -def subst_vars(doc):
> -    """Replaces @var by @code{var}"""
> -    return re.sub(r'@([\w-]+)', r'@code{\1}', doc)
> -
> -
> -def subst_braces(doc):
> -    """Replaces {} with @{ @}"""
> -    return doc.replace('{', '@{').replace('}', '@}')
> +def subst_special(doc):
> +    ret =3D ''
> +    for m in re.finditer(r'([^@{}]*)(@([-\w]*)|[{}])?', doc):
> +        ret +=3D m.group(1)
> +        if m.group(3):
> +            # format @NAME as @code{NAME}
> +            ret +=3D '@code{' + m.group(3) + '}'
> +        elif m.group(2):
> +            # escape Texinfo's special characters
> +            ret +=3D '@' + m.group(2)
> +    return ret
>
>
>  def texi_example(doc):
> @@ -71,8 +74,7 @@ def texi_format(doc):
>      - */-: generates an @itemize list
>      """
>      ret =3D ''
> -    doc =3D subst_braces(doc)
> -    doc =3D subst_vars(doc)
> +    doc =3D subst_special(doc)
>      doc =3D subst_emph(doc)
>      doc =3D subst_strong(doc)
>      inlist =3D ''
> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
> index 54a0012d5f..274004a8b6 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -10,7 +10,7 @@
>  #
>  # *strong* _with emphasis_
>  # @var {in braces}
> -# lone @ BUG: gets passed to Texinfo unescaped
> +# lone @
>  # * List item one
>  # - Two, multiple
>  #   lines
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
> index a62d2d879c..46261d5010 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -38,7 +38,7 @@ doc freeform
>
>  *strong* _with emphasis_
>  @var {in braces}
> -lone @ BUG: gets passed to Texinfo unescaped
> +lone @
>  * List item one
>  - Two, multiple
>  lines
> diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
> index 3b77f2f675..8777cbb7fb 100644
> --- a/tests/qapi-schema/doc-good.texi
> +++ b/tests/qapi-schema/doc-good.texi
> @@ -4,7 +4,7 @@
>
>  @strong{strong} @emph{with emphasis}
>  @code{var} @{in braces@}
> -lone @ BUG: gets passed to Texinfo unescaped
> +lone @@
>  @itemize @bullet
>  @item
>  List item one
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
