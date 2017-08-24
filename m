Received: from eggs.gnu.org ([2001:4830:134:3::10]:60501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dkpXK-0002Pr-3a
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dkpXJ-0006eY-6x
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:38:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dkpXI-0006db-Ty
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:38:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 285BC3680F
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 10:38:51 +0000 (UTC)
Date: Thu, 24 Aug 2017 06:38:50 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <41575783.3165577.1503571130508.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170824103350.16400-13-marcandre.lureau@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
	<20170824103350.16400-13-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/14] qlit: improve QLit list vs qlist
 comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com



----- Original Message -----
> Check that the QLit list has the same size as the qlist, this should
> ensure that we have an exact match when iterating over qlist for
> comparing the elements.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qobject/qlit.c     | 39 ++++++++++++++++++++++++++-------------
>  tests/check-qlit.c |  3 +++
>  2 files changed, 29 insertions(+), 13 deletions(-)
>=20
> diff --git a/qobject/qlit.c b/qobject/qlit.c
> index 45ae0635c0..0a60802d74 100644
> --- a/qobject/qlit.c
> +++ b/qobject/qlit.c
> @@ -67,6 +67,28 @@ end:
>      return success;
>  }
> =20
> +static bool qlit_equal_qlist(const QLitObject *lhs, const QList *qlist)
> +{
> +    QListCompareHelper helper;
> +    int i;
> +
> +    for (i =3D 0; lhs->value.qlist[i].type !=3D QTYPE_NONE; i++) {
> +        continue;
> +    }
> +
> +    if (qlist_size(qlist) !=3D i) {
> +        return false;
> +    }
> +
> +    helper.index =3D 0;
> +    helper.objs =3D lhs->value.qlist;
> +    helper.result =3D true;
> +
> +    qlist_iter(qlist, compare_helper, &helper);
> +
> +    return helper.result;
> +}
> +
>  bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)
>  {
>      int64_t val;
> @@ -82,21 +104,12 @@ bool qlit_equal_qobject(const QLitObject *lhs, const
> QObject *rhs)
>          val =3D qnum_get_int(qobject_to_qnum(rhs));
>          return lhs->value.qnum =3D=3D val;
>      case QTYPE_QSTRING:
> -        return (strcmp(lhs->value.qstr,
> -                       qstring_get_str(qobject_to_qstring(rhs))) =3D=3D =
0);
> +        return g_str_equal(lhs->value.qstr,
> +                           qstring_get_str(qobject_to_qstring(rhs)));

drop this hunk, it slipped in by mistake.

>      case QTYPE_QDICT:
>          return qlit_equal_qdict(lhs, qobject_to_qdict(rhs));
> -    case QTYPE_QLIST: {
> -        QListCompareHelper helper;
> -
> -        helper.index =3D 0;
> -        helper.objs =3D lhs->value.qlist;
> -        helper.result =3D true;
> -
> -        qlist_iter(qobject_to_qlist(rhs), compare_helper, &helper);
> -
> -        return helper.result;
> -    }
> +    case QTYPE_QLIST:
> +        return qlit_equal_qlist(lhs, qobject_to_qlist(rhs));
>      case QTYPE_QNULL:
>          return true;
>      default:
> diff --git a/tests/check-qlit.c b/tests/check-qlit.c
> index 5d9558dfd9..ae74bfcb83 100644
> --- a/tests/check-qlit.c
> +++ b/tests/check-qlit.c
> @@ -58,6 +58,9 @@ static void qlit_equal_qobject_test(void)
> =20
>      g_assert(!qlit_equal_qobject(&qlit_foo, qobj));
> =20
> +    qdict_put(qobject_to_qdict(qobj), "bee", qlist_new());
> +    g_assert(!qlit_equal_qobject(&qlit, qobj));
> +
>      qobject_decref(qobj);
>  }
> =20
> --
> 2.14.1.146.gd35faa819
>=20
>=20
