Received: from eggs.gnu.org ([2001:4830:134:3::10]:52278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fezuu-0006AR-TU
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fezur-0006uQ-NH
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:35:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42022 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fezur-0006tq-0z
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:35:37 -0400
Date: Mon, 16 Jul 2018 10:35:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180716093532.GK5616@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180710145557.12902-1-marcandre.lureau@redhat.com>
	<20180711144855.GE14423@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180711144855.GE14423@vader>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] seccomp: allow sched_setscheduler() with
 SCHED_IDLE policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, eskultet@redhat.com, kraxel@redhat.com, gschafer@gmail.com

On Wed, Jul 11, 2018 at 04:48:55PM +0200, Eduardo Otubo wrote:
> On 10/07/2018 - 16:55:57, Marc-Andr=C3=A9 Lureau wrote:
> > Current and upcoming mesa releases rely on a shader disk cash. It use=
s
> > a thread job queue with low priority, set with
> > sched_setscheduler(SCHED_IDLE). However, that syscall is rejected by
> > the "resourcecontrol" seccomp qemu filter.
> >=20
> > Since it should be safe to allow lowering thread priority, let's allo=
w
> > scheduling thread to idle policy.
> >=20
> > Related to:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1594456
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qemu-seccomp.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> > index 148e4c6f24..9cd8eb9499 100644
> > --- a/qemu-seccomp.c
> > +++ b/qemu-seccomp.c
> > @@ -34,6 +34,12 @@
> >  struct QemuSeccompSyscall {
> >      int32_t num;
> >      uint8_t set;
> > +    uint8_t narg;
> > +    const struct scmp_arg_cmp *arg_cmp;
> > +};
> > +
> > +const struct scmp_arg_cmp sched_setscheduler_arg[] =3D {
> > +    SCMP_A1(SCMP_CMP_NE, SCHED_IDLE)
> >  };
> > =20
> >  static const struct QemuSeccompSyscall blacklist[] =3D {
> > @@ -92,7 +98,8 @@ static const struct QemuSeccompSyscall blacklist[] =
=3D {
> >      { SCMP_SYS(setpriority),            QEMU_SECCOMP_SET_RESOURCECTL=
 },
> >      { SCMP_SYS(sched_setparam),         QEMU_SECCOMP_SET_RESOURCECTL=
 },
> >      { SCMP_SYS(sched_getparam),         QEMU_SECCOMP_SET_RESOURCECTL=
 },
> > -    { SCMP_SYS(sched_setscheduler),     QEMU_SECCOMP_SET_RESOURCECTL=
 },
> > +    { SCMP_SYS(sched_setscheduler),     QEMU_SECCOMP_SET_RESOURCECTL=
,
> > +      ARRAY_SIZE(sched_setscheduler_arg), sched_setscheduler_arg },
> >      { SCMP_SYS(sched_getscheduler),     QEMU_SECCOMP_SET_RESOURCECTL=
 },
> >      { SCMP_SYS(sched_setaffinity),      QEMU_SECCOMP_SET_RESOURCECTL=
 },
> >      { SCMP_SYS(sched_getaffinity),      QEMU_SECCOMP_SET_RESOURCECTL=
 },
> > @@ -118,7 +125,8 @@ static int seccomp_start(uint32_t seccomp_opts)
> >              continue;
> >          }
> > =20
> > -        rc =3D seccomp_rule_add(ctx, SCMP_ACT_KILL, blacklist[i].num=
, 0);
> > +        rc =3D seccomp_rule_add_array(ctx, SCMP_ACT_KILL, blacklist[=
i].num,
> > +                                    blacklist[i].narg, blacklist[i].=
arg_cmp);
> >          if (rc < 0) {
> >              goto seccomp_return;
> >          }
> > --=20
> > 2.18.0.129.ge3331758f1
> >=20
>=20
> Acked-by: Eduardo Otubo <otubo@redhat.com>
>=20
> Patch looks safe enough for me. If everyone else is OK with this I'll s=
end a
> pull-request tomorrow morning.

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
