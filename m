Received: from eggs.gnu.org ([2001:4830:134:3::10]:55456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f92uJ-0001Dd-8v
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f92uG-0007Kp-4s
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:18:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39004 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f92uF-0007KS-Vf
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:18:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9999C406803E
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:18:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-6-marcandre.lureau@redhat.com>
Date: Thu, 19 Apr 2018 08:18:52 +0200
In-Reply-To: <20180417133602.23832-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 17 Apr 2018 15:36:02 +0200")
Message-ID: <8736zryb03.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 5/5] qobject: modify qobject_ref() to
 assert on NULL
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> While it may be convenient to accept NULL value in
> qobject_unref() (for similar reasons as free() accepts NULL), it is
> not such a good idea for qobject_ref(), assert() on NULL. One place
> relied on that behaviour (the monitor request id), and it's best to be
> explicit that NULL is accepted there.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qobject.h | 7 ++++---
>  monitor.c                  | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
> index befc945504..a0b2affb2c 100644
> --- a/include/qapi/qmp/qobject.h
> +++ b/include/qapi/qmp/qobject.h
> @@ -73,9 +73,8 @@ static inline void qobject_init(QObject *obj, QType typ=
e)
>=20=20
>  static inline void *qobject_ref_impl(QObject *obj)
>  {
> -    if (obj) {
> -        obj->base.refcnt++;
> -    }
> +    assert(obj);
> +    obj->base.refcnt++;
>      return obj;
>  }
>=20=20
> @@ -103,6 +102,7 @@ static inline void qobject_unref_impl(QObject *obj)
>=20=20
>  /**
>   * qobject_ref(): Increment QObject's reference count
> + * @obj: a #QObject or child type instance (must not be NULL)
>   *
>   * Returns: the same @obj. The type of @obj will be propagated to the
>   * return type.
> @@ -112,6 +112,7 @@ static inline void qobject_unref_impl(QObject *obj)
>  /**
>   * qobject_unref(): Decrement QObject's reference count, deallocate
>   * when it reaches zero
> + * @obj: a #QObject or children type instance (can be NULL)
>   */
>  #define qobject_unref(obj) qobject_unref_impl(QOBJECT(obj))
>=20=20
> diff --git a/monitor.c b/monitor.c
> index 7dbc1f74b8..3a750208fd 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4188,7 +4188,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
>=20=20
>      req_obj =3D g_new0(QMPRequest, 1);
>      req_obj->mon =3D mon;
> -    req_obj->id =3D qobject_ref(id);
> +    req_obj->id =3D id ? qobject_ref(id) : NULL;
>      req_obj->req =3D req;
>      req_obj->need_resume =3D false;

What's your argument that this is the only use of qobject_ref() that
needs to be guarded now?
