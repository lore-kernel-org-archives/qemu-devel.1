Received: from eggs.gnu.org ([2001:4830:134:3::10]:37553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG3ON-0000fw-Lw
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG3OK-0004Wj-UC
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:10:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dG3OK-0004Wd-Ly
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:10:24 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-9-marcandre.lureau@redhat.com>
	<87pof86750.fsf@dusky.pond.sub.org>
	<CAJ+F1CJ1O2OHkq5xi9MKc6Cbo65a05oy2PyJp1tHNtNzS_kwCQ@mail.gmail.com>
Date: Wed, 31 May 2017 15:10:21 +0200
In-Reply-To: <CAJ+F1CJ1O2OHkq5xi9MKc6Cbo65a05oy2PyJp1tHNtNzS_kwCQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 30 May 2017
	12:28:48 +0000")
Message-ID: <87o9u9894y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, May 16, 2017 at 9:33 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> On the subject: there is no such thing as "QUInt".  I guess you mean
>> "uint type" (like in PATCH 06's subject).  Could also say "QNUM_U64".
>>
>> Apropos subject: humor me, and start your subjects with a capital
>> letter, like this:
>>
>>     qapi: Update the qobject visitor ...
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Switch to use QNum/uint where appropriate to remove i64 limitation.
>> >
>> > The input visitor will cast i64 input to u64 for compatibility
>> > reasons (existing json QMP client already use negative i64 for large
>> > u64, and expect an implicit cast in qemu).
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  qapi/qobject-input-visitor.c        | 13 +++++++++++--
>> >  qapi/qobject-output-visitor.c       |  3 +--
>> >  tests/test-qobject-output-visitor.c | 21 ++++++++++++++++-----
>> >  3 files changed, 28 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor=
.c
>> > index 785949ebab..72cefcf677 100644
>> > --- a/qapi/qobject-input-visitor.c
>> > +++ b/qapi/qobject-input-visitor.c
>> > @@ -420,9 +420,9 @@ static void qobject_input_type_int64_keyval(Visito=
r *v, const char *name,
>> >  static void qobject_input_type_uint64(Visitor *v, const char *name,
>> >                                        uint64_t *obj, Error **errp)
>> >  {
>> > -    /* FIXME: qobject_to_qnum mishandles values over INT64_MAX */
>> >      QObjectInputVisitor *qiv =3D to_qiv(v);
>> >      QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
>> > +    Error *err =3D NULL;
>> >      QNum *qnum;
>> >
>> >      if (!qobj) {
>> > @@ -435,7 +435,16 @@ static void qobject_input_type_uint64(Visitor *v,=
 const char *name,
>> >          return;
>> >      }
>> >
>> > -    *obj =3D qnum_get_int(qnum, errp);
>> > +    /* XXX: compatibility case, accept negative values as u64 */
>>
>> What does "XXX" signify?
>>
>
> It's a fairly common marker for something similar to FIXME (there are
> hundreds of them in qemu source tree).
>
> I'd like to leave a fixme that means that there should be a visitor
> flag/capability to fix this compatibility behaviour. (this could be expos=
ed
> as a qmp capability)

What I don't like about XXX: it doesn't say whether it merely marks
something we intend to do or something that's actually broken.  The text
following it should clarify, but let's stick to FIXME for the latter
case, and TODO for the former.

A FIXME comment must explain what's broken.  It may explain how to fix
it.

A TODO comment should explain what we intend to do (d'oh).

Your XXX comment does neither, and that's also why I asked :)

>>
>> > +    *obj =3D qnum_get_int(qnum, &err);
>> > +
>>
>> Shouldn't the comment go right here?
>>
>>
> Above qnum_get_int() is the right place imho.

I may have a stronger opinion once I see the revised comment text.

>> > +    if (err) {
>> > +        error_free(err);
>> > +        err =3D NULL;
>> > +        *obj =3D qnum_get_uint(qnum, &err);
>> > +    }
>> > +
>> > +    error_propagate(errp, err);
>> >  }
>> >
>> >  static void qobject_input_type_uint64_keyval(Visitor *v, const char *=
name,
>> > diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visit=
or.c
>> > index 2ca5093b22..70be84ccb5 100644
>> > --- a/qapi/qobject-output-visitor.c
>> > +++ b/qapi/qobject-output-visitor.c
>> > @@ -150,9 +150,8 @@ static void qobject_output_type_int64(Visitor *v, =
const char *name,
>> >  static void qobject_output_type_uint64(Visitor *v, const char *name,
>> >                                         uint64_t *obj, Error **errp)
>> >  {
>> > -    /* FIXME values larger than INT64_MAX become negative */
>> >      QObjectOutputVisitor *qov =3D to_qov(v);
>> > -    qobject_output_add(qov, name, qnum_from_int(*obj));
>> > +    qobject_output_add(qov, name, qnum_from_uint(*obj));
>>
>> Before the patch, uint64_t values above INT64_MAX are sent as negative
>> values, e.g. UINT64_MAX is sent as -1.
>>
>> After the patch, they are sent unmodified.  Clearly a bug fix, but we
>> have to consider compatibility issues anyway.  Does libvirt expect large
>> integers to be sent as negative integers?  Does it cope with this fix
>> gracefully?  Eric, any idea?
>>
>
> The libvirt json parser seems to rely on virStrToLong_ui(), which is a
> wrapper around strtoul(), so it accepts negative values with -2^63..-1.
> Changing it to return values larger than INT64_MAX should be ok.

Thanks for checking.

[...]
