Received: from eggs.gnu.org ([2001:4830:134:3::10]:43610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl7yw-0002e5-LA
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl7yt-00009E-Em
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:20:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dl7yt-00008m-8q
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:20:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 107D35D68C
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 06:20:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
	<20170824103350.16400-5-marcandre.lureau@redhat.com>
Date: Fri, 25 Aug 2017 08:20:29 +0200
In-Reply-To: <20170824103350.16400-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 24 Aug 2017 12:33:40 +0200")
Message-ID: <87valc2moi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/14] qlit: remove needless type cast
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

> And misc code style fix.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> index f36bca4554..1e9696988a 100644
> --- a/include/qapi/qmp/qlit.h
> +++ b/include/qapi/qmp/qlit.h
> @@ -36,13 +36,13 @@ struct QLitDictEntry {
>  };
>=20=20
>  #define QLIT_QNUM(val) \
> -    (QLitObject){.type =3D QTYPE_QNUM, .value.qnum =3D (val)}
> +    { .type =3D QTYPE_QNUM, .value.qnum =3D (val) }
>  #define QLIT_QSTR(val) \
> -    (QLitObject){.type =3D QTYPE_QSTRING, .value.qstr =3D (val)}
> +    { .type =3D QTYPE_QSTRING, .value.qstr =3D (val) }
>  #define QLIT_QDICT(val) \
> -    (QLitObject){.type =3D QTYPE_QDICT, .value.qdict =3D (val)}
> +    { .type =3D QTYPE_QDICT, .value.qdict =3D (val) }
>  #define QLIT_QLIST(val) \
> -    (QLitObject){.type =3D QTYPE_QLIST, .value.qlist =3D (val)}
> +    { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
>=20=20
>  int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs);

Technically, this isn't a type cast, it's a compound literal.  A
compound literal is "an unnamed object whose value is given by the
initializer list" (C99 =C2=A76.5.2.5).  The standard then cautions "that th=
is
differs from a cast expression" (ibid).

The previous paragraph probably makes sense only to language-lawyers, so
let's consider an example.

The macro

   #define QLIT_QSTR(val) \
       (QLitObject){.type =3D QTYPE_QSTRING, .value.qstr =3D (val)}

expands into a compound literal of type QLitObject, which can be used as
an initializer for a variable of type QLitObject.

The macro

   #define QLIT_QSTR(val) \
       { .type =3D QTYPE_QSTRING, .value.qstr =3D (val) }

expands into something that can be used as an initializer for a variable
of *any* structure type with suitable members.  Duck typing, if you
will.

The original author's choice of compound literals is clearly
intentional.  I'd prefer to respect it unless there's a compelling
reason not to.
