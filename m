Received: from eggs.gnu.org ([2001:4830:134:3::10]:55083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cqJ77-0001Ef-1z
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cqJ75-0002aK-Ht
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:42:13 -0400
Received: from mail-lf0-x235.google.com ([2a00:1450:4010:c07::235]:36560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cqJ75-0002Ze-4e
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:42:11 -0400
Received: by mail-lf0-x235.google.com with SMTP id y193so66565844lfd.3
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 05:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-5-marcandre.lureau@redhat.com>
	<84148275-6410-68f7-4da0-345b635c42f3@redhat.com>
	<87h92xk5p7.fsf@dusky.pond.sub.org>
	<7da78125-495b-4a2b-6383-d0ae22ba282b@redhat.com>
	<1815445054.3686730.1489411694165.JavaMail.zimbra@redhat.com>
In-Reply-To: <1815445054.3686730.1489411694165.JavaMail.zimbra@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Mar 2017 12:41:58 +0000
Message-ID: <CAJ+F1CKMUGA26PhTchxL3GNBJr11JMdS-eujvhF3gSyLULjbXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/21] qobject: add quint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>, anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.com

Hi

On Mon, Mar 13, 2017 at 5:29 PM Marc-Andr=C3=A9 Lureau <mlureau@redhat.com>
wrote:

Hi

----- Original Message -----
> On 03/13/2017 02:15 AM, Markus Armbruster wrote:
> > Eric Blake <eblake@redhat.com> writes:
> >
> >> On 03/11/2017 07:22 AM, Marc-Andr=C3=A9 Lureau wrote:
> >>> The type is not used at all yet. Add some tests to exercice it.
> >>
> >> s/exercice/exercise/
> >>
> >> I wonder if we need this patch at all.
> >>
> >> I've been thinking about a possible alternative representation, such
> >> that a single QInt type can cover _both_ signed and unsigned types, by
> >> having QInt track a sign bit bool in addition to a uint64_t value.
> >>
>
> > You say you've been thinking about extending QInt's range to cover
> > uint64_t.  I've been thinking even more radically: replace both QInt an=
d
> > QFloat by QNumber.  This is how JSON *actually* works.
> >
> > The new QNumber type provides constructors from double, int64_t and
> > uint64_t.  It also provides conversion functions to double, int64_t and
> > uint64_t.  The latter two can fail.
>
> Interesting - I like it, as it takes my idea and goes one step further.
> You'd want to track 64 bits of precision rather than just 53, when the
> input was integral, but the idea seems to have some merit (we have some
> special case in the testsuite for what happens in alternates with
> various combinations of 'number' vs. 'int' that may need tweaking when
> they are no longer distinguishable as QInt vs QFloat, but that's not too
> onerous).
>

I wonder the benefits from hiding the real type behind a QNumber
"superclass", then having to type check at a lower level. QType is not only
used for json, so I see some benefits from having a bit stricter type
declaration and compile-time check. But I don't have a very good idea of
what it would mean to have a generic QNumber type, I could try to implement
it to have a more informed opinion.


I have looked a bit more into implementing a QNumber type.

There is a bit more error handling to add everywhere for getting a value
(for get_int, get_uint), as some conversions will fail. The qdict getters
will  have to throw those errors too. Whereas the QObject type check or
dispatch is there, so less error handling to add.

In my proposal, conversion from int to uint is done for positive values,
with the qdict helper (is it the only way we access json parsed values?).
Do we want to cast a negative int to a uint? Do we have qmp clients using
this representation today, and can we break this?

The qdev-properties will be slightly less convenient to define, but that's
minor since it's behind macros, ex:
-            .qtype     =3D QTYPE_QUINT,                                   =
\
-            .defval.u  =3D (_type)_defval,                                =
\
+            .qtype     =3D QTYPE_QNUM,                                    =
\
+            .defval.type  =3D QNUM_U64,                                   =
\
+            .defval.u.u64  =3D (_type)_defval,                            =
\

The biggest issue I have is how to handle the alt visitors if all ints are
numbers, ex with AltIntNum:

    switch ((*obj)->type) {
    case QTYPE_QNUM:
        visit_type_int(v, name, &(*obj)->u.i, &err);
        break;
    case QTYPE_QNUM:
        visit_type_number(v, name, &(*obj)->u.n, &err);
        break;

Should the generator have special handling for QNUM and dispatch based on
underlying type?

Overall, it seems to me that using QUINT like I proposed is more
straightforward and equally convenient provided we have conversion helpers
where needed (mostly for qdict).

thanks for your comments
--=20
Marc-Andr=C3=A9 Lureau
