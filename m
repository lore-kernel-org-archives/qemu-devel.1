Received: from eggs.gnu.org ([2001:4830:134:3::10]:47117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0NS6-0008BC-Lg
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0NS3-0007PD-EN
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:58:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1g0NS2-0007OE-KU
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:58:15 -0400
Date: Thu, 13 Sep 2018 16:58:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180913085811.GR2526@lemon.usersys.redhat.com>
References: <20180907133902.28462-1-fli@suse.com>
	<20180907133902.28462-2-fli@suse.com>
	<20180912075508.GD2526@lemon.usersys.redhat.com>
	<442ff5f2-b1fb-e871-4a4c-e7346f4f273d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <442ff5f2-b1fb-e871-4a4c-e7346f4f273d@suse.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] Fix segmentation fault when
 qemu_signal_init fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, eblake@redhat.com

On Thu, 09/13 16:46, Fei Li wrote:
>=20
>=20
> On 09/12/2018 03:55 PM, Fam Zheng wrote:
> > On Fri, 09/07 21:38, Fei Li wrote:
> > > Currently, when qemu_signal_init() fails it only returns a non-zero
> > > value but without propagating any Error. But its callers need a
> > > non-null err when runs error_report_err(err), or else 0->msg occurs=
.
> > >=20
> > > To avoid such segmentation fault, add a new Error parameter to make
> > > the call trace to propagate the err to the final caller.
> > >=20
> > > This patch also adds the omitted error handling when creating signa=
lfd
> > > pipe fails in qemu_signalfd_compat().
> > >=20
> > > Signed-off-by: Fei Li <fli@suse.com>
> > > ---
> > >   include/qemu/osdep.h |  2 +-
> > >   util/compatfd.c      |  9 ++++++---
> > >   util/main-loop.c     | 10 +++++-----
> > >   3 files changed, 12 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > > index a91068df0e..09ed85fcb8 100644
> > > --- a/include/qemu/osdep.h
> > > +++ b/include/qemu/osdep.h
> > > @@ -421,7 +421,7 @@ struct qemu_signalfd_siginfo {
> > >                                additional fields in the future) */
> > >   };
> > > -int qemu_signalfd(const sigset_t *mask);
> > > +int qemu_signalfd(const sigset_t *mask, Error **errp);
> > >   void sigaction_invoke(struct sigaction *action,
> > >                         struct qemu_signalfd_siginfo *info);
> > >   #endif
> > > diff --git a/util/compatfd.c b/util/compatfd.c
> > > index 980bd33e52..d3ed890405 100644
> > > --- a/util/compatfd.c
> > > +++ b/util/compatfd.c
> > > @@ -16,6 +16,7 @@
> > >   #include "qemu/osdep.h"
> > >   #include "qemu-common.h"
> > >   #include "qemu/thread.h"
> > > +#include "qapi/error.h"
> > >   #include <sys/syscall.h>
> > > @@ -65,7 +66,7 @@ static void *sigwait_compat(void *opaque)
> > >       }
> > >   }
> > > -static int qemu_signalfd_compat(const sigset_t *mask)
> > > +static int qemu_signalfd_compat(const sigset_t *mask, Error **errp=
)
> > >   {
> > >       struct sigfd_compat_info *info;
> > >       QemuThread thread;
> > > @@ -73,11 +74,13 @@ static int qemu_signalfd_compat(const sigset_t =
*mask)
> > >       info =3D malloc(sizeof(*info));
> > >       if (info =3D=3D NULL) {
> > > +        error_setg(errp, "Failed to allocate signalfd memory");
> > >           errno =3D ENOMEM;
> > >           return -1;
> > >       }
> > >       if (pipe(fds) =3D=3D -1) {
> > > +        error_setg(errp, "Failed to create signalfd pipe");
> > >           free(info);
> > >           return -1;
> > >       }
> > > @@ -94,7 +97,7 @@ static int qemu_signalfd_compat(const sigset_t *m=
ask)
> > >       return fds[0];
> > >   }
> > > -int qemu_signalfd(const sigset_t *mask)
> > > +int qemu_signalfd(const sigset_t *mask, Error **errp)
> > >   {
> > >   #if defined(CONFIG_SIGNALFD)
> > >       int ret;
> > Extend the context:
> >=20
> >         ret =3D syscall(SYS_signalfd, -1, mask, _NSIG / 8);
> >         if (ret !=3D -1) {
> >             qemu_set_cloexec(ret);
> >             return ret;
> >         }
> >=20
> > This error path need error_setg() as well.
> Thanks for the comment. :)
> Like adding as below?
>=20
> =A0=A0=A0=A0 if (ret !=3D -1) {
> =A0=A0=A0=A0=A0=A0=A0=A0 qemu_set_cloexec(ret);
> =A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> +=A0=A0=A0 } else {
> +=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "syscall SYS_signalfd failed: %=
s",
> strerror(errno));
> =A0=A0=A0=A0 }
> =A0#endif
>=20
> =A0=A0=A0 return qemu_signalfd_compat(mask, errp);
>=20
>=20
> If yes, I'd like to confirm the logic:

Oh, I missed the fact that qemu_signalfd_compat is a fallback if
qemu_set_cloexec() fails. So no, your original patch is good, ignore what=
 I
said, there's no need to add the extra error_setg here. If you do so and
qemu_signalfd_compat() fails, error_setg() in it will hit the assertion f=
ailure.

Fam
