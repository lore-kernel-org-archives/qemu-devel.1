Received: from eggs.gnu.org ([2001:4830:134:3::10]:37839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gIUAR-0007pW-KA
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gITwE-00048c-7y
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:32:18 -0400
MIME-Version: 1.0
References: <20181102001303.32640-1-f4bug@amsat.org>
	<b32bf2a0-08ac-6b16-6372-455f9a239f9f@roeck-us.net>
In-Reply-To: <b32bf2a0-08ac-6b16-6372-455f9a239f9f@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 2 Nov 2018 08:32:00 +0100
Message-ID: <CAAdtpL6VCf+hyK7GGtoiC8KLAL2DJtaYomwhcY7Mz2OxMg2AiA@mail.gmail.com>
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

Hi Guenter,

On Fri, Nov 2, 2018 at 3:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/1/18 5:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi,
> >
> > This series is a mix of a previous work I had for the raspi, and a patc=
h from
> > Guenter: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03153=
.html
> >
> > The final patch keep Guenter ideas and comments, but is mostly a rewrit=
e.
> > I dropped the A2W code from this work, it doesn't seems unuseful to me.
> >
> > Guenter can you test this series?
> >
>
> arm/raspi2 works, but aarch64/raspi3 stalls.

Thanks for testing it!

So I suppose the A2W is required. And I'm probably using a too old kernel,
I'm using the Buster preview following Peter's post [1]:

[    0.000000] Linux version 4.14.0-3-arm64
(debian-kernel@lists.debian.org) (gcc version 7.2.0 (Debian 7.2.0-18))
#1 SMP Debian 4.14.12-2 (2018-01-06)
[    0.000000] Machine model: Raspberry Pi 3 Model B
[...]
[    8.044215] systemd[1]: Detected architecture arm64.
Welcome to Debian GNU/Linux buster/sid!

Debian GNU/Linux buster/sid rpi3 ttyAMA0

rpi3 login: root
Password:
Linux rpi3 4.14.0-3-arm64 #1 SMP Debian 4.14.12-2 (2018-01-06) aarch64
root@rpi3:~#

I'll look for a newer kernel.

BTW I use these QEMU command line options while testing:

qemu-system-aarch64 \
  -d unimp,guest_errors \
  -trace bcm2835_cprman_rd_\* -trace bcm2835_cprman_wr_\* \
  ...

And the cmdline suggested by Peter:

  -append "rw earlycon=3Dpl011,0x3f201000 console=3DttyAMA0 loglevel=3D8
root=3D/dev/mmcblk0p2 fsck.repair=3Dyes net.ifnames=3D0 rootwait memtest=3D=
1"

[1] https://translatedcode.wordpress.com/2018/04/25/debian-on-qemus-raspber=
ry-pi-3-model/

>
> [   45.683302] Run /sbin/init as init process
> [   50.745961] random: dd: uninitialized urandom read (512 bytes read)
> [   77.478266] Writes:  Total: 2074828  Max/Min: 0/0   Fail: 0
>
> ... then nothing else until I abort the session.
>
> This is with the series applied on top of master.
>
> Guenter
>
> > I kept Guenter S-o-b and (C), is that OK? (Guenter?, Peter?)
> >
> > - patches 1, 7: obvious updates in MAINTAINERS
> > - patches 3, 4: simple cleanups
> > - patches 2, 5: add UNIMP code
> > - patch 6: add the cprman (KISS init values from Guenter)
> >
> > Peter: can you take patch #1 for 3.1?
> >
> > Regards,
> >
> > Phil.
> >
> > Philippe Mathieu-Daud=C3=A9 (7):
> >    MAINTAINERS: Add an entry for the Raspberry Pi machines
> >    hw/misc/bcm2835_property: Handle the 'domain state' property
> >    hw/arm/bcm2835: Use 0x prefix for hex numbers
> >    hw/arm/bcm2835: Rename some definitions
> >    hw/arm/bcm2835: Add various unimplemented peripherals
> >    hw/arm/bcm2835: Add basic support for cprman (clock subsystem)
> >    MAINTAINERS: Volunteer to review Raspi patches
> >
> >   MAINTAINERS                          |   7 +
> >   hw/arm/bcm2835_peripherals.c         |  42 +++-
> >   hw/char/bcm2835_aux.c                |   2 +-
> >   hw/intc/bcm2836_control.c            |   4 +-
> >   hw/misc/Makefile.objs                |   1 +
> >   hw/misc/bcm2835_cprman.c             | 277 ++++++++++++++++++++++++++=
+
> >   hw/misc/bcm2835_property.c           |   8 +-
> >   hw/misc/trace-events                 |   8 +
> >   include/hw/arm/bcm2835_peripherals.h |  11 ++
> >   include/hw/arm/raspi_platform.h      |   6 +-
> >   include/hw/misc/bcm2835_cprman.h     |  28 +++
> >   11 files changed, 387 insertions(+), 7 deletions(-)
> >   create mode 100644 hw/misc/bcm2835_cprman.c
> >   create mode 100644 include/hw/misc/bcm2835_cprman.h
> >
>
