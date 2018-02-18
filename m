Received: from eggs.gnu.org ([2001:4830:134:3::10]:34301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHS-0002Fx-Jc
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHO-0003Gm-LW
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33318
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrHO-0003FN-8B
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:14 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJcejx067995
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:13 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g820yyf7w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:13 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:12 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-16-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-16-armbru@redhat.com>
Date: Sun, 18 Feb 2018 17:57:12 -0600
Message-Id: <151899823299.12376.14441267959518289640@sif>
Subject: Re: [Qemu-devel] [PATCH v2 15/29] qapi: Record 'include' directives
 in parse tree
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

Quoting Markus Armbruster (2018-02-11 03:35:53)
> The parse tree is a list of expressions.  Except include expressions
> currently get replaced by the included file's parse tree.
> =

> Instead of throwing away the include expression, keep it with the file
> name expanded so you don't have to track the including file's
> directory to make sense of it.
> =

> A future commit will put this include expression to use.
> =

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> =

> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index cc5a5941dd..6d49709784 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -290,8 +290,11 @@ class QAPISchemaParser(object):
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
> @@ -326,8 +329,7 @@ class QAPISchemaParser(object):
>                  "Documentation for '%s' is not followed by the definitio=
n"
>                  % doc.symbol)
> =

> -    def _include(self, include, info, base_dir, previously_included):
> -        incl_fname =3D os.path.join(base_dir, include)
> +    def _include(self, include, info, incl_fname, previously_included):
>          incl_abs_fname =3D os.path.abspath(incl_fname)
>          # catch inclusion cycle
>          inf =3D info
> @@ -893,6 +895,9 @@ def check_exprs(exprs):
>          info =3D expr_elem['info']
>          doc =3D expr_elem.get('doc')
> =

> +        if 'include' in expr:
> +            continue
> +
>          if not doc and doc_required:
>              raise QAPISemError(info,
>                                 "Expression missing documentation comment=
")
> @@ -931,6 +936,9 @@ def check_exprs(exprs):
> =

>      # Try again for hidden UnionKind enum
>      for expr_elem in exprs:
> +        if 'include' in expr:
> +            continue
> +

Wouldn't this ^

>          expr =3D expr_elem['expr']

Need to come after this?

>          if 'union' in expr and not discriminator_find_enum_define(expr):
>              name =3D '%sKind' % expr['union']
> @@ -943,6 +951,9 @@ def check_exprs(exprs):
> =

>      # Validate that exprs make sense
>      for expr_elem in exprs:
> +        if 'include' in expr:
> +            continue
> +
>          expr =3D expr_elem['expr']

And here.

>          info =3D expr_elem['info']
>          doc =3D expr_elem.get('doc')
> @@ -1667,6 +1678,8 @@ class QAPISchema(object):
>                  self._def_command(expr, info, doc)
>              elif 'event' in expr:
>                  self._def_event(expr, info, doc)
> +            elif 'include' in expr:
> +                pass
>              else:
>                  assert False
> =

> -- =

> 2.13.6
>=20
