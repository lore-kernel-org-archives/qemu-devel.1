Received: from eggs.gnu.org ([2001:4830:134:3::10]:39471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gMXYH-0005Ap-Uc
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gMXYD-0006vE-8O
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:12:17 -0500
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31]:34718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gMXYC-0006ub-9u
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:12:12 -0500
Received: by mail-io1-xd31.google.com with SMTP id f6so5690086iob.1
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 04:12:11 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.21030.1541972152.1282.qemu-devel@nongnu.org>
Date: Tue, 13 Nov 2018 07:12:06 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D9A31B6-6136-4ABD-B88D-722BA2D99528@gmail.com>
References: <mailman.21030.1541972152.1282.qemu-devel@nongnu.org>
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
To: QEMU Developers <qemu-devel@nongnu.org>, Berkus Decker <berkus@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>


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

Couldn't we use [NSValue valueWithPointer:] to pass the struct instance =
to performSelectorOnMainThread:withObject:waitUntilDone:?

=
https://developer.apple.com/documentation/foundation/nsvalue/1415975-value=
withpointer?language=3Dobjc

> These changes are ought to work on OSX 10.6, although I don?t have a =
machine handy to test it.

I have Mac OS 10.6 available for testing. I just don't think all this =
code is necessary to fix this issue. Hopefully I will have the time =
later today to investigate this issue some more.
