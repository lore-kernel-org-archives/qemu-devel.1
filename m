Received: from eggs.gnu.org ([2001:4830:134:3::10]:54294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f92ro-0008Ek-5f
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f92rl-0006DB-10
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:16:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f92rk-0006Ci-S6
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:16:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D01E722FC
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:16:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-4-marcandre.lureau@redhat.com>
Date: Thu, 19 Apr 2018 08:16:09 +0200
In-Reply-To: <20180417133602.23832-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 17 Apr 2018 15:36:00 +0200")
Message-ID: <877ep3yb4m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/5] qobject: replace
 qobject_incref/QINCREF qobject_decref/QDECREF
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

> Now that we can safely call QOBJECT() on QObject * as well as its
> subtypes, we can have macros qobject_ref() / qobject_unref() that work
> everywhere instead of having to use QINCREF() / QDECREF() for QObject
> and qobject_incref() / qobject_decref() for its subtypes.
>
> Note that the new macros evaluate their argument exactly once, thus no
> need to shout them.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/events.py              |   2 +-
>  include/qapi/qmp/qnull.h            |   2 +-
>  include/qapi/qmp/qobject.h          |  36 +++++-----
[...]
>  tests/wdt_ib700-test.c              |  14 ++--
>  util/keyval.c                       |  12 ++--
>  util/qemu-config.c                  |   4 +-
>  docs/devel/qapi-code-gen.txt        |   2 +-
>  scripts/coccinelle/qobject.cocci    |   8 +--
>  94 files changed, 606 insertions(+), 610 deletions(-)

The patch is not entirely mechanical (evidence: Eric's observations).
How did you create it?

> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> index 3dc523cf39..4426861ff1 100644
> --- a/scripts/qapi/events.py
> +++ b/scripts/qapi/events.py
> @@ -142,7 +142,7 @@ out:
>  ''')
>      ret +=3D mcgen('''
>      error_propagate(errp, err);
> -    QDECREF(qmp);
> +    qobject_unref(qmp);
>  }
>  ''')
>      return ret
> diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
> index e8ea2c315a..75b29c6a39 100644
> --- a/include/qapi/qmp/qnull.h
> +++ b/include/qapi/qmp/qnull.h
> @@ -23,7 +23,7 @@ extern QNull qnull_;
>=20=20
>  static inline QNull *qnull(void)
>  {
> -    QINCREF(&qnull_);
> +    qobject_ref(&qnull_);
>      return &qnull_;
>  }
>=20=20
> diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
> index 0a7f800d58..e08fbb80b9 100644
> --- a/include/qapi/qmp/qobject.h
> +++ b/include/qapi/qmp/qobject.h
> @@ -16,16 +16,16 @@
>   *
>   *  - Returning references: A function that returns an object may
>   *  return it as either a weak or a strong reference.  If the reference
> - *  is strong, you are responsible for calling QDECREF() on the reference
> + *  is strong, you are responsible for calling qobject_unref() on the re=
ference

Long line.

>   *  when you are done.
>   *
>   *  If the reference is weak, the owner of the reference may free it at
>   *  any time in the future.  Before storing the reference anywhere, you
> - *  should call QINCREF() to make the reference strong.
> + *  should call qobject_ref() to make the reference strong.
>   *
>   *  - Transferring ownership: when you transfer ownership of a reference
>   *  by calling a function, you are no longer responsible for calling
> - *  QDECREF() when the reference is no longer needed.  In other words,
> + *  qobject_unref() when the reference is no longer needed.  In other wo=
rds,
>   *  when the function returns you must behave as if the reference to the
>   *  passed object was weak.
>   */
[...]
