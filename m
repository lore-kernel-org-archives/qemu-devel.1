Received: from eggs.gnu.org ([2001:4830:134:3::10]:49723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fZLqi-0003B6-Ji
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 15:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fZLqf-0003z3-Hb
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 15:48:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1fZLqf-0003yJ-BD
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 15:47:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so4289202wmc.0
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 12:47:57 -0700 (PDT)
Date: Sat, 30 Jun 2018 21:47:53 +0200
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20180630214753.37119dd3@thl530.multi.box>
In-Reply-To: <CAFEAcA8n_qgGgtn055dGkAjHNPbE9d-dRDtfJGMcfhBg_x_Y5g@mail.gmail.com>
References: <20180630083357.23489-1-huth@tuxfamily.org>
	<20180630083357.23489-2-huth@tuxfamily.org>
	<CAFEAcA8n_qgGgtn055dGkAjHNPbE9d-dRDtfJGMcfhBg_x_Y5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/4] m68k: Add NeXTcube framebuffer
 device emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Natalia Portillo <claunia@claunia.com>, Laurent Vivier <laurent@vivier.eu>, Bryce Lanham <blanham@gmail.com>

Am Sat, 30 Jun 2018 17:12:01 +0100
schrieb Peter Maydell <peter.maydell@linaro.org>:

> On 30 June 2018 at 09:33, Thomas Huth <huth@tuxfamily.org> wrote:
> > The NeXTcube uses a linear framebuffer with 4 greyscale colors and
> > a fixed resolution of 1120 * 832.
> > This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch
> > at
> >
> >  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-fb.c
> >
> > and altered to fit the latest interface of the current QEMU (e.g.
> > the device has been "qdev"-ified etc.).
> >
> > Signed-off-by: Thomas Huth <huth@tuxfamily.org>  
> 
> > +static void nextfb_realize(DeviceState *dev, Error **errp)
> > +{
> > +    NeXTFbState *s = NEXTFB(dev);
> > +
> > +    memory_region_allocate_system_memory(&s->fb_mr, NULL,
> > "next.video",
> > +                                         0x1CB100);  
> 
> memory_region_allocate_system_memory() is for allocating
> a machine model's main memory, not for things like video
> framebuffer RAM. (See the doc comment in memory.h.)

That comment recommends memory_region_allocate_aux_memory(), but
that function does not exist (anymore)?

> > +    memory_region_add_subregion(get_system_memory(), 0xB000000,
> > &s->fb_mr);  
> 
> Devices shouldn't directly add memory regions into
> system memory. Instead they should expose sysbus
> memory regions which the board model then maps into
> the right place.

Ok, ... so just to make sure that I've got you right: The device
should call memory_region_init_ram() in it's realize function and the
board code should then call sysbus_mmio_map() with that region, right?

 Thomas
