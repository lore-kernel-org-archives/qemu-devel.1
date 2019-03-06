Received: from eggs.gnu.org ([209.51.188.92]:39918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1Wwj-0007p9-51
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1WwZ-0001yS-RS
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:50:51 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:31360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1WwT-0001uD-IE
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:50:42 -0500
Date: Wed, 6 Mar 2019 14:50:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190306060744.dxq75ak2knmzv4kv@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1903061440270.30260@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1903041535050.72040@zero.eik.bme.hu>
	<20190305053842.m2u5ahgztybbzpaj@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1903052357200.40521@zero.eik.bme.hu>
	<20190306060744.dxq75ak2knmzv4kv@sirius.home.kraxel.org>
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

On Wed, 6 Mar 2019, Gerd Hoffmann wrote:
> On Wed, Mar 06, 2019 at 12:48:59AM +0100, BALATON Zoltan wrote:
>> On Tue, 5 Mar 2019, Gerd Hoffmann wrote:
>>> Use dpy_cursor_define().
>>
>> I've done that but it's not working very well. The mouse pointer is quite
>> jumpy with this and there are some problems updating the pointer image when
>> the guest changes image data in video ram without changing registers. (Like
>
> When using a relative pointing device (i.e. mouse instead of tablet) you
> also need dpy_mouse_set(), to update the host mouse position when the
> guest moves the cursor sprite around.

Sure, I figured that out otherwise the mouse pointer would not move.

> Is it possible to figure where the cursor hotspot is?

Not sure what you mean. I call dpy_mouse_set() on writing the reg that 
contains mouse position. Hot spot is always top left of sprite (or I don't 
know where it's set). I'll submit a v5 after adding some more checks to 
make it a bit safer then you can have a look.

>> least doing hw cursor like this works somewhat but I note that the other
>> version with cursor_invalidate and cursor_draw_line callbacks worked much
>> smoother, alas I've found that cannot work with shared_surface.
>
> There is a VGAComminState->force_shadow ...

Yes, but that would also make things slower so I like to keep advantage of 
shared_surface and try to fix the jumpy mouse we get with define_cursor 
instead if possible.

>> should be? (Also note that draw_line callback could do complement pixels but
>> that's not possible with dpy_cursor_define.)
>
> Yep, dpy_cursor_define is designed for the way modern hardware handles
> hardware cursors, to allow it being used as hardware cursor on the host.
> cirrus has a few modes which modern hardware can't do, thats why it
> doesn't use dpy_cursor_define.
>
> Has ati cursor a complement pixel mode too?

Yes, this part dates back to first ATI VGA chips is seem and has the 2 bit 
Windows mouse encoding (fg, bg, transparent, complement) but we can 
probably live without that if it gives us faster display for a few bad 
pixels in mouse pointer.

Regards,
BALATON Zoltan
