Received: from eggs.gnu.org ([2001:4830:134:3::10]:47222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ec2JT-0000kg-Iu
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ec2JQ-0006kO-H5
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:00:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ec2JQ-0006iD-7r
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:00:28 -0500
Date: Thu, 18 Jan 2018 13:00:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180118050022.GE16100@xz-mi>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
	<1516112253-14480-9-git-send-email-pbonzini@redhat.com>
	<CAJ+F1CL9Zno3VGjqavPBXz3p1e_iTSLvi6+PYG2nkUazVaFFVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CL9Zno3VGjqavPBXz3p1e_iTSLvi6+PYG2nkUazVaFFVw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 08/51] chardev: introduce
 qemu_chr_timeout_add_ms()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Wed, Jan 17, 2018 at 05:21:40PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Jan 16, 2018 at 3:16 PM, Paolo Bonzini <pbonzini@redhat.com> wr=
ote:
> > From: Peter Xu <peterx@redhat.com>
> >
> > It's a replacement of g_timeout_add[_seconds]() for chardevs.  Charde=
vs
> > now can have dedicated gcontext, we should always bind chardev tasks
> > onto those gcontext rather than the default main context.  Since ther=
e
> > are quite a few of g_timeout_add[_seconds]() callers, a new function
> > qemu_chr_timeout_add_ms() is introduced.
> >
> > One thing to mention is that, terminal3270 is still always running on
> > main gcontext.  However let's convert that as well since it's still p=
art
> > of chardev codes and in case one day we'll miss that when we move it =
out
> > of main gcontext too.
> >
> > Also, convert all the timers from GSource tags into GSource pointers.
> > Gsource tag IDs and g_source_remove()s can only work with default
> > gcontext, while now these GSources can logically be attached to other
> > contexts.  So let's use explicit g_source_destroy() plus another
> > g_source_unref() to remove a timer.
> >
> > Note: when in the timer handler, we don't need the g_source_destroy()
> > any more since that'll be done automatically if the timer handler
> > returns false (and that's what all the current handlers do).
> >
> > Yet another note: in pty_chr_rearm_timer() we take special care for
> > ms=3D1000.  This patch merged the two cases into one.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Message-Id: <20180104141835.17987-4-peterx@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  chardev/char-pty.c     | 43 +++++++++++++++++++---------------------=
---
> >  chardev/char-socket.c  | 28 ++++++++++++++++++----------
> >  chardev/char.c         | 18 ++++++++++++++++++
> >  hw/char/terminal3270.c | 28 ++++++++++++++++------------
> >  include/chardev/char.h |  3 +++
> >  5 files changed, 74 insertions(+), 46 deletions(-)
> >
> > diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> > index 8248e36..89315e6 100644
> > --- a/chardev/char-pty.c
> > +++ b/chardev/char-pty.c
> > @@ -42,7 +42,7 @@ typedef struct {
> >
> >      /* Protected by the Chardev chr_write_lock.  */
> >      int connected;
> > -    guint timer_tag;
> > +    GSource *timer_src;
> >      GSource *open_source;
> >  } PtyChardev;
> >
> > @@ -57,7 +57,8 @@ static gboolean pty_chr_timer(gpointer opaque)
> >      PtyChardev *s =3D PTY_CHARDEV(opaque);
> >
> >      qemu_mutex_lock(&chr->chr_write_lock);
> > -    s->timer_tag =3D 0;
> > +    s->timer_src =3D NULL;
> > +    g_source_unref(s->open_source);
>=20
> why that line ^ ? It adds criticals every second (for ex with -chardev
> pty,id=3Dfoo -device isa-serial,chardev=3Dfoo).

My fault.  I must have had a wrong rebase somehow after switching to
GSource pointers while kept the compiling happy.  I'll post a fix
soon.  Sorry!

--=20
Peter Xu
