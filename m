Received: from eggs.gnu.org ([2001:4830:134:3::10]:39271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d3h6F-0006ck-Dh
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d3h6E-00024R-8l
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:56:39 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d3h6D-00024C-UF
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:56:38 -0400
Received: by mail-lf0-x241.google.com with SMTP id 75so3602240lfs.3
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 03:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <1493282486-28338-1-git-send-email-armbru@redhat.com>
	<1493282486-28338-5-git-send-email-armbru@redhat.com>
	<CAJ+F1CL2=cjEJ40tJ0nKtWD=DbG9aAmFkoRDT2y0+zaHFZbe0w@mail.gmail.com>
	<8760hqceh7.fsf@dusky.pond.sub.org>
In-Reply-To: <8760hqceh7.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 27 Apr 2017 10:56:25 +0000
Message-ID: <CAJ+F1CL=BH2wqKMi3U0iZp4ujw_kHAGszL3KXJHJp9+mF3fmXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] qobject-input-visitor: Catch misuse of
 end_struct vs. end_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On Thu, Apr 27, 2017 at 2:49 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > On Thu, Apr 27, 2017 at 12:41 PM Markus Armbruster <armbru@redhat.com>
> > wrote:
> >
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >>
> >
> > It would be more obvious with a check for qobject_type(tos->obj), no?
>
> --verbose?
>

Instead of assert(tos->h) assert(qobject_type(tos->obj) =3D=3D QTYPE_QDICT)=
 ?
similarly for the list case.

>
> > In any case:
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Thanks!
>
> >> ---
> >>  qapi/qobject-input-visitor.c | 21 +++++++++++++++++++--
> >>  1 file changed, 19 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor=
.c
> >> index 2530959..68a6742 100644
> >> --- a/qapi/qobject-input-visitor.c
> >> +++ b/qapi/qobject-input-visitor.c
> >> @@ -291,6 +291,15 @@ static void qobject_input_start_struct(Visitor *v=
,
> >> const char *name, void **obj,
> >>      }
> >>  }
> >>
> >> +static void qobject_input_end_struct(Visitor *v, void **obj)
> >> +{
> >> +    QObjectInputVisitor *qiv =3D to_qiv(v);
> >> +    StackObject *tos =3D QSLIST_FIRST(&qiv->stack);
> >> +
> >> +    assert(tos->h);
> >> +    qobject_input_pop(v, obj);
> >> +}
> >> +
> >>
> >>  static void qobject_input_start_list(Visitor *v, const char *name,
> >>                                       GenericList **list, size_t size,
> >> @@ -346,6 +355,14 @@ static void qobject_input_check_list(Visitor *v,
> >> Error **errp)
> >>      }
> >>  }
> >>
> >> +static void qobject_input_end_list(Visitor *v, void **obj)
> >> +{
> >> +    QObjectInputVisitor *qiv =3D to_qiv(v);
> >> +    StackObject *tos =3D QSLIST_FIRST(&qiv->stack);
> >> +
> >> +    assert(!tos->h);
> >> +    qobject_input_pop(v, obj);
> >> +}
> >>
> >>  static void qobject_input_start_alternate(Visitor *v, const char *nam=
e,
> >>                                            GenericAlternate **obj,
> size_t
> >> size,
> >> @@ -645,11 +662,11 @@ static QObjectInputVisitor
> >> *qobject_input_visitor_base_new(QObject *obj)
> >>      v->visitor.type =3D VISITOR_INPUT;
> >>      v->visitor.start_struct =3D qobject_input_start_struct;
> >>      v->visitor.check_struct =3D qobject_input_check_struct;
> >> -    v->visitor.end_struct =3D qobject_input_pop;
> >> +    v->visitor.end_struct =3D qobject_input_end_struct;
> >>      v->visitor.start_list =3D qobject_input_start_list;
> >>      v->visitor.next_list =3D qobject_input_next_list;
> >>      v->visitor.check_list =3D qobject_input_check_list;
> >> -    v->visitor.end_list =3D qobject_input_pop;
> >> +    v->visitor.end_list =3D qobject_input_end_list;
> >>      v->visitor.start_alternate =3D qobject_input_start_alternate;
> >>      v->visitor.optional =3D qobject_input_optional;
> >>      v->visitor.free =3D qobject_input_free;
> >> --
> >> 2.7.4
> >>
> >>
> >> --
> > Marc-Andr=C3=A9 Lureau
>
--=20
Marc-Andr=C3=A9 Lureau
