Received: from eggs.gnu.org ([2001:4830:134:3::10]:51715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f92mp-0005nr-4A
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f92ml-0003IX-Vk
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:11:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49028 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f92ml-0003I5-R2
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:11:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69361EAEAB
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:11:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-3-marcandre.lureau@redhat.com>
Date: Thu, 19 Apr 2018 08:11:08 +0200
In-Reply-To: <20180417133602.23832-3-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 17 Apr 2018 15:35:59 +0200")
Message-ID: <87d0yvybcz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/5] qobject: use a QObjectBase_ struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

In addition to Eric's comments...

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> By moving the base fields to a QObjectBase_, QObject can be a type
> which also has a 'base' field. This allows to write a generic
> QOBJECT() macro that will work with any QObject type, including
> QObject itself. The container_of() macro ensures that the object to
> cast has a QObjectBase_ base field, giving some type safety
> guarantees. QObject must have no members but QObjectBase_ base, or
> else QOBJECT() breaks.
>
> QObjectBase_ is not typedef and use a trailing underscore to make it
> obvious it is not for normal use and to avoid potential abuse.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
> index 5206ff9ee1..0a7f800d58 100644
> --- a/include/qapi/qmp/qobject.h
> +++ b/include/qapi/qmp/qobject.h
> @@ -34,13 +34,20 @@
>=20=20
>  #include "qapi/qapi-builtin-types.h"
>=20=20
> -struct QObject {
> +/* Not for use outside include/qapi/qmp/ */
> +struct QObjectBase_ {
>      QType type;
>      size_t refcnt;
>  };
>=20=20
> -/* Get the 'base' part of an object */
> -#define QOBJECT(obj) (&(obj)->base)
> +struct QObject {
> +    struct QObjectBase_ base;
> +};
> +
> +#define QOBJECT(x) ({                                       \
> +    typeof(x) __x =3D (x);                                    \
> +    __x ? container_of(&(__x)->base, QObject, base) : NULL; \
> +})

Identifiers that begin with double underscores are reserved for any
use.  Drop one of the two, please.

>=20=20
>  /* High-level interface for qobject_incref() */
>  #define QINCREF(obj)      \
> @@ -68,8 +75,8 @@ QEMU_BUILD_BUG_MSG(QTYPE__MAX !=3D 7,
>  static inline void qobject_init(QObject *obj, QType type)
>  {
>      assert(QTYPE_NONE < type && type < QTYPE__MAX);
> -    obj->refcnt =3D 1;
> -    obj->type =3D type;
> +    obj->base.refcnt =3D 1;
> +    obj->base.type =3D type;
>  }
>=20=20
>  /**
[...]
