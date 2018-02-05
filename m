Received: from eggs.gnu.org ([2001:4830:134:3::10]:52431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih5R-0000ow-6i
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih5M-0003Nr-3d
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:33 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:41880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih5L-0003NI-Oh
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:27 -0500
Received: by mail-qt0-f172.google.com with SMTP id r13so6148292qtm.8
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:45:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-13-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-13-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:45:26 +0100
Message-ID: <CAMxuvazW5+FzsFPq2+=jyktw+WMabKw0cMtM4N40JRLTz=C_iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 12/21] qapi: Concentrate
 QAPISchemaParser.exprs updates in .__init__()
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

It's not obvious the motivation behind this change (beside behind more
elegant), but
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/common.py | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index d334e1db5a..7a327bfe9f 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -286,8 +286,12 @@ class QAPISchemaParser(object):
>                  if not isinstance(include, str):
>                      raise QAPISemError(info,
>                                         "Value of 'include' must be a str=
ing")
> -                self._include(include, info, os.path.dirname(self.fname)=
,
> -                              previously_included)
> +                exprs_include =3D self._include(include, info,
> +                                              os.path.dirname(self.fname=
),
> +                                              previously_included)
> +                if exprs_include:
> +                    self.exprs.extend(exprs_include.exprs)
> +                    self.docs.extend(exprs_include.docs)
>              elif "pragma" in expr:
>                  self.reject_expr_doc(cur_doc)
>                  if len(expr) !=3D 1:
> @@ -330,14 +334,13 @@ class QAPISchemaParser(object):
>
>          # skip multiple include of the same file
>          if incl_abs_fname in previously_included:
> -            return
> +            return None
> +
>          try:
>              fobj =3D open(incl_fname, 'r')
>          except IOError as e:
>              raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname)=
)
> -        exprs_include =3D QAPISchemaParser(fobj, previously_included, in=
fo)
> -        self.exprs.extend(exprs_include.exprs)
> -        self.docs.extend(exprs_include.docs)
> +        return QAPISchemaParser(fobj, previously_included, info)
>
>      def _pragma(self, name, value, info):
>          global doc_required, returns_whitelist, name_case_whitelist
> --
> 2.13.6
>
