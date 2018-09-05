Received: from eggs.gnu.org ([2001:4830:134:3::10]:34722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fxTWS-0002G0-FI
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 04:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fxTIr-0007NL-M4
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 04:36:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fxTIr-0007Mj-E0
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 04:36:45 -0400
Date: Wed, 5 Sep 2018 09:36:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180905083641.GD3026@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180904110822.12863-1-fli@suse.com>
	<20180904110822.12863-2-fli@suse.com>
	<20180904112620.GG22349@redhat.com>
	<0831de15-95cb-0774-10f9-8b03f4141c10@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0831de15-95cb-0774-10f9-8b03f4141c10@suse.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] Fix segmentation fault when
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
Cc: qemu-devel@nongnu.org

On Wed, Sep 05, 2018 at 12:17:24PM +0800, Fei Li wrote:
> Thanks for the review! :)
>=20
>=20
> On 09/04/2018 07:26 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Sep 04, 2018 at 07:08:18PM +0800, Fei Li wrote:
> > > Currently, when qemu_signal_init() fails it only returns a non-zero
> > > value but without propagating any Error. But its callers need a
> > > non-null err when runs error_report_err(err), or else 0->msg occurs=
.
> > >=20
> > > To avoid such segmentation fault, add a new Error parameter to make
> > > the call trace to propagate the err to the final caller.
> > >=20
> > > Signed-off-by: Fei Li <fli@suse.com>
> > > ---
> > >   include/qemu/osdep.h |  2 +-
> > >   util/compatfd.c      | 17 ++++++++++++-----
> > >   util/main-loop.c     | 11 +++++++----
> > >   3 files changed, 20 insertions(+), 10 deletions(-)
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
> > > index 980bd33e52..65501de622 100644
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
> > > +        error_setg(errp, "Failed to malloc in %s", __func__);
> > I'd avoid using __func__ in error messages. Instead
> >=20
> >     "Failed to allocate signalfd memory"
> Ok, thanks.
> >=20
> > >           errno =3D ENOMEM;
> > >           return -1;
> > >       }
> > >       if (pipe(fds) =3D=3D -1) {
> > > +        error_setg(errp, "Failed to create a pipe in %s", __func__=
);
> >      "Failed to create signalfd pipe"
> OK.
> >=20
> > >           free(info);
> > >           return -1;
> > >       }
> > > @@ -94,17 +97,21 @@ static int qemu_signalfd_compat(const sigset_t =
*mask)
> > >       return fds[0];
> > >   }
> > > -int qemu_signalfd(const sigset_t *mask)
> > > +int qemu_signalfd(const sigset_t *mask, Error **errp)
> > >   {
> > > -#if defined(CONFIG_SIGNALFD)
> > >       int ret;
> > > +    Error *local_err =3D NULL;
> > > +#if defined(CONFIG_SIGNALFD)
> > >       ret =3D syscall(SYS_signalfd, -1, mask, _NSIG / 8);
> > >       if (ret !=3D -1) {
> > >           qemu_set_cloexec(ret);
> > >           return ret;
> > >       }
> > >   #endif
> > > -
> > > -    return qemu_signalfd_compat(mask);
> > > +    ret =3D qemu_signalfd_compat(mask, &local_err);
> > > +    if (local_err) {
> > > +        error_propagate(errp, local_err);
> > > +    }
> > Using a local_err is not required - you can just pass errp stright
> > to qemu_signalfd_compat() and then check
> >=20
> >     if (ret < 0)
> For the use of a local error object & error_propagate call, I'd like to
> explain here. :)
> In our code, the initial caller passes two kinds of Error to the call t=
race,
> one is
> something like &error_abort and &error_fatal, the other is NULL.
>=20
> For the former, the exit() occurs in the functions where
> error_handle_fatal() is called
> (e.g. called by error_propagate/error_setg/...). The patch3: qemu_init_=
vcpu
> is the case,
> that means the system will exit in the final callee: qemu_thread_create=
(),
> instead of
> the initial caller pc_new_cpu(). In such case, I think propagating seem=
s
> more reasonable.

I don't really agree. It is preferrable to abort immediately at the deepe=
st
place which raises the error. The stack trace will thus show the full cal=
l
chain leading upto the problem.

> How do you think passing errp straightly for the latter case, and use a
> local error object &
> error_propagate for the former case? This is a distinct treatment, but =
would
> shorten the code.

It is inappropriate to second-guess whether the caller is a passing in
NULL or &error_abort, or another Error object. What is passed in can
change at any time in the future.=20

We should only ever use a local error where the local method has a need
to look at the error contents before returning to the caller. Any other
case should just use the errp directly.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
