Received: from eggs.gnu.org ([209.51.188.92]:49319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDxAh-0004et-MJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDxAg-0004YM-RC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:16:43 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:41878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDxAg-0004XM-C2
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:16:42 -0400
Received: by mail-oi1-x235.google.com with SMTP id v7so14712630oie.8
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 13:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <154907151753.31178.12938166708527410326.malonedeb@gac.canonical.com>
	<155481790266.8592.9119116041656314996.malone@wampee.canonical.com>
	<CAAedzxqBuP98u=YkrK7NU7p7eECODcxHcvspTc09c0+FHFxNnA@mail.gmail.com>
In-Reply-To: <CAAedzxqBuP98u=YkrK7NU7p7eECODcxHcvspTc09c0+FHFxNnA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2019 03:16:29 +0700
Message-ID: <CAFEAcA9X+srbS8gFm-D3KwHZ=PBjTeswkJb3nRK+Hp4geD9-Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1814352] Re: SIOCGIFNAME takes a struct ifreq
 not an integer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1814352 <1814352@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 10 Apr 2019 at 01:26, Erik Kline <1814352@bugs.launchpad.net> wrote:
> Sure.  Looking at HEAD, and even the surrounding the lines, I think I
> should have tried STRUCT_short_ifreq instead of STRUCT_int_ifreq, though
> I'm not sure what the real difference would be.

The multiple STRUCT_*_ifreq are working around the fact that
our MK_STRUCT infrastructure can't handle unions. The struct
ifreq is a char array followed by a union whose members are
various different types. You should use the STRUCT_*_ifreq
corresponding to whatever type the union field used by this
particular ioctl is. For SIOCGIFNAME the ifr_ifindex is read,
and that's an int, so you want STRUCT_int_ifreq. (If you used
the 'short' version by mistake this would probably break for the
case of big-endian guest and little-endian host or vice-versa
because we'd swap the wrong amount of data.)

thanks
-- PMM
