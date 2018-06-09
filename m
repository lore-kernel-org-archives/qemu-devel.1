Received: from eggs.gnu.org ([2001:4830:134:3::10]:37106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRYLm-0000aU-NJ
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 03:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRYLi-0003a8-O4
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 03:31:50 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:35179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fRYLi-0003a2-Gl
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 03:31:46 -0400
Received: from player776.ha.ovh.net (unknown [10.109.122.22])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 485E91BCBBD
	for <qemu-devel@nongnu.org>; Sat,  9 Jun 2018 09:31:44 +0200 (CEST)
Date: Sat, 9 Jun 2018 09:31:37 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180609093137.56b182b8@bahia.lan>
In-Reply-To: <93a5ade5-2550-8b8a-60f3-9ee72bd75d45@amsat.org>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171606.21604-1-pbonzini@redhat.com>
	<20180531171606.21604-14-pbonzini@redhat.com>
	<20180608193905.0841f4d5@bahia.lan>
	<93a5ade5-2550-8b8a-60f3-9ee72bd75d45@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 52/53] char: Remove unwanted crlf conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Patryk Olszewski <patryk@fala.ehost.pl>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Fri, 8 Jun 2018 14:56:20 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 06/08/2018 02:39 PM, Greg Kurz wrote:
> > On Thu, 31 May 2018 19:16:05 +0200
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> >  =20
> >> From: Patryk Olszewski <patryk@fala.ehost.pl>
> >>
> >> This patch fixes a bug in serial that made it almost impossible for gu=
est
> >> to communicate with devices through host's serial.
> >>
> >> OPOST flag in c_oflag enables output processing letting other flags in
> >> c_oflag take effect. Usually in c_oflag ONLCR flag is also set, which
> >> causes crlf to be sent in place of lf. This breaks binary transmission=
s.
> >> Unsetting OPOST flag turns off any output processing which fixes the b=
ug.
> >> =20
> >=20
> > But it damages error reporting...
> >=20
> > Without this patch:
> >=20
> > $ qemu-system-ppc64 -serial stdio -kernel foo
> > foo: No such file or directory
> > qemu-system-ppc64: error loading foo: Failed to load ELF
> > $
> >=20
> > With this patch:
> >=20
> > $ .mbuild-ppc-for-3.0/obj/ppc64-softmmu/qemu-system-ppc64 -serial stdio=
 -kernel foo
> > foo: No such file or directory
> >                               qemu-system-ppc64: error loading foo: Fai=
led to load ELF
> >                                                                        =
               $
> >=20
> > It is possible to patch vreport() to append an explicit CR:
> >=20
> >      error_vprintf(fmt, ap);
> > -    error_printf("\n");
> > +    error_printf("\n\r");
> >  }
> >=20
> > but it only fixes the trailing newline of error_report(). Any other new=
line,
> > eg when using error_append_hint(), will lack the CR... Not sure how to =
fix
> > this :-\ =20
>=20
> Peter just pushed the fix (ed6b018ef7):
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg02152.html
>=20

Ah, cool ! :)

> >  =20
> >> Bug reports related:
> >> https://bugs.launchpad.net/qemu/+bug/1772086
> >> https://bugs.launchpad.net/qemu/+bug/1407813
> >> https://bugs.launchpad.net/qemu/+bug/1715296
> >> also
> >> https://lists.nongnu.org/archive/html/qemu-devel/2006-06/msg00196.html
> >>
> >> Signed-off-by: Patryk Olszewski <patryk@fala.ehost.pl>
> >> Message-Id: <1527105041-21013-1-git-send-email-patryk@fala.ehost.pl>
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>  chardev/char-serial.c | 2 +-
> >>  chardev/char-stdio.c  | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> >> index feb52e559d..ae548d28da 100644
> >> --- a/chardev/char-serial.c
> >> +++ b/chardev/char-serial.c
> >> @@ -139,7 +139,7 @@ static void tty_serial_init(int fd, int speed,
> >> =20
> >>      tty.c_iflag &=3D ~(IGNBRK | BRKINT | PARMRK | ISTRIP
> >>                       | INLCR | IGNCR | ICRNL | IXON);
> >> -    tty.c_oflag |=3D OPOST;
> >> +    tty.c_oflag &=3D ~OPOST;
> >>      tty.c_lflag &=3D ~(ECHO | ECHONL | ICANON | IEXTEN | ISIG);
> >>      tty.c_cflag &=3D ~(CSIZE | PARENB | PARODD | CRTSCTS | CSTOPB);
> >>      switch (data_bits) {
> >> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> >> index 96375f2ab8..d83e60e787 100644
> >> --- a/chardev/char-stdio.c
> >> +++ b/chardev/char-stdio.c
> >> @@ -59,7 +59,7 @@ static void qemu_chr_set_echo_stdio(Chardev *chr, bo=
ol echo)
> >>      if (!echo) {
> >>          tty.c_iflag &=3D ~(IGNBRK | BRKINT | PARMRK | ISTRIP
> >>                           | INLCR | IGNCR | ICRNL | IXON);
> >> -        tty.c_oflag |=3D OPOST;
> >> +        tty.c_oflag &=3D ~OPOST;
> >>          tty.c_lflag &=3D ~(ECHO | ECHONL | ICANON | IEXTEN);
> >>          tty.c_cflag &=3D ~(CSIZE | PARENB);
> >>          tty.c_cflag |=3D CS8; =20
> >  =20
