Received: from eggs.gnu.org ([2001:4830:134:3::10]:45093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dn2gH-0000YL-BV
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dn2g9-0002uI-Fz
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:05:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dn2g9-0002sd-6u
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:05:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39415A711
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 13:05:08 +0000 (UTC)
Date: Wed, 30 Aug 2017 09:05:08 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1949447918.6049001.1504098308093.JavaMail.zimbra@redhat.com>
In-Reply-To: <874lspgrmn.fsf@dusky.pond.sub.org>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-12-marcandre.lureau@redhat.com>
	<874lspgrmn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/14] qlit: improve QLit dict vs qdict
 comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Verify that all qdict values are covered.
> >
> > (a previous iteration of this patch created a copy of qdict to remove
> > all checked elements, verifying no duplicates exist in the literal
> > qdict, however this is a programming error, and a size comparison
> > should be enough)
>=20
> The parenthesis confused me, because I wasn't sure about the exact
> meaning of "a previous iteration of this patch".  I tried to find a
> prior commit, but it looks like you're really talking about v1.
> Confused me, because I don't expect commit messages discussing previous
> iterations.
>=20
> What about:
>=20
>     qlit: Tighten QLit dict vs qdict comparison
>=20
>     We check that all members of the QLit dictionary are also in the
>     QDict.  We neglect to check the other direction.
>=20
>     Comparing the number of members suffices, because QDict can't
>     contain duplicate members, and putting duplicates in a QLit is a
>     programming error.

Looks good to me

>=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qobject/qlit.c     | 37 +++++++++++++++++++++++--------------
> >  tests/check-qlit.c |  7 +++++++
> >  2 files changed, 30 insertions(+), 14 deletions(-)
> >
> > diff --git a/qobject/qlit.c b/qobject/qlit.c
> > index b1d9146220..dc0015f76c 100644
> > --- a/qobject/qlit.c
> > +++ b/qobject/qlit.c
> > @@ -41,6 +41,27 @@ static void compare_helper(QObject *obj, void *opaqu=
e)
> >          qlit_equal_qobject(&helper->objs[helper->index++], obj);
> >  }
> > =20
> > +static bool qlit_equal_qdict(const QLitObject *lhs, const QDict *qdict=
)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; lhs->value.qdict[i].key; i++) {
> > +        QObject *obj =3D qdict_get(qdict, lhs->value.qdict[i].key);
> > +
> > +        if (!qlit_equal_qobject(&lhs->value.qdict[i].value, obj)) {
> > +            return false;
> > +        }
> > +    }
> > +
> > +    /* Note: the literal qdict must not contain duplicates, this is
> > +     * considered a programming error and it isn't checked here. */
> > +    if (qdict_size(qdict) !=3D i) {
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> >  bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)
> >  {
> >      if (!rhs || lhs->type !=3D qobject_type(rhs)) {
> > @@ -55,20 +76,8 @@ bool qlit_equal_qobject(const QLitObject *lhs, const
> > QObject *rhs)
> >      case QTYPE_QSTRING:
> >          return (strcmp(lhs->value.qstr,
> >                         qstring_get_str(qobject_to_qstring(rhs))) =3D=
=3D 0);
> > -    case QTYPE_QDICT: {
> > -        int i;
> > -
> > -        for (i =3D 0; lhs->value.qdict[i].key; i++) {
> > -            QObject *obj =3D qdict_get(qobject_to_qdict(rhs),
> > -                                     lhs->value.qdict[i].key);
> > -
> > -            if (!qlit_equal_qobject(&lhs->value.qdict[i].value, obj)) =
{
> > -                return false;
> > -            }
> > -        }
> > -
> > -        return true;
> > -    }
> > +    case QTYPE_QDICT:
> > +        return qlit_equal_qdict(lhs, qobject_to_qdict(rhs));
> >      case QTYPE_QLIST: {
> >          QListCompareHelper helper;
> > =20
> > diff --git a/tests/check-qlit.c b/tests/check-qlit.c
> > index 47fde92a46..5d9558dfd9 100644
> > --- a/tests/check-qlit.c
> > +++ b/tests/check-qlit.c
> > @@ -28,6 +28,11 @@ static QLitObject qlit =3D QLIT_QDICT(((QLitDictEntr=
y[]) {
> >      { },
> >  }));
> > =20
> > +static QLitObject qlit_foo =3D QLIT_QDICT(((QLitDictEntry[]) {
> > +    { "foo", QLIT_QNUM(42) },
> > +    { },
> > +}));
> > +
> >  static QObject *make_qobject(void)
> >  {
> >      QDict *qdict =3D qdict_new();
> > @@ -51,6 +56,8 @@ static void qlit_equal_qobject_test(void)
> > =20
> >      g_assert(qlit_equal_qobject(&qlit, qobj));
> > =20
> > +    g_assert(!qlit_equal_qobject(&qlit_foo, qobj));
> > +
> >      qobject_decref(qobj);
> >  }
>=20
> Ah, you do have negative test cases, just not in the patch creating the
> test.
>=20
> When you leave gaps in that will be filled in later patches, I recomend
> pointing out the gaps in the commit message, with a promise they'll be
> filled shortly.  Your reviewers will thank you.
>=20
> With am improved commit message,
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20

Thanks
