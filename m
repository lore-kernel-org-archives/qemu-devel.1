Received: from eggs.gnu.org ([2001:4830:134:3::10]:38750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gIUCo-0002XO-LS
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gIUCi-0003fi-HQ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:49:21 -0400
MIME-Version: 1.0
References: <20181102001303.32640-1-f4bug@amsat.org>
	<b32bf2a0-08ac-6b16-6372-455f9a239f9f@roeck-us.net>
	<CAAdtpL6VCf+hyK7GGtoiC8KLAL2DJtaYomwhcY7Mz2OxMg2AiA@mail.gmail.com>
In-Reply-To: <CAAdtpL6VCf+hyK7GGtoiC8KLAL2DJtaYomwhcY7Mz2OxMg2AiA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 2 Nov 2018 08:48:58 +0100
Message-ID: <CAAdtpL776SX0rbO1-dsBmx_7D3gn8e5ukt5Z0STejYRt+oXcEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.2 v2 0/7] hw/arm/bcm2835: Add basic
 support for cprman (clock subsystem)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Fri, Nov 2, 2018 at 8:32 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Hi Guenter,
>
> On Fri, Nov 2, 2018 at 3:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 11/1/18 5:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > Hi,
> > >
> > > This series is a mix of a previous work I had for the raspi, and a pa=
tch from
> > > Guenter: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg031=
53.html
> > >
> > > The final patch keep Guenter ideas and comments, but is mostly a rewr=
ite.
> > > I dropped the A2W code from this work, it doesn't seems unuseful to m=
e.
> > >
> > > Guenter can you test this series?
> > >
> >
> > arm/raspi2 works, but aarch64/raspi3 stalls.
>
> Thanks for testing it!
>
> So I suppose the A2W is required. And I'm probably using a too old kernel=
,
> I'm using the Buster preview following Peter's post [1]:
>
> [    0.000000] Linux version 4.14.0-3-arm64
> (debian-kernel@lists.debian.org) (gcc version 7.2.0 (Debian 7.2.0-18))
> #1 SMP Debian 4.14.12-2 (2018-01-06)
> [    0.000000] Machine model: Raspberry Pi 3 Model B
> [...]
> [    8.044215] systemd[1]: Detected architecture arm64.
> Welcome to Debian GNU/Linux buster/sid!
>
> Debian GNU/Linux buster/sid rpi3 ttyAMA0
>
> rpi3 login: root
> Password:
> Linux rpi3 4.14.0-3-arm64 #1 SMP Debian 4.14.12-2 (2018-01-06) aarch64
> root@rpi3:~#
>
> I'll look for a newer kernel.

I'm a bit confuse since I can boot a 4.19 kernel:

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 4.19.0 (gokrazy@docker) (gcc version
6.3.0 20170516 (Debian 6.3.0-18)) #1 SMP PREEMPT Wed Mar 1 20:57:29
UTC 2017
[    0.000000] Machine model: Raspberry Pi 3 Model B
[    0.000000] earlycon: pl11 at MMIO 0x000000003f201000 (options '')
[    0.000000] bootconsole [pl11] enabled
...
[    2.722577] Freeing unused kernel memory: 5696K
[    2.723256] Run /init as init process
Loading, please wait...
starting version 236
...
root@rpi3:~# uname -a
Linux rpi3 4.19.0 #1 SMP PREEMPT Wed Mar 1 20:57:29 UTC 2017 aarch64 GNU/Li=
nux

>
> BTW I use these QEMU command line options while testing:
>
> qemu-system-aarch64 \
>   -d unimp,guest_errors \
>   -trace bcm2835_cprman_rd_\* -trace bcm2835_cprman_wr_\* \
>   ...
>
> And the cmdline suggested by Peter:
>
>   -append "rw earlycon=3Dpl011,0x3f201000 console=3DttyAMA0 loglevel=3D8
> root=3D/dev/mmcblk0p2 fsck.repair=3Dyes net.ifnames=3D0 rootwait memtest=
=3D1"
>
> [1] https://translatedcode.wordpress.com/2018/04/25/debian-on-qemus-raspb=
erry-pi-3-model/
>
> >
> > [   45.683302] Run /sbin/init as init process

init is ran way after A2W register accesses, so I doubt they are the
problem here.

Can you provide me your testing setup?

Thanks,

Phil.

> > [   50.745961] random: dd: uninitialized urandom read (512 bytes read)
> > [   77.478266] Writes:  Total: 2074828  Max/Min: 0/0   Fail: 0
> >
> > ... then nothing else until I abort the session.
> >
> > This is with the series applied on top of master.
> >
> > Guenter
> >
> > > I kept Guenter S-o-b and (C), is that OK? (Guenter?, Peter?)
> > >
> > > - patches 1, 7: obvious updates in MAINTAINERS
> > > - patches 3, 4: simple cleanups
> > > - patches 2, 5: add UNIMP code
> > > - patch 6: add the cprman (KISS init values from Guenter)
> > >
> > > Peter: can you take patch #1 for 3.1?
> > >
> > > Regards,
> > >
> > > Phil.
> > >
> > > Philippe Mathieu-Daud=C3=A9 (7):
> > >    MAINTAINERS: Add an entry for the Raspberry Pi machines
> > >    hw/misc/bcm2835_property: Handle the 'domain state' property
> > >    hw/arm/bcm2835: Use 0x prefix for hex numbers
> > >    hw/arm/bcm2835: Rename some definitions
> > >    hw/arm/bcm2835: Add various unimplemented peripherals
> > >    hw/arm/bcm2835: Add basic support for cprman (clock subsystem)
> > >    MAINTAINERS: Volunteer to review Raspi patches
> > >
> > >   MAINTAINERS                          |   7 +
> > >   hw/arm/bcm2835_peripherals.c         |  42 +++-
> > >   hw/char/bcm2835_aux.c                |   2 +-
> > >   hw/intc/bcm2836_control.c            |   4 +-
> > >   hw/misc/Makefile.objs                |   1 +
> > >   hw/misc/bcm2835_cprman.c             | 277 ++++++++++++++++++++++++=
+++
> > >   hw/misc/bcm2835_property.c           |   8 +-
> > >   hw/misc/trace-events                 |   8 +
> > >   include/hw/arm/bcm2835_peripherals.h |  11 ++
> > >   include/hw/arm/raspi_platform.h      |   6 +-
> > >   include/hw/misc/bcm2835_cprman.h     |  28 +++
> > >   11 files changed, 387 insertions(+), 7 deletions(-)
> > >   create mode 100644 hw/misc/bcm2835_cprman.c
> > >   create mode 100644 include/hw/misc/bcm2835_cprman.h
> > >
> >
