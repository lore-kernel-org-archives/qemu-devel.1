Received: from eggs.gnu.org ([2001:4830:134:3::10]:37518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faPR2-0004S7-HK
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faPR1-0002ch-Jb
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:49:52 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:45463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faPR1-0002cQ-DR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:49:51 -0400
Received: by mail-oi0-x22c.google.com with SMTP id m2-v6so5510231oim.12
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 10:49:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703041343.2014-1-programmingkidx@gmail.com>
References: <20180703041343.2014-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 18:49:29 +0100
Message-ID: <CAFEAcA81Ud8Yh7mTE8=nzAuWYpx7+m+hN5izLoMT-Jce8=-JCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: replace scrollingDeltaY with
 deltaY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 July 2018 at 05:13, John Arbuckle <programmingkidx@gmail.com> wrote:
> The NSEvent class method scrollingDeltaY is available for Mac OS 10.7 and=
 newer. Since QEMU supports Mac OS 10.5 and up, we need to be using a metho=
d that is available on these version of Mac OS X. The deltaY method is a me=
thod that does the same thing as scrollingDeltaY and is available on Mac OS=
 10.5 and up. So we simply replace scrollingDeltaY with deltaY.

I think that this change will result in scroll events from
high-scrolling-precision devices (eg magic trackpad)
sometimes giving the wrong kind of event.

In particular, this comment from a random Eclipse bug
report has a good description of what happens:
 https://bugs.eclipse.org/bugs/show_bug.cgi?id=3D220175#c13

For high-precision scrolling devices, the app gets events
which:
 * have hasPreciseScrollingDeltas true
 * have scrollingDeltaY something non-zero
 * may have deltaY be zero

So if we use
 ([event deltaY] > 0) ? INPUT_BUTTON_WHEEL_UP : INPUT_BUTTON_WHEEL_DOWN

then for a slow upward scroll on a high precision device
some (most) of our up-scroll events will appear with deltaY =3D=3D 0,
which this ?: will interpret as a WHEEL_DOWN event.

Two choices I can see here:

(1) make the code ignore ScrollWheel events with a deltaY of zero
(ie don't inject any QEMU button wheel event for them). Would
need to test on a 10.7+ system with a suitable precise-scrolling
device that this does actually still allow scrolling.

(2) use scrollingDeltaY on OSX versions that have it, and
only use deltaY on the older versions.

PS: could you line-break your commit messages, please?
They seem to be coming out as all one very long line.
Recommendation is hard linebreaks at about 70 chars per line.

thanks
-- PMM
