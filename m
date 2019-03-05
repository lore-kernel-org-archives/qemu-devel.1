Received: from eggs.gnu.org ([209.51.188.92]:41959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1JoL-0002KN-6Z
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1JoH-0002iQ-AN
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:49:23 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:17960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1Jo6-0002PA-4j
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:49:12 -0500
Date: Wed, 6 Mar 2019 00:48:59 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190305053842.m2u5ahgztybbzpaj@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1903052357200.40521@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1903041535050.72040@zero.eik.bme.hu>
	<20190305053842.m2u5ahgztybbzpaj@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] Question about hardware cursor in VGA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 5 Mar 2019, Gerd Hoffmann wrote:
> On Mon, Mar 04, 2019 at 03:58:00PM +0100, BALATON Zoltan wrote:
>> Hello,
>>
>> I'm trying to implement hardware cursor for ati-vga before submitting the
>> last version of it before the freeze.
>
> Use dpy_cursor_define().

I've done that but it's not working very well. The mouse pointer is quite 
jumpy with this and there are some problems updating the pointer image 
when the guest changes image data in video ram without changing registers. 
(Like when it sets cursor data offset first, then writes image data in 
memory after that but QEMUCursor is created from the still empty data on 
setting the register.) I've managed to solve this latter problem (at least 
for the guest I care about) by allowing some unnecessary cursor updates 
but position changes remain erratic. I'll submit this version (after some 
more checking of 2d functions which still don't work well beyond simple 
cases) because at least doing hw cursor like this works somewhat but I 
note that the other version with cursor_invalidate and cursor_draw_line 
callbacks worked much smoother, alas I've found that cannot work with 
shared_surface.

I'm not sure what causes this pointer position update problem. Could it be 
that pointer position updates are now independent of screen refresh with 
dpy_mouse_move so there's a higher chance of doing big jumps where the 
invalidate/draw_line callbacks were called from display update so they've 
sampled mouse position in smaller steps somehow? Or is it because mouse 
pointer is now a real hardware cursor which can be moved independent of 
the guest but any guest update will warp it back to where the guest thinks 
it should be? (Also note that draw_line callback could do complement 
pixels but that's not possible with dpy_cursor_define.)

This also reminds me that jumpy mouse problem was also reported with MacOS 
guests before with the gtk UI I think 
(https://www.emaculation.com/forum/viewtopic.php?f=34&t=9750) but not sure 
if that's related to this or not. Also not sure what would be the best way 
to improve this: reviving at least the mouse invalidate callback and do 
dpy_mouse_move from there instead of calling it on register change? Or 
also fixing the draw_cursor_line callback with shared surface maybe by 
providing a separate surface for the mouse in that case for the device 
model to render the mouse into which then can be composited on the display 
surface somehow by the frontend? This may be problematic for remote 
displays and may also loose the advantage of the shared surface unless 
there's some hardware support for this so I'm not sure about that. But at 
least the jumpy cursor should be fixed somehow because that makes user 
experience with hardware cursor quite bad.

Regards,
BALATON Zoltan
