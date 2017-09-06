Received: from eggs.gnu.org ([2001:4830:134:3::10]:53545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpc88-0003bV-SB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpc87-000600-Q5
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:20:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpc87-0005zk-HA
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:20:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-29-marcandre.lureau@redhat.com>
	<87bmmphwdz.fsf@dusky.pond.sub.org>
	<622608851.9114372.1504699766400.JavaMail.zimbra@redhat.com>
	<87efrk54kf.fsf@dusky.pond.sub.org>
	<219850500.9239913.1504706100152.JavaMail.zimbra@redhat.com>
Date: Wed, 06 Sep 2017 17:20:20 +0200
In-Reply-To: <219850500.9239913.1504706100152.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 6 Sep 2017
	09:55:00 -0400 (EDT)")
Message-ID: <87bmmn26rv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 28/54] qapi: do not define enumeration
 value explicitely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> ----- Original Message -----
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>=20
>> > ----- Original Message -----
>> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>> >>=20
>> >> > The C standard has the initial value at 0 and the subsequent values
>> >> > incremented by 1. No need to set this explicitely.
>> >> >
>> >> > This will prevent from artificial "gaps" when compiling out some en=
um
>> >> > values and having unnecessarily large MAX values & enums arrays.
>> >>=20
>> >> Yes, but it also risks entertaining mishaps like compiling this one
>> >>=20
>> >>     typedef enum Color {
>> >>         COLOR_WHITE,
>> >> #if defined(NEED_CPU_H)
>> >> #if defined(TARGET_S390X)
>> >>         COLOR_BLUE,
>> >> #endif /* defined(TARGET_S390X) */
>> >> #endif /* defined(NEED_CPU_H) */
>> >>         COLOR_BLACK,
>> >>     } Color;
>> >>=20
>> >> in s390x-code (COLOR_BLACK =3D 2) and in target-independent code
>> >> (COLOR_BLACK =3D 1), then linking the two together.
>> >
>> > This is also true with other kind of types, like struct.
>> >
>> > One of the main reason why we should have schemas for target-only and =
the
>> > NEED_CPU_H is a temporary working hack.
>>=20
>> A temporary hack that's ugly or occasionally breaks in an obvious way is
>> okay, but this is an open deathtrap.  I'm afraid we need to rethink our
>> short term conditional code generation strategy.
>>=20
>> Stupidest solution that could possibly work: apply conditionals *only*
>> to qmp-introspect.c, leave everything unconditional elsewhere.  What do
>> you think?
>
> That's not what I had in mind when I started. My first 45 loc approach wo=
uld have saved us a lot of troubles :)
>
> I would rather fix this, and split the schema. I'll investigate.

Beware of prerequisites escalating into "boil the ocean".

Don't get me wrong, I *want* the qapi monolith broken up.  I also think
applying conditionals everywhere would be neat, and save us quite a few
silly stubs.  But we need to identify intermedeate steps that are in
reasonably easy reach.

Applying conditionals just to qmp-introspect.c could be such a step.  It
solves the "can't introspect whether compile-time conditional stuff is
available" problem.  It may not be the simplest solution for that
problem, but it should be a stepping stone towards solving other
problems.

On breaking up the monolith, just to avoid misunderstandings: I don't
think we should split the schema into several independent schemas.
Instead, we should have the QAPI generators generate split output.

An obvious and stupid split is one set of files per .json, where the
headers include each other exactly like the .json do.  By itself not
enough to solve the poisoned symbol problem.  Could become enough if we
manage to move target-dependent stuff to separate .json.

We might need a smarter split.

Running a full generator once per generated file has always been stupid
and slow, and the more files we generate, the stupider and slower it'll
become.  There's no reason a single generator run can't generate all the
files.  Requires a bit of Make wizardry, though.
