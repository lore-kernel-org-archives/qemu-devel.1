Received: from eggs.gnu.org ([2001:4830:134:3::10]:46826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMapU-0001Tt-9X
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMapT-00047v-Eu
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:37:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eMapT-00046y-8J
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:37:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EC052CE919
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 14:37:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-2-marcandre.lureau@redhat.com>
	<60e9ce8a-9473-cf55-5429-f70902bc59c2@redhat.com>
	<752107234.14989591.1505311690362.JavaMail.zimbra@redhat.com>
Date: Wed, 06 Dec 2017 15:37:26 +0100
In-Reply-To: <752107234.14989591.1505311690362.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 13 Sep 2017
	10:08:10 -0400 (EDT)")
Message-ID: <87tvx3zzvd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/50] qlit: add qobject_from_qlit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> ----- Original Message -----
>> On 09/11/2017 06:05 AM, Marc-Andr=C3=A9 Lureau wrote:
>> > Instanciate a QObject* form a literal QLitObject.
>>=20
>> s/Instanciate/Instantiate/
>> s/form/from/
>
> thanks
>
>>=20
>> >=20
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  include/qapi/qmp/qlit.h |  2 ++
>> >  qobject/qlit.c          | 36 ++++++++++++++++++++++++++++++++++++
>> >  tests/check-qlit.c      | 26 ++++++++++++++++++++++++++
>> >  3 files changed, 64 insertions(+)
>>=20
>> > +QObject *qobject_from_qlit(const QLitObject *qlit)
>> > +{
>> > +    switch (qlit->type) {
>> > +    case QTYPE_QNULL:
>> > +        return QOBJECT(qnull());
>> > +    case QTYPE_QNUM:
>> > +        return QOBJECT(qnum_from_int(qlit->value.qnum));
>>=20
>> Is this going to work for all QNum values?
>>=20
>> > +++ b/tests/check-qlit.c
>> > @@ -64,11 +64,37 @@ static void qlit_equal_qobject_test(void)
>> >      qobject_decref(qobj);
>> >  }
>> >=20=20
>> > +static void qobject_from_qlit_test(void)
>> > +{
>> > +    QObject *obj, *qobj =3D qobject_from_qlit(&qlit);
>> > +    QDict *qdict;
>> > +    QList *bee;
>> > +
>> > +    qdict =3D qobject_to_qdict(qobj);
>> > +    g_assert_cmpint(qdict_get_int(qdict, "foo"), =3D=3D, 42);
>> > +    g_assert_cmpstr(qdict_get_str(qdict, "bar"), =3D=3D, "hello world=
");
>> > +    g_assert(qobject_type(qdict_get(qdict, "baz")) =3D=3D QTYPE_QNULL=
);
>>=20
>> Related to my question above - you pass because there are no floating
>> point values in qlit.  Is that something we want supported?
>
> Markus had some remarks about it when reviewing #define QLIT_QNUM. Only i=
64 are supported at this point, so it's left for whoever requires it in the=
 future.

Yes, QLitObject only supports int64_t for now.  uint64_t and double
aren't implemented.

By the way, shouldn't QLitObject member type be QType instead of int?
