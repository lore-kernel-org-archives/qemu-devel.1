Received: from eggs.gnu.org ([2001:4830:134:3::10]:34281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gITlD-0004Mv-SK
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gITl9-00049b-Pn
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:20:51 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gITl9-00046B-Jp
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:20:47 -0400
Received: by mail-yb1-f193.google.com with SMTP id d18-v6so421129yba.4
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 00:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181101183705.5422-1-philmd@redhat.com>
	<20181102064829.GB21032@magic>
In-Reply-To: <20181102064829.GB21032@magic>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 2 Nov 2018 08:20:26 +0100
Message-ID: <CAAdtpL44dNQLskpUJ=33vF8Kp8jNkFYSDQXyKixvvZFUim1SUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Use a stable snapshot for Debian
 Sid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Hi Fam,

Thanks for picking this.

On Fri, Nov 2, 2018 at 7:48 AM Fam Zheng <famz@redhat.com> wrote:
> On Thu, 11/01 19:37, Philippe Mathieu-Daud=C3=A9 wrote:
> > The Debian Sid repository is not garanteed to be stable, as his
> > 'unstable' name suggest :)

There is an error in "my be" -> "might be"...
Do you mind to update the comment:

> > To allow quick testing, packages are pushed various time a day,
> > which my be annoying when trying to use it for stable development
> > (which is not recommended, but Sid provides edge packages we use
> > for testing).

By:

To allow quick testing, Debian maintainers might push packages
various time a day. Sometime package dependencies might break,
which is annoying when using this repository for stable development
(which is not recommended, but Sid provides edge packages we use
for testing).

I can resend as v2 if you prefer.

Thanks!

Phil.

> > (which is not recommended, but Sid provides edge packages we use
> > for testing).
> >
> > Debian provides repositories snapshots which are suitable for our
> > use. Pick a recent date that works. When required, update to newer
> > releases will be easy.
> >
> > This fixes current issues with this image:
> >
> >   $ make docker-image-debian-sid
> >   [...]
> >   The following packages have unmet dependencies:
> >    build-essential : Depends: dpkg-dev (>=3D 1.17.11) but it is not goi=
ng to be installed
> >    git : Depends: perl but it is not going to be installed
> >          Depends: liberror-perl but it is not going to be installed
> >    pkg-config : Depends: libdpkg-perl but it is not going to be install=
ed
> >    texinfo : Depends: perl (>=3D 5.26.2-6) but it is not going to be in=
stalled
> >              Depends: libtext-unidecode-perl but it is not going to be =
installed
> >              Depends: libxml-libxml-perl but it is not going to be inst=
alled
> >   E: Unable to correct problems, you have held broken packages.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  tests/docker/dockerfiles/debian-sid.docker | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/=
dockerfiles/debian-sid.docker
> > index 9a3d168705..4e4cda0ba5 100644
> > --- a/tests/docker/dockerfiles/debian-sid.docker
> > +++ b/tests/docker/dockerfiles/debian-sid.docker
> > @@ -13,6 +13,10 @@
> >
> >  FROM debian:sid-slim
> >
> > +# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
> > +ENV DEBIAN_SNAPSHOT_DATE "20181030"
> > +RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [=
check-valid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPS=
HOT_DATE} \2%" /etc/apt/sources.list
> > +
> >  # Duplicate deb line as deb-src
> >  RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/s=
ources.list
> >
> > --
> > 2.17.2
> >
>
> Queued, thanks!
>
> Fam
