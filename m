Received: from eggs.gnu.org ([2001:4830:134:3::10]:40896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <omar.rizwan@gmail.com>) id 1cwjcf-0001E7-Ff
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 02:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <omar.rizwan@gmail.com>) id 1cwjce-0000oA-CM
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 02:13:21 -0400
MIME-Version: 1.0
In-Reply-To: <DM2PR21MB00601A5A86C3F935CCCBAC0D9E0F0@DM2PR21MB0060.namprd21.prod.outlook.com>
References: <20170408054318.19830-1-omar.rizwan@gmail.com>
	<DM2PR21MB00601A5A86C3F935CCCBAC0D9E0F0@DM2PR21MB0060.namprd21.prod.outlook.com>
From: Omar Rizwan <omar.rizwan@gmail.com>
Date: Fri, 7 Apr 2017 23:13:18 -0700
Message-ID: <CAJ=RBN+VF1ysQ39NELKY7dK75aMGcB-iDDGy_sFooC6pTf1rBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] raspi: Add Raspberry Pi 1 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

Hi Andrew --

On Fri, Apr 7, 2017 at 10:57 PM Andrew Baumann
<Andrew.Baumann@microsoft.com> wrote:
>
> Hi Omar,
>
> > From: Omar Rizwan [mailto:omar.rizwan@gmail.com]
> > Sent: Friday, 7 April 2017 22:43
>
> Did you do any testing of this? One of the reasons I never got around to =
upstreaming this was that I couldn't get Raspbian working reliably (there w=
as some problem with stalled DMA reads from the MMC controller), and I didn=
't have the cycles to debug it further. Also, IIRC Raspbian on pi1 depended=
 on the system timer devices, so it might not make sense to have this board=
-level support without adding that first.


I did test Raspbian on the raspi machine and maybe encountered the
same issue you did (or, more likely, a systimer related issue);
it would just hang in a loop with program counter at 0xC000A000.

But my use for this is bare-metal code, which works OK.
(Is there some standard that the machine should run Linux before
getting upstreamed?)

I'd like to upstream the system timer next, anyway.

>
> > --- a/hw/arm/bcm2835_peripherals.c
> > +++ b/hw/arm/bcm2835_peripherals.c
> > @@ -34,6 +34,7 @@ static void bcm2835_peripherals_init(Object *obj)
> >      /* Internal memory region for peripheral bus addresses (not export=
ed) */
> >      memory_region_init(&s->gpu_bus_mr, obj, "bcm2835-gpu", (uint64_t)1=
 <<
> > 32);
> >      object_property_add_child(obj, "gpu-bus", OBJECT(&s->gpu_bus_mr),
> > NULL);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->gpu_bus_mr);
> >
> >      /* Internal memory region for request/response communication with
> >       * mailbox-addressable peripherals (not exported)
>
> This line looks like it might have snuck in by accident?


Do you recall why that line was removed? bcm2835_realize fails without
it, because the second sysbus_mmio_map_overlap call

sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 1,
                            0x40000000, 1);

fails this assertion in sysbus.c, in sysbus_mmio_map_common:

assert(n >=3D 0 && n < dev->num_mmio);

I can't easily find documentation for that 0x40000000 memory mapping,
which I figured I'd keep in; should it just be removed from bcm2835?
Am I misunderstanding something?

>
>
> Andrew


thanks,
Omar
