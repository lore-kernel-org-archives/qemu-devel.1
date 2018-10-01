Received: from eggs.gnu.org ([2001:4830:134:3::10]:43803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1g72pm-00049f-Rp
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1g72pl-0007x8-HB
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:22:18 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1g72pl-0007wk-BX
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:22:17 -0400
Received: by mail-oi1-x241.google.com with SMTP id e17-v6so2780428oig.12
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 11:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <CANzW0mvSX5nWuinDU68W2yJzgoQSGAHPqpz0G36A6NKwRsz_4A@mail.gmail.com>
	<d45bff6c4e472811f01452b5f730c1b6@ispras.ru>
In-Reply-To: <d45bff6c4e472811f01452b5f730c1b6@ispras.ru>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Tue, 2 Oct 2018 00:22:04 +0600
Message-ID: <CANzW0mthuW0a7LR7DhpvTPnZ5n5DxtYyfYQf756vtyb9g0O7QQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Fixing record/replay and adding
 reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dovgaluk <dovgaluk@ispras.ru>
Cc: Pavel.Dovgaluk@ispras.ru, qemu-devel@nongnu.org

I've posted bug report with extended tests (incl. case without sleep=3Doff)=
.
You may find guest image (kernel) in bug description.
https://bugs.launchpad.net/qemu/+bug/1795369

The most annoying thing is that some issues are almost not reproducible.
There are definitely race conditions somewhere in qemu code. Running
'stress-ng' utility with CPU and I/O stressors in parallel with qemu
execution greatly minimizes amount of attempts when I'm trying to trigger
some of issues I encounter.

I'll try 'info monitor' command tomorrow, but no guarantees that I'll be
able to reproduce issue again.

Speaking about '-nographic' and SDL... I've noted that UI greatly minimizes
possibility of hanging (but not avoids it completely) when using icount in
general, so this effect isn't rr-specific. I've already reported this bug
too.


=D0=BF=D0=BD, 1 =D0=BE=D0=BA=D1=82. 2018 =D0=B3., 20:14 dovgaluk <dovgaluk@=
ispras.ru>:

> Artem Pisarenko =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2018-09-30 14:01:
> > Feature still broken :(
>
> Thanks for testing.
>
> >
> > Brief description of my tests.
> >
> > Guest image is Linux, which just powers off after kernel boots
> > (instead of proceeding to user-space /init or /sbin/init).
> > Base cmdline:
> > qemu-system-x86_64 -nodefaults -machine pc,accel=3Dtcg -m 2048 -cpu
> > qemu64 -rtc clock=3Dvm,base=3D2000-01-01T00:00:00 -kernel bzImage -init=
rd
> > rootfs -append 'nokaslr console=3DttyS0 rdinit=3D/init_poweroff'
> > -nographic -serial SERIAL_VALUE -icount
> > 1,sleep=3Doff,rr=3DRR_VALUE,rrfile=3Dicount_rr_capture.bin
>
> I've never tried it with sleep=3Doff. Can you remove it and try again?
>
> We also seen a problem with '-nographic'. When we remove this option and
> QEMU runs with SDL
> window, everything is ok. There is some problem with main loop which may
> sleep when there
> is no GUI to update, or something like that. We couldn't fix it yet.
>
> >
> > Test 1. When SERIAL_VALUE=3Dnone
> > Running with RR_VALUE=3Drecord completes successfully.
> > Running with RR_VALUE=3Dreplay doesn't completes. qemu process just
> > eating ~100% cpu and memory usage doesn't grow after some moment. I
> > don't see what happens because of problem no.2 (see below).
>
> Try 'info replay' monitor command. Does instruction counter increases?
>
> >
> > Test 2. When SERIAL_VALUE=3Dstdio
> > Running with RR_VALUE=3Drecord completes successfully.
> >
> > Running with RR_VALUE=3Dreplay caues exit with error:
> >
> > "qemu-system-x86_64: Missing character write event in the replay log"
> >
> > These problems are same with qemu 2.12 (both vanilla and with previous
> > versions of these patches applied). Furthemore, I consider whole
> > icount mode broken and determinism isn't achievable.
> > The irony is that I actually don't need record/replay feature. I've
> > tried to use it only as instrument to debug failing determinism in
> > qemu code. But since replay/record feature itself relies on
> > determinism, which is broken, it's no wonder why it fails also (I just
> > hoped to bypass it).
> >
> > Contact me if you need more details. I just tired a lot trying to get
> > all these things working... Hope is leaving me...
>
> Can you share the kernel in case the icount still broken?
>
>
> Pavel Dovgalyuk
>
> --

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
