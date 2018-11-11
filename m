Received: from eggs.gnu.org ([2001:4830:134:3::10]:35491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gLrDO-0003n2-Av
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 09:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gLrDL-0002CZ-1d
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 09:59:54 -0500
Received: from mail-it1-x12e.google.com ([2607:f8b0:4864:20::12e]:37317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gLrDK-000268-BF
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 09:59:50 -0500
Received: by mail-it1-x12e.google.com with SMTP id j79-v6so9836703itb.2
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 06:59:42 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Sun, 11 Nov 2018 09:59:38 -0500
References: <mailman.21086.1541937348.1283.qemu-devel@nongnu.org>
In-Reply-To: <mailman.21086.1541937348.1283.qemu-devel@nongnu.org>
Message-Id: <EF302223-2690-4FC2-9B05-23802B0320A3@gmail.com>
Subject: Re: [Qemu-devel] [Bug 1802684] Re: QEMU gui crashes on macOS Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>


> On Nov 11, 2018, at 6:55 AM, qemu-devel-request@nongnu.org wrote:
>=20
> The code for the cocoa stuff is in ui/cocoa.m. Quick notes on =
structure:
>=20
> * there is a weird thing where cocoa.m provides its own main(), and =
arranges that the function which is main() for every other UI is renamed =
qemu_main() and called later (I'd like to get rid of that one day if we =
could, it's just weird)
> * cocoa_display_init() is the "initialize the display" entry point -- =
this will always be called from on the main thread (strictly, from =
whichever thread OSX calls our applicationDidFinishLaunching callback =
on, but I assume that's the main thread)
> * the runtime entry points into the cocoa UI code are just the =
functions in the DisplayChangeListener struct: cocoa_update(), =
cocoa_switch() and cocoa_refresh()
>=20
> Arranging for the last 3 to schedule their operation onto the main
> thread is probably what's needed. Things I don't know:
>=20
> * should this "run thing on main thread" be synchronous or =
asynchronous? (sync is probably safest)
synchronous sounds good.=20

> * what's the right OSX API to do this?
=
https://developer.apple.com/documentation/objectivec/nsobject/1414900-perf=
ormselectoronmainthread?language=3Dobjc

> * how can we most cleanly do this in a way that still works on OSX =
10.6 (the oldest we currently support)? (I suspect we'll need ifdefs and =
fall back to "just run on this thread" on older versions)

I would make another function called switchSurfaceInternal: and then =
move all the code from switchSurface: to this new function. Then have =
the switchSurface: method call the switchSurfaceInternal: method by =
using [performSelectorOnMainThread:withObject:waitUntilDone:].=20

The call would look like this:=20
[self performSelectorOnMainThread: @selector(switchSurface:) withObject: =
surface waitUntilDone: YES]

I'm not sure if waitUntilDone should be set to YES. QEMU might work =
faster if it is set to NO.=20

Thank you.=
