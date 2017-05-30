Received: from eggs.gnu.org ([2001:4830:134:3::10]:54189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dFgGl-0002gC-1e
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dFgGj-0008IN-4I
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:29:03 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dFgGi-0008HQ-Mq
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:29:01 -0400
Received: by mail-lf0-x241.google.com with SMTP id q24so8764303lfb.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 05:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-9-marcandre.lureau@redhat.com>
	<87pof86750.fsf@dusky.pond.sub.org>
In-Reply-To: <87pof86750.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 30 May 2017 12:28:48 +0000
Message-ID: <CAJ+F1CJ1O2OHkq5xi9MKc6Cbo65a05oy2PyJp1tHNtNzS_kwCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/17] qapi: update the qobject visitor to
 use QUInt
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

On Tue, May 16, 2017 at 9:33 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> On the subject: there is no such thing as "QUInt".  I guess you mean
> "uint type" (like in PATCH 06's subject).  Could also say "QNUM_U64".
>
> Apropos subject: humor me, and start your subjects with a capital
> letter, like this:
>
>     qapi: Update the qobject visitor ...
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Switch to use QNum/uint where appropriate to remove i64 limitation.
> >
> > The input visitor will cast i64 input to u64 for compatibility
> > reasons (existing json QMP client already use negative i64 for large
> > u64, and expect an implicit cast in qemu).
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qapi/qobject-input-visitor.c        | 13 +++++++++++--
> >  qapi/qobject-output-visitor.c       |  3 +--
> >  tests/test-qobject-output-visitor.c | 21 ++++++++++++++++-----
> >  3 files changed, 28 insertions(+), 9 deletions(-)
> >
> > diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.=
c
> > index 785949ebab..72cefcf677 100644
> > --- a/qapi/qobject-input-visitor.c
> > +++ b/qapi/qobject-input-visitor.c
> > @@ -420,9 +420,9 @@ static void qobject_input_type_int64_keyval(Visitor
> *v, const char *name,
> >  static void qobject_input_type_uint64(Visitor *v, const char *name,
> >                                        uint64_t *obj, Error **errp)
> >  {
> > -    /* FIXME: qobject_to_qnum mishandles values over INT64_MAX */
> >      QObjectInputVisitor *qiv =3D to_qiv(v);
> >      QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
> > +    Error *err =3D NULL;
> >      QNum *qnum;
> >
> >      if (!qobj) {
> > @@ -435,7 +435,16 @@ static void qobject_input_type_uint64(Visitor *v,
> const char *name,
> >          return;
> >      }
> >
> > -    *obj =3D qnum_get_int(qnum, errp);
> > +    /* XXX: compatibility case, accept negative values as u64 */
>
> What does "XXX" signify?
>

It's a fairly common marker for something similar to FIXME (there are
hundreds of them in qemu source tree).

I'd like to leave a fixme that means that there should be a visitor
flag/capability to fix this compatibility behaviour. (this could be exposed
as a qmp capability)

>
> > +    *obj =3D qnum_get_int(qnum, &err);
> > +
>
> Shouldn't the comment go right here?
>
>
Above qnum_get_int() is the right place imho.



> > +    if (err) {
> > +        error_free(err);
> > +        err =3D NULL;
> > +        *obj =3D qnum_get_uint(qnum, &err);
> > +    }
> > +
> > +    error_propagate(errp, err);
> >  }
> >
> >  static void qobject_input_type_uint64_keyval(Visitor *v, const char
> *name,
> > diff --git a/qapi/qobject-output-visitor.c
> b/qapi/qobject-output-visitor.c
> > index 2ca5093b22..70be84ccb5 100644
> > --- a/qapi/qobject-output-visitor.c
> > +++ b/qapi/qobject-output-visitor.c
> > @@ -150,9 +150,8 @@ static void qobject_output_type_int64(Visitor *v,
> const char *name,
> >  static void qobject_output_type_uint64(Visitor *v, const char *name,
> >                                         uint64_t *obj, Error **errp)
> >  {
> > -    /* FIXME values larger than INT64_MAX become negative */
> >      QObjectOutputVisitor *qov =3D to_qov(v);
> > -    qobject_output_add(qov, name, qnum_from_int(*obj));
> > +    qobject_output_add(qov, name, qnum_from_uint(*obj));
>
> Before the patch, uint64_t values above INT64_MAX are sent as negative
> values, e.g. UINT64_MAX is sent as -1.
>
> After the patch, they are sent unmodified.  Clearly a bug fix, but we
> have to consider compatibility issues anyway.  Does libvirt expect large
> integers to be sent as negative integers?  Does it cope with this fix
> gracefully?  Eric, any idea?
>

The libvirt json parser seems to rely on virStrToLong_ui(), which is a
wrapper around strtoul(), so it accepts negative values with -2^63..-1.
Changing it to return values larger than INT64_MAX should be ok.


>
> >  }
> >
> >  static void qobject_output_type_bool(Visitor *v, const char *name, boo=
l
> *obj,
> > diff --git a/tests/test-qobject-output-visitor.c
> b/tests/test-qobject-output-visitor.c
> > index 66a682d5a8..767818e393 100644
> > --- a/tests/test-qobject-output-visitor.c
> > +++ b/tests/test-qobject-output-visitor.c
> > @@ -595,15 +595,26 @@ static void check_native_list(QObject *qobj,
> >      qlist =3D qlist_copy(qobject_to_qlist(qdict_get(qdict, "data")));
> >
> >      switch (kind) {
> > -    case USER_DEF_NATIVE_LIST_UNION_KIND_S8:
> > -    case USER_DEF_NATIVE_LIST_UNION_KIND_S16:
> > -    case USER_DEF_NATIVE_LIST_UNION_KIND_S32:
> > -    case USER_DEF_NATIVE_LIST_UNION_KIND_S64:
> >      case USER_DEF_NATIVE_LIST_UNION_KIND_U8:
> >      case USER_DEF_NATIVE_LIST_UNION_KIND_U16:
> >      case USER_DEF_NATIVE_LIST_UNION_KIND_U32:
> >      case USER_DEF_NATIVE_LIST_UNION_KIND_U64:
> > -        /* all integer elements in JSON arrays get stored into QNums
> when
> > +        for (i =3D 0; i < 32; i++) {
> > +            QObject *tmp;
> > +            QNum *qvalue;
> > +            tmp =3D qlist_peek(qlist);
> > +            g_assert(tmp);
> > +            qvalue =3D qobject_to_qnum(tmp);
> > +            g_assert_cmpuint(qnum_get_uint(qvalue, &error_abort), =3D=
=3D,
> i);
> > +            qobject_decref(qlist_pop(qlist));
> > +        }
> > +        break;
> > +
> > +    case USER_DEF_NATIVE_LIST_UNION_KIND_S8:
> > +    case USER_DEF_NATIVE_LIST_UNION_KIND_S16:
> > +    case USER_DEF_NATIVE_LIST_UNION_KIND_S32:
> > +    case USER_DEF_NATIVE_LIST_UNION_KIND_S64:
> > +        /* all integer elements in JSON arrays get stored into QInts
> when
> >           * we convert to QObjects, so we can check them all in the sam=
e
> >           * fashion, so simply fall through here
> >           */
>
> Make that "All signed integer ...", and wing both ends of the comment.
>

ok


> Or simply drop the comment.

--=20
Marc-Andr=C3=A9 Lureau
