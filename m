Received: from eggs.gnu.org ([2001:4830:134:3::10]:48049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSJPB-00081p-Nb
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSJP9-0005IY-Bg
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:18:45 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:36370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSJP8-0005Hz-VC
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:18:43 -0500
Received: by mail-ot1-x332.google.com with SMTP id k98so1255930otk.3
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 02:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20181128010817.6191-1-programmingkidx@gmail.com>
	<CAFEAcA_C3BtOvEFrSOntma4GtreJNEmtg3pxkB+2iCYKVFQinA@mail.gmail.com>
	<AFD02114-6C8E-441B-87C0-469BE693601E@gmail.com>
	<CABsm=W35aFrF=cTJD74E6d9Ugau=PwPQ9wrjCDZueJwhMGVHgA@mail.gmail.com>
In-Reply-To: <CABsm=W35aFrF=cTJD74E6d9Ugau=PwPQ9wrjCDZueJwhMGVHgA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Nov 2018 10:18:30 +0000
Message-ID: <CAFEAcA-dqKpce+odLb=BG5ypUEuQyhYTE9sdZsm0T_LzB6muyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] (no subject)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Berkus Decker <berkus@gmail.com>
Cc: G 3 <programmingkidx@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 29 Nov 2018 at 02:11, berkus infinitus <berkus@gmail.com> wrote:
>
> I suspect the main problem is the blocking call to qemu_main
> from the UI thread in the app delegate didFinishLoadingWithOptions
> if i=E2=80=99m not mistaken and everything else grows from there.

Yes; if there's no way that Mojave will allow us to run
qemu_main directly on the main thread, then we have to
create a 2nd thread to run qemu_main on (which then becomes
what QEMU thinks of as the "main loop thread"), and then
we run into the need to make all the UI calls be forwarded
from the main loop thread to the main thread, and to get
QEMU locks when making calls into qemu from the main thread.

I think the code we have in git currently will already do
all the UI calls on the main thread -- it just does it by
doing a blocking call into qemu_main which later does
event processing itself. (It's a shame OSX doesn't document
what you need to do to write code that way, it's a fairly
common paradigm for other GUIs.)

For High Sierra there is apparently a "main thread checker"
utility: https://developer.apple.com/documentation/code_diagnostics/main_th=
read_checker
so running
DYLD_INSERT_LIBRARIES=3D/Applications/Xcode.app/Contents/Developer/usr/lib/=
libMainThreadChecker.dylib
qemu-system-x86_64 args...

will let us check for violations of the "do things on main
thread" principle even without Mohave. For me with current
QEMU it doesn't report any issues.

thanks
-- PMM
