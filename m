Received: from eggs.gnu.org ([2001:4830:134:3::10]:42187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIysO-0006DH-1o
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIysK-00043v-TT
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:57:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIysK-000436-Nj
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:57:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94B6BC04BD30
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 14:57:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-6-marcandre.lureau@redhat.com>
Date: Thu, 08 Jun 2017 16:57:23 +0200
In-Reply-To: <20170607163635.17635-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 7 Jun 2017 20:35:57 +0400")
Message-ID: <871squ7cj0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/43] qapi: minor refactoring
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

Lets title this

    qapi: Clean up qobject_input_type_number() control flow

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Use the more common pattern to error out.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/qobject-input-visitor.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index eac40f618a..26ef49a60b 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -547,13 +547,13 @@ static void qobject_input_type_number(Visitor *v, c=
onst char *name, double *obj,
>      }
>=20=20
>      qfloat =3D qobject_to_qfloat(qobj);
> -    if (qfloat) {
> -        *obj =3D qfloat_get_double(qobject_to_qfloat(qobj));
> +    if (!qfloat) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
> +                   full_name(qiv, name), "number");
>          return;
>      }
>=20=20
> -    error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
> -               full_name(qiv, name), "number");
> +    *obj =3D qfloat_get_double(qobject_to_qfloat(qobj));
>  }
>=20=20
>  static void qobject_input_type_number_keyval(Visitor *v, const char *nam=
e,

Preferably with the more descriptive commit message
Reviewed-by: Markus Armbruster <armbru@redhat.com>
