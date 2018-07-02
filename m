Received: from eggs.gnu.org ([2001:4830:134:3::10]:54354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa0lc-00028J-6q
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa0la-0008AP-UN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:29:28 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:32838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fa0la-00089z-Gb
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:29:26 -0400
Received: by mail-oi0-x241.google.com with SMTP id c6-v6so17138202oiy.0
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:29:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_non89OR_-W3Fhr6gG0v0kkgg-ffJx-9K_h=U-Hz_wbg@mail.gmail.com>
References: <1529374119-27015-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA_8TAWdkgTzPPE7eggP4UAHjVPmcXiEa_-RCxDBphJ4HA@mail.gmail.com>
	<20180626175900.GA4307@roeck-us.net>
	<CAFEAcA8PPF1mDWMGSm0r6NtYijwQQG7QnNEJ3iwaaEZU8GTu7g@mail.gmail.com>
	<20180626200008.GA680@roeck-us.net>
	<CAFEAcA_non89OR_-W3Fhr6gG0v0kkgg-ffJx-9K_h=U-Hz_wbg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 16:29:05 +0100
Message-ID: <CAFEAcA_LPE+qgEWVdYLyHPvD97i3aAqFLzS3qn4_RJ8hLfxtdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/char/cmsdk-apb-timer: Correctly
 identify and set one-shot mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2 July 2018 at 16:05, Peter Maydell <peter.maydell@linaro.org> wrote:
> One thing I do notice reading the code is that we don't
> actually do anything to re-enable the timer on a write to
> the VALUE register. We call ptimer_set_count(), but that will
> not reenable the timer if it was disabled -- the cmsdk timer
> code needs to call ptimer_run() if necessary, I think. But
> that bug should manifest whether we're setting the timer up
> as a one-shot or as a periodic with a 0 limit, because
> ptimer_tick() will disable the timer when it fires whichever
> way we do that.

...but as it happens the Linux driver doesn't rely on this:
https://elixir.bootlin.com/linux/v4.18-rc3/source/drivers/clocksource/mps2-timer.c#L66
mps2_timer_set_next_event() always writes both VALUE and
the CTRL register, so it will re-enable the timer anyway
and avoid this QEMU bug.

thanks
-- PMM
