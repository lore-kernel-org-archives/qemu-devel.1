Received: from eggs.gnu.org ([2001:4830:134:3::10]:59811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqMyS-0005Mq-U7
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqMyP-00029s-0l
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:49:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39697)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqMyO-00028D-OA
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:49:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-5-marcandre.lureau@redhat.com>
	<84148275-6410-68f7-4da0-345b635c42f3@redhat.com>
	<87h92xk5p7.fsf@dusky.pond.sub.org>
	<7da78125-495b-4a2b-6383-d0ae22ba282b@redhat.com>
	<1815445054.3686730.1489411694165.JavaMail.zimbra@redhat.com>
	<CAJ+F1CKMUGA26PhTchxL3GNBJr11JMdS-eujvhF3gSyLULjbXg@mail.gmail.com>
Date: Tue, 21 Mar 2017 17:49:24 +0100
In-Reply-To: <CAJ+F1CKMUGA26PhTchxL3GNBJr11JMdS-eujvhF3gSyLULjbXg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 21 Mar 2017
	12:41:58 +0000")
Message-ID: <878tnyk223.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Mar 13, 2017 at 5:29 PM Marc-Andr=C3=A9 Lureau <mlureau@redhat.co=
m>
> wrote:
>
> Hi
>
> ----- Original Message -----
>> On 03/13/2017 02:15 AM, Markus Armbruster wrote:
>> > Eric Blake <eblake@redhat.com> writes:
>> >
>> >> On 03/11/2017 07:22 AM, Marc-Andr=C3=A9 Lureau wrote:
>> >>> The type is not used at all yet. Add some tests to exercice it.
>> >>
>> >> s/exercice/exercise/
>> >>
>> >> I wonder if we need this patch at all.
>> >>
>> >> I've been thinking about a possible alternative representation, such
>> >> that a single QInt type can cover _both_ signed and unsigned types, by
>> >> having QInt track a sign bit bool in addition to a uint64_t value.
>> >>
>>
>> > You say you've been thinking about extending QInt's range to cover
>> > uint64_t.  I've been thinking even more radically: replace both QInt a=
nd
>> > QFloat by QNumber.  This is how JSON *actually* works.
>> >
>> > The new QNumber type provides constructors from double, int64_t and
>> > uint64_t.  It also provides conversion functions to double, int64_t and
>> > uint64_t.  The latter two can fail.
>>
>> Interesting - I like it, as it takes my idea and goes one step further.
>> You'd want to track 64 bits of precision rather than just 53, when the
>> input was integral, but the idea seems to have some merit (we have some
>> special case in the testsuite for what happens in alternates with
>> various combinations of 'number' vs. 'int' that may need tweaking when
>> they are no longer distinguishable as QInt vs QFloat, but that's not too
>> onerous).
>>
>
> I wonder the benefits from hiding the real type behind a QNumber
> "superclass", then having to type check at a lower level. QType is not on=
ly
> used for json,

The less it is used for non-JSON purposes, the better.

>                so I see some benefits from having a bit stricter type
> declaration and compile-time check. But I don't have a very good idea of
> what it would mean to have a generic QNumber type, I could try to impleme=
nt
> it to have a more informed opinion.
>
>
> I have looked a bit more into implementing a QNumber type.
>
> There is a bit more error handling to add everywhere for getting a value
> (for get_int, get_uint), as some conversions will fail. The qdict getters
> will  have to throw those errors too. Whereas the QObject type check or
> dispatch is there, so less error handling to add.

How many places convert QNumber to C integer type?

How many of them have to do range checking anyway?

If range checking turns out to be common, we could fuse it into the
conversion, say return -EINVAL for qtype other than QNumber, and -ERANGE
for a QNumber out of range, like qemu_strtol() does.

> In my proposal, conversion from int to uint is done for positive values,
> with the qdict helper (is it the only way we access json parsed values?).

I doubt it.

> Do we want to cast a negative int to a uint? Do we have qmp clients using
> this representation today, and can we break this?

We don't have "intepret negative as large unsigned" issues in the JSON
parser, but we have them in the QObject input visitor:
visit_type_uint64() rejects integers above INT64_MAX, but happily
accepts integers between INT64_MIN and -1, and cast them to uint64_t.

This makes no sense for QMP.  It crept in right at the beginning because
visitors were added without adequate test coverage.  Eric noticed this
problem and added the FIXME in commit f755dea, four and a half years
later.  We still lack an adequate test case.  I'll add one.

We're awfully slow learners.

QMP clients that work around the "large positive integers are rejected"
bugs by sending large negative ones instead may well exist.  Fixing the
interface would break them.  Depressing.  Eric, could you have a peek at
libvirt?

Additionally, direct users of QObject could conceivably convert QInt to
int64_t, then silently cast to unsigned.  Or narrower integer types;
same bad idea, really.  The only way to find them is to review all the
code getting integers out of QObject.

> The qdev-properties will be slightly less convenient to define, but that's
> minor since it's behind macros, ex:
> -            .qtype     =3D QTYPE_QUINT,                                 =
  \
> -            .defval.u  =3D (_type)_defval,                              =
  \
> +            .qtype     =3D QTYPE_QNUM,                                  =
  \
> +            .defval.type  =3D QNUM_U64,                                 =
  \
> +            .defval.u.u64  =3D (_type)_defval,                          =
  \
>
> The biggest issue I have is how to handle the alt visitors if all ints are
> numbers, ex with AltIntNum:
>
>     switch ((*obj)->type) {
>     case QTYPE_QNUM:
>         visit_type_int(v, name, &(*obj)->u.i, &err);
>         break;
>     case QTYPE_QNUM:
>         visit_type_number(v, name, &(*obj)->u.n, &err);
>         break;
>
> Should the generator have special handling for QNUM and dispatch based on
> underlying type?

I'm afraid we'll need that for keyval anyway.

I've been playing with alternates a bit.  I think
visit_start_alternate() needs to be redone.  Need to find time to finish
my experiments and post patches.

> Overall, it seems to me that using QUINT like I proposed is more
> straightforward and equally convenient provided we have conversion helpers
> where needed (mostly for qdict).

Contradicts my gut feeling, but my gut is anything but infallible.  I
guess I'd like to see (sketches of) both, so we can make an informed
decision.

> thanks for your comments
