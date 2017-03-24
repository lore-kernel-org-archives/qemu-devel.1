Received: from eggs.gnu.org ([2001:4830:134:3::10]:40401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1crPOm-00019g-Vi
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1crPOm-0001o5-2o
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:37:01 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1crPOl-0001ne-TC
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:37:00 -0400
Received: by mail-wm0-x229.google.com with SMTP id t189so2472510wmt.1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 06:36:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489673540.15659.93.camel@redhat.com>
References: <20170316120110.11677-1-iwona260909@gmail.com>
	<20170316120110.11677-2-iwona260909@gmail.com>
	<CAFEAcA8ZBAAqYNbh_3J69W5SMXRsbW4S367Xe8ceF1C0M-RNnA@mail.gmail.com>
	<1489673540.15659.93.camel@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 24 Mar 2017 13:36:58 +0000
Message-ID: <CAJSP0QX3z_Zn-jdi7=2qw795Ep2nG5xvWR9DqyWajnKjkCGd3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Dead code removal: removing code for
 unsupported DEPTH.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: iwona260909@gmail.com
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Mar 16, 2017 at 2:12 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> > -#define DEPTH 8
>> > -#include "cirrus_vga_rop2.h"
>> > -
>> > -#define DEPTH 16
>> > -#include "cirrus_vga_rop2.h"
>> > -
>> > -#define DEPTH 24
>> > -#include "cirrus_vga_rop2.h"
>> > -
>> >  #define DEPTH 32
>> >  #include "cirrus_vga_rop2.h"
>
> No.  It isn't *that* simple.  The cirrus blitter operates on the guest
> framebuffer, which can have any format the guest wishes it to have.
> This is *not* about rendering into a 32bpp DisplaySurface.

Gerd, please reply if this is wrong, but here is a summary of the task:

Some emulated graphics cards use qemu_console_surface() and that
surface is always in 32 bits per pixel format.  Therefore, code for
dealing with other pixel formats can be removed.

When looking for emulated graphics cards where this cleanup is
possible, keep in mind that some of the code operates on the guest's
frame buffer, whose pixel format is not under QEMU's control.
Therefore we cannot assume that 32bpp is always used and this cleanup
doesn't apply there.  Limit yourself to code that uses
qemu_console_surface() exclusively to access the surface and you
should be fine.  Other code is likely to need support for additional
pixel formats.

One example is hw/display/milkymist-vgafb.c:

static void vgafb_update_display(void *opaque)
{
    DisplaySurface *surface = qemu_console_surface(s->con);
    ...
    switch (surface_bits_per_pixel(surface)) {
    case 0:
        return;
    case 8:
        fn = draw_line_8;
        break;
    case 15:
        fn = draw_line_15;
        dest_width *= 2;
        break;
    case 16:
        fn = draw_line_16;
        dest_width *= 2;
        break;
    case 24:
        fn = draw_line_24;
        dest_width *= 3;
        break;
    case 32:
        fn = draw_line_32;
        dest_width *= 4;
        break;

All cases except for 32 are dead code (they will never execute).  The
hw/display/milkymist-vgafb_template.h file can be deleted.
draw_line_32() can be macro expanded and moved into
hw/display/milkymist-vgafb.c.

Stefan
