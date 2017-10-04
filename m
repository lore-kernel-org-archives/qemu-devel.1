Received: from eggs.gnu.org ([2001:4830:134:3::10]:51560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzh3e-0006GP-AN
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzh3d-00024h-9Q
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:37:42 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:54603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzh3d-00023Q-4J
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:37:41 -0400
Received: by mail-oi0-x241.google.com with SMTP id u130so18845024oib.11
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:37:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-2-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-2-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:37:38 +0200
Message-ID: <CAJ+F1CKcHRaj5_8DsDvAX+UJeet1u10gnPzL1UH=XLwfe4nmHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 01/32] tests/qapi-schema: Improve
 coverage of '@'
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
> Demonstrates a qapi2texi.py bug: it can fail to escape '@'.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/qapi-schema/doc-good.json | 3 +++
>  tests/qapi-schema/doc-good.out  | 3 +++
>  tests/qapi-schema/doc-good.texi | 4 ++++
>  3 files changed, 10 insertions(+)
>
> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good=
.json
> index 97ab4625ff..44098d7f1a 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -10,6 +10,7 @@
>  #
>  # *strong* _with emphasis_
>  # @var {in braces}
> +# lone @ BUG: gets passed to Texinfo unescaped
>  # * List item one
>  # - Two, multiple
>  #   lines
> @@ -46,6 +47,7 @@
>  # <- out
>  # Examples:
>  # - *verbatim*
> +# - @at sign
>  # - {braces}
>  ##
>
> @@ -115,6 +117,7 @@
>  # <- out
>  # Examples:
>  # - *verbatim*
> +# - @at sign BUG: gets passed to Texinfo unescaped
>  # - {braces}
>  # Since: 2.10
>  ##
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
> index 1d2c250527..b732b81119 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -38,6 +38,7 @@ doc freeform
>
>  *strong* _with emphasis_
>  @var {in braces}
> +lone @ BUG: gets passed to Texinfo unescaped
>  * List item one
>  - Two, multiple
>  lines
> @@ -74,6 +75,7 @@ Example:
>  <- out
>  Examples:
>  - *verbatim*
> +- @at sign
>  - {braces}
>  doc symbol=3DEnum
>      body=3D
> @@ -136,6 +138,7 @@ Duis aute irure dolor
>  <- out
>      section=3DExamples
>  - *verbatim*
> +- @at sign BUG: gets passed to Texinfo unescaped
>  - {braces}
>      section=3DSince
>  2.10
> diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good=
.texi
> index 1778312581..840a492249 100644
> --- a/tests/qapi-schema/doc-good.texi
> +++ b/tests/qapi-schema/doc-good.texi
> @@ -4,6 +4,7 @@
>
>  @strong{strong} @emph{with emphasis}
>  @code{var} @{in braces@}
> +lone @ BUG: gets passed to Texinfo unescaped
>  @itemize @bullet
>  @item
>  List item one
> @@ -69,6 +70,8 @@ Examples:
>  @item
>  @strong{verbatim}
>  @item
> +@code{at} sign
> +@item
>  @{braces@}
>  @end itemize
>
> @@ -206,6 +209,7 @@ Duis aute irure dolor
>  @b{Examples:}
>  @example
>  - *verbatim*
> +- @at sign BUG: gets passed to Texinfo unescaped
>  - @{braces@}
>  @end example
>
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
