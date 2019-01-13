Received: from eggs.gnu.org ([209.51.188.92]:39551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <matwey.kornilov@gmail.com>) id 1giaEx-0002NC-S3
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 02:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <matwey.kornilov@gmail.com>) id 1giaEx-0005sm-1I
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 02:31:27 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <matwey.kornilov@gmail.com>)
	id 1giaEw-0005ry-Si
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 02:31:26 -0500
Received: by mail-ot1-x341.google.com with SMTP id k98so16775306otk.3
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 23:31:25 -0800 (PST)
MIME-Version: 1.0
References: <q186f8$1u3$1@blaine.gmane.org>
	<CAFEAcA9F+57RZzRTga8BvY_zCf13WX8d3NF6HA8kChtcw9_v6w@mail.gmail.com>
	<CAJs94EZbyyxoXROG8=y7sfrQhmLhNj-mbyz6DSryYOJgqkTpzw@mail.gmail.com>
In-Reply-To: <CAJs94EZbyyxoXROG8=y7sfrQhmLhNj-mbyz6DSryYOJgqkTpzw@mail.gmail.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Sun, 13 Jan 2019 10:31:13 +0300
Message-ID: <CAJs94EZORmm69g-O7ttVrtNW_gpDqs9h_HoxA2Qp_c0yFijZeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-user-linux: how could I measure performance
 for aarch64 and arm?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

=D0=BF=D1=82, 11 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 22:24, Matwey V. K=
ornilov <matwey.kornilov@gmail.com>:
>
> =D0=BF=D1=82, 11 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 12:52, Peter May=
dell <peter.maydell@linaro.org>:
> >
> > On Thu, 10 Jan 2019 at 19:33, Matwey V. Kornilov
> > <matwey.kornilov@gmail.com> wrote:
> > > I am running the same application compiled for aarch64 and armv7l on
> > > x86_64 platform using qemu-user-linux tools.
> > >
> > > I see dramatic performance difference (30 times) between emulated
> > > architectures: aarch64 runs for ~4 minutes, armv7l runs for ~2 hours.
> > > I do understand that CPU architecture emulation is inherently slow
> > > thing, but my question is about the difference.
> > >
> > > How could I debug to understand what is the reason for such a big
> > > difference? I've already tried to run stress-ng compiled for this two
> > > architectures, but it leads to the same performance per second.
> > >
> > > I am running qemu 2.11, should I try other version?
> >
> > Yes, do try 3.1 -- we have done some overall TCG performance
> > improvements.
>
> Indeed, qemu-arm from master runs for 4 minutes where 2.11 runs for 2
> hours for me. It is impressive improvement.

I've managed to bisected the first good (fast) commit:

commit 2a53535af471f4bee9d6cb5b363746b8d5ed21dd
Author: Luke Shumaker <lukeshu@parabola.nu>
Date:   Thu Dec 28 13:08:13 2017 -0500

    linux-user: init_guest_space: Try to make ARM space+commpage continuous

Though I am not sure, how does it help.

>
> >
> > For a big difference between target architectures like that,
> > I would try starting by using some host performance tools on
> > the two runs to see where all the time is being taken in
> > the armv7l guest run -- is it all in translated guest code,
> > or is there more time (proportionally) spent in particular
> > parts of the QEMU C code? Does the armv7l version do
> > many more or different syscalls (check with the QEMU -strace
> > option) ?
> >
> > Also you should check performance on h/w 32 bit vs
> > 64-bit Arm if you can, to confirm that it's not just
> > that the guest application runs much slower there.
> > (If you don't have the arm hardware you could at least
> > check x86 32-bit vs 64-bit.)
> >
> > thanks
> > -- PMM
>
>
>
> --
> With best regards,
> Matwey V. Kornilov



--=20
With best regards,
Matwey V. Kornilov
