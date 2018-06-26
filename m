Received: from eggs.gnu.org ([2001:4830:134:3::10]:50414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXsQl-0000He-W4
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXsQk-0007Ap-QA
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:11:07 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXsQk-00079X-BK
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:11:06 -0400
Received: by mail-ot0-x242.google.com with SMTP id d19-v6so20040922oti.8
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 11:11:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180626175900.GA4307@roeck-us.net>
References: <1529374119-27015-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA_8TAWdkgTzPPE7eggP4UAHjVPmcXiEa_-RCxDBphJ4HA@mail.gmail.com>
	<20180626175900.GA4307@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 19:10:45 +0100
Message-ID: <CAFEAcA8PPF1mDWMGSm0r6NtYijwQQG7QnNEJ3iwaaEZU8GTu7g@mail.gmail.com>
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

On 26 June 2018 at 18:59, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Jun 26, 2018 at 06:17:44PM +0100, Peter Maydell wrote:
>> Thanks for this patch. I was wondering whether it would be better
>> just to remove the fprintf message instead. I'll either apply
>> this or send a patch to do that before 3.0, anyway.
>>
>
> If I recall correctly, I tried that, and it did not help.
> The messages don't happen too often, and the message itself
> does not cause a problem. Issue is that the interrupts happen
> at the wrong time or not at all (after a while, ie after the
> configured one-shot time expires), and the kernel really doesn't
> like that.
>
> I think the underlying problem was that the periodic timer counts
> the period down (based on the time set for the one-shot timer),
> stops with the "Timer with delta zero, disabling" message once
> the period reaches 0, and does not fire anymore afterwards.
> As a result, the kernel fails to boot maybe 90% of the time.
> I should probably have mentioned that in more detail in the
> commit log.

Hmm, that's odd, because I don't really see what the difference
between the two is. If you set the thing as a one-shot then we
won't reenable the timer later either with this patch.

Can you provide an image/QEMU command line that repros this,
and I'll see if I can find time to investigate it? (We have
a softfreeze deadline next Tuesday, so I probably won't be
able to get to it until after that, but since this is a bugfix
it doesn't have to be done before freeze.)

>> periodic timer if the reload register is written with a nonzero
>> value before the timer expires (and that if that happens after
>> the timer expired that we restart the timer). Thinking about
>> this is also on my todo list.
>>
>
> I thought that was handled in the Linux driver by disabling
> the timer, updating the period, and then re-enabling it in
> periodic mode, but I may have misinterpreted the code.

Yeah, it would depend what the guest does whether it's affected,
but my reading of the data sheet is that messing with the reload
register with the timer still active isn't prohibited.

thanks
-- PMM
