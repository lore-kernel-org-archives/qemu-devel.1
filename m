Received: from eggs.gnu.org ([209.51.188.92]:35757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hL6f3-0003mF-Jm
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hL6f2-0006Kt-M2
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:49:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hL6f2-0006KS-Fb
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:49:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id l2so510308wrb.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 06:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180830143348.10595-1-marcandre.lureau@redhat.com>
	<20181213032452.GA25689@umbus.fritz.box>
	<0942d4a4-f264-fd42-0b2d-994c331a000c@redhat.com>
In-Reply-To: <0942d4a4-f264-fd42-0b2d-994c331a000c@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Apr 2019 15:49:22 +0200
Message-ID: <CAJ+F1CKifW6Z=ZDK0j4Wgjb5mzCGLL+aNeP1UdB665y+Sodz5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] seccomp: check TSYNC host capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Eduardo Otubo <otubo@redhat.com>, QEMU <qemu-devel@nongnu.org>, Andrea Bolognani <abologna@redhat.com>

Hi

On Mon, Apr 29, 2019 at 3:22 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 13/12/2018 04.24, David Gibson wrote:
> > On Thu, Aug 30, 2018 at 04:33:48PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> >> Remove -sandbox option if the host is not capable of TSYNC, since the
> >> sandbox will fail at setup time otherwise. This will help libvirt, for
> >> ex, to figure out if -sandbox will work.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This seems to have introduced a regression, which I found when
> > preparing a ppc pull request.  Specifically when running with RHEL7 on
> > a POWER host, using "-sandbox off" which one of my tests did, causes a
> > cryptic error followed by a SEGV:
> >
> > $ ./ppc64-softmmu/qemu-system-ppc64 -sandbox off
> > qemu-system-ppc64: -sandbox off: There is no option group 'sandbox'
> > Segmentation fault
> > $ ./x86_64-softmmu/qemu-system-x86_64 -sandbox off
> > qemu-system-x86_64: -sandbox off: There is no option group 'sandbox'
> > Segmentation fault
> >
> > I think the problem is that while this wrapped one use of the sandbox
> > option group to produce a sensible error, it didn't do the same for
> > another call to qemu_opts_parse_noisily():
> >
> > (gdb) bt
> > #0  0x00000000105b36d8 in opts_parse (list=3D0x0, params=3D0x3ffffffffa=
b5 "off", permit_abbrev=3Dtrue, defaults=3Dfalse, errp=3D0x3ffffffff080)
> >     at util/qemu-option.c:829
> > #1  0x00000000105b3b74 in qemu_opts_parse_noisily (list=3D<optimized ou=
t>, params=3D<optimized out>, permit_abbrev=3D<optimized out>) at util/qemu=
-option.c:890
> > #2  0x0000000010024964 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at vl.c:3589
> >
> > I'm guessing RHEL7 triggers it because that has a version of
> > libseccomp that doesn't support the feature needed to complete
> > registration (maybe on ppc host only; I haven't had a chance to try on
> > an x86 RHEL7 host).
>
> Andrea reported the same issue again today with QEMU v4.0 ...
> Marc-Andr=C3=A9, have you ever had another look into this issue?

Sorry, I thought this was already fixed and I forgot about it.

I just sent "[PATCH] vl: fix -sandbox parsing crash when seccomp
support is disabled".

thanks


--=20
Marc-Andr=C3=A9 Lureau
