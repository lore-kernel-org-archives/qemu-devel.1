Received: from eggs.gnu.org ([209.51.188.92]:43512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1try-0004Ws-2r
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1trw-0008BA-7a
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:19:34 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:65210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1tru-00086E-Fq
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:19:31 -0500
Date: Thu, 7 Mar 2019 15:19:25 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190307064332.mvxhuaopgpdtp3za@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1903071507470.53555@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1903041535050.72040@zero.eik.bme.hu>
	<20190305053842.m2u5ahgztybbzpaj@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1903052357200.40521@zero.eik.bme.hu>
	<20190306060744.dxq75ak2knmzv4kv@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1903061440270.30260@zero.eik.bme.hu>
	<20190307064332.mvxhuaopgpdtp3za@sirius.home.kraxel.org>
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

On Thu, 7 Mar 2019, Gerd Hoffmann wrote:
> On Wed, Mar 06, 2019 at 02:50:36PM +0100, BALATON Zoltan wrote:
>> On Wed, 6 Mar 2019, Gerd Hoffmann wrote:
>>> On Wed, Mar 06, 2019 at 12:48:59AM +0100, BALATON Zoltan wrote:
>>>> On Tue, 5 Mar 2019, Gerd Hoffmann wrote:
>>>>> Use dpy_cursor_define().
>>>>
>>>> I've done that but it's not working very well. The mouse pointer is quite
>>>> jumpy with this and there are some problems updating the pointer image when
>>>> the guest changes image data in video ram without changing registers. (Like
>>>
>>> When using a relative pointing device (i.e. mouse instead of tablet) you
>>> also need dpy_mouse_set(), to update the host mouse position when the
>>> guest moves the cursor sprite around.
>>
>> Sure, I figured that out otherwise the mouse pointer would not move.
>>
>>> Is it possible to figure where the cursor hotspot is?
>>
>> Not sure what you mean. I call dpy_mouse_set() on writing the reg that
>> contains mouse position. Hot spot is always top left of sprite (or I don't
>> know where it's set). I'll submit a v5 after adding some more checks to make
>> it a bit safer then you can have a look.
>
> Well, paravirtual graphics devices propagate the hot-spot information
> from the guest to the host.  But on real hardware you typically don't
> have registers for that information as the GPU doesn't need to know the
> hotspot for cursor display.  The guest driver can simply take the
> hotspot location into account when programming the cursor position into
> the hardware registers.
>
> So, the suggestion to use dpy_cursor_define() wasn't a good one after
> all.  I totally forgot about the hotspot issue as I work with
> paravirtual graphics devices most of the time.  Sorry for that.

Hmm, OK but this still does not explain why mouse is jumping when it's 
just moved around without changing the image.

>>>> least doing hw cursor like this works somewhat but I note that the other
>>>> version with cursor_invalidate and cursor_draw_line callbacks worked much
>>>> smoother, alas I've found that cannot work with shared_surface.
>>>
>>> There is a VGAComminState->force_shadow ...
>>
>> Yes, but that would also make things slower so I like to keep advantage of
>> shared_surface and try to fix the jumpy mouse we get with define_cursor
>> instead if possible.
>
> Its not so much a performance issue.  But you need a round-trip to the
> guest to update the cursor position, which adds noticeable latency to
> mouse moves ...

It's not a big performance issue when rendering the mouse but may be when 
rendering the screen having to copy contents to the display surface at 
each refresh (at least the part that changed) instead of using it directly 
from guest VRAM with shared_surface where this copy is avoided if I got 
that right.

I still have the unfinished version using the callbacks which might work 
with force_shadow like for cirrus but I'd need to finish and clean that 
up. Now that we have both implemented probably will allow switching 
between them but may not be able to do it before the freeze so don't wait 
for that. (The define_cursor way is enough for testing at the moment and 
rewriting it to use different callback could be considered bugfix or 
added in next devel cycle as well.)

Regards,
BALATON Zoltan
