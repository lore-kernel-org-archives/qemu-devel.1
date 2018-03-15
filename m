Received: from eggs.gnu.org ([2001:4830:134:3::10]:59284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bill.Paul@windriver.com>) id 1ewamD-00071v-Us
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bill.Paul@windriver.com>) id 1ewamA-0001st-P3
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:51:10 -0400
Received: from mail1.windriver.com ([147.11.146.13]:43325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Bill.Paul@windriver.com>)
	id 1ewamA-0001pw-Ft
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:51:06 -0400
From: Bill Paul <wpaul@windriver.com>
Date: Thu, 15 Mar 2018 14:49:53 -0700
References: <20180315191141.6789-1-andrew.smirnov@gmail.com>
	<20180315191141.6789-2-andrew.smirnov@gmail.com>
	<201803151345.27840.wpaul@windriver.com>
In-Reply-To: <201803151345.27840.wpaul@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <201803151449.53540.wpaul@windriver.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] char: i.MX: Add support for "TX
 complete" interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Of all the gin joints in all the towns in all the world, Bill Paul had to walk 
into mine at 13:45 on Thursday 15 March 2018 and say:

> Of all the gin joints in all the towns in all the world, Andrey Smirnov had
> to
> 
> walk into mine at 12:11 on Thursday 15 March 2018 and say:
> > Add support for "TX complete"/TXDC interrupt generate by real HW since
> > it is needed to support guests other than Linux.
> > 
> > Based on the patch by Bill Paul as found here:
> > https://bugs.launchpad.net/qemu/+bug/1753314
> > 
> > Cc: qemu-devel@nongnu.org
> > Cc: qemu-arm@nongnu.org
> > Cc: Bill Paul <wpaul@windriver.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> > 
> > Bill:
> > 
> > I only tested this with i.MX7/Linux guest combo and am hoping you can
> > take this and previous patch and give it a try on your VxWorks setup.
> 
> I tried it and it seems to work as well as my original patch did. There is
> one thing I noticed, which is that when printing a lot of output to the
> console, sometimes the output will stall until you press a key to generate
> an input interrupt, and then it resumes. This happens with my original
> patch too. My suspicion is that this has to do with the lack of emulation
> of the FIFO feature of the i.MX6 UART, but I'm not certain. (It's still
> much better than not having it work at all, so I didn't really mind this.
> :) ) All I know for sure is that the stalls don't happen on real hardware.

In retrospect, I think the problem may not be with the UART emulation. I went 
back and created a uniprocessor VxWorks image instead of an SMP image, and it 
doesn't seem to have the same stall behavior.

I added a vxWorks_up image to the URL below so that you can try that too. It 
may well be that having more than a 1 byte FIFO would fix the problem with the 
SMP image too, but I don't want to force you to implement that. If you want to 
try to fix the issue, great, otherwise I am happy with the patch as it is, so 
I will provide this:

Signed-off-by: Bill Paul <wpaul@windriver.com>

-Bill

> 
> FYI, I uploaded a sample VxWorks image that you can use for testing. You
> can find it here:
> 
> http://people.freebsd.org/~wpaul/qemu/sabrelite
> 
> The file vxWorks is the kernel, which is really all you need. This is an
> SMP image so you need to run QEMU with the -smp 4 option. The uVxWorks
> image and .dtb file are used on a real board with U-Boot and the bootm
> command. The qemu_imx.sh script contains the options I use for testing. I
> usually do:
> 
> % qemu_imx.sh vxWorks
> 
> You can download all the files at once by grabbing:
> 
> http://people.freebsd.org/~wpaul/qemu/sabrelite/vxworks_test.zip
> 
> At the -> prompt, you can type the following things (among others):
> 
> -> i -- show running task info
> -> vxbIoctlShow -- show VxBus device tree
> -> vxbDevShow -- show VxBus device tree in a different format
> -> vxbDrvShow -- show VxBus drivers
> -> vxbIntShow -- show information about interrupt bindings
> -> vmContextShow -- show MMU mappings
> -> memShow -- show heap usage
> -> ifconfig -- show network interfaces
> -> routec "show" -- show network routing table
> -> netstat "-a" -- show network socket info
> 
> The image also includes network support. You can use ifconfig to set the
> enet0 interface's addresss like this:
> 
> -> ifconfig "enet0 10.0.2.15 netmask 255.255.255.0 up"
> 
> You should then be able to telnet to the VxWorks image from the host
> machine by doing:
> 
> % telnet localhost 10023
> 
> To exit the telnet session, type logout:
> 
> -> logout
> 
> NOTE: this only works if you've patched the imx_fec module to fix the
> interrupt vector bug that I also reported.
> 
> If you run vxbIoctlShow, which generates a lot of output, you should be
> able to see the stall condition I'm talking about. If you don't, then
> maybe it has something to do with me running QEMU on FreeBSD.
> 
> > Peter:
> > 
> > Bill is the author of original code, so I am not sure how to handle
> > Signed-off-by from him. I'd like to add it to this patch, but since
> > his original submission to launchpad didn't have one it is currently
> > omitted.
> 
> My original goal was to report the bug and provide as much info as I could
> on how to maybe fix it, and let somebody else make a proper fix/patch.
> 
> -Bill
> 
> >  include/hw/char/imx_serial.h |  3 +++
> >  hw/char/imx_serial.c         | 20 +++++++++++++++++---
> >  2 files changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
> > index baeec3183f..5b99cee7cf 100644
> > --- a/include/hw/char/imx_serial.h
> > +++ b/include/hw/char/imx_serial.h
> > @@ -67,6 +67,8 @@
> > 
> >  #define UCR2_RXEN       (1<<1)    /* Receiver enable */
> >  #define UCR2_SRST       (1<<0)    /* Reset complete */
> > 
> > +#define UCR4_TCEN       BIT(3)    /* TX complete interrupt enable */
> > +
> > 
> >  #define UTS1_TXEMPTY    (1<<6)
> >  #define UTS1_RXEMPTY    (1<<5)
> >  #define UTS1_TXFULL     (1<<4)
> > 
> > @@ -95,6 +97,7 @@ typedef struct IMXSerialState {
> > 
> >      uint32_t ubmr;
> >      uint32_t ubrc;
> >      uint32_t ucr3;
> > 
> > +    uint32_t ucr4;
> > 
> >      qemu_irq irq;
> >      CharBackend chr;
> > 
> > diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
> > index d1e8586280..1e5540472b 100644
> > --- a/hw/char/imx_serial.c
> > +++ b/hw/char/imx_serial.c
> > @@ -37,8 +37,8 @@
> > 
> >  static const VMStateDescription vmstate_imx_serial = {
> >  
> >      .name = TYPE_IMX_SERIAL,
> > 
> > -    .version_id = 1,
> > -    .minimum_version_id = 1,
> > +    .version_id = 2,
> > +    .minimum_version_id = 2,
> > 
> >      .fields = (VMStateField[]) {
> >      
> >          VMSTATE_INT32(readbuff, IMXSerialState),
> >          VMSTATE_UINT32(usr1, IMXSerialState),
> > 
> > @@ -50,6 +50,7 @@ static const VMStateDescription vmstate_imx_serial = {
> > 
> >          VMSTATE_UINT32(ubmr, IMXSerialState),
> >          VMSTATE_UINT32(ubrc, IMXSerialState),
> >          VMSTATE_UINT32(ucr3, IMXSerialState),
> > 
> > +        VMSTATE_UINT32(ucr4, IMXSerialState),
> > 
> >          VMSTATE_END_OF_LIST()
> >      
> >      },
> >  
> >  };
> > 
> > @@ -71,6 +72,11 @@ static void imx_update(IMXSerialState *s)
> > 
> >       * unfortunately.
> >       */
> >      
> >      mask = (s->ucr1 & UCR1_TXMPTYEN) ? USR2_TXFE : 0;
> > 
> > +    /*
> > +     * TCEN and TXDC are both bit 3
> > +     */
> > +    mask |= s->ucr4 & UCR4_TCEN;
> > +
> > 
> >      usr2 = s->usr2 & mask;
> >      
> >      qemu_set_irq(s->irq, usr1 || usr2);
> > 
> > @@ -163,6 +169,8 @@ static uint64_t imx_serial_read(void *opaque, hwaddr
> > offset, return s->ucr3;
> > 
> >      case 0x23: /* UCR4 */
> > 
> > +        return s->ucr4;
> > +
> > 
> >      case 0x29: /* BRM Incremental */
> >      
> >          return 0x0; /* TODO */
> > 
> > @@ -191,8 +199,10 @@ static void imx_serial_write(void *opaque, hwaddr
> > offset, * qemu_chr_fe_write and background I/O callbacks */
> > 
> >              qemu_chr_fe_write_all(&s->chr, &ch, 1);
> >              s->usr1 &= ~USR1_TRDY;
> > 
> > +            s->usr2 &= ~USR2_TXDC;
> > 
> >              imx_update(s);
> >              s->usr1 |= USR1_TRDY;
> > 
> > +            s->usr2 |= USR2_TXDC;
> > 
> >              imx_update(s);
> >          
> >          }
> >          break;
> > 
> > @@ -265,8 +275,12 @@ static void imx_serial_write(void *opaque, hwaddr
> > offset, s->ucr3 = value & 0xffff;
> > 
> >          break;
> > 
> > -    case 0x2d: /* UTS1 */
> > 
> >      case 0x23: /* UCR4 */
> > 
> > +        s->ucr4 = value & 0xffff;
> > +        imx_update(s);
> > +        break;
> > +
> > +    case 0x2d: /* UTS1 */
> > 
> >          qemu_log_mask(LOG_UNIMP, "[%s]%s: Unimplemented reg 0x%"
> >          
> >                        HWADDR_PRIx "\n", TYPE_IMX_SERIAL, __func__,
> > 
> > offset); /* TODO */
-- 
=============================================================================
-Bill Paul            (510) 749-2329 | Senior Member of Technical Staff,
                 wpaul@windriver.com | Master of Unix-Fu - Wind River Systems
=============================================================================
   "I put a dollar in a change machine. Nothing changed." - George Carlin
=============================================================================
