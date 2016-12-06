Received: from eggs.gnu.org ([2001:4830:134:3::10]:49986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEIKT-0003Ga-4H
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEIKO-0005C5-Bz
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:10:53 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:35045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEIKN-0005Bb-VL
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:10:48 -0500
Received: by mail-ua0-f178.google.com with SMTP id 12so386154186uas.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 08:10:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87k2bdytrx.fsf@linaro.org>
References: <20161206113915.26308.72810.malonedeb@wampee.canonical.com>
	<20161206145104.16048-1-alex.bennee@linaro.org>
	<CAFEAcA8tnP5_annrApB2O_ZUXvc7HXM7+K1XOsPUVqrU6hHLeA@mail.gmail.com>
	<87k2bdytrx.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Dec 2016 16:09:26 +0000
Message-ID: <CAFEAcA9fVNxmLNHtbRBCVAbumuwu-sX++WqqgjP7FuZwJ4Aqcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] exec.c: simplify the breakpoint
 invalidation logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Bug 1647683 <1647683@bugs.launchpad.net>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:Overall" <qemu-devel@nongnu.org>

On 6 December 2016 at 15:14, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> I think this is the wrong direction. We only need to invalidate
>> the TBs for the specific location the breakpoint is at.
>> Even if we for the moment want to apply a big hammer of doing
>> a full tb flush on breakpoint to fix this issue for this release,
>> we shouldn't drop the indirection through breakpoint_invalidate(),
>> because then we can't go back to invalidating just the parts we need
>> easily later.
>
> Why would we? It's not like fresh code generation is particularly slow,
> especially in a debugging situation when you've just stopped the
> machine.

Because a wholescale tb_flush() is a "this is probably wrong"
flag, and a great way to hide bugs. It also makes the gdbstub
more invasive than it strictly has to be.

We have less than 10 calls to tb_flush() in the whole system
and I think they could all use examination to see whether
they're really correct.

thanks
-- PMM
