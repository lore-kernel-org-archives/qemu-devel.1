Received: from eggs.gnu.org ([2001:4830:134:3::10]:45272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLs12-00020P-2w
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLs0y-0004kz-W9
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:18:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52734 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLs0y-0004kZ-QH
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:18:52 -0400
Date: Thu, 24 May 2018 18:18:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180524181754-mutt-send-email-mst@kernel.org>
References: <1527172175-129517-1-git-send-email-mst@redhat.com>
	<6b3cad0d-b849-6ba9-64cb-6a36a37cd19d@redhat.com>
	<20180524175709-mutt-send-email-mst@kernel.org>
	<CAJ+F1CKg2yY24erk72rnt4F28t1-zvzviVKJvA7hW=kt=yBa_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKg2yY24erk72rnt4F28t1-zvzviVKJvA7hW=kt=yBa_g@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>, Tiwei Bie <tiwei.bie@intel.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, May 24, 2018 at 05:04:56PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Thu, May 24, 2018 at 5:00 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > On Thu, May 24, 2018 at 04:45:31PM +0200, Thomas Huth wrote:
> >> On 24.05.2018 16:30, Michael S. Tsirkin wrote:
> >> > Right now tests report OK status if QEMU crashes during cleanup.
> >> > Let's catch that case and fail the test.
> >> >
> >> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> > ---
> >> >  tests/libqtest.c | 9 ++++++++-
> >> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/tests/libqtest.c b/tests/libqtest.c
> >> > index 43fb97e..f869854 100644
> >> > --- a/tests/libqtest.c
> >> > +++ b/tests/libqtest.c
> >> > @@ -103,8 +103,15 @@ static int socket_accept(int sock)
> >> >  static void kill_qemu(QTestState *s)
> >> >  {
> >> >      if (s->qemu_pid !=3D -1) {
> >> > +        int wstatus =3D 0;
> >> > +        pid_t pid;
> >> > +
> >> >          kill(s->qemu_pid, SIGTERM);
> >> > -        waitpid(s->qemu_pid, NULL, 0);
> >> > +        pid =3D waitpid(s->qemu_pid, &wstatus, 0);
> >> > +
> >> > +        if (pid =3D=3D s->qemu_pid && WIFSIGNALED(wstatus)) {
> >> > +            assert(!WCOREDUMP(wstatus));
> >> > +        }
> >> >      }
> >> >  }
> >>
> >> That's basically a good idea ... but I've already seen yet another i=
ssue
> >> in the past already: QEMU sometimes simply hangs in an endless loop
> >> during clean up and never terminates. I think we should detect that
> >> situation, too. So instead of killing QEMU at the end of the testing=
, I think we should
> >> rather try to terminate it with the QMP "quit" command. If QEMU does=
 not
> >> terminate with an exit code of 0, then the test should be flagged a
> >> failed (and only if QEMU did not terminate at all, it should be kill=
ed
> >> with SIGKILL).
> >>
> >>  Thomas
> >
> > Fine but can we agree to do this as a patch on top? And do you have
> > the time to implement this?
> >
> > I'm seeing patches that cause crash on cleanup, it's not a theoretica=
l
> > problem for me, so I'd like this one to go in first.
>=20
> What is the difference between sending "quit" and SIGTERM (qemu has
> code to handle it in termsig_handler()). Is this documented somewhere?

SIGTERM might wake QEMU if it's blocked somewhere in kernel.
Sending quit also tests QMP isn't blocked.

>=20
> --=20
> Marc-Andr=E9 Lureau
