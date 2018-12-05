Received: from eggs.gnu.org ([2001:4830:134:3::10]:51558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUa0J-0006e0-80
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUa0H-0008Hl-Mt
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:26:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUa0H-00088S-7w
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:26:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52C7B315487B
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 16:26:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-11-marcandre.lureau@redhat.com>
Date: Wed, 05 Dec 2018 17:26:17 +0100
In-Reply-To: <20180706105753.26700-11-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 6 Jul 2018
	12:57:36 +0200")
Message-ID: <87k1koq6s6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 10/27] qapi: factor out checking for keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Introduce a new helper function to check if the given keys are known,
> and if mandatory keys are present. The function will be reused in
> other places in the following code changes.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index a353670079..8313c478c4 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -873,6 +873,17 @@ def check_struct(expr, info):
>                 allow_metas=3D['struct'])
>=20=20
>=20=20
> +def check_known_keys(info, source, keys, required, optional):
> +    for key in keys:
> +        if key not in required and key not in optional:
> +            raise QAPISemError(info, "Unknown key '%s' in %s" % (key, so=
urce))
> +
> +    for key in required:
> +        if key not in keys:
> +            raise QAPISemError(info, "Key '%s' is missing from %s"
> +                               % (key, source))
> +
> +
>  def check_keys(expr_elem, meta, required, optional=3D[]):
>      expr =3D expr_elem['expr']
>      info =3D expr_elem['info']
> @@ -880,10 +891,9 @@ def check_keys(expr_elem, meta, required, optional=
=3D[]):
>      if not isinstance(name, str):
>          raise QAPISemError(info, "'%s' key must have a string value" % m=
eta)
>      required =3D required + [meta]
> +    source =3D "%s '%s'" % (meta, name)
> +    check_known_keys(info, source, list(expr.keys()), required, optional)

Sure you need list() here?

>      for (key, value) in expr.items():
> -        if key not in required and key not in optional:
> -            raise QAPISemError(info, "Unknown key '%s' in %s '%s'"
> -                               % (key, meta, name))
>          if key in ['gen', 'success-response'] and value is not False:
>              raise QAPISemError(info,
>                                 "'%s' of %s '%s' should only use false va=
lue"
> @@ -895,10 +905,6 @@ def check_keys(expr_elem, meta, required, optional=
=3D[]):
>                                 % (key, meta, name))
>          if key =3D=3D 'if':
>              check_if(expr, info)
> -    for key in required:
> -        if key not in expr:
> -            raise QAPISemError(info, "Key '%s' is missing from %s '%s'"
> -                               % (key, meta, name))
>=20=20
>=20=20
>  def check_exprs(exprs):
