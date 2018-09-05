Received: from eggs.gnu.org ([2001:4830:134:3::10]:38215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fxYxI-0002zp-4P
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fxYxE-0004Kc-4z
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:38:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fxYxD-0004Ii-T2
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:38:48 -0400
Date: Wed, 5 Sep 2018 22:38:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180905143844.GA21726@lemon.usersys.redhat.com>
References: <20180904110822.12863-1-fli@suse.com>
	<20180904110822.12863-2-fli@suse.com>
	<20180904112620.GG22349@redhat.com>
	<0831de15-95cb-0774-10f9-8b03f4141c10@suse.com>
	<20180905083641.GD3026@redhat.com>
	<c7666ea1-20c2-8037-3f9d-79f3dc12e413@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c7666ea1-20c2-8037-3f9d-79f3dc12e413@suse.com>
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Wed, 09/05 19:20, Fei Li wrote:
>=20
>=20
> On 09/05/2018 04:36 PM, Daniel P. Berrang=E9 wrote:
> > On Wed, Sep 05, 2018 at 12:17:24PM +0800, Fei Li wrote:
> > > Thanks for the review! :)
> > >=20
> > >=20
> > > On 09/04/2018 07:26 PM, Daniel P. Berrang=E9 wrote:
> > > > On Tue, Sep 04, 2018 at 07:08:18PM +0800, Fei Li wrote:
> > > >=20
> ... snip ...
> > > > >            free(info);
> > > > >            return -1;
> > > > >        }
> > > > > @@ -94,17 +97,21 @@ static int qemu_signalfd_compat(const sigse=
t_t *mask)
> > > > >        return fds[0];
> > > > >    }
> > > > > -int qemu_signalfd(const sigset_t *mask)
> > > > > +int qemu_signalfd(const sigset_t *mask, Error **errp)
> > > > >    {
> > > > > -#if defined(CONFIG_SIGNALFD)
> > > > >        int ret;
> > > > > +    Error *local_err =3D NULL;
> > > > > +#if defined(CONFIG_SIGNALFD)
> > > > >        ret =3D syscall(SYS_signalfd, -1, mask, _NSIG / 8);
> > > > >        if (ret !=3D -1) {
> > > > >            qemu_set_cloexec(ret);
> > > > >            return ret;
> > > > >        }
> > > > >    #endif
> > > > > -
> > > > > -    return qemu_signalfd_compat(mask);
> > > > > +    ret =3D qemu_signalfd_compat(mask, &local_err);
> > > > > +    if (local_err) {
> > > > > +        error_propagate(errp, local_err);
> > > > > +    }
> > > > Using a local_err is not required - you can just pass errp strigh=
t
> > > > to qemu_signalfd_compat() and then check
> > > >=20
> > > >      if (ret < 0)
> > > For the use of a local error object & error_propagate call, I'd lik=
e to
> > > explain here. :)
> > > In our code, the initial caller passes two kinds of Error to the ca=
ll trace,
> > > one is
> > > something like &error_abort and &error_fatal, the other is NULL.
> > >=20
> > > For the former, the exit() occurs in the functions where
> > > error_handle_fatal() is called
> > > (e.g. called by error_propagate/error_setg/...). The patch3: qemu_i=
nit_vcpu
> > > is the case,
> > > that means the system will exit in the final callee: qemu_thread_cr=
eate(),
> > > instead of
> > > the initial caller pc_new_cpu(). In such case, I think propagating =
seems
> > > more reasonable.
> > I don't really agree. It is preferrable to abort immediately at the d=
eepest
> > place which raises the error. The stack trace will thus show the full=
 call
> > chain leading upto the problem.
> Sorry for the above example, it is not exactly correct: for the patch3 =
case,
> the
> system will exit in device_set_realized(), where the first error_propag=
ate()
> is called
> if we pass errp directly, but not in the final callee.. Sorry for the
> misleading.
>=20
> For another example, its call trace:
> qemu_thread_create(, NULL)
> <=3D iothread_complete(, NULL)
> <=3D=3D user_creatable_complete(, NULL)
> <=3D=3D=3D object_new_with_propv(, errp)
> <=3D=3D=3D=3D object_new_with_props(, errp) {... error_propagate(errp, =
local_err);
> ...}
> <=3D=3D=3D=3D=3D iothread_create(, &error_abort)
> The exit occurs in object_new_with_props where the first error_propagat=
e is
> called.
>=20
> Either the device_set_realized() or object_new_with_props() is a middle
> caller, thus
> we can only see the top half stack trace until where error_handle_fatal=
() is
> called.
>=20
> In other words, the exit() occurs neither in the final callee nor the
> initial caller.
> Sorry for the misleading example again..

This means using error_propagate can potentially lose the final callee in=
 the
error_abort cases. That is why it's preferrable to just pass errp down th=
e
calling chain when possible. The reason why object_new_with_propv uses
error_propagate is because both object_property_add_child and
user_creatable_complete return void, thus cannot flag success/failure to =
its
caller via their return values. To check whether they succeed,
object_new_with_propv wants a non-NULL err parameter. But like you said, =
errp
passed to object_new_with_propv may or may not be NULL, so a local_err lo=
cal
variable is defined to cope with that.

Alternatively it could do this instead:

{

    ...

    if (errp) {
        object_property_add_child(parent, id, obj, errp);
        if (*errp) {
            goto error;
        }
    } else {
        Error *local_err =3D NULL;
        object_property_add_child(parent, id, obj, &local_err);
        if (local_err) {
            goto error;
        }
    }
    ...

}

This way if error_abort was passed and object_property_add_child failed, =
the
abort point would be in the innermost function. But this is boilerplate c=
ode so
it's not used.

On the contrary, using error_propagate when not necessary also means more=
 lines
of code but gives less info on the call trace when aborted.

So I fully agree with Dan.

Fam

> >=20
> > > How do you think passing errp straightly for the latter case, and u=
se a
> > > local error object &
> > > error_propagate for the former case? This is a distinct treatment, =
but would
> > > shorten the code.
> > It is inappropriate to second-guess whether the caller is a passing i=
n
> > NULL or &error_abort, or another Error object. What is passed in can
> > change at any time in the future.
> ok.
> >=20
> > We should only ever use a local error where the local method has a ne=
ed
> > to look at the error contents before returning to the caller. Any oth=
er
> > case should just use the errp directly.
> >=20
> > Regards,
> > Daniel
> Have a nice day, thanks
> Fei
>=20
