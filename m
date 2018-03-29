Received: from eggs.gnu.org ([2001:4830:134:3::10]:47196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1aL0-0004lO-H0
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1aKv-0004CH-SU
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:23:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40194 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f1aKv-0004BA-N1
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:23:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1F5240201A4
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 16:23:33 +0000 (UTC)
References: <20180329154833.566-1-marcandre.lureau@redhat.com>
	<20180329154833.566-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b041bde4-b926-2ede-d8a5-4721dafe6736@redhat.com>
Date: Thu, 29 Mar 2018 11:23:26 -0500
MIME-Version: 1.0
In-Reply-To: <20180329154833.566-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qobject: replace
 qobject_incref/QINCREF qobject_decref/QDECREF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com

On 03/29/2018 10:48 AM, Marc-Andr=C3=A9 Lureau wrote:
> Now that we can safely call QOBJECT() on QObject * and children types,
> we can have a single macro to ref/unref the object.
>=20
> Change the incref/decref prefix name for the more common ref/unref.
>=20
> Note that before the patch, "QDECREF(obj)" was problematic because it
> would expand to "obj ? obj : ...", which could evaluate "obj" multiple
> times.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> +++ b/include/qapi/qmp/qobject.h
> @@ -48,14 +48,6 @@ struct QObject {
>       __x ? container_of(&(__x)->base, QObject, base) : NULL; \
>   })
>  =20
> -/* High-level interface for qobject_incref() */
> -#define QINCREF(obj)      \
> -    qobject_incref(QOBJECT(obj))
> -
> -/* High-level interface for qobject_decref() */
> -#define QDECREF(obj)              \
> -    qobject_decref(obj ? QOBJECT(obj) : NULL)
> -

Interesting choice to move the macros...

>   /* Required for qobject_to() */
>   #define QTYPE_CAST_TO_QNull     QTYPE_QNULL
>   #define QTYPE_CAST_TO_QNum      QTYPE_QNUM
> @@ -78,10 +70,7 @@ static inline void qobject_init(QObject *obj, QType =
type)
>       obj->base.type =3D type;
>   }
>  =20
> -/**
> - * qobject_incref(): Increment QObject's reference count
> - */
> -static inline void qobject_incref(QObject *obj)
> +static inline void qobject_ref(QObject *obj)
>   {
>       if (obj) {
>           obj->base.refcnt++;
> @@ -102,11 +91,7 @@ bool qobject_is_equal(const QObject *x, const QObje=
ct *y);
>    */
>   void qobject_destroy(QObject *obj);
>  =20
> -/**
> - * qobject_decref(): Decrement QObject's reference count, deallocate
> - * when it reaches zero
> - */
> -static inline void qobject_decref(QObject *obj)
> +static inline void qobject_unref(QObject *obj)
>   {
>       assert(!obj || obj->base.refcnt);
>       if (obj && --obj->base.refcnt =3D=3D 0) {
> @@ -114,6 +99,19 @@ static inline void qobject_decref(QObject *obj)
>       }
>   }
>  =20
> +/**
> + * qobject_ref(): Increment QObject's reference count
> + */
> +#define qobject_ref(obj)                        \
> +    qobject_ref(QOBJECT(obj))

...below the functions of the same name.  C preprocessor rules guarantee=20
that you don't get infinite expansion, although I did a double-take the=20
first time I read through the patch (especially since your v2 used the=20
name qobject_ref_impl() for the function, distinct from the macro name).=20
  Worth a comment?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
