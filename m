Received: from eggs.gnu.org ([2001:4830:134:3::10]:38157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkWmt-0000IH-KV
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fkWmo-0007PY-Q4
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:42:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60988 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fkWmo-0007OJ-JQ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:42:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180731104258.2459-1-marcandre.lureau@redhat.com>
	<87tvofr6a8.fsf@dusky.pond.sub.org>
	<CAJ+F1CJnXYZfKD2Uoy4cFpzEeHKXREdw3_3-f8Sao1PyO4=EFQ@mail.gmail.com>
Date: Tue, 31 Jul 2018 17:42:07 +0200
In-Reply-To: <CAJ+F1CJnXYZfKD2Uoy4cFpzEeHKXREdw3_3-f8Sao1PyO4=EFQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 31 Jul 2018
	14:44:32 +0200")
Message-ID: <87ftzztnsg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: accept input on resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Jul 31, 2018 at 1:30 PM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>>> A chardev may stop trying to write if the associated can_read()
>>> callback returned 0. This happens when the monitor is suspended.
>>> The frontend is supposed to call qemu_chr_fe_accept_input() when it is
>>> ready to accept data again.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Impact?
>
> I have observed the issue with a spice port, all pending commands
> aren't flushed. Most chardev don't use the accept_input() callback,
> and instead poll regularly, like char-socket.c:tcp_chr_read_poll()

The ones that do use it are braille, mux, msmouse, spice (abstract),
spicevmc, spiceport, wctablet.

A description of the impact should be worked into the commit message.

>> Is this to be considered for 3.0?
>
> This is not a regression, afaik, and doesn't impact common monitor
> chardev. So it could be delayed. But it's also a small fix for Spice
> chardev that shouldn't create regression, so it should be fine for
> 3.0.

If the callbacks we now call all work fine, we should be good.  But
that's a chardev question, and I'm the guy for the monitor questions.  I
think the decision needs to be made by maintainers of the chardev
subsystem.

Preferably with an improved commit message:
Acked-by: Markus Armbruster <armbru@redhat.com>
