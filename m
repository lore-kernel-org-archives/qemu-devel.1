Received: from eggs.gnu.org ([2001:4830:134:3::10]:55556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOX1w-0003SR-HV
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 19:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOX1s-0007kP-Jg
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 19:03:08 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOX1s-0007kF-Fg
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 19:03:04 -0500
Received: by mail-yb1-f193.google.com with SMTP id 131-v6so11896767ybe.12
	for <qemu-devel@nongnu.org>; Sun, 18 Nov 2018 16:03:04 -0800 (PST)
MIME-Version: 1.0
References: <154238824601.3534.13597728205342770469.stgit@wayrath>
	<87k1lai2vo.fsf@linaro.org>
	<177817734b4def66a3a0641ad2fba1ec9a4092cb.camel@suse.com>
In-Reply-To: <177817734b4def66a3a0641ad2fba1ec9a4092cb.camel@suse.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 19 Nov 2018 01:02:51 +0100
Message-ID: <CAAdtpL4nkWZ4_p=Vo=Smz9TpL97eYxDLrd8OGXWhGEn=92C_kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: dockerfile for openSUSE Leap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dfaggioli@suse.com
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi Dario,

On Sun, Nov 18, 2018 at 10:54 PM Dario Faggioli <dfaggioli@suse.com> wrote:
>
> On Sun, 2018-11-18 at 19:47 +0000, Alex Benn=C3=A9e wrote:
> > Dario Faggioli <dfaggioli@suse.com> writes:
> >
> > > Dockerfile for building an openSUSE Leap container.
> > >
> > > Tracks the latest release (at the time of writing this
> > > patch, it is Leap 15).
> > >
> > > Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
> > > ---
> > > Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> > > Cc: Fam Zheng <famz@redhat.com>
> > > Cc: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> > > ---
> > >  tests/docker/dockerfiles/opensuse-leap.docker |   62
> > > +++++++++++++++++++++++++
> > >  1 file changed, 62 insertions(+)
> > >  create mode 100644 tests/docker/dockerfiles/opensuse-leap.docker
> > >
> > > diff --git a/tests/docker/dockerfiles/opensuse-leap.docker
> > > b/tests/docker/dockerfiles/opensuse-leap.docker
> > > new file mode 100644
> > > index 0000000000..9d00861e66
> > > --- /dev/null
> > > +++ b/tests/docker/dockerfiles/opensuse-leap.docker
> > > @@ -0,0 +1,62 @@
> > > +FROM opensuse/leap
> > > +ENV PACKAGES \
> > <snip>
> > > +    tar \
> > > +    usbredir-devel \
> > > +    virglrenderer-devel \
> > > +    vte-devel \
> > > +    which \
> > > +    xen-devel
> > > +    zlib-devel \
> >
> > This hasn't been tested because the docker image fails to build due
> > to
> > continuation breakage.
> >
> It is indeed broken.
>
> Basically, I tested it thoroughly, and I'm quite sure it works ok
> (although, I'm no docker expert).

I quickly fixed/tried it.
First this package list pulls many unuseful system packages.
I added '--no-recommends' to reduce a bit:

RUN zypper ref && \
    zypper up -y && \
    zypper install -y --no-recommends $PACKAGES

This still install a bunch of unnecessary stuffs:

Creating group systemd-journal with gid 485.
Creating group systemd-network with gid 484.
Creating user systemd-network (systemd Network Management) with uid
484 and gid 484.
Creating group systemd-coredump with gid 483.
Creating user systemd-coredump (systemd Core Dumper) with uid 483 and gid 4=
83.
Creating group systemd-timesync with gid 482.
Creating user systemd-timesync (systemd Time Synchronization) with uid
482 and gid 482.
Failed to connect to bus: No such file or directory

Then the resulting image takes the same than without --no-recommends:
1.1GB. No idea why.
At some point some package tried to talk to the network manager via
DBus to start sshd...

Second, while this works on x86_64, it fails on aarch64:

Problem: libcurl-devel-7.59.0-lp150.1.2.aarch64 requires libcurl4 =3D
7.59.0, but this requirement cannot be provided
  not installable providers: libcurl4-7.59.0-lp150.1.2.aarch64[repo-oss]
 Solution 1: downgrade of libcurl4-7.60.0-lp150.2.15.1.aarch64 to
libcurl4-7.59.0-lp150.1.2.aarch64
 Solution 2: do not install libcurl-devel-7.59.0-lp150.1.2.aarch64
 Solution 3: break libcurl-devel-7.59.0-lp150.1.2.aarch64 by ignoring
some of its dependencies

Not your fault. So I suppose you are planning to use this image to
compile QEMU for openSUSE/x86_64 only, is this correct?

Regards,

Phil.

>
> Then, when I was about to send the mail, I saw in another commit that
> it was best to have the package list sorted; so I did that, and forgot
> to adjust the continuation. :-(
>
> Sorry.
>
> I'll send a v2 with this fixed.
>
> Thanks and Regards,
> Dario
> --
> <<This happens because I choose it to happen!>> (Raistlin Majere)
> -----------------------------------------------------------------
> Dario Faggioli, Ph.D, http://about.me/dario.faggioli
> Software Engineer @ SUSE https://www.suse.com/
