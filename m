Received: from eggs.gnu.org ([2001:4830:134:3::10]:37795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gMjR6-0000sb-7m
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 19:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gMjR0-0001me-9t
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 19:53:38 -0500
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:55685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gMjQt-0001k7-4T
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 19:53:28 -0500
Received: by mail-it1-x142.google.com with SMTP id o19so12196618itg.5
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 16:53:23 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Tue, 13 Nov 2018 19:53:20 -0500
References: <mailman.21030.1541972152.1282.qemu-devel@nongnu.org>
In-Reply-To: <mailman.21030.1541972152.1282.qemu-devel@nongnu.org>
Message-Id: <0377CFB0-49FE-48B1-8EE6-A8CAFE034080@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Fix for crashes and non-responsive UI on
 macOS Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Berkus Decker <berkus@gmail.com>, Peter Maydell <peter.maydell@linaro.org>


> On Nov 11, 2018, at 4:35 PM, qemu-devel-request@nongnu.org wrote:
>=20
> It seems that Cocoa checks are stricter on Mojave and some callbacks =
that worked from non-GUI thread on High Sierra are no longer working.
>=20
> The fixes included here are:
>=20
> * Deferring qemu_main() to another thread so that the actual main =
thread is reserved for the Cocoa UI; it also removes blocking from =
applicationDidFinishLoading: delegate. I beleive this alone caused =
complete UI blockage on Mojave.
> * Deferring UI-related updates in callbacks to the UI thread using =
invokeOnMainThread helper function. This function uses =
DDInvocationGrabber object courtesy of Dave Dribin, licensed under MIT =
license.
> Here?s relevant blog post for his code: =
https://www.dribin.org/dave/blog/archives/2008/05/22/invoke_on_main_thread=
/
>=20
> NSInvocation is used here instead of plain =
performSelectorOnMainThread:withObject:waitUntilDone: because we want to =
be able to pass non-id types to the handlers.

Also I realized that the only way we could call cocoa_refresh() from =
performSelectorOnMainThread:withObject:waitUntilDone: would be to add it =
to a class.=20

> These changes are ought to work on OSX 10.6, although I don?t have a =
machine handy to test it.
>=20
> Fixes https://bugs.launchpad.net/qemu/+bug/1802684
>=20
> =46rom 8f86e30f3710d782d78dccdbe7a1564ae79220c7 Mon Sep 17 00:00:00 =
2001
> From: Berkus Decker <berkus+github@metta.systems>
> Date: Sun, 11 Nov 2018 21:58:17 +0200
> Subject: [PATCH 1/2] ui/cocoa: Defer qemu to another thread, leaving =
main
> thread for the UI

<snip>

I tried both patch 1 and 2 together on Mac OS 10.12. Both =
qemu-system-i386 and qemu-system-ppc do not load their BIOS files. All I =
see is a black window each time. There is no indication of anything =
loading. The Machine menu doesn't populate with devices. Sorry.=20
