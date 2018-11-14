Received: from eggs.gnu.org ([2001:4830:134:3::10]:51797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berkus@gmail.com>) id 1gMsDP-000550-3a
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berkus@gmail.com>) id 1gMsDL-00025R-L0
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:16:06 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:46697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berkus@gmail.com>) id 1gMsDL-00023h-CN
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:16:03 -0500
Received: by mail-lj1-x241.google.com with SMTP id v15-v6so13574213ljh.13
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 02:16:02 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Berkus Decker <berkus@gmail.com>
In-Reply-To: <0377CFB0-49FE-48B1-8EE6-A8CAFE034080@gmail.com>
Date: Wed, 14 Nov 2018 12:15:59 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <85C9973D-7489-4EC2-B181-BD1F259C2F90@gmail.com>
References: <mailman.21030.1541972152.1282.qemu-devel@nongnu.org>
	<0377CFB0-49FE-48B1-8EE6-A8CAFE034080@gmail.com>
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
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

I will double check on High Sierra and El Capitan.

So far I only tested qemu-system-aarch64 and it worked on Mojave, but =
did not test elsewhere (my aim was to get my osdev going, only).

I have a range of older osx machines (not as old as 10.6 though), so =
will put it through some rounds. Will post here with results.

Thanks for taking your time!

> On 14 Nov 2018, at 02:53, Programmingkid <programmingkidx@gmail.com> =
wrote:
>=20
>=20
>> On Nov 11, 2018, at 4:35 PM, qemu-devel-request@nongnu.org wrote:
>>=20
>> It seems that Cocoa checks are stricter on Mojave and some callbacks =
that worked from non-GUI thread on High Sierra are no longer working.
>>=20
>> The fixes included here are:
>>=20
>> * Deferring qemu_main() to another thread so that the actual main =
thread is reserved for the Cocoa UI; it also removes blocking from =
applicationDidFinishLoading: delegate. I beleive this alone caused =
complete UI blockage on Mojave.
>> * Deferring UI-related updates in callbacks to the UI thread using =
invokeOnMainThread helper function. This function uses =
DDInvocationGrabber object courtesy of Dave Dribin, licensed under MIT =
license.
>> Here?s relevant blog post for his code: =
https://www.dribin.org/dave/blog/archives/2008/05/22/invoke_on_main_thread=
/
>>=20
>> NSInvocation is used here instead of plain =
performSelectorOnMainThread:withObject:waitUntilDone: because we want to =
be able to pass non-id types to the handlers.
>=20
> Also I realized that the only way we could call cocoa_refresh() from =
performSelectorOnMainThread:withObject:waitUntilDone: would be to add it =
to a class.=20
>=20
>> These changes are ought to work on OSX 10.6, although I don?t have a =
machine handy to test it.
>>=20
>> Fixes https://bugs.launchpad.net/qemu/+bug/1802684
>>=20
>> =46rom 8f86e30f3710d782d78dccdbe7a1564ae79220c7 Mon Sep 17 00:00:00 =
2001
>> From: Berkus Decker <berkus+github@metta.systems>
>> Date: Sun, 11 Nov 2018 21:58:17 +0200
>> Subject: [PATCH 1/2] ui/cocoa: Defer qemu to another thread, leaving =
main
>> thread for the UI
>=20
> <snip>
>=20
> I tried both patch 1 and 2 together on Mac OS 10.12. Both =
qemu-system-i386 and qemu-system-ppc do not load their BIOS files. All I =
see is a black window each time. There is no indication of anything =
loading. The Machine menu doesn't populate with devices. Sorry.=20
>=20
>=20
