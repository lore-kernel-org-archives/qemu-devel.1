Received: from eggs.gnu.org ([209.51.188.92]:42168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guoaB-0001ip-II
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 20:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guoa8-0002E9-7N
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 20:15:55 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:42299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1guoa2-0001p9-II
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 20:15:48 -0500
Date: Sat, 16 Feb 2019 02:15:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA9aUxU4gTnpP3OKLToLttagfNWuA9UzxNGHeXNkKCWiDg@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1902160210420.81823@zero.eik.bme.hu>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-8-peter.maydell@linaro.org>
	<alpine.BSF.2.21.9999.1902150223200.49412@zero.eik.bme.hu>
	<CAFEAcA9aUxU4gTnpP3OKLToLttagfNWuA9UzxNGHeXNkKCWiDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 7/7] ui/cocoa: Perform UI operations
 only on the main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, John Arbuckle <programmingkidx@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>

On Fri, 15 Feb 2019, Peter Maydell wrote:
> On Fri, 15 Feb 2019 at 01:28, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Thu, 14 Feb 2019, Peter Maydell wrote:
>>> - (void)sendEvent:(NSEvent *)event
>>> {
>>>     COCOA_DEBUG("QemuApplication: sendEvent\n");
>>> -    [super sendEvent: event];
>>> +    if (!cocoaView || ![cocoaView handleEvent:event]) {
>>> +        [super sendEvent: event];
>>> +    }
>>
>> I think the menu problem may be because now all mouse events go to our
>> handleEvent method and it may swallow those that should operate the menus
>> somehow while previously [super sendEvent] took care of those events and
>> only left the remaining mouse events in queue? Maybe we should test in
>> handleEvent if the mouse event is within our window and forward everything
>> else to super? But I'm not sure and could be wrong, only guessing.
>
> Menus definitely did work for me (both mouse interaction and
> keyboard shortcuts), so I'm not sure why you're seeing something
> different.
>
> My understanding is that the new code should eat exactly the
> same set of events that the old code did:
> * in the old code, only our custom "pull events off the queue"
>   code took events from OSX, and it passed them to handleEvent;
>   only events handleEvent called [NSApp sendEvent] on would
>   ever get to the OSX menu/etc handling
> * in the new code, OSX's run loop takes events off the queue:
>   they go to our NSApplication sendEvent method, which passes
>   them to handleEvent. Only events that handleEvent returns false
>   for will ever get to the OSX menu/etc handling
> and (absent bugs) handleEvent should now return false for exactly
> the set of events that it previously called sendEvent on.
>
> I know menu handling in OSX is a bit odd because the menu
> drag stuff uses a 'private event loop' to handle events
> while the menu is down. Maybe something is interacting
> badly with that.

Sorry, looks like my proposed patch [ui/cocoa: Make sure app is not 
starting in the background] is the one which breaks this. After some 
recompiling menus work here as well with your series so forget about this 
patch and sorry for the false alarm. (The habit of macOS to open apps 
started from Terminal in the background is quite annoying but looks like 
it's normal and can't be fixed that easily.)

Regards,
BALATON Zoltan
