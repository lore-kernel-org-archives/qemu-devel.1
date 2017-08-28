Received: from eggs.gnu.org ([2001:4830:134:3::10]:56886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmI3O-0004Zp-TH
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmI3L-0008Jd-NG
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:18:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dmI3L-0008J3-Eg
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:17:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
	<20170824103350.16400-5-marcandre.lureau@redhat.com>
	<87valc2moi.fsf@dusky.pond.sub.org>
	<CAJ+F1CJVUziORWKRmeciU+Encgz_90fLVQvh8SdFifiv_tgkFQ@mail.gmail.com>
Date: Mon, 28 Aug 2017 13:17:56 +0200
In-Reply-To: <CAJ+F1CJVUziORWKRmeciU+Encgz_90fLVQvh8SdFifiv_tgkFQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 25 Aug 2017
	10:17:18 +0000")
Message-ID: <878ti43pqz.fsf@dusky.pond.sub.org>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Fri, Aug 25, 2017 at 8:20 AM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > And misc code style fix.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  include/qapi/qmp/qlit.h | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
>> > index f36bca4554..1e9696988a 100644
>> > --- a/include/qapi/qmp/qlit.h
>> > +++ b/include/qapi/qmp/qlit.h
>> > @@ -36,13 +36,13 @@ struct QLitDictEntry {
>> >  };
>> >
>> >  #define QLIT_QNUM(val) \
>> > -    (QLitObject){.type =3D QTYPE_QNUM, .value.qnum =3D (val)}
>> > +    { .type =3D QTYPE_QNUM, .value.qnum =3D (val) }
>> >  #define QLIT_QSTR(val) \
>> > -    (QLitObject){.type =3D QTYPE_QSTRING, .value.qstr =3D (val)}
>> > +    { .type =3D QTYPE_QSTRING, .value.qstr =3D (val) }
>> >  #define QLIT_QDICT(val) \
>> > -    (QLitObject){.type =3D QTYPE_QDICT, .value.qdict =3D (val)}
>> > +    { .type =3D QTYPE_QDICT, .value.qdict =3D (val) }
>> >  #define QLIT_QLIST(val) \
>> > -    (QLitObject){.type =3D QTYPE_QLIST, .value.qlist =3D (val)}
>> > +    { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
>> >
>> >  int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs);
>>
>> Technically, this isn't a type cast, it's a compound literal.  A
>> compound literal is "an unnamed object whose value is given by the
>> initializer list" (C99 =C2=A76.5.2.5).  The standard then cautions "that=
 this
>> differs from a cast expression" (ibid).
>
> You are right, but actually the patch helps with another issue if we keep
> the compound type:
>
> const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
>             QLIT_QNULL,
>             {}
>         }));
>
> qmp-introspect.c:17:63: error: initializer element is not constant
>  const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
>                                                                ^
> /home/elmarco/src/qemu/include/qapi/qmp/qlit.h:50:57: note: in definition
> of macro =E2=80=98QLIT_QLIST=E2=80=99
>      (QLitObject) { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
>                                                          ^~~
> qmp-introspect.c:17:63: note: (near initialization for =E2=80=98(anonymou=
s).value=E2=80=99)
>  const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
>                                                                ^
> /home/elmarco/src/qemu/include/qapi/qmp/qlit.h:50:57: note: in definition
> of macro =E2=80=98QLIT_QLIST=E2=80=99
>      (QLitObject) { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
>                                                          ^~~
> Any idea how to fix that?

This one:

[...]
>> The original author's choice of compound literals is clearly
>> intentional.  I'd prefer to respect it unless there's a compelling
>> reason not to.

Rewrite your commit message so it explains your *actual* reason for
converting the macro from compound literal to initializer.
