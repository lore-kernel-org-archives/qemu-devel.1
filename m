Received: from eggs.gnu.org ([209.51.188.92]:56238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1go8s8-0004qm-DU
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1go8s7-0002J3-Fl
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:30:52 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:15784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1go8s7-0002C2-4C
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:30:51 -0500
Date: Mon, 28 Jan 2019 16:30:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA-9rbjin-k-bxq=UZ_j4N2rADJ4=NWB7D9ogB1K_=7Zdw@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1901281625380.18355@zero.eik.bme.hu>
References: <83206F6D-0BA5-4781-8635-84D48DD33A2A@foghorn.io>
	<CAFEAcA-PJadBG0sE43N9wEx9Qm3Nxu2am_0Zy2Zqtz66C9SJ-w@mail.gmail.com>
	<ECFBC025-CD7F-444B-BF7F-62E20954A85A@foghorn.io>
	<CAFEAcA9M73BdXs345vdqkuQE3sxT+GnS4PWZ2OPO8DWwNtRQ-A@mail.gmail.com>
	<EC65CD28-C2F9-49D7-BDE1-9C3B5F68665E@foghorn.io>
	<47126B68-3AF7-48AB-B904-4D8EAC854BC7@foghorn.io>
	<CAFEAcA9Oc3Rg_NWkeEjYPVz8yQnBbWd0WM5UQSWNRRP9VfjonQ@mail.gmail.com>
	<alpine.BSF.2.21.9999.1901272321030.63988@zero.eik.bme.hu>
	<CAFEAcA-9rbjin-k-bxq=UZ_j4N2rADJ4=NWB7D9ogB1K_=7Zdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ben Hekster <ben.hekster@foghorn.io>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 28 Jan 2019, Peter Maydell wrote:
> On Sun, 27 Jan 2019 at 23:13, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Sun, 27 Jan 2019, Peter Maydell wrote:
>>> Unfortunately I'm not sufficiently familiar with how OSX
>>> event handling works to figure out how to plumb it back in
>>> again. It ought to be a fairly simple matter of "implement
>>> whatever method OSX sends events to on whatever of our
>>> various classes is the right one, and make it call handleEvent
>>> with the NSEvent", but I've tried a few things and haven't
>>> been able to actually get any event handling methods to
>>> fire at all :-(
>>
>> I think you need to implement keyDown: and keyUp: methods in QemuCocoaView
>> to get keyboard events and there are similar methods for mouse events,
>> see:
>>
>> https://developer.apple.com/documentation/appkit/nsview?language=objc
>
> Yeah, I got something working later last night. You also need
> to implement acceptsFirstResponder or you don't get any events.

Yes, I remembered it also has something to do with FirstResponder but did 
not recall what you need for it.

> So I have something that at least works for key events in the
> monitor window now. I need to check whether we do the right
> thing for things like cmd-key hotkeys which need to be handled
> by the stock OSX event handling. (In the old scheme we deal with
> these by having handleEvent pass them on to sendEvent, but in
> the new setup that's an infinite recursion.)
>
>> But these are a lot of methods which are supposedly called from the
>> sendEvent: method of the NSWindow containing this view so maybe a better
>> place to catch all events is there. For this we need an NSWindow subclass
>> implementing sendEvent: which is then used to hold QemuCocoaView. I may be
>> wrong though, haven't tested it and don't know what you've tried.
>
> Yeah, we could also do something like that, or another approach
> I found by searching around is to use addLocalMonitorForEventsMatchingMask
> to catch events. I'd kind of prefer to do whatever is the "expected"
> setup for OSX apps, though, and I get the impression that completely
> overriding sendEvent is a bit outside the normal path.

Event monitor is also an option on 10.6+ (which we already require I 
think). Not sure if it's simpler. Overriding sendEvent: is mentioned in 
the docs so probably it should be OK and as long as you pass all unhandled 
events to the super method it also should not break to much. I think 
command key actions are handled at the NSApp level so if we override at 
the NSWindow level then probably we don't have to care about those but I'm 
not completely sure.

Regards,
BALATON Zoltan
