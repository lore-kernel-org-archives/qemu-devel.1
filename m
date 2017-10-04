Received: from eggs.gnu.org ([2001:4830:134:3::10]:44817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgkw-0000J1-EI
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgkv-0006oo-DK
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:18:22 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:54852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzgkv-0006oU-7c
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:18:21 -0400
Received: by mail-qt0-x242.google.com with SMTP id i13so18136132qtc.11
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:18:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002141341.24616-5-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
	<20171002141341.24616-5-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:18:20 +0200
Message-ID: <CAJ+F1CJzEMXezgTiey3V=cThkmC1Wz5Dzic6PNb6xAE8fRQBFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/11] qapi: Make cur_doc local to
 QAPISchemaParser.__init__()
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
> QAPISchemaParser.cur_doc is used only by .__init__() and its helper
> .reject_expr_doc().  Make it local to __init__() and pass it to
> .reject_expr_doc() explicitly.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi.py | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 6c8001e96d..2f2738f562 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -272,21 +272,21 @@ class QAPISchemaParser(object):
>          self.line_pos =3D 0
>          self.exprs =3D []
>          self.docs =3D []
> -        self.cur_doc =3D None
>          self.accept()
> +        cur_doc =3D None
>
>          while self.tok is not None:
>              info =3D {'file': self.fname, 'line': self.line,
>                      'parent': self.incl_info}
>              if self.tok =3D=3D '#':
> -                self.reject_expr_doc()
> -                self.cur_doc =3D self.get_doc(info)
> -                self.docs.append(self.cur_doc)
> +                self.reject_expr_doc(cur_doc)
> +                cur_doc =3D self.get_doc(info)
> +                self.docs.append(cur_doc)
>                  continue
>
>              expr =3D self.get_expr(False)
>              if 'include' in expr:
> -                self.reject_expr_doc()
> +                self.reject_expr_doc(cur_doc)
>                  if len(expr) !=3D 1:
>                      raise QAPISemError(info, "Invalid 'include' directiv=
e")
>                  include =3D expr['include']
> @@ -296,7 +296,7 @@ class QAPISchemaParser(object):
>                  self._include(include, info, os.path.dirname(abs_fname),
>                                previously_included)
>              elif "pragma" in expr:
> -                self.reject_expr_doc()
> +                self.reject_expr_doc(cur_doc)
>                  if len(expr) !=3D 1:
>                      raise QAPISemError(info, "Invalid 'pragma' directive=
")
>                  pragma =3D expr['pragma']
> @@ -308,22 +308,22 @@ class QAPISchemaParser(object):
>              else:
>                  expr_elem =3D {'expr': expr,
>                               'info': info}
> -                if self.cur_doc:
> -                    if not self.cur_doc.symbol:
> +                if cur_doc:
> +                    if not cur_doc.symbol:
>                          raise QAPISemError(
> -                            self.cur_doc.info,
> -                            "Expression documentation required")
> -                    expr_elem['doc'] =3D self.cur_doc
> +                            cur_doc.info, "Expression documentation requ=
ired")
> +                    expr_elem['doc'] =3D cur_doc
>                  self.exprs.append(expr_elem)
> -            self.cur_doc =3D None
> -        self.reject_expr_doc()
> +            cur_doc =3D None
> +        self.reject_expr_doc(cur_doc)
>
> -    def reject_expr_doc(self):
> -        if self.cur_doc and self.cur_doc.symbol:
> +    @staticmethod
> +    def reject_expr_doc(doc):
> +        if doc and doc.symbol:
>              raise QAPISemError(
> -                self.cur_doc.info,
> +                doc.info,
>                  "Documentation for '%s' is not followed by the definitio=
n"
> -                % self.cur_doc.symbol)
> +                % doc.symbol)
>
>      def _include(self, include, info, base_dir, previously_included):
>          incl_abs_fname =3D os.path.join(base_dir, include)
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
