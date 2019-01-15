Received: from eggs.gnu.org ([209.51.188.92]:47982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQB8-0000vk-PM
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjQB7-0006hv-0K
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:58:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjQB5-0006gz-Uq
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:58:56 -0500
Date: Tue, 15 Jan 2019 14:58:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190115145820.GB16157@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1547487921-605-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-tPoQK+7GTesyqAVmoKm7g3SHoP2iz3R8k7WX=PW5q4w@mail.gmail.com>
	<cdf8a1ab-c99b-789f-8325-f63d6da5e0c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdf8a1ab-c99b-789f-8325-f63d6da5e0c1@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/27] ivshmem deprecation, qtests,
 typedefs and gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>, Eduardo Otubo <otubo@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Jan 15, 2019 at 03:32:10PM +0100, Thomas Huth wrote:
> On 2019-01-15 14:16, Peter Maydell wrote:
> > On Mon, 14 Jan 2019 at 17:45, Thomas Huth <thuth@redhat.com> wrote:
> >>
> >>  Hi Peter!
> >>
> >> The following changes since commit 7260438b7056469610ee166f7abe9ff8a=
26b8b16:
> >>
> >>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master=
-3.2-part2' into staging (2019-01-14 11:41:43 +0000)
> >>
> >> are available in the git repository at:
> >>
> >>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-14v2
> >>
> >> for you to fetch changes up to 650db715681ad1a042705484776e1974f288f=
3d4:
> >>
> >>   tests/hexloader-test: Don't pass -nographic to the QEMU under test=
 (2019-01-14 18:21:29 +0100)
> >>
> >> ----------------------------------------------------------------
> >> - Remove deprecated "ivshmem" legacy device
> >> - Bug fix for vhost-user-test
> >> - Use more CONFIG Makefile switches for qtests
> >> - Get rid of global_qtests in some more qtests
> >> - typedef cleanups
> >> - Fixes for compiling with Clang
> >> - Force C standard to gnu99
> >> ----------------------------------------------------------------
> >=20
> > Hi; another compile failure on that ppc64 system, I'm afraid:
> >=20
> > /home/pm215/qemu/qemu-seccomp.c:45:1: error: initializer element is n=
ot constant
> >  };
> >  ^
> > /home/pm215/qemu/qemu-seccomp.c:45:1: error: (near initialization for
> > =E2=80=98sched_setscheduler_arg[0]=E2=80=99)
> >=20
> > (I did a quick check with 'make -k' and it looks like there aren't
> > any more lurking after that one.)
> >=20
> > The system libseccomp is libseccomp-2.3.1-3.el7.
>=20
> Darn, I think this time it is a compiler bug:
>=20
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D63567
>=20
> It's only fixed in GCC >=3D v5.0 :-(
>=20
> I see two options:
>=20
> 1) Expand the macro manually:
>=20
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -41,7 +41,7 @@ struct QemuSeccompSyscall {
>  };
>=20
>  const struct scmp_arg_cmp sched_setscheduler_arg[] =3D {
> -    SCMP_A1(SCMP_CMP_NE, SCHED_IDLE)
> +    { .arg =3D 1, .op =3D SCMP_CMP_NE, .datum_a =3D SCHED_IDLE }
>  };
>=20
> ... then it compiles fine for me in gnu99 mode, too.
>=20
> 2) Scratch the whole idea with gnu99 again ...

I'd prefer 1, since I think its important for us to actually have a
consistent compiler standard to target, even if we have to do some
short terms hacks like the one you show.  As long as a put a comment
next to it, we can revert the hack when we eventually ditch support for t=
he
GCC <=3D 5.0

Also, I'd probably argue that the seccomp syntax without the macro
is clearer to understand regardless :-)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
