Received: from eggs.gnu.org ([2001:4830:134:3::10]:33043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlBgB-0006j0-Sj
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlBgA-0003B1-HM
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:17:31 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:35160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dlBgA-0003Ah-BM
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:17:30 -0400
Received: by mail-vk0-x244.google.com with SMTP id s199so780493vke.2
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 03:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
	<20170824103350.16400-5-marcandre.lureau@redhat.com>
	<87valc2moi.fsf@dusky.pond.sub.org>
In-Reply-To: <87valc2moi.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 25 Aug 2017 10:17:18 +0000
Message-ID: <CAJ+F1CJVUziORWKRmeciU+Encgz_90fLVQvh8SdFifiv_tgkFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Fri, Aug 25, 2017 at 8:20 AM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > And misc code style fix.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qapi/qmp/qlit.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> > index f36bca4554..1e9696988a 100644
> > --- a/include/qapi/qmp/qlit.h
> > +++ b/include/qapi/qmp/qlit.h
> > @@ -36,13 +36,13 @@ struct QLitDictEntry {
> >  };
> >
> >  #define QLIT_QNUM(val) \
> > -    (QLitObject){.type =3D QTYPE_QNUM, .value.qnum =3D (val)}
> > +    { .type =3D QTYPE_QNUM, .value.qnum =3D (val) }
> >  #define QLIT_QSTR(val) \
> > -    (QLitObject){.type =3D QTYPE_QSTRING, .value.qstr =3D (val)}
> > +    { .type =3D QTYPE_QSTRING, .value.qstr =3D (val) }
> >  #define QLIT_QDICT(val) \
> > -    (QLitObject){.type =3D QTYPE_QDICT, .value.qdict =3D (val)}
> > +    { .type =3D QTYPE_QDICT, .value.qdict =3D (val) }
> >  #define QLIT_QLIST(val) \
> > -    (QLitObject){.type =3D QTYPE_QLIST, .value.qlist =3D (val)}
> > +    { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
> >
> >  int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs);
>
> Technically, this isn't a type cast, it's a compound literal.  A
> compound literal is "an unnamed object whose value is given by the
> initializer list" (C99 =C2=A76.5.2.5).  The standard then cautions "that =
this
> differs from a cast expression" (ibid).
>


You are right, but actually the patch helps with another issue if we keep
the compound type:

const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
            QLIT_QNULL,
            {}
        }));

qmp-introspect.c:17:63: error: initializer element is not constant
 const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
                                                               ^
/home/elmarco/src/qemu/include/qapi/qmp/qlit.h:50:57: note: in definition
of macro =E2=80=98QLIT_QLIST=E2=80=99
     (QLitObject) { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
                                                         ^~~
qmp-introspect.c:17:63: note: (near initialization for =E2=80=98(anonymous)=
.value=E2=80=99)
 const QLitObject qmp_schema_qlit =3D QLIT_QLIST(((QLitObject[]) {
                                                               ^
/home/elmarco/src/qemu/include/qapi/qmp/qlit.h:50:57: note: in definition
of macro =E2=80=98QLIT_QLIST=E2=80=99
     (QLitObject) { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
                                                         ^~~
Any idea how to fix that?



>
> The previous paragraph probably makes sense only to language-lawyers, so
> let's consider an example.
>
> The macro
>
>    #define QLIT_QSTR(val) \
>        (QLitObject){.type =3D QTYPE_QSTRING, .value.qstr =3D (val)}
>
> expands into a compound literal of type QLitObject, which can be used as
> an initializer for a variable of type QLitObject.
>
> The macro
>
>    #define QLIT_QSTR(val) \
>        { .type =3D QTYPE_QSTRING, .value.qstr =3D (val) }
>
> expands into something that can be used as an initializer for a variable
> of *any* structure type with suitable members.  Duck typing, if you
> will.
>
> The original author's choice of compound literals is clearly
> intentional.  I'd prefer to respect it unless there's a compelling
> reason not to.
>
> --
Marc-Andr=C3=A9 Lureau
