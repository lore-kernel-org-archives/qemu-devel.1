Received: from eggs.gnu.org ([2001:4830:134:3::10]:52468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih5W-0000tZ-6o
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih5R-0003Sl-8U
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:38 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih5Q-0003S0-Os
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:32 -0500
Received: by mail-qk0-f176.google.com with SMTP id 15so4298548qkl.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:45:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-14-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-14-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:45:31 +0100
Message-ID: <CAMxuvaxUWLrtEq=N7WpPRi1HzhiZFeSiCDZsOjWTF_g9WrP4wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 13/21] qapi: Record 'include'
 directives in parse tree
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
> The parse tree is a list of expressions.  Except include expressions
> currently get replaced by the included file's parse tree.
>
> Instead of throwing away the include expression, keep it with the file
> name expanded so you don't have to track the including file's
> directory to make sense of it.
>
> A future commit will put this include expression to use.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/common.py | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 7a327bfe9f..d5b93e7381 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -286,8 +286,11 @@ class QAPISchemaParser(object):
>                  if not isinstance(include, str):
>                      raise QAPISemError(info,
>                                         "Value of 'include' must be a str=
ing")
> -                exprs_include =3D self._include(include, info,
> -                                              os.path.dirname(self.fname=
),
> +                incl_fname =3D os.path.join(os.path.dirname(self.fname),
> +                                          include)
> +                self.exprs.append({'expr': {'include': incl_fname},
> +                                   'info': info})
> +                exprs_include =3D self._include(include, info, incl_fnam=
e,
>                                                previously_included)
>                  if exprs_include:
>                      self.exprs.extend(exprs_include.exprs)
> @@ -322,8 +325,7 @@ class QAPISchemaParser(object):
>                  "Documentation for '%s' is not followed by the definitio=
n"
>                  % doc.symbol)
>
> -    def _include(self, include, info, base_dir, previously_included):
> -        incl_fname =3D os.path.join(base_dir, include)
> +    def _include(self, include, info, incl_fname, previously_included):
>          incl_abs_fname =3D os.path.abspath(incl_fname)
>          # catch inclusion cycle
>          inf =3D info
> @@ -889,6 +891,9 @@ def check_exprs(exprs):
>          info =3D expr_elem['info']
>          doc =3D expr_elem.get('doc')
>
> +        if 'include' in expr:
> +            continue
> +
>          if not doc and doc_required:
>              raise QAPISemError(info,
>                                 "Expression missing documentation comment=
")
> @@ -927,6 +932,9 @@ def check_exprs(exprs):
>
>      # Try again for hidden UnionKind enum
>      for expr_elem in exprs:
> +        if 'include' in expr:
> +            continue
> +
>          expr =3D expr_elem['expr']
>          if 'union' in expr and not discriminator_find_enum_define(expr):
>              name =3D '%sKind' % expr['union']
> @@ -939,6 +947,9 @@ def check_exprs(exprs):
>
>      # Validate that exprs make sense
>      for expr_elem in exprs:
> +        if 'include' in expr:
> +            continue
> +
>          expr =3D expr_elem['expr']
>          info =3D expr_elem['info']
>          doc =3D expr_elem.get('doc')
> @@ -1663,6 +1674,8 @@ class QAPISchema(object):
>                  self._def_command(expr, info, doc)
>              elif 'event' in expr:
>                  self._def_event(expr, info, doc)
> +            elif 'include' in expr:
> +                pass
>              else:
>                  assert False
>
> --
> 2.13.6
>
