Received: from eggs.gnu.org ([2001:4830:134:3::10]:34268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHR-0002Fn-5w
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHN-0003EK-9h
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33344
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrHN-0003DZ-5N
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:13 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJcoHd102755
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:12 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g84phrgdf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:12 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:11 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-15-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-15-armbru@redhat.com>
Date: Sun, 18 Feb 2018 17:32:15 -0600
Message-Id: <151899673594.12376.17437330615460644069@sif>
Subject: Re: [Qemu-devel] [PATCH v2 14/29] qapi: Concentrate
 QAPISchemaParser.exprs updates in .__init__()
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

Quoting Markus Armbruster (2018-02-11 03:35:52)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> =

> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index dce289ae21..cc5a5941dd 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -290,8 +290,12 @@ class QAPISchemaParser(object):
>                  if not isinstance(include, str):
>                      raise QAPISemError(info,
>                                         "Value of 'include' must be a str=
ing")
> -                self._include(include, info, os.path.dirname(self.fname),
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
> @@ -334,14 +338,13 @@ class QAPISchemaParser(object):
> =

>          # skip multiple include of the same file
>          if incl_abs_fname in previously_included:
> -            return
> +            return None
> +
>          try:
>              fobj =3D open(incl_fname, 'r')
>          except IOError as e:
>              raise QAPISemError(info, '%s: %s' % (e.strerror, incl_fname))
> -        exprs_include =3D QAPISchemaParser(fobj, previously_included, in=
fo)
> -        self.exprs.extend(exprs_include.exprs)
> -        self.docs.extend(exprs_include.docs)

minor nit, but the function of _include() seems more appropriately
described now as _parse_include() or _parse_if_new() or something similar.
Maybe it would be more readable to just move the previously_included
checks into init() and just drop _include() entirely?

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> +        return QAPISchemaParser(fobj, previously_included, info)
> =

>      def _pragma(self, name, value, info):
>          global doc_required, returns_whitelist, name_case_whitelist
> -- =

> 2.13.6
>=20
