Received: from eggs.gnu.org ([209.51.188.92]:49719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gntcV-0004VG-U0
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 18:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gntcU-0007FH-5E
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 18:13:43 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:15938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gntcS-00079X-Bl
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 18:13:42 -0500
Date: Mon, 28 Jan 2019 00:13:29 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA9Oc3Rg_NWkeEjYPVz8yQnBbWd0WM5UQSWNRRP9VfjonQ@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1901272321030.63988@zero.eik.bme.hu>
References: <83206F6D-0BA5-4781-8635-84D48DD33A2A@foghorn.io>
	<CAFEAcA-PJadBG0sE43N9wEx9Qm3Nxu2am_0Zy2Zqtz66C9SJ-w@mail.gmail.com>
	<ECFBC025-CD7F-444B-BF7F-62E20954A85A@foghorn.io>
	<CAFEAcA9M73BdXs345vdqkuQE3sxT+GnS4PWZ2OPO8DWwNtRQ-A@mail.gmail.com>
	<EC65CD28-C2F9-49D7-BDE1-9C3B5F68665E@foghorn.io>
	<47126B68-3AF7-48AB-B904-4D8EAC854BC7@foghorn.io>
	<CAFEAcA9Oc3Rg_NWkeEjYPVz8yQnBbWd0WM5UQSWNRRP9VfjonQ@mail.gmail.com>
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

On Sun, 27 Jan 2019, Peter Maydell wrote:
> On Wed, 19 Dec 2018 at 19:42, Ben Hekster <ben.hekster@foghorn.io> wrote:
>>
>> Should have tested a little more:
>>
>> While the crashing has stopped, the window isn't responsive to
>> keystrokes.  This includes the frame buffer emulation itself (so
>> I can't actually log in) as well as the QEMU Monitor; nothing I
>> type has any effect in either.
>
> Yes, I can reproduce this with my "refactor the OSX UI code"
> patchset too. The problem is that with the removal of the
> code that was in the cocoa_refresh() function that manually
> pulled events out of the OSX event queue and called our
> QemuCocoaView handleEvent method on them, there's nothing
> that does cause that code to be called. (I had mistakenly
> assumed handleEvent was an OSX UI method and so the run loop
> would call it.)
>
> Unfortunately I'm not sufficiently familiar with how OSX
> event handling works to figure out how to plumb it back in
> again. It ought to be a fairly simple matter of "implement
> whatever method OSX sends events to on whatever of our
> various classes is the right one, and make it call handleEvent
> with the NSEvent", but I've tried a few things and haven't
> been able to actually get any event handling methods to
> fire at all :-(

I think you need to implement keyDown: and keyUp: methods in QemuCocoaView 
to get keyboard events and there are similar methods for mouse events, 
see:

https://developer.apple.com/documentation/appkit/nsview?language=objc

But these are a lot of methods which are supposedly called from the 
sendEvent: method of the NSWindow containing this view so maybe a better 
place to catch all events is there. For this we need an NSWindow subclass 
implementing sendEvent: which is then used to hold QemuCocoaView. I may be 
wrong though, haven't tested it and don't know what you've tried. (If all 
else fails there's also sendEvent: of NSApp which is where all events 
should start from and it might be subclassed as well but then some events 
may need to be passed on so doing it at the window is probably better.)

Regards,
BALATON Zoltan
