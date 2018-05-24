Received: from eggs.gnu.org ([2001:4830:134:3::10]:42173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fLrnd-0002mP-GE
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fLrnX-0000ma-Sg
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:05:05 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fLrnX-0000lR-MJ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:04:59 -0400
Received: by mail-wm0-x243.google.com with SMTP id f8-v6so6261941wmc.4
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 08:04:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180524175709-mutt-send-email-mst@kernel.org>
References: <1527172175-129517-1-git-send-email-mst@redhat.com>
	<6b3cad0d-b849-6ba9-64cb-6a36a37cd19d@redhat.com>
	<20180524175709-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 May 2018 17:04:56 +0200
Message-ID: <CAJ+F1CKg2yY24erk72rnt4F28t1-zvzviVKJvA7hW=kt=yBa_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] libqtest: fail if child coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>, Tiwei Bie <tiwei.bie@intel.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Hi

On Thu, May 24, 2018 at 5:00 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, May 24, 2018 at 04:45:31PM +0200, Thomas Huth wrote:
>> On 24.05.2018 16:30, Michael S. Tsirkin wrote:
>> > Right now tests report OK status if QEMU crashes during cleanup.
>> > Let's catch that case and fail the test.
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > ---
>> >  tests/libqtest.c | 9 ++++++++-
>> >  1 file changed, 8 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/tests/libqtest.c b/tests/libqtest.c
>> > index 43fb97e..f869854 100644
>> > --- a/tests/libqtest.c
>> > +++ b/tests/libqtest.c
>> > @@ -103,8 +103,15 @@ static int socket_accept(int sock)
>> >  static void kill_qemu(QTestState *s)
>> >  {
>> >      if (s->qemu_pid !=3D -1) {
>> > +        int wstatus =3D 0;
>> > +        pid_t pid;
>> > +
>> >          kill(s->qemu_pid, SIGTERM);
>> > -        waitpid(s->qemu_pid, NULL, 0);
>> > +        pid =3D waitpid(s->qemu_pid, &wstatus, 0);
>> > +
>> > +        if (pid =3D=3D s->qemu_pid && WIFSIGNALED(wstatus)) {
>> > +            assert(!WCOREDUMP(wstatus));
>> > +        }
>> >      }
>> >  }
>>
>> That's basically a good idea ... but I've already seen yet another issue
>> in the past already: QEMU sometimes simply hangs in an endless loop
>> during clean up and never terminates. I think we should detect that
>> situation, too. So instead of killing QEMU at the end of the testing, I =
think we should
>> rather try to terminate it with the QMP "quit" command. If QEMU does not
>> terminate with an exit code of 0, then the test should be flagged a
>> failed (and only if QEMU did not terminate at all, it should be killed
>> with SIGKILL).
>>
>>  Thomas
>
> Fine but can we agree to do this as a patch on top? And do you have
> the time to implement this?
>
> I'm seeing patches that cause crash on cleanup, it's not a theoretical
> problem for me, so I'd like this one to go in first.

What is the difference between sending "quit" and SIGTERM (qemu has
code to handle it in termsig_handler()). Is this documented somewhere?


--=20
Marc-Andr=C3=A9 Lureau
