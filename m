Received: from eggs.gnu.org ([209.51.188.92]:53089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gygxM-0007lm-2T
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gygxJ-0004vK-3U
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:55:50 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gygxG-0004Ei-52
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 12:55:48 -0500
Received: by mail-oi1-x242.google.com with SMTP id s16so11064927oih.9
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 09:55:02 -0800 (PST)
MIME-Version: 1.0
References: <1550878686-23934-1-git-send-email-michelheily@gmail.com>
In-Reply-To: <1550878686-23934-1-git-send-email-michelheily@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 17:54:49 +0000
Message-ID: <CAFEAcA9=rswhCNXE6zgzN_S5QDTy_4sfHnsy+buyOzdRSKVFcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/stellaris: Implement watchdog timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: michelheily@gmail.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, "open list:Stellaris" <qemu-arm@nongnu.org>

On Fri, 22 Feb 2019 at 23:45, <michelheily@gmail.com> wrote:
>
> From: Michel Heily <michelheily@gmail.com>
>
> Signed-off-by: Michel Heily <michelheily@gmail.com>

Hi; thanks for this patch; it looks pretty good (though
it does have a few issues). However, it turns out that we
already have a model of something that's practically the
same hardware...

I would suggest that you look at the code we have for
the CMSDK APB watchdog in hw/watchdog/cmsdk-apb-watchdog.c:
I think the semantics of that device are almost identical
to this one, so rather than writing an entire new device
model we can just parameterize that one to behave as the
Stellaris SoC requires. I think the differences are just:
 * ID register values are different
 * the control register doesn't allow the RESEN or INTEN bits
   to be written from 1 to 0, only 0 to 1
 * the WDOGITCR register doesn't exist
 * new WDTTEST register at 0x418

So we can just implement the Stellaris watchdog device
as a subclass of the CMSDK APB watchdog -- you can look
at hw/char/pl011.c as an example of how to do this
(in that case we're modifying the standard Arm PL011
UART to make it look like the one in the Stellaris board) --
and then make the CMSDK watchdog's code conditionally
do the Stellaris-specific things in that case.

thanks
-- PMM
