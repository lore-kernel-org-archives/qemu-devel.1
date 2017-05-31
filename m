Received: from eggs.gnu.org ([2001:4830:134:3::10]:49125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG0Ym-0005lw-PL
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG0Yj-0002jN-Ar
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dG0Yj-0002jJ-4n
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:08:57 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-8-marcandre.lureau@redhat.com>
	<87tw4mgr07.fsf@dusky.pond.sub.org>
	<CAJ+F1CKctXGjPOghFGXQTyTdT9Oaxn8w3x0N+L5vBp4m8U4XCA@mail.gmail.com>
Date: Wed, 31 May 2017 12:08:54 +0200
In-Reply-To: <CAJ+F1CKctXGjPOghFGXQTyTdT9Oaxn8w3x0N+L5vBp4m8U4XCA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 30 May 2017
	11:35:25 +0000")
Message-ID: <8760ghfidl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/17] json: learn to parse uint64 numbers
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
> On Mon, May 15, 2017 at 6:00 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Switch strtoll() usage to qemu_strtoi64() helper while at it.
>> >
>> > Replace temporarily the error in qnum_get_int() with values >INT64_MAX
>> > until the visitor is updated.
>> >
>> > Add a few tests for large numbers.
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
>> > diff --git a/qobject/qnum.c b/qobject/qnum.c
>> > index be6307accf..2f87952db8 100644
>> > --- a/qobject/qnum.c
>> > +++ b/qobject/qnum.c
>> > @@ -76,8 +76,8 @@ int64_t qnum_get_int(const QNum *qn, Error **errp)
>> >          return qn->u.i64;
>> >      case QNUM_U64:
>> >          if (qn->u.u64 > INT64_MAX) {
>> > -            error_setg(errp, "The number is too large, use qnum_get_u=
int()");
>> > -            return 0;
>> > +            /* temporarily accepts to cast to i64 until visitor is sw=
itched */
>> > +            error_report("The number is too large, use qnum_get_uint(=
)");
>>
>> Awkward.  Can we avoid this somehow?
>>
>>
> by merging the next two patches? I think it's easier to understand why and
> how I came up with the following fix.

I played with it a bit.  Here's something that appears to do the trick:

PATCH 07: Drop changes to qobject/qnum.c tests/check-qnum.c
          Move change to tests/test-qobject-input-visitor.c to PATCH 08
PATCH 08: Move PATCH 09's change to hw/i386/acpi-build.c here
PATCH 09: No need to revert the changes dropped in PATCH 07; patch is
          now empty

Less churn, no temporary breakage, same end result.

Pushed as branch hack-qapi-qnum for your convenience:
https://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/hack-qapi-qnum

Original is on branch review-qapi-qnum.

>> >          }
>> >          return qn->u.u64;
>> >      case QNUM_DOUBLE:
[...]
