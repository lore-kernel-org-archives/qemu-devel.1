Received: from eggs.gnu.org ([209.51.188.92]:42560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gnq6H-0008Vd-N2
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gnq6F-0003DR-Q4
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:28:13 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:46105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gnq6D-0003AC-SJ
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:28:09 -0500
Received: by mail-oi1-x229.google.com with SMTP id x202so11346703oif.13
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 11:28:07 -0800 (PST)
MIME-Version: 1.0
References: <83206F6D-0BA5-4781-8635-84D48DD33A2A@foghorn.io>
	<CAFEAcA-PJadBG0sE43N9wEx9Qm3Nxu2am_0Zy2Zqtz66C9SJ-w@mail.gmail.com>
	<ECFBC025-CD7F-444B-BF7F-62E20954A85A@foghorn.io>
	<CAFEAcA9M73BdXs345vdqkuQE3sxT+GnS4PWZ2OPO8DWwNtRQ-A@mail.gmail.com>
	<EC65CD28-C2F9-49D7-BDE1-9C3B5F68665E@foghorn.io>
	<47126B68-3AF7-48AB-B904-4D8EAC854BC7@foghorn.io>
In-Reply-To: <47126B68-3AF7-48AB-B904-4D8EAC854BC7@foghorn.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 27 Jan 2019 19:27:54 +0000
Message-ID: <CAFEAcA9Oc3Rg_NWkeEjYPVz8yQnBbWd0WM5UQSWNRRP9VfjonQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Hekster <ben.hekster@foghorn.io>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 19 Dec 2018 at 19:42, Ben Hekster <ben.hekster@foghorn.io> wrote:
>
> Should have tested a little more:
>
> While the crashing has stopped, the window isn't responsive to
>keystrokes.  This includes the frame buffer emulation itself (so
>I can't actually log in) as well as the QEMU Monitor; nothing I
>type has any effect in either.

Yes, I can reproduce this with my "refactor the OSX UI code"
patchset too. The problem is that with the removal of the
code that was in the cocoa_refresh() function that manually
pulled events out of the OSX event queue and called our
QemuCocoaView handleEvent method on them, there's nothing
that does cause that code to be called. (I had mistakenly
assumed handleEvent was an OSX UI method and so the run loop
would call it.)

Unfortunately I'm not sufficiently familiar with how OSX
event handling works to figure out how to plumb it back in
again. It ought to be a fairly simple matter of "implement
whatever method OSX sends events to on whatever of our
various classes is the right one, and make it call handleEvent
with the NSEvent", but I've tried a few things and haven't
been able to actually get any event handling methods to
fire at all :-(

thanks
-- PMM
