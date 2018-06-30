Received: from eggs.gnu.org ([2001:4830:134:3::10]:51683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZM99-0008HL-0V
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZM97-0006ph-Nf
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:07:02 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZM97-0006p1-H7
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 16:07:01 -0400
Received: by mail-oi0-x244.google.com with SMTP id k81-v6so11427872oib.4
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 13:07:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180630214753.37119dd3@thl530.multi.box>
References: <20180630083357.23489-1-huth@tuxfamily.org>
	<20180630083357.23489-2-huth@tuxfamily.org>
	<CAFEAcA8n_qgGgtn055dGkAjHNPbE9d-dRDtfJGMcfhBg_x_Y5g@mail.gmail.com>
	<20180630214753.37119dd3@thl530.multi.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Jun 2018 21:06:40 +0100
Message-ID: <CAFEAcA_Ui6rzg1qxVcQq1gS8-r5cLhUg-AJaxQh+ZrfMtU571g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Thomas Huth <huth@tuxfamily.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Natalia Portillo <claunia@claunia.com>, Laurent Vivier <laurent@vivier.eu>, Bryce Lanham <blanham@gmail.com>

On 30 June 2018 at 20:47, Thomas Huth <huth@tuxfamily.org> wrote:
> Am Sat, 30 Jun 2018 17:12:01 +0100
> schrieb Peter Maydell <peter.maydell@linaro.org>:
>
>> On 30 June 2018 at 09:33, Thomas Huth <huth@tuxfamily.org> wrote:
>> > The NeXTcube uses a linear framebuffer with 4 greyscale colors and
>> > a fixed resolution of 1120 * 832.
>> > This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch
>> > at
>> >
>> >  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-fb.c
>> >
>> > and altered to fit the latest interface of the current QEMU (e.g.
>> > the device has been "qdev"-ified etc.).
>> >
>> > Signed-off-by: Thomas Huth <huth@tuxfamily.org>
>>
>> > +static void nextfb_realize(DeviceState *dev, Error **errp)
>> > +{
>> > +    NeXTFbState *s = NEXTFB(dev);
>> > +
>> > +    memory_region_allocate_system_memory(&s->fb_mr, NULL,
>> > "next.video",
>> > +                                         0x1CB100);
>>
>> memory_region_allocate_system_memory() is for allocating
>> a machine model's main memory, not for things like video
>> framebuffer RAM. (See the doc comment in memory.h.)
>
> That comment recommends memory_region_allocate_aux_memory(), but
> that function does not exist (anymore)?

Oops, good catch. That's a leftover comment that should have
been updated -- we changed the function name during discussion
of the patchset, I think, but I forgot to fix the comment.
I'll send a patch to fix that next week.

You want memory_region_init_ram() (which does both the MR
init and the mark-this-ram-for-migration).

>> > +    memory_region_add_subregion(get_system_memory(), 0xB000000,
>> > &s->fb_mr);
>>
>> Devices shouldn't directly add memory regions into
>> system memory. Instead they should expose sysbus
>> memory regions which the board model then maps into
>> the right place.
>
> Ok, ... so just to make sure that I've got you right: The device
> should call memory_region_init_ram() in it's realize function and the
> board code should then call sysbus_mmio_map() with that region, right?

The device should call memory_region_init_ram() and then
sysbus_init_mmio(); then the board code can call
sysbus_mmio_map().

I have a feeling that for framebuffer devices you should
also do something involving DIRTY_MEMORY_VGA, but I'm
not really familiar enough with the display code to say
for sure.

thanks
-- PMM
