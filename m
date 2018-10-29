Received: from eggs.gnu.org ([2001:4830:134:3::10]:53125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cdupontd@redhat.com>) id 1gH5su-0003VY-9h
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cdupontd@redhat.com>) id 1gH5sq-00036f-R6
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:39:04 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cdupontd@redhat.com>) id 1gH5sm-0002xu-4I
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:38:58 -0400
Received: by mail-wr1-f51.google.com with SMTP id y15-v6so8290576wru.9
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 04:38:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Christophe de Dinechin <cdupontd@redhat.com>
In-Reply-To: <87mur0ls8o.fsf@dusky.pond.sub.org>
Date: Mon, 29 Oct 2018 12:38:44 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A5AF003-10DC-4E8A-9FBB-6E960733941B@redhat.com>
References: <87mur0ls8o.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Minutes of KVM Forum BoF on deprecating stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Andrea Bolognani <abologna@redhat.com>, =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laine Stump <laine@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Pino Toscano <ptoscano@redhat.com>, Thomas Huth <thuth@redhat.com>



> On 26 Oct 2018, at 16:03, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> This is from my (imperfect) notes, corrections welcome.
>=20
> Motivation: QEMU contains stuff of dubious value, which gets in the =
way
> in various (sometimes painful and expensive) ways.
>=20
> Deprecation is the marking of an external interface as "we intend to
> remove this, you should stop using it" (preferably with advice on what
> to use instead).  We have a deprecation policy to guide us through =
this
> process.
>=20
> Topics we covered, reordered for readability:
>=20
> * Dropping features inconveniences their users.  Keeping them impedes
>  forward movement, and thus inconveniences other users.  We need to
>  engage with the tradeoffs.
>=20
> * The cost of keeping both old and new for a deprecation grace period
>  (currently two releases) can be painfully high.  Tradeoff again.
>  However, there's rough consensus not to mess with the deprecation
>  policy right now.
>=20
> * When something has been broken for the customary deprecation grace
>  period, removing it without going through the deprecation process
>  should be okay.
>=20
> * We may have to deprecate interfaces, but we may also have a need to
>  deprecate guarantees interfaces provide.  Worse when the guarantees
>  are tacit.  No good answers.  Let's attack less thorny problems =
first.
>=20
> * One obvious class of candidates for removal is machines we don't =
know
>  how to boot, or can't boot, say because we lack required firmware
>  and/or OS.
>=20
>  Of course, "can boot" should be an automated test.  As a first step
>  towards that, we should at least document how to boot each machine.
>  We're going to ask machine maintainers to do that.
>=20
> * We need to communicate "you're using something that is deprecated".
>  How?  Right now, we print a deprecation message.  Okay when humans =
use
>  QEMU directly in a shell.  However, when QEMU sits at the bottom of a
>  software stack, the message will likely end up in a log file that is
>  effectively write-only.

A reliable way to bubble up important notifications to the end user
is not a problem specific to deprecation. You may also need it e.g.
to report unsupported configurations (incl. for licensing reasons),
reporting severe runtime errors, etc.

>=20
>  - The one way to get people read log files is crashing their
>    application.  A command line option --future could make QEMU crash
>    right after printing a deprecation message.  This could help with
>    finding use of deprecated features in a testing environment.

I would try to make it more general. Also, I think it should be obvious =
that
it may cause a crash. Something like
	=E2=80=94crash=3Ddeprecated,unsupported,veryslow,asserts

with =E2=80=94crash alone enabling all of them.

Also, even if you have to monitor your log files, finding what you need
there is not necessarily obvious.

>=20
>  - A less destructive way to grab people's attention is to make things
>    run really, really slow: have QEMU go to sleep for a while after
>    printing a deprecation message.
>=20
>  - We can also pass the buck to the next layer up: emit a QMP event.
>=20
>    Sadly, by the time the next layer connects to QMP, plenty of stuff
>    already happened.  We'd have to buffer deprecation events somehow.

QM events are fine if libvirt is the consumer. But there are other =
outlets
for notifications, ranging from the GNOME notification center all the =
way
to Insights. How do we reach those?

>=20
>    What would libvirt do with such an event?  Log it, taint the =
domain,
>    emit a (libvirt) event to pass it on to the next layer up.
>=20
>  - A completely different idea is to have a configuratin linter.  To
>    support doing this at the libvirt level, QEMU could expose "is
>    deprecated" in interface introspection.  Feels feasible for QMP,
>    where we already have sufficiently expressive introspection.  For
>    CLI, we'd first have to provide that (but we want that anyway).
>=20
>  - We might also want to dispay deprecation messages in QEMU's GUI
>    somehow, or on serial consoles.
